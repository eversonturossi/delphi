unit TFlatAnimationUnit;

{ *************************************************************** }
{ TFlatAnimation }
{ Copyright ©1999 Lloyd Kinsella. }
{ }
{ FlatStyle is Copyright ©1998-99 Maik Porkert. }
{ *************************************************************** }

interface

{$I DFS.inc}

uses Windows, SysUtils, Classes, Controls, Graphics, Messages, StdCtrls,
  ExtCtrls, FlatUtilitys;

type
  TOnFrameChange = procedure(Sender: TObject; FrameNumber: Integer) of object;
  TAnimationLayout = (alAcross, alDown);

type
  TFlatAnimation = class(TGraphicControl)
  private
    FUseAdvColors: Boolean;
    FAdvColorHighlight: TAdvColors;
    FAdvColorShadow: TAdvColors;
    FTransparent: Boolean;
    FAnimation: TBitmap;
    FFrames: Integer;
    FFrameWidth: Integer;
    FFrame: Integer;
    FInterval: Integer;
    FTransColor: TColor;
    FActive: Boolean;
    FLoop: Boolean;
    FReverse: Boolean;
    FTimer: TTimer;
    FHighlightColor: TColor;
    FShadowColor: TColor;
    FBorder: Boolean;
    FFrameChange: TOnFrameChange;
    FAnimationLayout: TAnimationLayout;
    procedure SetAnimation(Value: TBitmap);
    procedure SetFrames(Value: Integer);
    procedure SetFrameWidth(Value: Integer);
    procedure SetFrame(Value: Integer);
    procedure SetActive(Value: Boolean);
    procedure SetTransparent(Value: Boolean);
    procedure SetLoop(Value: Boolean);
    procedure SetReverse(Value: Boolean);
    procedure SetInterval(Value: Integer);
    procedure SetBorder(Value: Boolean);
    procedure DoTimer(Sender: TObject);
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure SetAnimationLayout(const Value: TAnimationLayout);
  protected
    procedure Paint; override;
    procedure CalcAdvColors;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property AdvColorHighlight: TAdvColors index 0 read FAdvColorHighlight write SetAdvColors default 50;
    property AdvColorShadow: TAdvColors index 1 read FAdvColorShadow write SetAdvColors default 50;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default False;
    property Color;
    property Animation: TBitmap read FAnimation write SetAnimation;
    property Frames: Integer read FFrames write SetFrames;
    property FrameWidth: Integer read FFrameWidth write SetFrameWidth;
    property Frame: Integer read FFrame write SetFrame default 1;
    property Interval: Integer read FInterval write SetInterval;
    property ColorTransparent: TColor index 0 read FTransColor write SetColors default clFuchsia;
    property ColorHighLight: TColor index 1 read FHighlightColor write SetColors;
    property ColorShadow: TColor index 2 read FShadowColor write SetColors;
    property Active: Boolean read FActive write SetActive;
    property Loop: Boolean read FLoop write SetLoop;
    property Reverse: Boolean read FReverse write SetReverse;
    property Border: Boolean read FBorder write SetBorder;
    property AnimationLayout: TAnimationLayout read FAnimationLayout write SetAnimationLayout;
    property OnFrameChange: TOnFrameChange read FFrameChange write FFrameChange;
    property Transparent: Boolean read FTransparent write SetTransparent;
    property Align;
    property Enabled;
    property ParentColor;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$IFDEF DFS_DELPHI_4_UP}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

implementation

constructor TFlatAnimation.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAnimation := TBitmap.Create;
  ControlStyle := ControlStyle + [csOpaque];
  SetBounds(0, 0, 60, 60);
  AdvColorHighlight := 50;
  AdvColorShadow := 50;
  FrameWidth := 30;
  Frames := 1;
  Frame := 0;
  ColorTransparent := clFuchsia;
  ColorHighLight := $00996633;
  ColorShadow := $00996633;
  Active := False;
  Loop := True;
  Interval := 100; // 1 Second
end;

destructor TFlatAnimation.Destroy;
begin
  FAnimation.Free;
  inherited Destroy;
end;

procedure TFlatAnimation.Paint;
var
  X, Y, Pos: Integer;
  SrcRect, DestRect: TRect;
  tempGlyph: TBitmap;
begin
  case FAnimationLayout of
    alAcross:
      begin
        X := Width div 2 - (FAnimation.Width div FFrames) div 2;
        Y := Height div 2 - FAnimation.Height div 2;
        Pos := (FAnimation.Width div FFrames) * FFrame;
        DestRect := Rect(X, Y, X + (FAnimation.Width div FFrames), Y + FAnimation.Height);
        SrcRect := Rect(Pos, 0, Pos + (FAnimation.Width div FFrames), FAnimation.Height);
      end;
    alDown:
      begin
        X := Width div 2 - FFrameWidth div 2;
        Y := Height div 2 - (FAnimation.Height div FFrames) div 2;
        Pos := (FAnimation.Height div FFrames) * FFrame;
        DestRect := Rect(X, Y, X + FFrameWidth, Y + (FAnimation.Height div FFrames));
        SrcRect := Rect(0, Pos, FFrameWidth, Pos + FFrameWidth);
      end;
  end;
  if Transparent then
  begin
    tempGlyph := TBitmap.Create;
    tempGlyph.Height := Height;
    tempGlyph.Width := Width;
    tempGlyph.Canvas.Brush.Color := Color;
    tempGlyph.Canvas.BrushCopy(DestRect, FAnimation, SrcRect, FTransColor);
    Canvas.CopyRect(DestRect, tempGlyph.Canvas, DestRect);
    tempGlyph.Free;
  end
  else
  begin
    Canvas.CopyRect(DestRect, FAnimation.Canvas, SrcRect);
  end;
  if FBorder = True then
  begin
    with Canvas do
    begin
      with ClientRect do
      begin
        Pen.Style := psSolid;
        Pen.Width := 1;
        Pen.Color := FHighlightColor;
        MoveTo(Left, Top);
        LineTo(Right, Top);
        MoveTo(Left, Top);
        LineTo(Left, Bottom);
        Pen.Color := FShadowColor;
        MoveTo(Left + 1, Bottom - 1);
        LineTo(Right, Bottom - 1);
        MoveTo(Right - 1, Top);
        LineTo(Right - 1, Bottom);
      end;
    end;
  end;
  if (csDesigning in ComponentState) and (not FBorder) then
  begin
    with Canvas do
    begin
      Pen.Style := psDot;
      Pen.Color := clBlack;
      Brush.Style := bsClear;
      Rectangle(0, 0, ClientWidth, ClientHeight);
    end;
  end;
end;

procedure TFlatAnimation.SetAnimation(Value: TBitmap);
begin
  if Value <> FAnimation then
  begin
    FAnimation.Assign(Value);
    if not FAnimation.Empty then
    begin
      if FAnimation.Width > FAnimation.Height then
        FAnimationLayout := alAcross
      else
        FAnimationLayout := alDown;
      case FAnimationLayout of
        alAcross:
          if FAnimation.Width mod FAnimation.Height = 0 then
            FFrames := FAnimation.Width div FAnimation.Height;
        alDown:
          if FAnimation.Height mod FAnimation.Width = 0 then
            FFrames := FAnimation.Height div FAnimation.Width;
      end;
      FFrame := 1;
      case FAnimationLayout of
        alAcross:
          FFrameWidth := FAnimation.Width div FFrames;
        alDown:
          FFrameWidth := FAnimation.Height div FFrames;
      end;
      FTransColor := FAnimation.Canvas.Pixels[0, FAnimation.Height - 1];
    end;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetFrames(Value: Integer);
begin
  if Value <> FFrames then
  begin
    FFrames := Value;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetFrameWidth(Value: Integer);
begin
  if Value <> FFrameWidth then
  begin
    FFrameWidth := Value;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetFrame(Value: Integer);
var
  Temp: Integer;
begin
  if Value < 0 then
  begin
    Temp := FFrames - 1
  end
  else
  begin
    Temp := Value mod FFrames;
  end;
  if Temp <> FFrame then
  begin
    FFrame := Temp;
    if Assigned(FFrameChange) then
    begin
      FFrameChange(Self, FFrame);
    end;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetActive(Value: Boolean);
begin
  if Value <> FActive then
  begin
    FActive := Value;
    if not Value then
    begin
      FTimer.Free;
      FTimer := nil;
    end
    else if FInterval > 0 then
    begin
      FTimer := TTimer.Create(Self);
      FTimer.Interval := FInterval;
      FTimer.OnTimer := DoTimer;
    end;
  end;
end;

procedure TFlatAnimation.SetTransparent(Value: Boolean);
begin
  if Value <> FTransparent then
  begin
    FTransparent := Value;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetLoop(Value: Boolean);
begin
  if Value <> FLoop then
  begin
    FLoop := Value;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetReverse(Value: Boolean);
begin
  if Value <> FReverse then
  begin
    FReverse := Value;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetInterval(Value: Integer);
begin
  if Value <> FInterval then
  begin
    FInterval := Value;
    if FActive then
      FTimer.Interval := Value;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetBorder(Value: Boolean);
begin
  if Value <> FBorder then
  begin
    FBorder := Value;
    Invalidate;
  end;
end;

procedure TFlatAnimation.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FTransColor := Value;
    1:
      FHighlightColor := Value;
    2:
      FShadowColor := Value;
  end;
  Invalidate;
end;

procedure TFlatAnimation.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FHighlightColor := CalcAdvancedColor(Color, FHighlightColor, FAdvColorHighlight, lighten);
    FShadowColor := CalcAdvancedColor(Color, FShadowColor, FAdvColorShadow, darken);
  end;
end;

procedure TFlatAnimation.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorHighlight := Value;
    1:
      FAdvColorShadow := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatAnimation.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    ParentColor := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatAnimation.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatAnimation.CMParentColorChanged(var Message: TWMNoParams);
begin
  inherited;
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatAnimation.WMSize(var Message: TWMSize);
begin
  inherited;
  Invalidate;
end;

procedure TFlatAnimation.DoTimer(Sender: TObject);

  procedure ChkStop;
  begin
    if not FLoop then
    begin
      FActive := False;
      FTimer.Free;
      FTimer := nil;
    end;
  end;

begin
  if FReverse then
  begin
    Frame := Frame - 1;
    if FFrame = 0 then
      ChkStop;
  end
  else
  begin
    Frame := Frame + 1;
    if FFrame = Frames - 1 then
      ChkStop;
  end;
end;

procedure TFlatAnimation.SetAnimationLayout(const Value: TAnimationLayout);
begin
  FAnimationLayout := Value;
  Invalidate;
end;

end.
