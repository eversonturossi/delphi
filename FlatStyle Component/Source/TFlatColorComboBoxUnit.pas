unit TFlatColorComboBoxUnit;

{ *************************************************************** }
{ TFlatColorComboBox }
{ Copyright ©1999 Lloyd Kinsella. }
{ }
{ FlatStyle is Copyright ©1998-99 Maik Porkert. }
{ *************************************************************** }

interface

{$I DFS.inc}

uses
  Windows, Messages, Classes, Forms, Controls, Graphics, StdCtrls, FlatUtilitys,
  SysUtils, ShellApi, CommCtrl, Consts, Dialogs;

type
  TFlatColorComboBox = class(TCustomComboBox)
  private
    FArrowColor: TColor;
    FArrowBackgroundColor: TColor;
    FBorderColor: TColor;
    FHighlightColor: TColor;
    FUseAdvColors: Boolean;
    FAdvColorArrowBackground: TAdvColors;
    FAdvColorBorder: TAdvColors;
    FAdvColorHighlight: TAdvColors;
    FButtonWidth: Integer;
    FChildHandle: HWND;
    FDefListProc: Pointer;
    FListHandle: HWND;
    FListInstance: Pointer;
    FSysBtnWidth: Integer;
    FSolidBorder: Boolean;
    FShowNames: Boolean;
    FValue: TColor;
    FColorBoxWidth: Integer;
    FColorDlg: TColorDialog;
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    function GetButtonRect: TRect;
    procedure PaintButton;
    procedure PaintBorder;
    procedure RedrawBorders;
    procedure InvalidateSelection;
    function GetSolidBorder: Boolean;
    procedure SetSolidBorder;
    procedure ListWndProc(var Message: TMessage);
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMKeyDown(var Message: TMessage); message WM_KEYDOWN;
    procedure WMPaint(var Message: TWMPaint); message WM_PAINT;
    procedure WMNCPaint(var Message: TMessage); message WM_NCPAINT;
    procedure CMEnabledChanged(var Msg: TMessage); message CM_ENABLEDCHANGED;
    procedure CNCommand(var Message: TWMCommand); message CN_COMMAND;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;
    procedure SetShowNames(Value: Boolean);
    procedure SetColorValue(Value: TColor);
    procedure SetColorBoxWidth(Value: Integer);
  protected
    procedure DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure CreateWnd; override;
    procedure WndProc(var Message: TMessage); override;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWND; ComboProc: Pointer); override;
    procedure CalcAdvColors;
    property SolidBorder: Boolean read FSolidBorder;
    procedure Click; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function AddColor(ColorName: String; Color: TColor): Boolean;
    function DeleteColorByName(ColorName: String): Boolean;
    function DeleteColorByColor(Color: TColor): Boolean;
  published
    property Color default $00E1EAEB;
    property ColorArrow: TColor index 0 read FArrowColor write SetColors default clBlack;
    property ColorArrowBackground: TColor index 1 read FArrowBackgroundColor write SetColors default $00C5D6D9;
    property ColorBorder: TColor index 2 read FBorderColor write SetColors default $008396A0;
    property ColorHighlight: TColor index 3 read FHighlightColor write SetColors default clHighlight;
    property AdvColorBorder: TAdvColors index 0 read FAdvColorBorder write SetAdvColors default 50;
    property AdvColorArrowBackground: TAdvColors index 1 read FAdvColorArrowBackground write SetAdvColors default 10;
    property AdvColorHighlight: TAdvColors index 2 read FAdvColorHighlight write SetAdvColors default 50;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default False;
    property BoxWidth: Integer read FColorBoxWidth write SetColorBoxWidth;
    property ShowNames: Boolean read FShowNames write SetShowNames;
    property Value: TColor read FValue write SetColorValue;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property MaxLength;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
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

const
  StdColors = 16;
  StdColorValues: array [1 .. StdColors] of TColor = (clBlack, clMaroon, clGreen, clOlive, clNavy, clPurple, clTeal,
    clGray, clSilver, clRed, clLime, clYellow, clBlue, clFuchsia, clAqua, clWhite);

constructor TFlatColorComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csFixedHeight] + [csOpaque];
  TControlCanvas(Canvas).Control := Self;
  Style := csOwnerDrawFixed;
  FButtonWidth := 11;
  FSysBtnWidth := GetSystemMetrics(SM_CXVSCROLL);
  FListInstance := MakeObjectInstance(ListWndProc);
  FDefListProc := nil;
  FArrowColor := clBlack;
  FArrowBackgroundColor := $00C5D6D9;
  FBorderColor := $008396A0;
  FHighlightColor := clHighlight;
  FUseAdvColors := False;
  FAdvColorBorder := 50;
  FAdvColorArrowBackground := 10;
  FAdvColorHighlight := 30;
  FShowNames := True;
  FColorBoxWidth := 12;
  FValue := clBlack;
  FColorDlg := TColorDialog.Create(Self);
end;

destructor TFlatColorComboBox.Destroy;
begin
  FColorDlg.Free;
  FreeObjectInstance(FListInstance);
  inherited;
end;

procedure TFlatColorComboBox.CreateWnd;
var
  I: Integer;
  ColorName: string;
begin
  inherited CreateWnd;
  Clear;
  for I := 1 to StdColors do
  begin
    ColorName := Copy(ColorToString(StdColorValues[I]), 3, 40);
    Items.AddObject(ColorName, TObject(StdColorValues[I]));
  end;
  Items.AddObject('Custom', TObject(clBlack));
  ItemIndex := 0;
  Change;
end;

procedure TFlatColorComboBox.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FArrowColor := Value;
    1:
      FArrowBackgroundColor := Value;
    2:
      FBorderColor := Value;
    3:
      FHighlightColor := Value;
  end;
  Invalidate;
end;

procedure TFlatColorComboBox.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FBorderColor := CalcAdvancedColor(TForm(Parent).Color, FBorderColor, FAdvColorBorder, darken);
    FArrowBackgroundColor := CalcAdvancedColor(TForm(Parent).Color, FArrowBackgroundColor, FAdvColorArrowBackground,
      darken);
    FHighlightColor := CalcAdvancedColor(TForm(Parent).Color, FHighlightColor, FAdvColorHighlight, darken);
  end;
end;

procedure TFlatColorComboBox.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorBorder := Value;
    1:
      FAdvColorArrowBackground := Value;
    2:
      FAdvColorHighlight := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatColorComboBox.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatColorComboBox.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
    CalcAdvColors;
  Invalidate;
end;

procedure TFlatColorComboBox.CMParentColorChanged(var Message: TWMNoParams);
begin
  if FUseAdvColors then
    CalcAdvColors;
  Invalidate;
end;

procedure TFlatColorComboBox.WndProc(var Message: TMessage);
begin
  if (Message.Msg = WM_PARENTNOTIFY) then
    case LoWord(Message.wParam) of
      WM_CREATE:
        if FDefListProc <> nil then
        begin
          SetWindowLong(FListHandle, GWL_WNDPROC, Longint(FDefListProc));
          FDefListProc := nil;
          FChildHandle := Message.lParam;
        end
        else if FChildHandle = 0 then
          FChildHandle := Message.lParam
        else
          FListHandle := Message.lParam;
    end
  else if (Message.Msg = WM_WINDOWPOSCHANGING) then
    if Style in [csDropDown, csSimple] then
      SetWindowPos(EditHandle, 0, 0, 0, ClientWidth - FButtonWidth - 2 * 2 - 4, Height - 2 * 2 - 2,
        SWP_NOMOVE + SWP_NOZORDER + SWP_NOACTIVATE + SWP_NOREDRAW);
  inherited;
  if Message.Msg = WM_CTLCOLORLISTBOX then
  begin
    SetBkColor(Message.wParam, ColorToRGB(Color));
    Message.Result := CreateSolidBrush(ColorToRGB(Color));
  end;
end;

procedure TFlatColorComboBox.ListWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_WINDOWPOSCHANGING:
      with TWMWindowPosMsg(Message).WindowPos^ do
      begin
        // size of the drop down list
        if Style in [csDropDown, csDropDownList] then
          cy := (GetFontHeight(Font) - 2) * Min(DropDownCount, Items.Count) + 4
        else
          cy := (ItemHeight) * Min(DropDownCount, Items.Count) + 4;
        if cy <= 4 then
          cy := 10;
      end;
  else
    with Message do
      Result := CallWindowProc(FDefListProc, FListHandle, Msg, wParam, lParam);
  end;
end;

procedure TFlatColorComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWND; ComboProc: Pointer);
begin
  inherited;
  if (ComboWnd = EditHandle) then
    case Message.Msg of
      WM_SETFOCUS, WM_KILLFOCUS:
        SetSolidBorder;
    end;
end;

procedure TFlatColorComboBox.WMSetFocus(var Message: TMessage);
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    SetSolidBorder;
    if not(Style in [csSimple, csDropDown]) then
      InvalidateSelection;
  end;
end;

procedure TFlatColorComboBox.WMKillFocus(var Message: TMessage);
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    SetSolidBorder;
    if not(Style in [csSimple, csDropDown]) then
      InvalidateSelection;
  end;
end;

procedure TFlatColorComboBox.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TFlatColorComboBox.CNCommand(var Message: TWMCommand);
var
  R: TRect;
begin
  inherited;
  if Message.NotifyCode in [1, 9, CBN_DROPDOWN, CBN_SELCHANGE] then
  begin
    if not(Style in [csSimple, csDropDown]) then
      InvalidateSelection;
  end;
  if (Message.NotifyCode in [CBN_CLOSEUP]) then
  begin
    R := GetButtonRect;
    Dec(R.Left, 2);
    InvalidateRect(Handle, @R, False);
  end;
end;

procedure TFlatColorComboBox.WMKeyDown(var Message: TMessage);
var
  S: String;
begin
  S := Text;
  inherited;
  if not(Style in [csSimple, csDropDown]) and (Text <> S) then
    InvalidateSelection;
end;

procedure TFlatColorComboBox.WMPaint(var Message: TWMPaint);
var
  R: TRect;
  DC: HDC;
  PS: TPaintStruct;
begin
  DC := BeginPaint(Handle, PS);
  try
    R := PS.rcPaint;
    if R.Right > Width - FButtonWidth - 4 then
      R.Right := Width - FButtonWidth - 4;
    FillRect(DC, R, Brush.Handle);
    if RectInRect(GetButtonRect, PS.rcPaint) then
      PaintButton;
    ExcludeClipRect(DC, ClientWidth - FSysBtnWidth - 2, 0, ClientWidth, ClientHeight);
    PaintWindow(DC);
    if (Style = csDropDown) and DroppedDown then
    begin
      R := ClientRect;
      InflateRect(R, -2, -2);
      R.Right := Width - FButtonWidth - 3;
      Canvas.Brush.Color := clWindow;
      Canvas.FrameRect(R);
    end
    else if Style <> csDropDown then
      InvalidateSelection;
  finally
    EndPaint(Handle, PS);
  end;
  RedrawBorders;
  Message.Result := 0;
end;

procedure TFlatColorComboBox.WMNCPaint(var Message: TMessage);
begin
  inherited;
  RedrawBorders;
end;

procedure TFlatColorComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ItemHeight := 13;
  RecreateWnd;
end;

procedure TFlatColorComboBox.InvalidateSelection;
var
  R: TRect;
begin
  R := ClientRect;
  InflateRect(R, -2, -3);
  R.Left := R.Right - FButtonWidth - 8;
  Dec(R.Right, FButtonWidth + 3);
  if (GetFocus = Handle) and not DroppedDown then
    Canvas.Brush.Color := FHighlightColor
  else
    Canvas.Brush.Color := Color;
  Canvas.Brush.Style := bsSolid;
  Canvas.FillRect(R);
  if (GetFocus = Handle) and not DroppedDown then
  begin
    R := ClientRect;
    InflateRect(R, -3, -3);
    Dec(R.Right, FButtonWidth + 2);
    Canvas.FrameRect(R);
    Canvas.Brush.Color := clWindow;
  end;
  ExcludeClipRect(Canvas.Handle, ClientWidth - FSysBtnWidth - 2, 0, ClientWidth, ClientHeight);
end;

function TFlatColorComboBox.GetButtonRect: TRect;
begin
  GetWindowRect(Handle, Result);
  OffsetRect(Result, -Result.Left, -Result.Top);
  Inc(Result.Left, ClientWidth - FButtonWidth);
  OffsetRect(Result, -1, 0);
end;

procedure TFlatColorComboBox.PaintButton;
var
  R: TRect;
  x, y: Integer;
begin
  R := GetButtonRect;
  InflateRect(R, 1, 0);

  Canvas.Brush.Color := FArrowBackgroundColor;
  Canvas.FillRect(R);
  Canvas.Brush.Color := FBorderColor;
  Canvas.FrameRect(R);

  x := (R.Right - R.Left) div 2 - 6 + R.Left;
  if DroppedDown then
    y := (R.Bottom - R.Top) div 2 - 1 + R.Top
  else
    y := (R.Bottom - R.Top) div 2 - 1 + R.Top;

  if Enabled then
  begin
    Canvas.Brush.Color := FArrowColor;
    Canvas.Pen.Color := FArrowColor;
    if DroppedDown then
      Canvas.Polygon([Point(x + 4, y + 2), Point(x + 8, y + 2), Point(x + 6, y)])
    else
      Canvas.Polygon([Point(x + 4, y), Point(x + 8, y), Point(x + 6, y + 2)]);
  end
  else
  begin
    Canvas.Brush.Color := clWhite;
    Canvas.Pen.Color := clWhite;
    Inc(x);
    Inc(y);
    if DroppedDown then
      Canvas.Polygon([Point(x + 4, y + 2), Point(x + 8, y + 2), Point(x + 6, y)])
    else
      Canvas.Polygon([Point(x + 4, y), Point(x + 8, y), Point(x + 6, y + 2)]);
    Dec(x);
    Dec(y);
    Canvas.Brush.Color := clGray;
    Canvas.Pen.Color := clGray;
    if DroppedDown then
      Canvas.Polygon([Point(x + 4, y + 2), Point(x + 8, y + 2), Point(x + 6, y)])
    else
      Canvas.Polygon([Point(x + 4, y), Point(x + 8, y), Point(x + 6, y + 2)]);
  end;
  ExcludeClipRect(Canvas.Handle, ClientWidth - FSysBtnWidth, 0, ClientWidth, ClientHeight);
end;

procedure TFlatColorComboBox.PaintBorder;
var
  DC: HDC;
  R: TRect;
  BtnFaceBrush, WindowBrush: HBRUSH;
begin
  DC := GetWindowDC(Handle);

  GetWindowRect(Handle, R);
  OffsetRect(R, -R.Left, -R.Top);
  Dec(R.Right, FButtonWidth + 1);
  try
    BtnFaceBrush := CreateSolidBrush(ColorToRGB(FBorderColor));
    WindowBrush := CreateSolidBrush(ColorToRGB(Color));

    FrameRect(DC, R, BtnFaceBrush);
    InflateRect(R, -1, -1);
    FrameRect(DC, R, WindowBrush);
    InflateRect(R, -1, -1);
    FrameRect(DC, R, WindowBrush);
  finally
    ReleaseDC(Handle, DC);
  end;
  DeleteObject(WindowBrush);
  DeleteObject(BtnFaceBrush);
end;

function TFlatColorComboBox.GetSolidBorder: Boolean;
begin
  Result := ((csDesigning in ComponentState) and Enabled) or
    (not(csDesigning in ComponentState) and (DroppedDown or (GetFocus = Handle) or (GetFocus = EditHandle)));
end;

procedure TFlatColorComboBox.SetSolidBorder;
var
  sb: Boolean;
begin
  sb := GetSolidBorder;
  if sb <> FSolidBorder then
  begin
    FSolidBorder := sb;
    RedrawBorders;
  end;
end;

procedure TFlatColorComboBox.RedrawBorders;
begin
  PaintBorder;
  if Style <> csSimple then
    PaintButton;
end;

procedure TFlatColorComboBox.SetShowNames(Value: Boolean);
begin
  if Value <> FShowNames then
  begin
    FShowNames := Value;
    Invalidate;
  end;
end;

procedure TFlatColorComboBox.SetColorValue(Value: TColor);
var
  Item: Integer;
  CurrentColor: TColor;
begin
  if (ItemIndex < 0) or (Value <> FValue) then
  begin
    for Item := 0 to Pred(Items.Count) do
    begin
      CurrentColor := TColor(Items.Objects[Item]);
      if CurrentColor = Value then
      begin
        FValue := Value;
        if ItemIndex <> Item then
          ItemIndex := Item;
        Change;
        Break;
      end;
    end;
  end;
end;

procedure TFlatColorComboBox.SetColorBoxWidth(Value: Integer);
begin
  if Value <> FColorBoxWidth then
  begin
    FColorBoxWidth := Value;
  end;
  Invalidate;
end;

procedure TFlatColorComboBox.DrawItem(Index: Integer; Rect: TRect; State: TOwnerDrawState);
var
  ARect: TRect;
  Text: array [0 .. 255] of Char;
  Safer: TColor;
begin
  ARect := Rect;
  Inc(ARect.Top, 2);
  Dec(ARect.Bottom, 2);

  Inc(ARect.Left, 2);
  Dec(ARect.Right, 2);

  if FShowNames then
  begin
    ARect.Right := ARect.Left + FColorBoxWidth;
  end
  else
  begin
    Dec(ARect.Right, 3);
  end;
  with Canvas do
  begin
    Safer := Brush.Color;
    if (odSelected in State) then
    begin
      Canvas.Brush.Color := FHighlightColor;
      FillRect(Rect);
      Pen.Color := clBlack;
      Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    end
    else
    begin
      Canvas.Brush.Color := Color;
      FillRect(Rect);
      Pen.Color := clBlack;
      Rectangle(ARect.Left, ARect.Top, ARect.Right, ARect.Bottom);
    end;
    Brush.Color := ColorToRGB(TColor(Items.Objects[Index]));
    try
      InflateRect(ARect, -1, -1);
      FillRect(ARect) finally Brush.Color := Safer;
    end;
    if FShowNames then
    begin
      StrPCopy(Text, Items[Index]);
      Rect.Left := ARect.Right + 5;
      Brush.Style := bsClear;
      DrawText(Canvas.Handle, Text, StrLen(Text), Rect, DT_SINGLELINE or DT_VCENTER or DT_NOPREFIX);
      Brush.Style := bsSolid;
    end;
  end;
end;

procedure TFlatColorComboBox.Click;
begin
  if ItemIndex >= 0 then
  begin
    if Items[ItemIndex] = 'Custom' then
    begin
      if not FColorDlg.Execute then
        Exit;
      Items.Objects[ItemIndex] := TObject(FColorDlg.Color);
    end;
    Value := TColor(Items.Objects[ItemIndex]);
  end;
  inherited Click;
end;

function TFlatColorComboBox.AddColor(ColorName: String; Color: TColor): Boolean;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
  begin
    if UpperCase(ColorName) = UpperCase(Items[I]) then
    begin
      Result := False;
      Exit;
    end;
  end;
  Items.InsertObject(Items.Count - 1, ColorName, TObject(Color));
  Result := True;
end;

function TFlatColorComboBox.DeleteColorByName(ColorName: String): Boolean;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
  begin
    if UpperCase(ColorName) = UpperCase(Items[I]) then
    begin
      Items.Delete(I);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

function TFlatColorComboBox.DeleteColorByColor(Color: TColor): Boolean;
var
  I: Integer;
begin
  for I := 0 to Items.Count - 1 do
  begin
    if Color = TColor(Items.Objects[I]) then
    begin
      Items.Delete(I);
      Result := True;
      Exit;
    end;
  end;
  Result := False;
end;

end.
