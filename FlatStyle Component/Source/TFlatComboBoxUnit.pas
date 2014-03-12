unit TFlatComboBoxUnit;

interface

{$I DFS.inc}

uses
  Windows, Messages, Classes, Forms, Controls, Graphics, StdCtrls, FlatUtilitys,
  SysUtils, ShellApi, Commctrl, comctrls, Consts;

type
  TFlatComboBox = class(TCustomComboBox)
  private
    FArrowColor: TColor;
    FArrowBackgroundColor: TColor;
    FBorderColor: TColor;
    FUseAdvColors: Boolean;
    FAdvColorArrowBackground: TAdvColors;
    FAdvColorBorder: TAdvColors;
    FButtonWidth: Integer;
    FChildHandle: HWND;
    FDefListProc: Pointer;
    FListHandle: HWND;
    FListInstance: Pointer;
    FSysBtnWidth: Integer;
    FSolidBorder: Boolean;
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
  protected
    procedure CalcAdvColors;
    procedure WndProc(var Message: TMessage); override;
    procedure ComboWndProc(var Message: TMessage; ComboWnd: HWND; ComboProc: Pointer); override;
    property SolidBorder: Boolean read FSolidBorder;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Style;
    property Color default $00E1EAEB;
    property ColorArrow: TColor index 0 read FArrowColor write SetColors default clBlack;
    property ColorArrowBackground: TColor index 1 read FArrowBackgroundColor write SetColors default $00C5D6D9;
    property ColorBorder: TColor index 2 read FBorderColor write SetColors default $008396A0;
    property AdvColorBorder: TAdvColors index 0 read FAdvColorBorder write SetAdvColors default 50;
    property AdvColorArrowBackground: TAdvColors index 1 read FAdvColorArrowBackground write SetAdvColors default 10;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default false;
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    property ItemHeight;
    property Items;
    property MaxLength;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Text;
    property Visible;
    property ItemIndex;
    property OnChange;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
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

constructor TFlatComboBox.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ControlStyle := ControlStyle - [csFixedHeight] + [csOpaque];
  TControlCanvas(Canvas).Control := self;
  FButtonWidth := 11;
  FSysBtnWidth := GetSystemMetrics(SM_CXVSCROLL);
  FListInstance := MakeObjectInstance(ListWndProc);
  FDefListProc := nil;
  ItemHeight := 13;
  FArrowColor := clBlack;
  FArrowBackgroundColor := $00C5D6D9;
  FBorderColor := $008396A0;
  FUseAdvColors := false;
  FAdvColorBorder := 50;
  FAdvColorArrowBackground := 10;
end;

destructor TFlatComboBox.Destroy;
begin
  FreeObjectInstance(FListInstance);
  inherited;
end;

procedure TFlatComboBox.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FArrowColor := Value;
    1:
      FArrowBackgroundColor := Value;
    2:
      FBorderColor := Value;
  end;
  Invalidate;
end;

procedure TFlatComboBox.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FBorderColor := CalcAdvancedColor(TForm(Parent).Color, FBorderColor, FAdvColorBorder, darken);
    FArrowBackgroundColor := CalcAdvancedColor(TForm(Parent).Color, FArrowBackgroundColor, FAdvColorArrowBackground,
      darken);
  end;
end;

procedure TFlatComboBox.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorBorder := Value;
    1:
      FAdvColorArrowBackground := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatComboBox.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatComboBox.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
    CalcAdvColors;
  Invalidate;
end;

procedure TFlatComboBox.CMParentColorChanged(var Message: TWMNoParams);
begin
  if FUseAdvColors then
    CalcAdvColors;
  Invalidate;
end;

procedure TFlatComboBox.WndProc(var Message: TMessage);
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

procedure TFlatComboBox.ListWndProc(var Message: TMessage);
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

procedure TFlatComboBox.ComboWndProc(var Message: TMessage; ComboWnd: HWND; ComboProc: Pointer);
begin
  inherited;
  if (ComboWnd = EditHandle) then
    case Message.Msg of
      WM_SETFOCUS, WM_KILLFOCUS:
        SetSolidBorder;
    end;
end;

procedure TFlatComboBox.WMSetFocus(var Message: TMessage);
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    SetSolidBorder;
    if not(Style in [csSimple, csDropDown]) then
      InvalidateSelection;
  end;
end;

procedure TFlatComboBox.WMKillFocus(var Message: TMessage);
begin
  inherited;
  if not(csDesigning in ComponentState) then
  begin
    SetSolidBorder;
    if not(Style in [csSimple, csDropDown]) then
      InvalidateSelection;
  end;
end;

procedure TFlatComboBox.CMEnabledChanged(var Msg: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TFlatComboBox.CNCommand(var Message: TWMCommand);
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
    InvalidateRect(Handle, @R, false);
  end;
end;

procedure TFlatComboBox.WMKeyDown(var Message: TMessage);
var
  S: String;
begin
  S := Text;
  inherited;
  if not(Style in [csSimple, csDropDown]) and (Text <> S) then
    InvalidateSelection;
end;

procedure TFlatComboBox.WMPaint(var Message: TWMPaint);
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

procedure TFlatComboBox.WMNCPaint(var Message: TMessage);
begin
  inherited;
  RedrawBorders;
end;

procedure TFlatComboBox.CMFontChanged(var Message: TMessage);
begin
  inherited;
  ItemHeight := 13;
  RecreateWnd;
end;

procedure TFlatComboBox.InvalidateSelection;
var
  R: TRect;
begin
  R := ClientRect;
  InflateRect(R, -2, -3);
  R.Left := R.Right - FButtonWidth - 8;
  Dec(R.Right, FButtonWidth + 3);
  if (GetFocus = Handle) and not DroppedDown then
    Canvas.Brush.Color := clHighlight
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

function TFlatComboBox.GetButtonRect: TRect;
begin
  GetWindowRect(Handle, Result);
  OffsetRect(Result, -Result.Left, -Result.Top);
  Inc(Result.Left, ClientWidth - FButtonWidth);
  OffsetRect(Result, -1, 0);
end;

procedure TFlatComboBox.PaintButton;
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

procedure TFlatComboBox.PaintBorder;
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

function TFlatComboBox.GetSolidBorder: Boolean;
begin
  Result := ((csDesigning in ComponentState) and Enabled) or
    (not(csDesigning in ComponentState) and (DroppedDown or (GetFocus = Handle) or (GetFocus = EditHandle)));
end;

procedure TFlatComboBox.SetSolidBorder;
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

procedure TFlatComboBox.RedrawBorders;
begin
  PaintBorder;
  if Style <> csSimple then
    PaintButton;
end;

end.
