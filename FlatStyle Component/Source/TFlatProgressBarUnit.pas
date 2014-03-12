unit TFlatProgressBarUnit;

interface

{$I DFS.inc}

uses
  SysUtils, WinTypes, WinProcs, Messages, Classes, Graphics, Controls,
  Forms, Dialogs, ExtCtrls, Comctrls, FlatUtilitys;

type
  TFlatProgressBar = class(TGraphicControl)
  private
    FTransparent: Boolean;
    FSmooth: Boolean;
    FUseAdvColors: Boolean;
    FAdvColorBorder: TAdvColors;
    FOrientation: TProgressBarOrientation;
    FElementWidth: Integer;
    FElementColor: TColor;
    FBorderColor: TColor;
    FPosition: Integer;
    FMin: Integer;
    FMax: Integer;
    FStep: Integer;
    procedure SetMin(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetPosition(Value: Integer);
    procedure SetStep(Value: Integer);
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    procedure SetOrientation(Value: TProgressBarOrientation);
    procedure SetSmooth(Value: Boolean);
    procedure CheckBounds;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;
    procedure SetTransparent(const Value: Boolean);
  protected
    procedure CalcAdvColors;
    procedure DrawElements;
    procedure Paint; override;
{$IFDEF DFS_COMPILER_4_UP}
    procedure SetBiDiMode(Value: TBiDiMode); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    procedure StepIt;
    procedure StepBy(Delta: Integer);
  published
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property Align;
    property Cursor;
    property Color default $00E1EAEB;
    property ColorElement: TColor index 0 read FElementColor write SetColors default $00996633;
    property ColorBorder: TColor index 1 read FBorderColor write SetColors default $008396A0;
    property AdvColorBorder: TAdvColors index 0 read FAdvColorBorder write SetAdvColors default 50;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default false;
    property Orientation: TProgressBarOrientation read FOrientation write SetOrientation default pbHorizontal;
    property Enabled;
    property ParentColor;
    property Visible;
    property Hint;
    property ShowHint;
    property PopupMenu;
    property ParentShowHint;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    property Position: Integer read FPosition write SetPosition default 0;
    property Step: Integer read FStep write SetStep default 10;
    property Smooth: Boolean read FSmooth write SetSmooth default false;

    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$IFDEF DFS_COMPILER_4_UP}
    property Anchors;
    property BiDiMode write SetBiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

implementation

constructor TFlatProgressBar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Height := 16;
  Width := 147;
  FElementWidth := 8;
  FElementColor := $00996633;
  FBorderColor := $008396A0;
  ParentColor := True;
  Orientation := pbHorizontal;
  FStep := 10;
  FMin := 0;
  FMax := 100;
  FUseAdvColors := false;
  FAdvColorBorder := 50;
  Transparent := false;
end;

procedure TFlatProgressBar.SetOrientation(Value: TProgressBarOrientation);
begin
  if FOrientation <> Value then
  begin
    FOrientation := Value;
    if (csLoading in ComponentState) then
    begin
      Repaint;
      Exit;
    end;
    SetBounds(Left, Top, Height, Width);
    Invalidate;
  end;
end;

procedure TFlatProgressBar.SetMin(Value: Integer);
begin
  if FMin <> Value then
  begin
    FMin := Value;
    Invalidate;
  end;
end;

procedure TFlatProgressBar.SetMax(Value: Integer);
begin
  if FMax <> Value then
  begin
    if Value < FPosition then
      FPosition := Value;
    FMax := Value;
    Invalidate;
  end;
end;

procedure TFlatProgressBar.SetPosition(Value: Integer);
begin
  if Value > FMax then
    Value := FMax;
  if Value < FMin then
    Value := FMin;

  if Value > FPosition then
  begin
    FPosition := Value;
    DrawElements;
  end;
  if Value < FPosition then
  begin
    FPosition := Value;
    Invalidate;
  end;
end;

procedure TFlatProgressBar.SetStep(Value: Integer);
begin
  if FStep <> Value then
  begin
    FStep := Value;
    Invalidate;
  end;
end;

procedure TFlatProgressBar.StepIt;
begin
  if (FPosition + FStep) > FMax then
    FPosition := FMax
  else
    FPosition := FPosition + FStep;
  DrawElements;
end;

procedure TFlatProgressBar.StepBy(Delta: Integer);
begin
  if (FPosition + Delta) > FMax then
    FPosition := FMax
  else
    FPosition := FPosition + Delta;
  DrawElements;
end;

procedure TFlatProgressBar.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FElementColor := Value;
    1:
      FBorderColor := Value;
  end;
  Invalidate;
end;

procedure TFlatProgressBar.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FBorderColor := CalcAdvancedColor(Color, FBorderColor, FAdvColorBorder, darken);
  end;
end;

procedure TFlatProgressBar.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorBorder := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatProgressBar.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    ParentColor := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatProgressBar.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatProgressBar.CMParentColorChanged(var Message: TWMNoParams);
begin
  inherited;
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatProgressBar.SetSmooth(Value: Boolean);
begin
  if Value <> FSmooth then
  begin
    FSmooth := Value;
    Invalidate;
  end;
end;

procedure TFlatProgressBar.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;
  Invalidate;
end;
{$IFDEF DFS_COMPILER_4_UP}

procedure TFlatProgressBar.SetBiDiMode(Value: TBiDiMode);
begin
  inherited;
  Invalidate;
end;
{$ENDIF}

procedure TFlatProgressBar.CheckBounds;
var
  maxboxes: Word;
begin
  if FOrientation = pbHorizontal then
  begin
    maxboxes := (Width - 3) div (FElementWidth + 1);
    if Width < 12 then
      Width := 12
    else
      Width := maxboxes * (FElementWidth + 1) + 3;
  end
  else
  begin
    maxboxes := (Height - 3) div (FElementWidth + 1);
    if Height < 12 then
      Height := 12
    else
      Height := maxboxes * (FElementWidth + 1) + 3;
  end;
end;

procedure TFlatProgressBar.Paint;
var
  PaintRect: TRect;
begin
  if not Smooth then
    CheckBounds;
  PaintRect := ClientRect;

  // Background
  if not FTransparent then
  begin
    canvas.Brush.Color := Self.Color;
    canvas.Brush.Style := bsSolid;
    canvas.FillRect(PaintRect);
  end;

  // Border
  canvas.Brush.Color := FBorderColor;
  canvas.FrameRect(PaintRect);

  // Elements
  DrawElements;
end;

procedure TFlatProgressBar.DrawElements;
var
  NumElements, NumToPaint: LongInt;
  Painted: Byte;
  ElementRect: TRect;
begin
  with canvas do
  begin
    if not Smooth then
    begin
      if FOrientation = pbHorizontal then
      begin
        NumElements := Trunc((ClientWidth - 3) div (FElementWidth + 1));
        NumToPaint := Trunc((FPosition - FMin) / ((FMax - FMin) / NumElements) + 0.00000001);

        if NumToPaint > NumElements then
          NumToPaint := NumElements;
{$IFDEF DFS_COMPILER_4_UP}
        if BiDiMode = bdRightToLeft then
          ElementRect := Rect(ClientRect.Right - 2 - FElementWidth, ClientRect.Top + 2, ClientRect.Right - 2,
            ClientRect.Bottom - 2)
        else
          ElementRect := Rect(ClientRect.Left + 2, ClientRect.Top + 2, ClientRect.Left + 2 + FElementWidth,
            ClientRect.Bottom - 2);
{$ELSE}
        ElementRect := Rect(ClientRect.Left + 2, ClientRect.Top + 2, ClientRect.Left + 2 + FElementWidth,
          ClientRect.Bottom - 2);
{$ENDIF}
        if NumToPaint > 0 then
        begin
          Brush.Color := FElementColor;
          Brush.Style := bsSolid;
          for Painted := 1 to NumToPaint do
          begin
            canvas.FillRect(ElementRect);
{$IFDEF DFS_COMPILER_4_UP}
            if BiDiMode = bdRightToLeft then
            begin
              ElementRect.Left := ElementRect.Left - FElementWidth - 1;
              ElementRect.Right := ElementRect.Right - FElementWidth - 1;
            end
            else
            begin
              ElementRect.Left := ElementRect.Left + FElementWidth + 1;
              ElementRect.Right := ElementRect.Right + FElementWidth + 1;
            end;
{$ELSE}
            ElementRect.Left := ElementRect.Left + FElementWidth + 1;
            ElementRect.Right := ElementRect.Right + FElementWidth + 1;
{$ENDIF}
          end;
        end;
      end
      else
      begin
        NumElements := Trunc((ClientHeight - 3) div (FElementWidth + 1));
        NumToPaint := Trunc((FPosition - FMin) / ((FMax - FMin) / NumElements) + 0.00000001);

        if NumToPaint > NumElements then
          NumToPaint := NumElements;
        ElementRect := Rect(ClientRect.Left + 2, ClientRect.Bottom - FElementWidth - 2, ClientRect.Right - 2,
          ClientRect.Bottom - 2);

        if NumToPaint > 0 then
        begin
          Brush.Color := FElementColor;
          Brush.Style := bsSolid;
          for Painted := 1 to NumToPaint do
          begin
            canvas.FillRect(ElementRect);
            ElementRect.Top := ElementRect.Top - (FElementWidth + 1);
            ElementRect.Bottom := ElementRect.Bottom - (FElementWidth + 1);
          end;
        end;
      end;
    end
    else
    begin
      if (FOrientation = pbHorizontal) and (FPosition > 0) then
      begin
        Brush.Color := FElementColor;
        canvas.FillRect(Rect(2, 2, ClientRect.Left + 2 + ((FPosition * (ClientWidth - 4)) div (FMax - FMin)),
            ClientRect.Bottom - 2));
      end
      else
      begin
        Brush.Color := FElementColor;
        canvas.FillRect(Rect(2, ClientRect.Bottom - 2 - ((FPosition * (ClientHeight - 4)) div (FMax - FMin)),
            ClientRect.Right - 2, ClientRect.Bottom - 2));
      end;
    end;
  end;
end;

end.
