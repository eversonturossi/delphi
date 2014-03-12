unit TFlatScrollbarUnit;

{ ****************************************************************************** }
{ }
{ FlatStyle Scrollbar Unit }
{ }
{ Copyright ©2000 Lloyd Kinsella. }
{ }
{ FlatStyle is Copyright ©1998-2000 Maik Porkert. }
{ }
{ Notes: }
{ I spent about a week working on this code, as up until now FlatStyle did }
{ not have any kind of flat Encarta like scrollbar. }
{ }
{ There are "missing" features, notably if you click on the track the thumb }
{ does not auto scroll to where you clicked. Also clicking on the scroll }
{ buttons forces the thumb to be often too responsive. }
{ GetScrollInfo and SetScrollInfo Win32 API's do not work for some reason, }
{ hope to fix this soon. }
{ }
{ If you have any ideas of improvement or extra functionality then either }
{ send me the idea in an e-mail or modify a copy of this code and send it to }
{ me. I cannot promise to implement your idea but I will look into it and }
{ discuss its merits with Maik and other FlatStyle developers. }
{ }
{ I would ask that you please do not release your own FlatStyle/Encarta }
{ style scrollbars, I worked hard on this for your benefit as well as my own. }
{ }
{ If you have any ideas, code or information on the following topics, }
{ then please send it to me, it will be invaluable: }
{ }
{ Custom Scrollbars in a TScrollbox (Or similar) }
{ Custom Scrollbars in a TMemo, TRichEdit, TListBox etc... }
{ }
{ This is because the current TFlatMemo and friends use the standard }
{ Windows scrollbars and I would love to hook the TFlatScrollbar up to them! }
{ Try out hooking the scrollbars up to TMemos etc, then send us the code, }
{ but I request it MUST be compatible with Delphi 3 and in original code and }
{ not pre-compiled form (i.e DCU). }
{ }
{ E-Mail: lloydk@iname.com }
{ Web:    http://www.flatstyle.de/ }
{ }
{ ****************************************************************************** }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, TFlatButtonUnit, FlatGraphics;

{ TFlatScrollbarThumb }

type
  TFlatScrollbarThumb = class(TFlatButton)
  private
    FDown: Boolean;
    FOldX, FOldY: Integer;
    FTopLimit: Integer;
    FBottomLimit: Integer;
  protected
    constructor Create(AOwner: TComponent); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    property Color;
  end;

  { TFlatScrollbarTrack }

type
  TFlatScrollbarTrack = class(TCustomControl)
  private
    FThumb: TFlatScrollbarThumb;

    FKind: TScrollBarKind;

    FSmallChange: Integer;
    FLargeChange: Integer;
    FMin: Integer;
    FMax: Integer;
    FPosition: Integer;

    procedure SetSmallChange(Value: Integer);
    procedure SetLargeChange(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetPosition(Value: Integer);
    procedure SetKind(Value: TScrollBarKind);

    procedure WMSize(var Message: TMessage); message WM_SIZE;

    function ThumbFromPosition: Integer;
    function PositionFromThumb: Integer;

    procedure DoPositionChange;

    procedure DoThumbHighlightColor(Value: TColor);
    procedure DoThumbShadowColor(Value: TColor);
    procedure DoThumbBorderColor(Value: TColor);
    procedure DoThumbFocusedColor(Value: TColor);
    procedure DoThumbDownColor(Value: TColor);
    procedure DoThumbColor(Value: TColor);

    procedure DoHScroll(var Message: TWMScroll);
    procedure DoVScroll(var Message: TWMScroll);
    procedure DoEnableArrows(var Message: TMessage);
    procedure DoGetPos(var Message: TMessage);
    procedure DoGetRange(var Message: TMessage);
    procedure DoSetPos(var Message: TMessage);
    procedure DoSetRange(var Message: TMessage);
    procedure DoKeyDown(var Message: TWMKeyDown);
  protected
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;
  published
    property Align;
    property Color;
    property ParentColor;
    property Min: Integer read FMin write SetMin;
    property Max: Integer read FMax write SetMax;
    property SmallChange: Integer read FSmallChange write SetSmallChange;
    property LargeChange: Integer read FLargeChange write SetLargeChange;
    property Position: Integer read FPosition write SetPosition;
    property Kind: TScrollBarKind read FKind write SetKind;
  end;

  { TFlatScrollbarButton }

type
  TFlatScrollbarButton = class(TFlatButton)
  private
    FNewDown: Boolean;
    FTimer: TTimer;
    FOnDown: TNotifyEvent;
    procedure DoTimer(Sender: TObject);
  protected
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  published
    property Align;
    property OnDown: TNotifyEvent read FOnDown write FOnDown;
  end;

  { TFlatScrollbar }

type
  TFlatOnScroll = procedure(Sender: TObject; ScrollPos: Integer) of object;

type
  TFlatScrollbar = class(TCustomControl)
  private
    FTrack: TFlatScrollbarTrack;

    FBtnOne: TFlatScrollbarButton;
    FBtnTwo: TFlatScrollbarButton;

    FMin: Integer;
    FMax: Integer;
    FSmallChange: Integer;
    FLargeChange: Integer;
    FPosition: Integer;
    FKind: TScrollBarKind;

    FButtonHighlightColor: TColor;
    FButtonShadowColor: TColor;
    FButtonBorderColor: TColor;
    FButtonFocusedColor: TColor;
    FButtonDownColor: TColor;
    FButtonColor: TColor;
    FThumbHighlightColor: TColor;
    FThumbShadowColor: TColor;
    FThumbBorderColor: TColor;
    FThumbFocusedColor: TColor;
    FThumbDownColor: TColor;
    FThumbColor: TColor;

    FOnScroll: TFlatOnScroll;

    procedure SetSmallChange(Value: Integer);
    procedure SetLargeChange(Value: Integer);
    procedure SetMin(Value: Integer);
    procedure SetMax(Value: Integer);
    procedure SetPosition(Value: Integer);
    procedure SetKind(Value: TScrollBarKind);

    procedure SetButtonHighlightColor(Value: TColor);
    procedure SetButtonShadowColor(Value: TColor);
    procedure SetButtonBorderColor(Value: TColor);
    procedure SetButtonFocusedColor(Value: TColor);
    procedure SetButtonDownColor(Value: TColor);
    procedure SetButtonColor(Value: TColor);
    procedure SetThumbHighlightColor(Value: TColor);
    procedure SetThumbShadowColor(Value: TColor);
    procedure SetThumbBorderColor(Value: TColor);
    procedure SetThumbFocusedColor(Value: TColor);
    procedure SetThumbDownColor(Value: TColor);
    procedure SetThumbColor(Value: TColor);

    procedure BtnOneClick(Sender: TObject);
    procedure BtnTwoClick(Sender: TObject);

    procedure EnableBtnOne(Value: Boolean);
    procedure EnableBtnTwo(Value: Boolean);

    procedure DoScroll;

    procedure WMSize(var Message: TWMSize); message WM_SIZE;

    procedure CNHScroll(var Message: TWMScroll); message WM_HSCROLL;
    procedure CNVScroll(var Message: TWMScroll); message WM_VSCROLL;
    procedure SBMEnableArrows(var Message: TMessage); message SBM_ENABLE_ARROWS;
    procedure SBMGetPos(var Message: TMessage); message SBM_GETPOS;
    procedure SBMGetRange(var Message: TMessage); message SBM_GETRANGE;
    procedure SBMSetPos(var Message: TMessage); message SBM_SETPOS;
    procedure SBMSetRange(var Message: TMessage); message SBM_SETRANGE;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
  protected
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  public
  published
    property Min: Integer read FMin write SetMin default 0;
    property Max: Integer read FMax write SetMax default 100;
    property SmallChange: Integer read FSmallChange write SetSmallChange default 1;
    property LargeChange: Integer read FLargeChange write SetLargeChange default 1;
    property Position: Integer read FPosition write SetPosition default 0;
    property Kind: TScrollBarKind read FKind write SetKind default sbVertical;
    property OnScroll: TFlatOnScroll read FOnScroll write FOnScroll;
    property ButtonHighlightColor: TColor read FButtonHighlightColor write SetButtonHighlightColor;
    property ButtonShadowColor: TColor read FButtonShadowColor write SetButtonShadowColor;
    property ButtonBorderColor: TColor read FButtonBorderColor write SetButtonBorderColor;
    property ButtonFocusedColor: TColor read FButtonFocusedColor write SetButtonFocusedColor;
    property ButtonDownColor: TColor read FButtonDownColor write SetButtonDownColor;
    property ButtonColor: TColor read FButtonColor write SetButtonColor;
    property ThumbHighlightColor: TColor read FThumbHighlightColor write SetThumbHighlightColor;
    property ThumbShadowColor: TColor read FThumbShadowColor write SetThumbShadowColor;
    property ThumbBorderColor: TColor read FThumbBorderColor write SetThumbBorderColor;
    property ThumbFocusedColor: TColor read FThumbFocusedColor write SetThumbFocusedColor;
    property ThumbDownColor: TColor read FThumbDownColor write SetThumbDownColor;
    property ThumbColor: TColor read FThumbColor write SetThumbColor;
    property Align;
    property Color;
    property ParentColor;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyUp;
    property OnStartDrag;
  end;

procedure Register;

implementation

{$R TFlatScrollbarUnit.RES}
{ TFlatScrollbarTrackThumb }

constructor TFlatScrollbarThumb.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

procedure TFlatScrollbarThumb.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  iTop: Integer;
begin
  if TFlatScrollbarTrack(Parent).Kind = sbVertical then
  begin
    FTopLimit := 0;
    FBottomLimit := TFlatScrollbarTrack(Parent).Height;
    if FDown = True then
    begin
      iTop := Top + Y - FOldY;
      if iTop < FTopLimit then
      begin
        iTop := FTopLimit;
      end;
      if (iTop > FBottomLimit) or ((iTop + Height) > FBottomLimit) then
      begin
        iTop := FBottomLimit - Height;
      end;
      Top := iTop;
    end;
  end
  else
  begin
    FTopLimit := 0;
    FBottomLimit := TFlatScrollbarTrack(Parent).Width;
    if FDown = True then
    begin
      iTop := Left + X - FOldX;
      if iTop < FTopLimit then
      begin
        iTop := FTopLimit;
      end;
      if (iTop > FBottomLimit) or ((iTop + Width) > FBottomLimit) then
      begin
        iTop := FBottomLimit - Width;
      end;
      Left := iTop;
    end;
  end;
  TFlatScrollbarTrack(Parent).FPosition := TFlatScrollbarTrack(Parent).PositionFromThumb;
  TFlatScrollbarTrack(Parent).DoPositionChange;
  inherited MouseMove(Shift, X, Y);
end;

procedure TFlatScrollbarThumb.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDown := False;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TFlatScrollbarThumb.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbleft) and not FDown then
    FDown := True;
  FOldX := X;
  FOldY := Y;
  inherited MouseDown(Button, Shift, X, Y);
end;

{ TFlatScrollbarTrack }

constructor TFlatScrollbarTrack.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Color := ecLightKaki;

  FThumb := TFlatScrollbarThumb.Create(Self);
  FThumb.Color := ecLightBrown;
  FThumb.ColorFocused := ecLightBrown;
  FThumb.ColorDown := ecLightBrown;
  FThumb.ColorBorder := ecLightBrown;
  FThumb.ColorHighLight := ecLightBrown;
  FThumb.ColorShadow := ecLightBrown;
  FThumb.Height := 17;
  InsertControl(FThumb);

  FMin := 0;
  FMax := 100;
  FSmallChange := 1;
  FLargeChange := 1;
  FPosition := 0;

  FThumb.Top := ThumbFromPosition;
end;

destructor TFlatScrollbarTrack.Destroy;
begin
  FThumb.Free;
  inherited Destroy;
end;

procedure TFlatScrollbarTrack.Paint;
begin
  with Canvas do
  begin
    Brush.Color := Color;
    FillRect(ClientRect);
  end;
end;

procedure TFlatScrollbarTrack.SetSmallChange(Value: Integer);
begin
  if Value <> FSmallChange then
  begin
    FSmallChange := Value;
  end;
end;

procedure TFlatScrollbarTrack.SetLargeChange(Value: Integer);
begin
  if Value <> FLargeChange then
  begin
    FLargeChange := Value;
  end;
end;

procedure TFlatScrollbarTrack.SetMin(Value: Integer);
begin
  if Value <> FMin then
  begin
    FMin := Value;
    FThumb.Top := ThumbFromPosition;
  end;
end;

procedure TFlatScrollbarTrack.SetMax(Value: Integer);
begin
  if Value <> FMax then
  begin
    FMax := Value;
    FThumb.Top := ThumbFromPosition;
  end;
end;

procedure TFlatScrollbarTrack.SetPosition(Value: Integer);
begin
  FPosition := Value;
  if Position > Max then
  begin
    Position := Max;
  end;
  if Position < Min then
  begin
    Position := Min;
  end;
  case FKind of
    sbVertical:
      FThumb.Top := ThumbFromPosition;
    sbHorizontal:
      FThumb.Left := ThumbFromPosition;
  end;
end;

procedure TFlatScrollbarTrack.SetKind(Value: TScrollBarKind);
begin
  if Value <> FKind then
  begin
    FKind := Value;
    case FKind of
      sbVertical:
        FThumb.Height := 17;
      sbHorizontal:
        FThumb.Width := 17;
    end;
  end;
  Position := FPosition;
end;

procedure TFlatScrollbarTrack.WMSize(var Message: TMessage);
begin
  if FKind = sbVertical then
  begin
    FThumb.Width := Width;
  end
  else
  begin
    FThumb.Height := Height;
  end;
end;

function TFlatScrollbarTrack.ThumbFromPosition: Integer;
var
  iHW, iMin, iMax, iPosition, iResult: Integer;
begin
  iHW := 0;
  case FKind of
    sbVertical:
      iHW := Height - FThumb.Height;
    sbHorizontal:
      iHW := Width - FThumb.Width;
  end;
  iMin := FMin;
  iMax := FMax;
  iPosition := FPosition;
  iResult := Round((iHW / (iMax - iMin)) * iPosition);
  Result := iResult;
end;

function TFlatScrollbarTrack.PositionFromThumb: Integer;
var
  iHW, iMin, iMax, iPosition, iResult: Integer;
begin
  iHW := 0;
  case FKind of
    sbVertical:
      iHW := Height - FThumb.Height;
    sbHorizontal:
      iHW := Width - FThumb.Width;
  end;
  iMin := FMin;
  iMax := FMax;
  iPosition := 0;
  case FKind of
    sbVertical:
      iPosition := FThumb.Top;
    sbHorizontal:
      iPosition := FThumb.Left;
  end;
  iResult := Round(iPosition / iHW * (iMax - iMin));
  Result := iResult;
end;

procedure TFlatScrollbarTrack.DoPositionChange;
begin
  TFlatScrollbar(Parent).FPosition := Position;
  TFlatScrollbar(Parent).DoScroll;
end;

procedure TFlatScrollbarTrack.DoThumbHighlightColor(Value: TColor);
begin
  FThumb.ColorHighLight := Value;
end;

procedure TFlatScrollbarTrack.DoThumbShadowColor(Value: TColor);
begin
  FThumb.ColorShadow := Value;
end;

procedure TFlatScrollbarTrack.DoThumbBorderColor(Value: TColor);
begin
  FThumb.ColorBorder := Value;
end;

procedure TFlatScrollbarTrack.DoThumbFocusedColor(Value: TColor);
begin
  FThumb.ColorFocused := Value;
end;

procedure TFlatScrollbarTrack.DoThumbDownColor(Value: TColor);
begin
  FThumb.ColorDown := Value;
end;

procedure TFlatScrollbarTrack.DoThumbColor(Value: TColor);
begin
  FThumb.Color := Value;
end;

procedure TFlatScrollbarTrack.DoHScroll(var Message: TWMScroll);
var
  iPosition: Integer;
begin
  case Message.ScrollCode of
    SB_BOTTOM:
      Position := Max;
    SB_LINELEFT:
      begin
        iPosition := Position;
        Dec(iPosition, SmallChange);
        Position := iPosition;
      end;
    SB_LINERIGHT:
      begin
        iPosition := Position;
        Inc(iPosition, SmallChange);
        Position := iPosition;
      end;
    SB_PAGELEFT:
      begin
        iPosition := Position;
        Dec(iPosition, LargeChange);
        Position := iPosition;
      end;
    SB_PAGERIGHT:
      begin
        iPosition := Position;
        Inc(iPosition, LargeChange);
        Position := iPosition;
      end;
    SB_THUMBPOSITION, SB_THUMBTRACK:
      Position := Message.Pos;
    SB_TOP:
      Position := Min;
  end;
  Message.Result := 0;
end;

procedure TFlatScrollbarTrack.DoVScroll(var Message: TWMScroll);
var
  iPosition: Integer;
begin
  case Message.ScrollCode of
    SB_BOTTOM:
      Position := Max;
    SB_LINEUP:
      begin
        iPosition := Position;
        Dec(iPosition, SmallChange);
        Position := iPosition;
      end;
    SB_LINEDOWN:
      begin
        iPosition := Position;
        Inc(iPosition, SmallChange);
        Position := iPosition;
      end;
    SB_PAGEUP:
      begin
        iPosition := Position;
        Dec(iPosition, LargeChange);
        Position := iPosition;
      end;
    SB_PAGEDOWN:
      begin
        iPosition := Position;
        Inc(iPosition, LargeChange);
        Position := iPosition;
      end;
    SB_THUMBPOSITION, SB_THUMBTRACK:
      Position := Message.Pos;
    SB_TOP:
      Position := Min;
  end;
  Message.Result := 0;
end;

procedure TFlatScrollbarTrack.DoEnableArrows(var Message: TMessage);
begin
  if Message.WParam = ESB_DISABLE_BOTH then
  begin
    TFlatScrollbar(Parent).EnableBtnOne(False);
    TFlatScrollbar(Parent).EnableBtnTwo(False);
  end;
  if Message.WParam = ESB_DISABLE_DOWN then
  begin
    if FKind = sbVertical then
      TFlatScrollbar(Parent).EnableBtnTwo(False);
  end;
  if Message.WParam = ESB_DISABLE_LTUP then
  begin
    TFlatScrollbar(Parent).EnableBtnOne(False);
  end;
  if Message.WParam = ESB_DISABLE_LEFT then
  begin
    if FKind = sbHorizontal then
      TFlatScrollbar(Parent).EnableBtnOne(False);
  end;
  if Message.WParam = ESB_DISABLE_RTDN then
  begin
    TFlatScrollbar(Parent).EnableBtnTwo(False);
  end;
  if Message.WParam = ESB_DISABLE_UP then
  begin
    if FKind = sbVertical then
      TFlatScrollbar(Parent).EnableBtnOne(False);
  end;
  if Message.WParam = ESB_ENABLE_BOTH then
  begin
    TFlatScrollbar(Parent).EnableBtnOne(True);
    TFlatScrollbar(Parent).EnableBtnTwo(True);
  end;
  Message.Result := 1;
end;

procedure TFlatScrollbarTrack.DoGetPos(var Message: TMessage);
begin
  Message.Result := Position;
end;

procedure TFlatScrollbarTrack.DoGetRange(var Message: TMessage);
begin
  Message.WParam := Min;
  Message.LParam := Max;
end;

procedure TFlatScrollbarTrack.DoSetPos(var Message: TMessage);
begin
  Position := Message.WParam;
end;

procedure TFlatScrollbarTrack.DoSetRange(var Message: TMessage);
begin
  Min := Message.WParam;
  Max := Message.LParam;
end;

procedure TFlatScrollbarTrack.DoKeyDown(var Message: TWMKeyDown);
var
  iPosition: Integer;
begin
  iPosition := Position;
  case Message.CharCode of
    VK_PRIOR:
      Dec(iPosition, LargeChange);
    VK_NEXT:
      Inc(iPosition, LargeChange);
    VK_UP:
      if FKind = sbVertical then
        Dec(iPosition, SmallChange);
    VK_DOWN:
      if FKind = sbVertical then
        Inc(iPosition, SmallChange);
    VK_LEFT:
      if FKind = sbHorizontal then
        Dec(iPosition, SmallChange);
    VK_RIGHT:
      if FKind = sbHorizontal then
        Inc(iPosition, SmallChange);
  end;
  Position := iPosition;
end;

{ TFlatScrollbarButton }

constructor TFlatScrollbarButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
end;

destructor TFlatScrollbarButton.Destroy;
begin
  inherited Destroy;
end;

procedure TFlatScrollbarButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  FNewDown := True;
  FTimer := TTimer.Create(Self);
  FTimer.Interval := 10;
  FTimer.OnTimer := DoTimer;
  FTimer.Enabled := True;
end;

procedure TFlatScrollbarButton.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseMove(Shift, X, Y);
end;

procedure TFlatScrollbarButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseUp(Button, Shift, X, Y);
  FNewDown := False;
  FTimer.Enabled := False;
  FTimer.Free;
end;

procedure TFlatScrollbarButton.DoTimer(Sender: TObject);
begin
  if FNewDown = True then
  begin
    if Assigned(FOnDown) then
      FOnDown(Self);
    TFlatScrollbar(Parent).DoScroll;
  end;
end;

{ TFlatScrollbar }

constructor TFlatScrollbar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);

  Width := 200;
  Height := 17;

  Color := ecLightKaki;

  FBtnOne := TFlatScrollbarButton.Create(Self);
  FBtnOne.Color := ecLightKaki;
  FBtnOne.ColorFocused := ecLightKaki;
  FBtnOne.ColorDown := ecLightKaki;
  FBtnOne.ColorBorder := ecLightKaki;
  FBtnOne.Glyph.LoadFromResourceName(hInstance, 'THUMB_UP_ENABLED');
  FBtnOne.OnDown := BtnOneClick;
  InsertControl(FBtnOne);

  FBtnTwo := TFlatScrollbarButton.Create(Self);
  FBtnTwo.Color := ecLightKaki;
  FBtnTwo.ColorFocused := ecLightKaki;
  FBtnTwo.ColorDown := ecLightKaki;
  FBtnTwo.ColorBorder := ecLightKaki;
  FBtnTwo.Glyph.LoadFromResourceName(hInstance, 'THUMB_DOWN_ENABLED');
  FBtnTwo.OnDown := BtnTwoClick;
  InsertControl(FBtnTwo);

  FTrack := TFlatScrollbarTrack.Create(Self);
  FTrack.Color := ecLightKaki;
  FTrack.SetBounds(0, 0, Width, Height);
  InsertControl(FTrack);

  Kind := sbVertical;

  Min := 0;
  Max := 100;
  Position := 0;
  SmallChange := 1;
  LargeChange := 1;

  ButtonColor := ecScrollbar;
  ButtonFocusedColor := ecScrollbar;
  ButtonDownColor := ecScrollbar;
  ButtonBorderColor := ecScrollbar;
  ButtonHighlightColor := clWhite;
  ButtonShadowColor := clBlack;

  ThumbColor := ecScrollbarThumb;
  ThumbFocusedColor := ecScrollbarThumb;
  ThumbDownColor := ecScrollbarThumb;
  ThumbBorderColor := ecScrollbarThumb;
  ThumbHighlightColor := ecScrollbarThumb;
  ThumbShadowColor := ecScrollbarThumb;
end;

destructor TFlatScrollbar.Destroy;
begin
  FTrack.Free;
  FBtnOne.Free;
  FBtnTwo.Free;
  inherited Destroy;
end;

procedure TFlatScrollbar.SetSmallChange(Value: Integer);
begin
  if Value <> FSmallChange then
  begin
    FSmallChange := Value;
    FTrack.SmallChange := FSmallChange;
  end;
end;

procedure TFlatScrollbar.SetLargeChange(Value: Integer);
begin
  if Value <> FLargeChange then
  begin
    FLargeChange := Value;
    FTrack.LargeChange := FLargeChange;
  end;
end;

procedure TFlatScrollbar.SetMin(Value: Integer);
begin
  if Value <> FMin then
  begin
    FMin := Value;
    FTrack.Min := FMin;
  end;
end;

procedure TFlatScrollbar.SetMax(Value: Integer);
begin
  if Value <> FMax then
  begin
    FMax := Value;
    FTrack.Max := FMax;
  end;
end;

procedure TFlatScrollbar.SetPosition(Value: Integer);
begin
  FPosition := Value;
  if Position < Min then
  begin
    Position := Min;
  end;
  if Position > Max then
  begin
    Position := Max;
  end;
  FTrack.Position := FPosition;
end;

procedure TFlatScrollbar.SetKind(Value: TScrollBarKind);
var
  i: Integer;
begin
  if FKind <> Value then
  begin
    FKind := Value;
    FTrack.Kind := FKind;
    if FKind = sbVertical then
    begin
      FBtnOne.Glyph.LoadFromResourceName(hInstance, 'THUMB_UP_ENABLED');
      FBtnOne.Refresh;
      FBtnTwo.Glyph.LoadFromResourceName(hInstance, 'THUMB_DOWN_ENABLED');
      FBtnTwo.Refresh;
    end
    else
    begin
      FBtnOne.Glyph.LoadFromResourceName(hInstance, 'THUMB_LEFT_ENABLED');
      FBtnOne.Refresh;
      FBtnTwo.Glyph.LoadFromResourceName(hInstance, 'THUMB_RIGHT_ENABLED');
      FBtnTwo.Refresh;
    end;
    if (csDesigning in ComponentState) and not(csLoading in ComponentState) then
    begin
      i := Width;
      Width := Height;
      Height := i;
    end;
  end;
end;

procedure TFlatScrollbar.SetButtonHighlightColor(Value: TColor);
begin
  if Value <> FButtonHighlightColor then
  begin
    FButtonHighlightColor := Value;
    FBtnOne.ColorHighLight := ButtonHighlightColor;
    FBtnTwo.ColorHighLight := ButtonHighlightColor;
  end;
end;

procedure TFlatScrollbar.SetButtonShadowColor(Value: TColor);
begin
  if Value <> FButtonShadowColor then
  begin
    FButtonShadowColor := Value;
    FBtnOne.ColorShadow := ButtonShadowColor;
    FBtnTwo.ColorShadow := ButtonShadowColor;
  end;
end;

procedure TFlatScrollbar.SetButtonBorderColor(Value: TColor);
begin
  if Value <> FButtonBorderColor then
  begin
    FButtonBorderColor := Value;
    FBtnOne.ColorBorder := ButtonBorderColor;
    FBtnTwo.ColorBorder := ButtonBorderColor;
  end;
end;

procedure TFlatScrollbar.SetButtonFocusedColor(Value: TColor);
begin
  if Value <> FButtonFocusedColor then
  begin
    FButtonFocusedColor := Value;
    FBtnOne.ColorFocused := ButtonFocusedColor;
    FBtnTwo.ColorFocused := ButtonFocusedColor;
  end;
end;

procedure TFlatScrollbar.SetButtonDownColor(Value: TColor);
begin
  if Value <> FButtonDownColor then
  begin
    FButtonDownColor := Value;
    FBtnOne.ColorDown := ButtonDownColor;
    FBtnTwo.ColorDown := ButtonDownColor;
  end;
end;

procedure TFlatScrollbar.SetButtonColor(Value: TColor);
begin
  if Value <> FButtonColor then
  begin
    FButtonColor := Value;
    FBtnOne.Color := ButtonColor;
    FBtnTwo.Color := ButtonColor;
  end;
end;

procedure TFlatScrollbar.SetThumbHighlightColor(Value: TColor);
begin
  if Value <> FThumbHighlightColor then
  begin
    FThumbHighlightColor := Value;
    FTrack.DoThumbHighlightColor(Value);
  end;
end;

procedure TFlatScrollbar.SetThumbShadowColor(Value: TColor);
begin
  if Value <> FThumbShadowColor then
  begin
    FThumbShadowColor := Value;
    FTrack.DoThumbShadowColor(Value);
  end;
end;

procedure TFlatScrollbar.SetThumbBorderColor(Value: TColor);
begin
  if Value <> FThumbBorderColor then
  begin
    FThumbBorderColor := Value;
    FTrack.DoThumbBorderColor(Value);
  end;
end;

procedure TFlatScrollbar.SetThumbFocusedColor(Value: TColor);
begin
  if Value <> FThumbFocusedColor then
  begin
    FThumbFocusedColor := Value;
    FTrack.DoThumbFocusedColor(Value);
  end;
end;

procedure TFlatScrollbar.SetThumbDownColor(Value: TColor);
begin
  if Value <> FThumbDownColor then
  begin
    FThumbDownColor := Value;
    FTrack.DoThumbDownColor(Value);
  end;
end;

procedure TFlatScrollbar.SetThumbColor(Value: TColor);
begin
  if Value <> FThumbColor then
  begin
    FThumbColor := Value;
    FTrack.DoThumbColor(Value);
  end;
end;

procedure TFlatScrollbar.BtnOneClick(Sender: TObject);
var
  iPosition: Integer;
begin
  iPosition := Position;
  Dec(iPosition, SmallChange);
  Position := iPosition;
end;

procedure TFlatScrollbar.BtnTwoClick(Sender: TObject);
var
  iPosition: Integer;
begin
  iPosition := Position;
  Inc(iPosition, SmallChange);
  Position := iPosition;
end;

procedure TFlatScrollbar.EnableBtnOne(Value: Boolean);
begin
  if Value = True then
  begin
    FBtnOne.Enabled := True;
    case FKind of
      sbVertical:
        FBtnOne.Glyph.LoadFromResourceName(hInstance, 'THUMB_UP_ENABLED');
      sbHorizontal:
        FBtnOne.Glyph.LoadFromResourceName(hInstance, 'THUMB_LEFT_ENABLED');
    end;
  end
  else
  begin
    case FKind of
      sbVertical:
        FBtnOne.Glyph.LoadFromResourceName(hInstance, 'THUMB_UP_DISABLED');
      sbHorizontal:
        FBtnOne.Glyph.LoadFromResourceName(hInstance, 'THUMB_LEFT_DISABLED');
    end;
    FBtnOne.Enabled := False;
  end;
end;

procedure TFlatScrollbar.EnableBtnTwo(Value: Boolean);
begin
  if Value = True then
  begin
    FBtnTwo.Enabled := True;
    case FKind of
      sbVertical:
        FBtnTwo.Glyph.LoadFromResourceName(hInstance, 'THUMB_DOWN_ENABLED');
      sbHorizontal:
        FBtnTwo.Glyph.LoadFromResourceName(hInstance, 'THUMB_RIGHT_ENABLED');
    end;
  end
  else
  begin
    case FKind of
      sbVertical:
        FBtnTwo.Glyph.LoadFromResourceName(hInstance, 'THUMB_DOWN_DISABLED');
      sbHorizontal:
        FBtnTwo.Glyph.LoadFromResourceName(hInstance, 'THUMB_RIGHT_DISABLED');
    end;
    FBtnTwo.Enabled := False;
  end;
end;

procedure TFlatScrollbar.WMSize(var Message: TWMSize);
begin
  if FKind = sbVertical then
  begin
    SetBounds(Left, Top, Width, Height);
    FBtnOne.SetBounds(0, 0, Width, 17);
    FBtnTwo.SetBounds(0, Height - 17, Width, 17);
    FTrack.SetBounds(0, 17, Width, Height - 34);
  end
  else
  begin
    SetBounds(Left, Top, Width, Height);
    FBtnOne.SetBounds(0, 0, 17, Height);
    FBtnTwo.SetBounds(Width - 17, 0, 17, Height);
    FTrack.SetBounds(17, 0, Width - 34, Height);
  end;
  Position := FPosition;
end;

procedure TFlatScrollbar.DoScroll;
begin
  if Assigned(FOnScroll) then
    FOnScroll(Self, Position);
end;

{ These scrollbar messages are just passed onto the TFlatScrollbarTrack for handling }

procedure TFlatScrollbar.CNHScroll(var Message: TWMScroll);
begin
  FTrack.DoHScroll(Message);
end;

procedure TFlatScrollbar.CNVScroll(var Message: TWMScroll);
begin
  FTrack.DoVScroll(Message);
end;

procedure TFlatScrollbar.SBMEnableArrows(var Message: TMessage);
begin
  FTrack.DoEnableArrows(Message);
end;

procedure TFlatScrollbar.SBMGetPos(var Message: TMessage);
begin
  FTrack.DoGetPos(Message);
end;

procedure TFlatScrollbar.SBMGetRange(var Message: TMessage);
begin
  FTrack.DoGetRange(Message);
end;

procedure TFlatScrollbar.SBMSetPos(var Message: TMessage);
begin
  FTrack.DoSetPos(Message);
end;

procedure TFlatScrollbar.SBMSetRange(var Message: TMessage);
begin
  FTrack.DoSetRange(Message);
end;

{ This message handler handles keyboard events }

procedure TFlatScrollbar.WMKeyDown(var Message: TWMKeyDown);
begin
  FTrack.DoKeyDown(Message); { Problems? }
end;

procedure Register;
begin
  RegisterComponents('FlatStyle', [TFlatScrollbar]);
end;

end.
