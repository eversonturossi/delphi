unit TFlatSplitterUnit;

{ *************************************************************** }
{ TFlatsplitter }
{ Copyright ©1999 Lloyd Kinsella. }
{ }
{ FlatStyle is Copyright ©1998-99 Maik Porkert. }
{ *************************************************************** }

interface

{$I DFS.inc}

uses Messages, Windows, SysUtils, Classes, Controls, Forms, Menus, Graphics,
  StdCtrls, ExtCtrls, FlatUtilitys;

type
  TSplitterStatus = (ssIn, ssOut);
{$IFDEF DFS_COMPILER_2}
  NaturalNumber = 1 .. High(Integer);
{$ENDIF}

type
  THack = class(TWinControl);

    TFlatSplitter = class(TGraphicControl)private FUseAdvColors: Boolean;
    FAdvColorBorder: TAdvColors;
    FAdvColorFocused: TAdvColors;
    FBorderColor: TColor;
    FFocusedColor: TColor;
    FLineDC: HDC;
    FDownPos: TPoint;
    FSplit: Integer;
    FMinSize: NaturalNumber;
    FMaxSize: Integer;
    FControl: TControl;
    FNewSize: Integer;
    FActiveControl: TWinControl;
    FOldKeyDown: TKeyEvent;
    FLineVisible: Boolean;
    FOnMoved: TNotifyEvent;
    FStatus: TSplitterStatus;
    procedure AllocateLineDC;
    procedure DrawLine;
    procedure ReleaseLineDC;
    procedure UpdateSize(X, Y: Integer);
    procedure FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;
    procedure CMEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMExit(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    procedure CalcAdvColors;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure StopSizing;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AdvColorBorder: TAdvColors index 0 read FAdvColorBorder write SetAdvColors default 50;
    property AdvColorFocused: TAdvColors index 1 read FAdvColorFocused write SetAdvColors default 50;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default False;
    property Color default $00E0E9EF;
    property ColorFocused: TColor index 0 read FFocusedColor write SetColors default $0053D2FF;
    property ColorBorder: TColor index 1 read FBorderColor write SetColors default $00555E66;
    property MinSize: NaturalNumber read FMinSize write FMinSize default 30;
    property OnMoved: TNotifyEvent read FOnMoved write FOnMoved;
    property Align default alLeft;
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property ShowHint;
    property Visible;
{$IFDEF DFS_DELPHI_4_UP}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property ParentBiDiMode;
{$ENDIF}
  end;

implementation

constructor TFlatSplitter.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle + [csOpaque];
  Align := alLeft;
  Width := 5;
  Cursor := crHSplit;
  FMinSize := 30;
  FStatus := ssOut;
  ParentColor := true;
  ColorFocused := $0053D2FF;
  ColorBorder := $00555E66;
end;

procedure TFlatSplitter.AllocateLineDC;
begin
  FLineDC := GetDCEx(Parent.Handle, 0, DCX_CACHE or DCX_CLIPSIBLINGS or DCX_LOCKWINDOWUPDATE);
end;

procedure TFlatSplitter.DrawLine;
var
  P: TPoint;
begin
  FLineVisible := not FLineVisible;
  P := Point(Left, Top);
  if Align in [alLeft, alRight] then
    P.X := Left + FSplit
  else
    P.Y := Top + FSplit;
  with P do
    PatBlt(FLineDC, X, Y, Width, Height, PATINVERT);
end;

procedure TFlatSplitter.ReleaseLineDC;
begin
  ReleaseDC(Parent.Handle, FLineDC);
end;

procedure TFlatSplitter.Paint;
var
  memoryBitmap: TBitmap;
begin
  memoryBitmap := TBitmap.Create; // create memory-bitmap to draw flicker-free
  try
    memoryBitmap.Height := ClientRect.Bottom;
    memoryBitmap.Width := ClientRect.Right;

    if FStatus = ssIn then
    begin
      memoryBitmap.Canvas.Brush.Color := FFocusedColor;
      memoryBitmap.Canvas.FillRect(ClientRect);
      Frame3DBorder(memoryBitmap.Canvas, ClientRect, FBorderColor, FBorderColor, 1);
    end;
    if FStatus = ssOut then
    begin
      memoryBitmap.Canvas.Brush.Color := Color;
      memoryBitmap.Canvas.FillRect(ClientRect);
      Frame3DBorder(memoryBitmap.Canvas, ClientRect, FBorderColor, FBorderColor, 1);
    end;

    Canvas.CopyRect(ClientRect, memoryBitmap.Canvas, ClientRect); // Copy bitmap to screen
  finally
    memoryBitmap.free; // delete the bitmap
  end;
end;

procedure TFlatSplitter.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

  function FindControl: TControl;
  var
    P: TPoint;
    I: Integer;
  begin
    Result := nil;
    P := Point(Left, Top);
    case Align of
      alLeft:
        Dec(P.X);
      alRight:
        Inc(P.X, Width);
      alTop:
        Dec(P.Y);
      alBottom:
        Inc(P.Y, Height);
    else
      Exit;
    end;
    for I := 0 to Parent.ControlCount - 1 do
    begin
      Result := Parent.Controls[I];
      if PtInRect(Result.BoundsRect, P) then
        Exit;
    end;
    Result := nil;
  end;

var
  I: Integer;
begin
  inherited;
  if Button = mbLeft then
  begin
    FControl := FindControl;
    FDownPos := Point(X, Y);
    if Assigned(FControl) then
    begin
      if Align in [alLeft, alRight] then
      begin
        FMaxSize := Parent.ClientWidth - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alLeft, alRight] then
              Dec(FMaxSize, Width);
        Inc(FMaxSize, FControl.Width);
      end
      else
      begin
        FMaxSize := Parent.ClientHeight - FMinSize;
        for I := 0 to Parent.ControlCount - 1 do
          with Parent.Controls[I] do
            if Align in [alTop, alBottom] then
              Dec(FMaxSize, Height);
        Inc(FMaxSize, FControl.Height);
      end;
      UpdateSize(X, Y);
      AllocateLineDC;
      with ValidParentForm(Self) do
        if ActiveControl <> nil then
        begin
          FActiveControl := ActiveControl;
          FOldKeyDown := THack(FActiveControl).OnKeyDown;
          THack(FActiveControl).OnKeyDown := FocusKeyDown;
        end;
      DrawLine;
    end;
  end;
end;

procedure TFlatSplitter.UpdateSize(X, Y: Integer);
var
  S: Integer;
begin
  if Align in [alLeft, alRight] then
    FSplit := X - FDownPos.X
  else
    FSplit := Y - FDownPos.Y;
  S := 0;
  case Align of
    alLeft:
      S := FControl.Width + FSplit;
    alRight:
      S := FControl.Width - FSplit;
    alTop:
      S := FControl.Height + FSplit;
    alBottom:
      S := FControl.Height - FSplit;
  end;
  FNewSize := S;
  if S < FMinSize then
    FNewSize := FMinSize
  else if S > FMaxSize then
    FNewSize := FMaxSize;
  if S <> FNewSize then
  begin
    if Align in [alRight, alBottom] then
      S := S - FNewSize
    else
      S := FNewSize - S;
    Inc(FSplit, S);
  end;
end;

procedure TFlatSplitter.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Assigned(FControl) then
  begin
    DrawLine;
    UpdateSize(X, Y);
    DrawLine;
  end;
end;

procedure TFlatSplitter.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  if Assigned(FControl) then
  begin
    DrawLine;
    case Align of
      alLeft:
        FControl.Width := FNewSize;
      alTop:
        FControl.Height := FNewSize;
      alRight:
        begin
          Parent.DisableAlign;
          try
            FControl.Left := FControl.Left + (FControl.Width - FNewSize);
            FControl.Width := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
      alBottom:
        begin
          Parent.DisableAlign;
          try
            FControl.Top := FControl.Top + (FControl.Height - FNewSize);
            FControl.Height := FNewSize;
          finally
            Parent.EnableAlign;
          end;
        end;
    end;
    StopSizing;
  end;
end;

procedure TFlatSplitter.FocusKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    StopSizing
  else if Assigned(FOldKeyDown) then
    FOldKeyDown(Sender, Key, Shift);
end;

procedure TFlatSplitter.StopSizing;
begin
  if Assigned(FControl) then
  begin
    if FLineVisible then
      DrawLine;
    FControl := nil;
    ReleaseLineDC;
    if Assigned(FActiveControl) then
    begin
      THack(FActiveControl).OnKeyDown := FOldKeyDown;
      FActiveControl := nil;
    end;
  end;
  if Assigned(FOnMoved) then
    FOnMoved(Self);
end;

procedure TFlatSplitter.CMEnter(var Message: TMessage);
begin
  if FStatus <> ssIn then
  begin
    FStatus := ssIn;
    Invalidate;
  end;
end;

procedure TFlatSplitter.CMExit(var Message: TMessage);
begin
  if FStatus <> ssOut then
  begin
    FStatus := ssOut;
    Invalidate;
  end;
end;

procedure TFlatSplitter.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FFocusedColor := Value;
    1:
      FBorderColor := Value;
  end;
  Invalidate;
end;

procedure TFlatSplitter.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FBorderColor := CalcAdvancedColor(Color, FBorderColor, FAdvColorBorder, darken);
    FFocusedColor := CalcAdvancedColor(Color, FFocusedColor, FAdvColorFocused, darken);
  end;
end;

procedure TFlatSplitter.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorBorder := Value;
    1:
      FAdvColorFocused := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatSplitter.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    ParentColor := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatSplitter.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
  begin
    ParentColor := true;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatSplitter.CMParentColorChanged(var Message: TWMNoParams);
begin
  inherited;
  if FUseAdvColors then
  begin
    ParentColor := true;
    CalcAdvColors;
  end;
  Invalidate;
end;

end.
