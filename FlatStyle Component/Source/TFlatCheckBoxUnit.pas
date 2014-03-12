unit TFlatCheckBoxUnit;

interface

{$I DFS.inc}

uses
  Windows, Messages, Classes, Graphics, Controls, Forms, ExtCtrls, FlatUtilitys;

type
  TFlatCheckBox = class(TCustomControl)
  private
    FUseAdvColors: Boolean;
    FAdvColorFocused: TAdvColors;
    FAdvColorDown: TAdvColors;
    FAdvColorBorder: TAdvColors;
    FMouseInControl: Boolean;
    MouseIsDown: Boolean;
    Focused: Boolean;
    FLayout: TCheckBoxLayout;
    FChecked: Boolean;
    FFocusedColor: TColor;
    FDownColor: TColor;
    FCheckColor: TColor;
    FBorderColor: TColor;
    FTransparent: Boolean;
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    procedure SetLayout(Value: TCheckBoxLayout);
    procedure SetChecked(Value: Boolean);
    procedure SetTransparent(const Value: Boolean);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var Message: TWmNoParams); message CM_TEXTCHANGED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWmNoParams); message CM_PARENTCOLORCHANGED;
    procedure RemoveMouseTimer;
    procedure MouseTimerHandler(Sender: TObject);
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
  protected
    procedure CalcAdvColors;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure CreateWnd; override;
    procedure DrawCheckRect;
    procedure DrawCheckText;
    procedure Paint; override;
{$IFDEF DFS_COMPILER_4_UP}
    procedure SetBiDiMode(Value: TBiDiMode); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure MouseEnter;
    procedure MouseLeave;
  published
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property Caption;
    property Checked: Boolean read FChecked write SetChecked default false;
    property Color default $00E1EAEB;
    property ColorFocused: TColor index 0 read FFocusedColor write SetColors default clWhite;
    property ColorDown: TColor index 1 read FDownColor write SetColors default $00C5D6D9;
    property ColorCheck: TColor index 2 read FCheckColor write SetColors default clBlack;
    property ColorBorder: TColor index 3 read FBorderColor write SetColors default $008396A0;
    property AdvColorFocused: TAdvColors index 0 read FAdvColorFocused write SetAdvColors default 10;
    property AdvColorDown: TAdvColors index 1 read FAdvColorDown write SetAdvColors default 10;
    property AdvColorBorder: TAdvColors index 2 read FAdvColorBorder write SetAdvColors default 50;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default false;
    property Enabled;
    property Font;
    property Layout: TCheckBoxLayout read FLayout write SetLayout default checkBoxLeft;
    property ParentColor;
    property ParentFont;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
{$IFDEF DFS_COMPILER_4_UP}
    property Action;
    property Anchors;
    property BiDiMode write SetBiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

var
  MouseInControl: TFlatCheckBox = nil;

implementation

var
  MouseTimer: TTimer = nil;
  ControlCounter: Integer = 0;

procedure TFlatCheckBox.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  case FLayout of
    checkBoxLeft:
      if PtInRect(Rect(ClientRect.Left + 1, ClientRect.Top + 3, ClientRect.Left + 12, ClientRect.Top + 14),
        Point(message.XPos, message.YPos)) then
        Message.Result := 1
      else
        Message.Result := 0;
    checkboxRight:
      if PtInRect(Rect(ClientRect.Right - 12, ClientRect.Top + 3, ClientRect.Right - 1, ClientRect.Top + 14),
        Point(message.XPos, message.YPos)) then
        Message.Result := 1
      else
        Message.Result := 0;
  end;
end;

constructor TFlatCheckBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if MouseTimer = nil then
  begin
    MouseTimer := TTimer.Create(nil);
    MouseTimer.Enabled := false;
    MouseTimer.Interval := 100; // 10 times a second
  end;
  ParentColor := True;
  ParentFont := True;
  FFocusedColor := clWhite;
  FDownColor := $00C5D6D9;
  FCheckColor := clBlack;
  FBorderColor := $008396A0;
  FLayout := checkBoxLeft;
  TabStop := True;
  FChecked := false;
  Enabled := True;
  Visible := True;
  SetBounds(0, 0, 121, 17);
  FUseAdvColors := false;
  FAdvColorFocused := 10;
  FAdvColorDown := 10;
  FAdvColorBorder := 50;
  Inc(ControlCounter);
end;

destructor TFlatCheckBox.Destroy;
begin
  RemoveMouseTimer;
  Dec(ControlCounter);
  if ControlCounter = 0 then
  begin
    MouseTimer.Free;
    MouseTimer := nil;
  end;
  inherited;
end;

procedure TFlatCheckBox.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FFocusedColor := Value;
    1:
      FDownColor := Value;
    2:
      FCheckColor := Value;
    3:
      FBorderColor := Value;
  end;
  Invalidate;
end;

procedure TFlatCheckBox.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FFocusedColor := CalcAdvancedColor(Color, FFocusedColor, FAdvColorFocused, lighten);
    FDownColor := CalcAdvancedColor(Color, FDownColor, FAdvColorDown, darken);
    FBorderColor := CalcAdvancedColor(Color, FBorderColor, FAdvColorBorder, darken);
  end;
end;

procedure TFlatCheckBox.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorFocused := Value;
    1:
      FAdvColorDown := Value;
    2:
      FAdvColorBorder := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatCheckBox.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    ParentColor := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatCheckBox.SetLayout(Value: TCheckBoxLayout);
begin
  FLayout := Value;
  Invalidate;
end;

procedure TFlatCheckBox.SetChecked(Value: Boolean);
begin
  if FChecked <> Value then
  begin
    FChecked := Value;
    Click;
    DrawCheckRect;
    if csDesigning in ComponentState then
      if (GetParentForm(self) <> nil) and (GetParentForm(self).Designer <> nil) then
        GetParentForm(self).Designer.Modified;
  end;
end;

procedure TFlatCheckBox.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not Enabled then
  begin
    FMouseInControl := false;
    MouseIsDown := false;
    RemoveMouseTimer;
  end;
  Invalidate;
end;

procedure TFlatCheckBox.CMTextChanged(var Message: TWmNoParams);
begin
  inherited;
  Invalidate;
end;

procedure TFlatCheckBox.MouseEnter;
begin
  if Enabled and not FMouseInControl then
  begin
    FMouseInControl := True;
    DrawCheckRect;
  end;
end;

procedure TFlatCheckBox.MouseLeave;
begin
  if Enabled and FMouseInControl and not MouseIsDown then
  begin
    FMouseInControl := false;
    RemoveMouseTimer;
    DrawCheckRect;
  end;
end;

procedure TFlatCheckBox.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(Message.CharCode, Caption) and CanFocus then
    begin
      SetFocus;
      if Checked then
        Checked := false
      else
        Checked := True;
      Result := 1;
    end
    else if (CharCode = VK_SPACE) and Focused then
    begin
      if Checked then
        Checked := false
      else
        Checked := True;
    end
    else
      inherited;
end;

procedure TFlatCheckBox.CNCommand(var Message: TWMCommand);
begin
  if Message.NotifyCode = BN_CLICKED then
    Click;
end;

procedure TFlatCheckBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Enabled then
  begin
    Focused := True;
    DrawCheckRect;
  end;
end;

procedure TFlatCheckBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  if Enabled then
  begin
    FMouseInControl := false;
    Focused := false;
    DrawCheckRect;
  end;
end;

procedure TFlatCheckBox.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatCheckBox.CMParentColorChanged(var Message: TWmNoParams);
begin
  inherited;
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatCheckBox.DoEnter;
begin
  inherited DoEnter;
  Focused := True;
  DrawCheckRect;
end;

procedure TFlatCheckBox.DoExit;
begin
  inherited DoExit;
  Focused := false;
  DrawCheckRect;
end;

procedure TFlatCheckBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and Enabled then
  begin
    SetFocus;
    MouseIsDown := True;
    DrawCheckRect;
    inherited MouseDown(Button, Shift, X, Y);
  end;
end;

procedure TFlatCheckBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Button = mbLeft) and Enabled then
  begin
    MouseIsDown := false;
    if FMouseInControl then
      if Checked then
        Checked := false
      else
        Checked := True;
    DrawCheckRect;
    inherited MouseUp(Button, Shift, X, Y);
  end;
end;

procedure TFlatCheckBox.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  P: TPoint;
begin
  inherited;
  // mouse is in control ?
  P := ClientToScreen(Point(X, Y));
  if (MouseInControl <> self) and (FindDragTarget(P, True) = self) then
  begin
    if Assigned(MouseInControl) then
      MouseInControl.MouseLeave;
    // the application is active ?
    if (GetActiveWindow <> 0) then
    begin
      if MouseTimer.Enabled then
        MouseTimer.Enabled := false;
      MouseInControl := self;
      MouseTimer.OnTimer := MouseTimerHandler;
      MouseTimer.Enabled := True;
      MouseEnter;
    end;
  end;
end;

procedure TFlatCheckBox.CreateWnd;
begin
  inherited CreateWnd;
  SendMessage(Handle, BM_SETCHECK, Cardinal(FChecked), 0);
end;

procedure TFlatCheckBox.DrawCheckRect;
var
  CheckboxRect: TRect;
begin
  case FLayout of
    checkBoxLeft:
      CheckboxRect := Rect(ClientRect.Left + 1, ClientRect.Top + 3, ClientRect.Left + 12, ClientRect.Top + 14);
    checkboxRight:
      CheckboxRect := Rect(ClientRect.Right - 12, ClientRect.Top + 3, ClientRect.Right - 1, ClientRect.Top + 14);
  end;

  canvas.pen.style := psSolid;
  canvas.pen.width := 1;
  // Background
  if Focused or FMouseInControl then
    if not MouseIsDown then
    begin
      canvas.brush.Color := FFocusedColor;
      canvas.pen.Color := FFocusedColor;
    end
    else
    begin
      canvas.brush.Color := FDownColor;
      canvas.brush.Color := FDownColor;
    end
    else
    begin
      canvas.brush.Color := Color;
      canvas.pen.Color := Color;
    end;
  canvas.FillRect(CheckboxRect);
  // Tick
  if Checked then
  begin
    if Enabled then
      canvas.pen.Color := FCheckColor
    else
      canvas.pen.Color := clBtnShadow;
    canvas.penpos := Point(CheckboxRect.Left + 2, CheckboxRect.Top + 4);
    canvas.lineto(CheckboxRect.Left + 6, CheckboxRect.Top + 8);
    canvas.penpos := Point(CheckboxRect.Left + 2, CheckboxRect.Top + 5);
    canvas.lineto(CheckboxRect.Left + 5, CheckboxRect.Top + 8);
    canvas.penpos := Point(CheckboxRect.Left + 2, CheckboxRect.Top + 6);
    canvas.lineto(CheckboxRect.Left + 5, CheckboxRect.Top + 9);
    canvas.penpos := Point(CheckboxRect.Left + 8, CheckboxRect.Top + 2);
    canvas.lineto(CheckboxRect.Left + 4, CheckboxRect.Top + 6);
    canvas.penpos := Point(CheckboxRect.Left + 8, CheckboxRect.Top + 3);
    canvas.lineto(CheckboxRect.Left + 4, CheckboxRect.Top + 7);
    canvas.penpos := Point(CheckboxRect.Left + 8, CheckboxRect.Top + 4);
    canvas.lineto(CheckboxRect.Left + 5, CheckboxRect.Top + 7);
  end;
  // Border
  canvas.brush.Color := FBorderColor;
  canvas.FrameRect(CheckboxRect);
end;

procedure TFlatCheckBox.DrawCheckText;
var
  TextBounds: TRect;
  Format: UINT;
begin
  Format := DT_WORDBREAK;
  case FLayout of
    checkBoxLeft:
      begin
        TextBounds := Rect(ClientRect.Left + 16, ClientRect.Top + 1, ClientRect.Right - 1, ClientRect.Bottom - 1);
        Format := Format or DT_LEFT;
      end;
    checkboxRight:
      begin
        TextBounds := Rect(ClientRect.Left + 1, ClientRect.Top + 1, ClientRect.Right - 16, ClientRect.Bottom - 1);
        Format := Format or DT_RIGHT;
      end;
  end;

  with canvas do
  begin
    brush.style := bsClear;
    Font := self.Font;
    if not Enabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      Font.Color := clBtnHighlight;
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds, Format);
      OffsetRect(TextBounds, -1, -1);
      Font.Color := clBtnShadow;
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds, Format);
    end
    else
      DrawText(Handle, PChar(Caption), Length(Caption), TextBounds, Format);
  end;
end;

procedure TFlatCheckBox.Paint;
begin
  if FTransparent then
    DrawParentImage(self, self.canvas);
  DrawCheckRect;
  DrawCheckText;
end;

procedure TFlatCheckBox.MouseTimerHandler(Sender: TObject);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if FindDragTarget(P, True) <> self then
    MouseLeave;
end;

procedure TFlatCheckBox.RemoveMouseTimer;
begin
  if MouseInControl = self then
  begin
    MouseTimer.Enabled := false;
    MouseInControl := nil;
  end;
end;

procedure TFlatCheckBox.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;
  Invalidate;
end;

procedure TFlatCheckBox.WMMove(var Message: TWMMove);
begin
  inherited;
  if FTransparent then
    Invalidate;
end;

procedure TFlatCheckBox.WMSize(var Message: TWMSize);
begin
  inherited;
  if FTransparent then
    Invalidate;
end;
{$IFDEF DFS_COMPILER_4_UP}

procedure TFlatCheckBox.SetBiDiMode(Value: TBiDiMode);
begin
  inherited;
  if BiDiMode = bdRightToLeft then
    Layout := checkboxRight
  else
    Layout := checkBoxLeft;
end;
{$ENDIF}

end.
