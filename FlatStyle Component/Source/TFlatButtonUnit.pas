unit TFlatButtonUnit;

interface

{$I DFS.inc}

uses Windows, Messages, Classes, Controls, Forms, Graphics, StdCtrls, ExtCtrls,
  CommCtrl, Buttons, FlatUtilitys;

type
  TFlatButton = class(TCustomControl)
  private
    FOnMouseEnter: TNotifyEvent;
    FOnMouseLeave: TNotifyEvent;
    FTransparent: TTransparentMode;
    FModalResult: TModalResult;
    FUseAdvColors: Boolean;
    FAdvColorFocused: TAdvColors;
    FAdvColorDown: TAdvColors;
    FAdvColorBorder: TAdvColors;
    TextBounds: TRect;
    GlyphPos: TPoint;
    FNumGlyphs: TNumGlyphs;
    FDownColor: TColor;
    FBorderColor: TColor;
    FColorHighlight: TColor;
    FColorShadow: TColor;
    FFocusedColor: TColor;
    FGroupIndex: Integer;
    FGlyph: TBitmap;
    FDown: Boolean;
    FDragging: Boolean;
    FAllowAllUp: Boolean;
    FLayout: TButtonLayout;
    FSpacing: Integer;
    FMargin: Integer;
    FMouseInControl: Boolean;
    FDefault: Boolean;
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    procedure UpdateExclusive;
    procedure SetGlyph(Value: TBitmap);
    procedure SetNumGlyphs(Value: TNumGlyphs);
    procedure SetDown(Value: Boolean);
    procedure SetAllowAllUp(Value: Boolean);
    procedure SetGroupIndex(Value: Integer);
    procedure SetLayout(Value: TButtonLayout);
    procedure SetSpacing(Value: Integer);
    procedure SetMargin(Value: Integer);
    procedure UpdateTracking;
    procedure WMLButtonDblClk(var Message: TWMLButtonDown); message WM_LBUTTONDBLCLK;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMButtonPressed(var Message: TMessage); message CM_BUTTONPRESSED;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;
    procedure RemoveMouseTimer;
    procedure MouseTimerHandler(Sender: TObject);
    procedure SetDefault(const Value: Boolean);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure SetTransparent(const Value: TTransparentMode);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
  protected
    FState: TButtonState;
    function GetPalette: HPALETTE; override;
    procedure CalcAdvColors;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Click; override;
    procedure MouseEnter;
    procedure MouseLeave;
  published
    property TransparentMode: TTransparentMode read FTransparent write SetTransparent default tmNone;
    property Default: Boolean read FDefault write SetDefault default False;
    property AllowAllUp: Boolean read FAllowAllUp write SetAllowAllUp default False;
    property Color default $00E1EAEB;
    property ColorFocused: TColor index 0 read FFocusedColor write SetColors default $00E1EAEB;
    property ColorDown: TColor index 1 read FDownColor write SetColors default $00C5D6D9;
    property ColorBorder: TColor index 2 read FBorderColor write SetColors default $008396A0;
    property ColorHighLight: TColor index 3 read FColorHighlight write SetColors default clWhite;
    property ColorShadow: TColor index 4 read FColorShadow write SetColors default clBlack;
    property AdvColorFocused: TAdvColors index 0 read FAdvColorFocused write SetAdvColors default 10;
    property AdvColorDown: TAdvColors index 1 read FAdvColorDown write SetAdvColors default 10;
    property AdvColorBorder: TAdvColors index 2 read FAdvColorBorder write SetAdvColors default 50;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default False;
    property GroupIndex: Integer read FGroupIndex write SetGroupIndex default 0;
    property Down: Boolean read FDown write SetDown default False;
    property Caption;
    property Enabled;
    property Font;
    property Glyph: TBitmap read FGlyph write SetGlyph;
    property Layout: TButtonLayout read FLayout write SetLayout default blGlyphTop;
    property Margin: Integer read FMargin write SetMargin default - 1;
    property NumGlyphs: TNumGlyphs read FNumGlyphs write SetNumGlyphs default 1;
    property ParentFont;
    property ParentColor;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabStop;
    property TabOrder;
    property Spacing: Integer read FSpacing write SetSpacing default 4;
    property ModalResult: TModalResult read FModalResult write FModalResult default 0;
    property Visible;
    property OnClick;
    property OnDblClick;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnMouseEnter: TNotifyEvent read FOnMouseEnter write FOnMouseEnter;
    property OnMouseLeave: TNotifyEvent read FOnMouseLeave write FOnMouseLeave;
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

var
  MouseInControl: TFlatButton = nil;

implementation

var
  MouseTimer: TTimer = nil;
  ControlCounter: Integer = 0;

constructor TFlatButton.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  if MouseTimer = nil then
  begin
    MouseTimer := TTimer.Create(nil);
    MouseTimer.Enabled := False;
    MouseTimer.Interval := 100; // 10 times a second
  end;
  SetBounds(0, 0, 25, 25);
  ControlStyle := [csCaptureMouse, csOpaque, csDoubleClicks];
  FGlyph := TBitmap.Create;
  FNumGlyphs := 1;
  ParentFont := True;
  ParentColor := True;
  FFocusedColor := $00E1EAEB;
  FDownColor := $00C5D6D9;
  FBorderColor := $008396A0;
  FColorHighlight := clWhite;
  FColorShadow := clBlack;
  FSpacing := 4;
  FMargin := -1;
  FLayout := blGlyphTop;
  FUseAdvColors := False;
  FAdvColorFocused := 10;
  FAdvColorDown := 10;
  FAdvColorBorder := 50;
  FModalResult := mrNone;
  FTransparent := tmNone;
  Inc(ControlCounter);
end;

destructor TFlatButton.Destroy;
begin
  RemoveMouseTimer;
  FGlyph.Free;
  Dec(ControlCounter);
  if ControlCounter = 0 then
  begin
    MouseTimer.Free;
    MouseTimer := nil;
  end;
  inherited Destroy;
end;

procedure TFlatButton.Paint;
var
  FTransColor: TColor;
  FImageList: TImageList;
  sourceRect, destRect: TRect;
  tempGlyph, memoryBitmap: TBitmap;
  Offset: TPoint;
begin
  // get the transparent color
  FTransColor := FGlyph.Canvas.Pixels[0, FGlyph.Height - 1];

  memoryBitmap := TBitmap.Create; // create memory-bitmap to draw flicker-free
  try
    memoryBitmap.Height := ClientRect.Bottom;
    memoryBitmap.Width := ClientRect.Right;
    memoryBitmap.Canvas.Font := Self.Font;

    if FState in [bsDown, bsExclusive] then
      Offset := Point(1, 1)
    else
      Offset := Point(0, 0);

    CalcButtonLayout(memoryBitmap.Canvas, ClientRect, Offset, FLayout, FSpacing, FMargin, FGlyph, FNumGlyphs, Caption,
      TextBounds, GlyphPos);

    if not Enabled then
    begin
      FState := bsDisabled;
      FDragging := False;
    end
    else if FState = bsDisabled then
      if FDown and (GroupIndex <> 0) then
        FState := bsExclusive
      else
        FState := bsUp;

    // DrawBackground
    case FTransparent of
      tmAlways:
        DrawParentImage(Self, memoryBitmap.Canvas);
      tmNone:
        begin
          case FState of
            bsUp:
              if FMouseInControl then
                memoryBitmap.Canvas.Brush.Color := FFocusedColor
              else
                memoryBitmap.Canvas.Brush.Color := Self.Color;
            bsDown:
              memoryBitmap.Canvas.Brush.Color := FDownColor;
            bsExclusive:
              if FMouseInControl then
                memoryBitmap.Canvas.Brush.Color := FFocusedColor
              else
                memoryBitmap.Canvas.Brush.Color := FDownColor;
            bsDisabled:
              memoryBitmap.Canvas.Brush.Color := Self.Color;
          end;
          memoryBitmap.Canvas.FillRect(ClientRect);
        end;
      tmNotFocused:
        if FMouseInControl then
        begin
          case FState of
            bsUp:
              if FMouseInControl then
                memoryBitmap.Canvas.Brush.Color := FFocusedColor
              else
                memoryBitmap.Canvas.Brush.Color := Self.Color;
            bsDown:
              memoryBitmap.Canvas.Brush.Color := FDownColor;
            bsExclusive:
              if FMouseInControl then
                memoryBitmap.Canvas.Brush.Color := FFocusedColor
              else
                memoryBitmap.Canvas.Brush.Color := FDownColor;
            bsDisabled:
              memoryBitmap.Canvas.Brush.Color := Self.Color;
          end;
          memoryBitmap.Canvas.FillRect(ClientRect);
        end
        else
          DrawParentImage(Self, memoryBitmap.Canvas);
    end;

    // DrawBorder
    case FState of
      bsUp:
        if FMouseInControl then
          Frame3DBorder(memoryBitmap.Canvas, ClientRect, FColorHighlight, FColorShadow, 1)
        else if FDefault then
          Frame3DBorder(memoryBitmap.Canvas, ClientRect, FBorderColor, FBorderColor, 2)
        else
          Frame3DBorder(memoryBitmap.Canvas, ClientRect, FBorderColor, FBorderColor, 1);
      bsDown, bsExclusive:
        Frame3DBorder(memoryBitmap.Canvas, ClientRect, FColorShadow, FColorHighlight, 1);
      bsDisabled:
        Frame3DBorder(memoryBitmap.Canvas, ClientRect, FBorderColor, FBorderColor, 1);
    end;

    // DrawGlyph
    if not FGlyph.Empty then
    begin
      tempGlyph := TBitmap.Create;
      case FNumGlyphs of
        1:
          case FState of
            bsUp:
              sourceRect := Rect(0, 0, FGlyph.Width, FGlyph.Height);
            bsDisabled:
              sourceRect := Rect(0, 0, FGlyph.Width, FGlyph.Height);
            bsDown:
              sourceRect := Rect(0, 0, FGlyph.Width, FGlyph.Height);
            bsExclusive:
              sourceRect := Rect(0, 0, FGlyph.Width, FGlyph.Height);
          end;
        2:
          case FState of
            bsUp:
              sourceRect := Rect(0, 0, FGlyph.Width div FNumGlyphs, FGlyph.Height);
            bsDisabled:
              sourceRect := Rect(FGlyph.Width div FNumGlyphs, 0, FGlyph.Width, FGlyph.Height);
            bsDown:
              sourceRect := Rect(0, 0, FGlyph.Width div FNumGlyphs, FGlyph.Height);
            bsExclusive:
              sourceRect := Rect(0, 0, FGlyph.Width div FNumGlyphs, FGlyph.Height);
          end;
        3:
          case FState of
            bsUp:
              sourceRect := Rect(0, 0, FGlyph.Width div FNumGlyphs, FGlyph.Height);
            bsDisabled:
              sourceRect := Rect(FGlyph.Width div FNumGlyphs, 0, (FGlyph.Width div FNumGlyphs) * 2, FGlyph.Height);
            bsDown:
              sourceRect := Rect((FGlyph.Width div FNumGlyphs) * 2, 0, FGlyph.Width, FGlyph.Height);
            bsExclusive:
              sourceRect := Rect((FGlyph.Width div FNumGlyphs) * 2, 0, FGlyph.Width, FGlyph.Height);
          end;
        4:
          case FState of
            bsUp:
              sourceRect := Rect(0, 0, FGlyph.Width div FNumGlyphs, FGlyph.Height);
            bsDisabled:
              sourceRect := Rect(FGlyph.Width div FNumGlyphs, 0, (FGlyph.Width div FNumGlyphs) * 2, FGlyph.Height);
            bsDown:
              sourceRect := Rect((FGlyph.Width div FNumGlyphs) * 2, 0, (FGlyph.Width div FNumGlyphs) * 3,
                FGlyph.Height);
            bsExclusive:
              sourceRect := Rect((FGlyph.Width div FNumGlyphs) * 3, 0, FGlyph.Width, FGlyph.Height);
          end;
      end;

      destRect := Rect(0, 0, FGlyph.Width div FNumGlyphs, FGlyph.Height);
      tempGlyph.Width := FGlyph.Width div FNumGlyphs;
      tempGlyph.Height := FGlyph.Height;
      tempGlyph.Canvas.copyRect(destRect, FGlyph.Canvas, sourceRect);

      if (FNumGlyphs = 1) and (FState = bsDisabled) then
      begin
        tempGlyph := CreateDisabledBitmap(tempGlyph, clBlack, clBtnFace, clBtnHighlight, clBtnShadow, True);
        FTransColor := tempGlyph.Canvas.Pixels[0, tempGlyph.Height - 1];
      end;

      FImageList := TImageList.CreateSize(FGlyph.Width div FNumGlyphs, FGlyph.Height);
      try
        FImageList.AddMasked(tempGlyph, FTransColor);
        FImageList.Draw(memoryBitmap.Canvas, GlyphPos.X, GlyphPos.Y, 0);
      finally
        FImageList.Free;
      end;
      tempGlyph.Free;
    end;

    // DrawText
    memoryBitmap.Canvas.Brush.Style := bsClear;
    if FState = bsDisabled then
    begin
      OffsetRect(TextBounds, 1, 1);
      memoryBitmap.Canvas.Font.Color := clBtnHighlight;
      DrawText(memoryBitmap.Canvas.Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or DT_SINGLELINE);
      OffsetRect(TextBounds, -1, -1);
      memoryBitmap.Canvas.Font.Color := clBtnShadow;
      DrawText(memoryBitmap.Canvas.Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    end
    else
      DrawText(memoryBitmap.Canvas.Handle, PChar(Caption), Length(Caption), TextBounds,
        DT_CENTER or DT_VCENTER or DT_SINGLELINE);

    // Copy memoryBitmap to screen
    Canvas.copyRect(ClientRect, memoryBitmap.Canvas, ClientRect);
  finally
    memoryBitmap.Free; // delete the bitmap
  end;
end;

procedure TFlatButton.UpdateTracking;
var
  P: TPoint;
begin
  if Enabled then
  begin
    GetCursorPos(P);
    FMouseInControl := not(FindDragTarget(P, True) = Self);
    if FMouseInControl then
      MouseLeave
    else
      MouseEnter;
  end;
end;

procedure TFlatButton.Loaded;
begin
  inherited Loaded;
  Invalidate;
end;

procedure TFlatButton.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  if (Button = mbLeft) and Enabled then
  begin
    if not FDown then
    begin
      FState := bsDown;
      Invalidate;
    end;
    FDragging := True;
    SetFocus;
  end;
end;

procedure TFlatButton.MouseMove(Shift: TShiftState; X, Y: Integer);
var
  NewState: TButtonState;
  P: TPoint;
begin
  inherited;

  // mouse is in control ?
  P := ClientToScreen(Point(X, Y));
  if (MouseInControl <> Self) and (FindDragTarget(P, True) = Self) then
  begin
    if Assigned(MouseInControl) then
      MouseInControl.MouseLeave;
    // the application is active ?
    if (GetActiveWindow <> 0) then
    begin
      if MouseTimer.Enabled then
        MouseTimer.Enabled := False;
      MouseInControl := Self;
      MouseTimer.OnTimer := MouseTimerHandler;
      MouseTimer.Enabled := True;
      MouseEnter;
    end;
  end;

  if FDragging then
  begin
    if not FDown then
      NewState := bsUp
    else
      NewState := bsExclusive;
    if (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight) then
      if FDown then
        NewState := bsExclusive
      else
        NewState := bsDown;
    if NewState <> FState then
    begin
      FState := NewState;
      Invalidate;
    end;
  end;
end;

procedure TFlatButton.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  DoClick: Boolean;
begin
  inherited MouseUp(Button, Shift, X, Y);
  if FDragging then
  begin
    FDragging := False;
    DoClick := (X >= 0) and (X < ClientWidth) and (Y >= 0) and (Y <= ClientHeight);
    if FGroupIndex = 0 then
    begin
      // Redraw face in-case mouse is captured
      FState := bsUp;
      FMouseInControl := False;
      if DoClick and not(FState in [bsExclusive, bsDown]) then
        Invalidate;
    end
    else if DoClick then
    begin
      SetDown(not FDown);
      if FDown then
        Repaint;
    end
    else
    begin
      if FDown then
        FState := bsExclusive;
      Repaint;
    end;
    if DoClick then
      Click
    else
      MouseLeave;
    UpdateTracking;
  end;
end;

procedure TFlatButton.Click;
begin
  if Parent <> nil then
    GetParentForm(Self).ModalResult := FModalResult;
  inherited Click;
end;

function TFlatButton.GetPalette: HPALETTE;
begin
  Result := FGlyph.Palette;
end;

procedure TFlatButton.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FFocusedColor := Value;
    1:
      FDownColor := Value;
    2:
      FBorderColor := Value;
    3:
      FColorHighlight := Value;
    4:
      FColorShadow := Value;
  end;
  Invalidate;
end;

procedure TFlatButton.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FFocusedColor := CalcAdvancedColor(Color, FFocusedColor, FAdvColorFocused, lighten);
    FDownColor := CalcAdvancedColor(Color, FDownColor, FAdvColorDown, darken);
    FBorderColor := CalcAdvancedColor(Color, FBorderColor, FAdvColorBorder, darken);
  end;
end;

procedure TFlatButton.SetAdvColors(Index: Integer; Value: TAdvColors);
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

procedure TFlatButton.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    ParentColor := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatButton.SetGlyph(Value: TBitmap);
begin
  if Value <> FGlyph then
  begin
    FGlyph.Assign(Value);
    if not FGlyph.Empty then
    begin
      if FGlyph.Width mod FGlyph.Height = 0 then
      begin
        FNumGlyphs := FGlyph.Width div FGlyph.Height;
        if FNumGlyphs > 4 then
          FNumGlyphs := 1;
      end;
    end;
    Invalidate;
  end;
end;

procedure TFlatButton.SetNumGlyphs(Value: TNumGlyphs);
begin
  if Value <> FNumGlyphs then
  begin
    FNumGlyphs := Value;
    Invalidate;
  end;
end;

procedure TFlatButton.UpdateExclusive;
var
  Msg: TMessage;
begin
  if (FGroupIndex <> 0) and (Parent <> nil) then
  begin
    Msg.Msg := CM_BUTTONPRESSED;
    Msg.WParam := FGroupIndex;
    Msg.LParam := Longint(Self);
    Msg.Result := 0;
    Parent.Broadcast(Msg);
  end;
end;

procedure TFlatButton.SetDown(Value: Boolean);
begin
  if FGroupIndex = 0 then
    Value := False;
  if Value <> FDown then
  begin
    if FDown and (not FAllowAllUp) then
      Exit;
    FDown := Value;
    if Value then
    begin
      if FState = bsUp then
        Invalidate;
      FState := bsExclusive
    end
    else
    begin
      FState := bsUp;
      Repaint;
    end;
    if Value then
      UpdateExclusive;
  end;
end;

procedure TFlatButton.SetGroupIndex(Value: Integer);
begin
  if FGroupIndex <> Value then
  begin
    FGroupIndex := Value;
    UpdateExclusive;
  end;
end;

procedure TFlatButton.SetLayout(Value: TButtonLayout);
begin
  if FLayout <> Value then
  begin
    FLayout := Value;
    Invalidate;
  end;
end;

procedure TFlatButton.SetMargin(Value: Integer);
begin
  if (Value <> FMargin) and (Value >= -1) then
  begin
    FMargin := Value;
    Invalidate;
  end;
end;

procedure TFlatButton.SetSpacing(Value: Integer);
begin
  if Value <> FSpacing then
  begin
    FSpacing := Value;
    Invalidate;
  end;
end;

procedure TFlatButton.SetAllowAllUp(Value: Boolean);
begin
  if FAllowAllUp <> Value then
  begin
    FAllowAllUp := Value;
    UpdateExclusive;
  end;
end;

procedure TFlatButton.WMLButtonDblClk(var Message: TWMLButtonDown);
begin
  inherited;
  if FDown then
    DblClick;
end;

procedure TFlatButton.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  if not Enabled then
  begin
    FMouseInControl := False;
    FState := bsDisabled;
    RemoveMouseTimer;
  end;
  UpdateTracking;
  Invalidate;
end;

procedure TFlatButton.CMButtonPressed(var Message: TMessage);
var
  Sender: TFlatButton;
begin
  if Message.WParam = FGroupIndex then
  begin
    Sender := TFlatButton(Message.LParam);
    if Sender <> Self then
    begin
      if Sender.Down and FDown then
      begin
        FDown := False;
        FState := bsUp;
        Invalidate;
      end;
      FAllowAllUp := Sender.AllowAllUp;
    end;
  end;
end;

procedure TFlatButton.CMDialogChar(var Message: TCMDialogChar);
begin
  with Message do
    if IsAccel(CharCode, Caption) and Enabled then
    begin
      if GroupIndex <> 0 then
        SetDown(True);
      Click;
      Result := 1;
    end;
end;

procedure TFlatButton.CMFontChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TFlatButton.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TFlatButton.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatButton.CMParentColorChanged(var Message: TWMNoParams);
begin
  inherited;
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatButton.MouseEnter;
begin
  if Enabled and not FMouseInControl then
  begin
    FMouseInControl := True;
    Invalidate;
  end;
end;

procedure TFlatButton.MouseLeave;
begin
  if Enabled and FMouseInControl and not FDragging then
  begin
    FMouseInControl := False;
    RemoveMouseTimer;
    Invalidate;
  end;
end;

procedure TFlatButton.MouseTimerHandler(Sender: TObject);
var
  P: TPoint;
begin
  GetCursorPos(P);
  if FindDragTarget(P, True) <> Self then
    MouseLeave;
end;

procedure TFlatButton.RemoveMouseTimer;
begin
  if MouseInControl = Self then
  begin
    MouseTimer.Enabled := False;
    MouseInControl := nil;
  end;
end;

procedure TFlatButton.SetDefault(const Value: Boolean);
var
{$IFDEF DFS_COMPILER_2}
  Form: TForm;
{$ELSE}
  Form: TCustomForm;
{$ENDIF}
begin
  FDefault := Value;
  if HandleAllocated then
  begin
    Form := GetParentForm(Self);
    if Form <> nil then
      Form.Perform(CM_FOCUSCHANGED, 0, Longint(Form.ActiveControl));
  end;
  Invalidate;
end;

procedure TFlatButton.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  MouseLeave;
end;

procedure TFlatButton.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if Enabled then
  begin
    FMouseInControl := True;
    Invalidate;
  end;
end;

procedure TFlatButton.WMKeyDown(var Message: TWMKeyDown);
begin
  if Message.CharCode = VK_SPACE then
  begin
    if GroupIndex = 0 then
      FState := bsDown
    else
      SetDown(True);
    Invalidate;
  end;
end;

procedure TFlatButton.WMKeyUp(var Message: TWMKeyUp);
begin
  if Message.CharCode = VK_SPACE then
  begin
    if GroupIndex = 0 then
      FState := bsUp
    else
      SetDown(False);
    Click;
    Invalidate;
  end;
end;

procedure TFlatButton.SetTransparent(const Value: TTransparentMode);
begin
  FTransparent := Value;
  Invalidate;
end;

procedure TFlatButton.WMMove(var Message: TWMMove);
begin
  inherited;
  if not(FTransparent = tmNone) then
    Invalidate;
end;

procedure TFlatButton.WMSize(var Message: TWMSize);
begin
  inherited;
  if not(FTransparent = tmNone) then
    Invalidate;
end;

procedure TFlatButton.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnMouseEnter) then
    FOnMouseEnter(Self);
end;

procedure TFlatButton.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  if Assigned(FOnMouseLeave) then
    FOnMouseLeave(Self);
end;

end.
