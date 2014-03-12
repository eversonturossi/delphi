unit TFlatHintUnit;

interface

uses
  Classes, Windows, Graphics, Messages, Controls, Forms, SysUtils, FlatUtilitys;

type
  TFlatHint = class(TComponent)
  private
    FHintFont: TFont;
    FBackgroundColor: TColor;
    FBorderColor: TColor;
    FArrowBackgroundColor: TColor;
    FArrowColor: TColor;
    FHintWidth: Integer;
    FOnShowHint: TShowHintEvent;
{$IFDEF DFS_DELPHI_4_UP}
    FBidiMode: TBidiMode;
{$ENDIF}
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetHintFont(Value: TFont);
    procedure GetHintInfo(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
{$IFDEF DFS_DELPHI_4_UP}
    procedure SetBidiMode(const Value: TBidiMode);
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property ColorBackground: TColor index 0 read FBackgroundColor write SetColors default clWhite;
    property ColorBorder: TColor index 1 read FBorderColor write SetColors default clBlack;
    property ColorArrowBackground: TColor index 2 read FArrowBackgroundColor write SetColors default $0053D2FF;
    property ColorArrow: TColor index 3 read FArrowColor write SetColors default clBlack;
    property MaxHintWidth: Integer read FHintWidth write FHintWidth default 200;
    property Font: TFont read FHintFont write SetHintFont;
    property OnShowHint: TShowHintEvent read FOnShowHint write FOnShowHint;
{$IFDEF DFS_DELPHI_4_UP}
    property BidiMode: TBidiMode read FBidiMode write SetBidiMode;
{$ENDIF}
  end;

  TFlatHintWindow = class(THintWindow)
  private
    FArrowPos: TArrowPos;
    FArrowPoint: TPoint;
    FHint: TFlatHint;
    function FindFlatHint: TFlatHint;
  protected
    procedure Paint; override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    procedure ActivateHint(HintRect: TRect; const AHint: string); Override;
  end;

implementation

var
  HintControl: TControl; // control the tooltip belongs to

constructor TFlatHint.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  if not(csDesigning in ComponentState) then
  begin
    HintWindowClass := TFlatHintWindow;

    with Application do
    begin
      ShowHint := not ShowHint;
      ShowHint := not ShowHint;
      OnShowHint := GetHintInfo;

      HintShortPause := 25;
      HintPause := 500;
      HintHidePause := 5000;
    end;
  end;

  FBackgroundColor := clWhite;
  FBorderColor := clBlack;
  FArrowBackgroundColor := $0053D2FF;
  FArrowColor := clBlack;
  FHintWidth := 200;

  FHintFont := TFont.Create;
end;

destructor TFlatHint.Destroy;
begin
  FHintFont.Free;
  inherited Destroy;
end;

procedure TFlatHint.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FBackgroundColor := Value;
    1:
      FBorderColor := Value;
    2:
      FArrowBackgroundColor := Value;
    3:
      FArrowColor := Value;
  end;
end;

procedure TFlatHint.SetHintFont(Value: TFont);
begin
  FHintFont.Assign(Value);
end;

procedure TFlatHint.GetHintInfo(var HintStr: string; var CanShow: Boolean; var HintInfo: THintInfo);
begin
  if Assigned(FOnShowHint) then
    FOnShowHint(HintStr, CanShow, HintInfo);
  HintControl := HintInfo.HintControl;
end;
{$IFDEF DFS_DELPHI_4_UP}

procedure TFlatHint.SetBidiMode(const Value: TBidiMode);
begin
  if FBidiMode <> Value then
    FBidiMode := Value;
end;
{$ENDIF}
{ TFlatHintWindow }

function TFlatHintWindow.FindFlatHint: TFlatHint;
var
  currentComponent: Integer;
begin
  Result := nil;

  with Application.MainForm do
    for currentComponent := 0 to ComponentCount - 1 do
      if Components[currentComponent] is TFlatHint then
      begin
        Result := TFlatHint(Components[currentComponent]);
        Break;
      end;
end;

procedure TFlatHintWindow.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style - WS_BORDER;
end;

procedure TFlatHintWindow.Paint;
var
  ArrowRect, TextRect: TRect;
begin
  // Set the Rect's
  case FArrowPos of
    NW, SW:
      begin
        ArrowRect := Rect(ClientRect.Left + 1, ClientRect.Top + 1, ClientRect.Left + 15, ClientRect.Bottom - 1);
        TextRect := Rect(ClientRect.Left + 15, ClientRect.Top + 1, ClientRect.Right - 1, ClientRect.Bottom - 1);
      end;
    NE, SE:
      begin
        ArrowRect := Rect(ClientRect.Right - 15, ClientRect.Top + 1, ClientRect.Right - 1, ClientRect.Bottom - 1);
        TextRect := Rect(ClientRect.Left + 1, ClientRect.Top + 1, ClientRect.Right - 15, ClientRect.Bottom - 1);
      end;
  end;

  // DrawBackground
  canvas.brush.color := FHint.FArrowBackgroundColor;
  canvas.FillRect(ArrowRect);
  canvas.brush.color := FHint.FBackgroundColor;
  canvas.FillRect(TextRect);

  // DrawBorder
  canvas.brush.color := FHint.FBorderColor;
  canvas.FrameRect(ClientRect);

  // DrawArrow
  case FArrowPos of
    NW:
      FArrowPoint := Point(ArrowRect.Left + 2, ArrowRect.Top + 2);
    NE:
      FArrowPoint := Point(ArrowRect.Right - 3, ArrowRect.Top + 2);
    SW:
      FArrowPoint := Point(ArrowRect.Left + 2, ArrowRect.Bottom - 3);
    SE:
      FArrowPoint := Point(ArrowRect.Right - 3, ArrowRect.Bottom - 3);
  end;
  canvas.Pen.color := FHint.FArrowColor;
  case FArrowPos of
    NW:
      canvas.Polyline([Point(FArrowPoint.x, FArrowPoint.y), Point(FArrowPoint.x, FArrowPoint.y + 6),
        Point(FArrowPoint.x + 1, FArrowPoint.y + 6), Point(FArrowPoint.x + 1, FArrowPoint.y), Point(FArrowPoint.x + 6,
          FArrowPoint.y), Point(FArrowPoint.x + 6, FArrowPoint.y + 1), Point(FArrowPoint.x + 2, FArrowPoint.y + 1),
        Point(FArrowPoint.x + 2, FArrowPoint.y + 4), Point(FArrowPoint.x + 5, FArrowPoint.y + 7),
        Point(FArrowPoint.x + 6, FArrowPoint.y + 7), Point(FArrowPoint.x + 3, FArrowPoint.y + 4),
        Point(FArrowPoint.x + 3, FArrowPoint.y + 3), Point(FArrowPoint.x + 6, FArrowPoint.y + 6),
        Point(FArrowPoint.x + 7, FArrowPoint.y + 6), Point(FArrowPoint.x + 3, FArrowPoint.y + 2),
        Point(FArrowPoint.x + 4, FArrowPoint.y + 2), Point(FArrowPoint.x + 7, FArrowPoint.y + 5),
        Point(FArrowPoint.x + 7, FArrowPoint.y + 6)]);
    NE:
      canvas.Polyline([Point(FArrowPoint.x, FArrowPoint.y), Point(FArrowPoint.x, FArrowPoint.y + 6),
        Point(FArrowPoint.x - 1, FArrowPoint.y + 6), Point(FArrowPoint.x - 1, FArrowPoint.y), Point(FArrowPoint.x - 6,
          FArrowPoint.y), Point(FArrowPoint.x - 6, FArrowPoint.y + 1), Point(FArrowPoint.x - 2, FArrowPoint.y + 1),
        Point(FArrowPoint.x - 2, FArrowPoint.y + 4), Point(FArrowPoint.x - 5, FArrowPoint.y + 7),
        Point(FArrowPoint.x - 6, FArrowPoint.y + 7), Point(FArrowPoint.x - 3, FArrowPoint.y + 4),
        Point(FArrowPoint.x - 3, FArrowPoint.y + 3), Point(FArrowPoint.x - 6, FArrowPoint.y + 6),
        Point(FArrowPoint.x - 7, FArrowPoint.y + 6), Point(FArrowPoint.x - 3, FArrowPoint.y + 2),
        Point(FArrowPoint.x - 4, FArrowPoint.y + 2), Point(FArrowPoint.x - 7, FArrowPoint.y + 5),
        Point(FArrowPoint.x - 7, FArrowPoint.y + 6)]);
    SW:
      canvas.Polyline([Point(FArrowPoint.x, FArrowPoint.y), Point(FArrowPoint.x, FArrowPoint.y - 6),
        Point(FArrowPoint.x + 1, FArrowPoint.y - 6), Point(FArrowPoint.x + 1, FArrowPoint.y), Point(FArrowPoint.x + 6,
          FArrowPoint.y), Point(FArrowPoint.x + 6, FArrowPoint.y - 1), Point(FArrowPoint.x + 2, FArrowPoint.y - 1),
        Point(FArrowPoint.x + 2, FArrowPoint.y - 4), Point(FArrowPoint.x + 5, FArrowPoint.y - 7),
        Point(FArrowPoint.x + 6, FArrowPoint.y - 7), Point(FArrowPoint.x + 3, FArrowPoint.y - 4),
        Point(FArrowPoint.x + 3, FArrowPoint.y - 3), Point(FArrowPoint.x + 6, FArrowPoint.y - 6),
        Point(FArrowPoint.x + 7, FArrowPoint.y - 6), Point(FArrowPoint.x + 3, FArrowPoint.y - 2),
        Point(FArrowPoint.x + 4, FArrowPoint.y - 2), Point(FArrowPoint.x + 7, FArrowPoint.y - 5),
        Point(FArrowPoint.x + 7, FArrowPoint.y - 6)]);
    SE:
      canvas.Polyline([Point(FArrowPoint.x, FArrowPoint.y), Point(FArrowPoint.x, FArrowPoint.y - 6),
        Point(FArrowPoint.x - 1, FArrowPoint.y - 6), Point(FArrowPoint.x - 1, FArrowPoint.y), Point(FArrowPoint.x - 6,
          FArrowPoint.y), Point(FArrowPoint.x - 6, FArrowPoint.y - 1), Point(FArrowPoint.x - 2, FArrowPoint.y - 1),
        Point(FArrowPoint.x - 2, FArrowPoint.y - 4), Point(FArrowPoint.x - 5, FArrowPoint.y - 7),
        Point(FArrowPoint.x - 6, FArrowPoint.y - 7), Point(FArrowPoint.x - 3, FArrowPoint.y - 4),
        Point(FArrowPoint.x - 3, FArrowPoint.y - 3), Point(FArrowPoint.x - 6, FArrowPoint.y - 6),
        Point(FArrowPoint.x - 7, FArrowPoint.y - 6), Point(FArrowPoint.x - 3, FArrowPoint.y - 2),
        Point(FArrowPoint.x - 4, FArrowPoint.y - 2), Point(FArrowPoint.x - 7, FArrowPoint.y - 5),
        Point(FArrowPoint.x - 7, FArrowPoint.y - 6)]);
  end;

  // DrawHintText
  canvas.brush.Style := bsClear;
  InflateRect(TextRect, -3, -1);
{$IFDEF DFS_COMPILER_4_UP}
  if BidiMode = bdRightToLeft then
    DrawText(canvas.handle, PChar(Caption), Length(Caption), TextRect, DT_RIGHT or DT_WORDBREAK or DT_NOPREFIX)
  else
    DrawText(canvas.handle, PChar(Caption), Length(Caption), TextRect, DT_WORDBREAK or DT_NOPREFIX);
{$ELSE}
  DrawText(canvas.handle, PChar(Caption), Length(Caption), TextRect, DT_WORDBREAK or DT_NOPREFIX);
{$ENDIF}
end;

procedure TFlatHintWindow.ActivateHint(HintRect: TRect; const AHint: string);
var
  curWidth: Byte;
  Pnt: TPoint;
  HintHeight, HintWidth: Integer;
  NordWest, NordEast, SouthWest, SouthEast: TRect;
begin
  Caption := AHint;
  FHint := FindFlatHint;

  if FHint <> nil then
    canvas.Font.Assign(FHint.FHintFont);

  // Calculate width and height
  HintRect.Right := HintRect.Left + FHint.FHintWidth - 22;
{$IFDEF DFS_COMPILER_4_UP}
  if BidiMode = bdRightToLeft then
    DrawText(canvas.handle, @AHint[1], Length(AHint), HintRect, DT_RIGHT or DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX)
  else
    DrawText(canvas.handle, @AHint[1], Length(AHint), HintRect, DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX);
{$ELSE}
  DrawText(canvas.handle, @AHint[1], Length(AHint), HintRect, DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX);
{$ENDIF}
  DrawText(canvas.handle, @AHint[1], Length(AHint), HintRect, DT_CALCRECT or DT_WORDBREAK or DT_NOPREFIX);
  Inc(HintRect.Right, 22);
  Inc(HintRect.Bottom, 6);

  // Divide the screen in 4 pices
  NordWest := Rect(0, 0, Screen.Width div 2, Screen.Height div 2);
  NordEast := Rect(Screen.Width div 2, 0, Screen.Width, Screen.Height div 2);
  SouthWest := Rect(0, Screen.Height div 2, Screen.Width div 2, Screen.Height);
  SouthEast := Rect(Screen.Width div 2, Screen.Height div 2, Screen.Width, Screen.Height);

  GetCursorPos(Pnt);

  if PtInRect(NordWest, Pnt) then
    FArrowPos := NW
  else if PtInRect(NordEast, Pnt) then
    FArrowPos := NE
  else if PtInRect(SouthWest, Pnt) then
    FArrowPos := SW
  else
    FArrowPos := SE;

  // Calculate the position of the hint
  if FArrowPos = NW then
    curWidth := 12
  else
    curWidth := 5;

  HintHeight := HintRect.Bottom - HintRect.Top;
  HintWidth := HintRect.Right - HintRect.Left;

  case FArrowPos of
    NW:
      HintRect := Rect(Pnt.x + curWidth, Pnt.y + curWidth, Pnt.x + HintWidth + curWidth, Pnt.y + HintHeight + curWidth);
    NE:
      HintRect := Rect(Pnt.x - HintWidth - curWidth, Pnt.y + curWidth, Pnt.x - curWidth, Pnt.y + HintHeight + curWidth);
    SW:
      HintRect := Rect(Pnt.x + curWidth, Pnt.y - HintHeight - curWidth, Pnt.x + HintWidth + curWidth, Pnt.y - curWidth);
    SE:
      HintRect := Rect(Pnt.x - HintWidth - curWidth, Pnt.y - HintHeight - curWidth, Pnt.x - curWidth, Pnt.y - curWidth);
  end;

  BoundsRect := HintRect;

  Pnt := ClientToScreen(Point(0, 0));

  SetWindowPos(handle, HWND_TOPMOST, Pnt.x, Pnt.y, 0, 0, SWP_SHOWWINDOW or SWP_NOACTIVATE or SWP_NOSIZE);
end;

end.
