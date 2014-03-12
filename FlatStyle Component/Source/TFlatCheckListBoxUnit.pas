unit TFlatCheckListBoxUnit;

interface

{$I DFS.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, ExtCtrls, FlatUtilitys;

type
  TFlatCheckListBox = class(TCustomControl)
  private
    FSelected: Integer;
    FTransparent: TTransparentMode;
    FOnClickCheck: TNotifyEvent;
    cWheelMessage: Cardinal;
    scrollType: TScrollType;
    firstItem: Integer;
    maxItems: Integer;
    FSorted: Boolean;
    FItems: TStringList;
    FItemsRect: TList;
    FItemsHeight: Integer;
    FChecked: set of Byte;
    FScrollBars: Boolean;
    FUseAdvColors: Boolean;
    FAdvColorBorder: TAdvColors;
    FArrowColor: TColor;
    FCheckColor: TColor;
    FBorderColor: TColor;
    FItemsRectColor: TColor;
    FItemsSelectColor: TColor;
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    procedure SetSorted(Value: Boolean);
    procedure SetItems(Value: TStringList);
    procedure SetItemsRect;
    procedure SetItemsHeight(Value: Integer);
    function GetChecked(Index: Integer): Boolean;
    procedure SetChecked(Index: Integer; Value: Boolean);
    function GetSelCount: Integer;
    procedure SetScrollBars(Value: Boolean);
    function GetItemIndex: Integer;
    procedure SetItemIndex(Value: Integer);
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;
    procedure ScrollTimerHandler(Sender: TObject);
    procedure ItemsChanged(Sender: TObject);
    procedure WMSetFocus(var Message: TWMSetFocus); message WM_SETFOCUS;
    procedure WMKillFocus(var Message: TWMKillFocus); message WM_KILLFOCUS;
    procedure CNKeyDown(var Message: TWMKeyDown); message CN_KEYDOWN;
    procedure WMMouseWheel(var Message: TMessage); message WM_MOUSEWHEEL;
    procedure SetTransparent(const Value: TTransparentMode);
  protected
    procedure CalcAdvColors;
    procedure DrawCheckRect(canvas: TCanvas; start: TPoint; checked: Boolean);
    procedure DrawScrollBar(canvas: TCanvas);
    procedure Paint; override;
    procedure Loaded; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WndProc(var Message: TMessage); override;
{$IFDEF DFS_COMPILER_4_UP}
    procedure SetBiDiMode(Value: TBiDiMode); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property checked[Index: Integer]: Boolean read GetChecked write SetChecked;
    property SelCount: Integer read GetSelCount;
    procedure Clear;
    property ItemIndex: Integer read GetItemIndex write SetItemIndex;
  published
    property Items: TStringList read FItems write SetItems;
    property ItemHeight: Integer read FItemsHeight write SetItemsHeight default 17;
    property ScrollBars: Boolean read FScrollBars write SetScrollBars default false;
    property Color default $00E1EAEB;
    property ColorArrow: TColor index 0 read FArrowColor write SetColors default clBlack;
    property ColorBorder: TColor index 1 read FBorderColor write SetColors default $008396A0;
    property ColorItemsRect: TColor index 2 read FItemsRectColor write SetColors default clWhite;
    property ColorItemsSelect: TColor index 3 read FItemsSelectColor write SetColors default $009CDEF7;
    property ColorCheck: TColor index 4 read FCheckColor write SetColors default clBlack;
    property AdvColorBorder: TAdvColors index 0 read FAdvColorBorder write SetAdvColors default 40;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default false;
    property Sorted: Boolean read FSorted write SetSorted default false;
    property TransparentMode: TTransparentMode read FTransparent write SetTransparent default tmNone;
    property Align;
    property Font;
    property ParentFont;
    property ParentColor;
    property ParentShowHint;
    property Enabled;
    property Visible;
    property PopupMenu;
    property ShowHint;

    property OnClick;
    property OnClickCheck: TNotifyEvent read FOnClickCheck write FOnClickCheck;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
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

var
  ScrollTimer: TTimer = nil;

const
  FTimerInterval = 600;
  FScrollSpeed = 100;

constructor TFlatCheckListBox.Create(AOwner: TComponent);
begin
  inherited;
  if ScrollTimer = nil then
  begin
    ScrollTimer := TTimer.Create(nil);
    ScrollTimer.Enabled := false;
    ScrollTimer.Interval := FTimerInterval;
  end;
  ControlStyle := ControlStyle + [csOpaque];
  SetBounds(Left, Top, 137, 99);
  FItems := TStringList.Create;
  FItemsRect := TList.Create;
  FItemsHeight := 17;

  TStringList(FItems).OnChange := ItemsChanged;

  FScrollBars := false;
  firstItem := 0;
  FArrowColor := clBlack;
  FBorderColor := $008396A0;
  FItemsRectColor := clWhite;
  FItemsSelectColor := $009CDEF7;
  FCheckColor := clBlack;
  ParentColor := True;
  ParentFont := True;
  Enabled := True;
  Visible := True;
  FUseAdvColors := false;
  FAdvColorBorder := 40;
  FSorted := false;
  FTransparent := tmNone;
  FSelected := -1;
  cWheelMessage := RegisterWindowMessage(MSH_MOUSEWHEEL);
end;

destructor TFlatCheckListBox.Destroy;
var
  counter: Integer;
begin
  ScrollTimer.Free;
  ScrollTimer := nil;
  FItems.Free;
  for counter := 0 to FItemsRect.Count - 1 do
    Dispose(FItemsRect.Items[counter]);
  FItemsRect.Free;
  inherited;
end;

procedure TFlatCheckListBox.WndProc(var Message: TMessage);
begin
  if Message.Msg = cWheelMessage then
  begin
    SendMessage(Self.Handle, WM_MOUSEWHEEL, Message.wParam, Message.lParam);
  end;
  inherited;
end;

procedure TFlatCheckListBox.WMMouseWheel(var Message: TMessage);
var
  fScrollLines: Integer;
begin
  if not(csDesigning in ComponentState) then
  begin
    SystemParametersInfo(SPI_GETWHEELSCROLLLINES, 0, @fScrollLines, 0);

    if (fScrollLines = 0) then
      fScrollLines := maxItems;

    if ShortInt(Message.WParamHi) = -WHEEL_DELTA then
      if firstItem + maxItems + fScrollLines <= FItems.Count then
        Inc(firstItem, fScrollLines)
      else if FItems.Count - maxItems < 0 then
        firstItem := 0
      else
        firstItem := FItems.Count - maxItems
      else if ShortInt(Message.WParamHi) = WHEEL_DELTA then
        if firstItem - fScrollLines < 0 then
          firstItem := 0
        else
          dec(firstItem, fScrollLines);
    Invalidate;
  end;
end;

procedure TFlatCheckListBox.ItemsChanged(Sender: TObject);
begin
  if Enabled then
  begin
    FChecked := FChecked - [0 .. High(Byte)];
    Invalidate;
  end;
end;

procedure TFlatCheckListBox.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FArrowColor := Value;
    1:
      FBorderColor := Value;
    2:
      FItemsRectColor := Value;
    3:
      FItemsSelectColor := Value;
    4:
      FCheckColor := Value;
  end;
  Invalidate;
end;

procedure TFlatCheckListBox.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FBorderColor := CalcAdvancedColor(Color, FBorderColor, FAdvColorBorder, darken);
  end;
end;

procedure TFlatCheckListBox.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorBorder := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatCheckListBox.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    ParentColor := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatCheckListBox.SetSorted(Value: Boolean);
begin
  if Value <> FSorted then
  begin
    FSorted := Value;
    FItems.Sorted := Value;
    FChecked := FChecked - [0 .. High(Byte)];
    Invalidate;
  end;
end;

procedure TFlatCheckListBox.SetItems(Value: TStringList);
var
  counter: Integer;
begin
  if Value.Count - 1 > High(Byte) then
    Exit;

  // delete all spaces at left and right
  for counter := 0 to Value.Count - 1 do
    Value[counter] := Trim(Value[counter]);

  FItems.Assign(Value);

  Invalidate;
end;

procedure TFlatCheckListBox.SetItemsRect;
var
  counter: Integer;
  ItemRect: ^TRect;
  position: TPoint;
begin
  // Delete all curent Rects
  FItemsRect.Clear;

  // calculate the maximum items to draw
  if ScrollBars then
    maxItems := (Height - 24) div (FItemsHeight + 2)
  else
    maxItems := (Height - 4) div (FItemsHeight + 2);

  // set left/top position for the the first item
  if ScrollBars then
    position := Point(ClientRect.Left + 3, ClientRect.Top + 13)
  else
    position := Point(ClientRect.Left + 3, ClientRect.Top + 3);

  for counter := 0 to maxItems - 1 do
  begin
    // create a new Item-Rect
    New(ItemRect);
    // calculate the Item-Rect
    ItemRect^ := Rect(position.X, position.Y, ClientRect.Right - 3, position.Y + FItemsHeight);
    // set left/top position for next Item-Rect
    position := Point(position.X, position.Y + FItemsHeight + 2);
    // add the Item-Rect to the Items-Rect-List
    FItemsRect.Add(ItemRect);
  end;
  Invalidate;
end;

procedure TFlatCheckListBox.SetItemsHeight(Value: Integer);
begin
  if Value < 1 then
    Value := 1;

  FItemsHeight := Value;

  if not(csLoading in ComponentState) then
    if ScrollBars then
      SetBounds(Left, Top, Width, maxItems * (FItemsHeight + 2) + 24)
    else
      SetBounds(Left, Top, Width, maxItems * (FItemsHeight + 2) + 4);

  SetItemsRect;
end;

function TFlatCheckListBox.GetChecked(Index: Integer): Boolean;
begin
  Result := Index in FChecked;
end;

procedure TFlatCheckListBox.SetChecked(Index: Integer; Value: Boolean);
begin
  if Value then
    Include(FChecked, Index)
  else
    Exclude(FChecked, Index);
  Invalidate;
end;
{$IFDEF DFS_COMPILER_4_UP}

procedure TFlatCheckListBox.SetBiDiMode(Value: TBiDiMode);
begin
  inherited;
  Invalidate;
end;
{$ENDIF}

function TFlatCheckListBox.GetSelCount: Integer;
var
  counter: Integer;
begin
  Result := 0;
  for counter := 0 to High(Byte) do
    if counter in FChecked then
      Inc(Result);
end;

procedure TFlatCheckListBox.SetScrollBars(Value: Boolean);
begin
  if FScrollBars <> Value then
  begin
    FScrollBars := Value;
    if not(csLoading in ComponentState) then
      if Value then
        Height := Height + 20
      else
        Height := Height - 20;
    SetItemsRect;
  end;
end;

procedure TFlatCheckListBox.DrawScrollBar(canvas: TCanvas);
var
  X, Y: Integer;
begin
  // Draw the ScrollBar background
  canvas.Brush.Color := Color;
  canvas.FillRect(Rect(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Top + 11));
  canvas.FillRect(Rect(ClientRect.Left, ClientRect.Bottom - 11, ClientRect.Right, ClientRect.Bottom));

  // Draw the ScrollBar border
  canvas.Brush.Color := FBorderColor;
  canvas.FrameRect(Rect(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Top + 11));
  canvas.FrameRect(Rect(ClientRect.Left, ClientRect.Bottom - 11, ClientRect.Right, ClientRect.Bottom));

  // Draw the up arrow
  X := (ClientRect.Right - ClientRect.Left) div 2 - 6;
  Y := ClientRect.Top + 4;

  if (firstItem <> 0) and Enabled then
  begin
    canvas.Brush.Color := FArrowColor;
    canvas.Pen.Color := FArrowColor;
    canvas.Polygon([Point(X + 4, Y + 2), Point(X + 8, Y + 2), Point(X + 6, Y)]);
  end
  else
  begin
    canvas.Brush.Color := clWhite;
    canvas.Pen.Color := clWhite;
    Inc(X);
    Inc(Y);
    canvas.Polygon([Point(X + 4, Y + 2), Point(X + 8, Y + 2), Point(X + 6, Y)]);
    dec(X);
    dec(Y);
    canvas.Brush.Color := clGray;
    canvas.Pen.Color := clGray;
    canvas.Polygon([Point(X + 4, Y + 2), Point(X + 8, Y + 2), Point(X + 6, Y)]);
  end;

  // Draw the down arrow
  Y := ClientRect.Bottom - 7;
  if (firstItem + maxItems + 1 <= FItems.Count) and Enabled then
  begin
    canvas.Brush.Color := FArrowColor;
    canvas.Pen.Color := FArrowColor;
    canvas.Polygon([Point(X + 4, Y), Point(X + 8, Y), Point(X + 6, Y + 2)]);
  end
  else
  begin
    canvas.Brush.Color := clWhite;
    canvas.Pen.Color := clWhite;
    Inc(X);
    Inc(Y);
    canvas.Polygon([Point(X + 4, Y), Point(X + 8, Y), Point(X + 6, Y + 2)]);
    dec(X);
    dec(Y);
    canvas.Brush.Color := clGray;
    canvas.Pen.Color := clGray;
    canvas.Polygon([Point(X + 4, Y), Point(X + 8, Y), Point(X + 6, Y + 2)]);
  end;
end;

procedure TFlatCheckListBox.DrawCheckRect(canvas: TCanvas; start: TPoint; checked: Boolean);
var
  CheckboxRect: TRect;
begin
{$IFDEF DFS_COMPILER_4_UP}
  if BiDiMode = bdRightToLeft then
    CheckboxRect := Rect(start.X - 14, start.Y + 3, start.X - 3, start.Y + 14)
  else
    CheckboxRect := Rect(start.X + 3, start.Y + 3, start.X + 14, start.Y + 14);
{$ELSE}
  CheckboxRect := Rect(start.X + 3, start.Y + 3, start.X + 14, start.Y + 14);
{$ENDIF}
  canvas.Pen.style := psSolid;
  canvas.Pen.Width := 1;
  // Background
  canvas.Brush.Color := FItemsRectColor;
  canvas.Pen.Color := FItemsRectColor;

  canvas.FillRect(CheckboxRect);

  // Tick
  if checked then
  begin
    canvas.Pen.Color := FCheckColor;

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
  canvas.Brush.Color := FBorderColor;
  canvas.FrameRect(CheckboxRect);
end;

procedure TFlatCheckListBox.Paint;
var
  memoryBitmap: TBitmap;
  counterRect, counterItem: Integer;
  ItemRect: ^TRect;
  Format: UINT;
begin
{$IFDEF DFS_COMPILER_4_UP}
  if BiDiMode = bdRightToLeft then
    Format := DT_RIGHT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX
  else
    Format := DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX;
{$ELSE}
  Format := DT_LEFT or DT_VCENTER or DT_SINGLELINE or DT_NOPREFIX;
{$ENDIF}
  // create memory-bitmap to draw flicker-free
  memoryBitmap := TBitmap.Create;
  try
    memoryBitmap.Height := ClientRect.Bottom;
    memoryBitmap.Width := ClientRect.Right;
    memoryBitmap.canvas.Font.Assign(Self.Font);

    // Clear Background
    case FTransparent of
      tmAlways:
        DrawParentImage(Self, memoryBitmap.canvas);
      tmNone:
        begin
          memoryBitmap.canvas.Brush.Color := FItemsRectColor;
          memoryBitmap.canvas.FillRect(ClientRect);
        end;
      tmNotFocused:
        if Focused then
        begin
          memoryBitmap.canvas.Brush.Color := FItemsRectColor;
          memoryBitmap.canvas.FillRect(ClientRect);
        end
        else
          DrawParentImage(Self, memoryBitmap.canvas);
    end;

    // Draw Border
    memoryBitmap.canvas.Brush.Color := FBorderColor;
    memoryBitmap.canvas.FrameRect(ClientRect);

    // Draw ScrollBars
    if ScrollBars then
      DrawScrollBar(memoryBitmap.canvas);

    // Initialize the counter for the Items
    counterItem := firstItem;

    // Draw Items
    for counterRect := 0 to maxItems - 1 do
    begin
      ItemRect := FItemsRect.Items[counterRect];
      if (counterItem <= FItems.Count - 1) then
      begin
        // Item is selected
        if counterItem = FSelected then
        begin
          // Fill ItemRect
          memoryBitmap.canvas.Brush.Color := FItemsSelectColor;
          memoryBitmap.canvas.FillRect(ItemRect^);
          // Draw ItemBorder
          memoryBitmap.canvas.Brush.Color := FBorderColor;
          memoryBitmap.canvas.FrameRect(ItemRect^);
        end;
        if counterItem in FChecked then
{$IFDEF DFS_COMPILER_4_UP}
          if BiDiMode = bdRightToLeft then
            DrawCheckRect(memoryBitmap.canvas, Point(ItemRect^.Right, ItemRect^.Top), True)
          else
            DrawCheckRect(memoryBitmap.canvas, Point(ItemRect^.Left, ItemRect^.Top), True)
{$ELSE}
            DrawCheckRect(memoryBitmap.canvas, Point(ItemRect^.Left, ItemRect^.Top), True)
{$ENDIF}
          else
{$IFDEF DFS_COMPILER_4_UP}
          if BiDiMode = bdRightToLeft then
            DrawCheckRect(memoryBitmap.canvas, Point(ItemRect^.Right, ItemRect^.Top), false)
          else
            DrawCheckRect(memoryBitmap.canvas, Point(ItemRect^.Left, ItemRect^.Top), false);
{$ELSE}
        DrawCheckRect(memoryBitmap.canvas, Point(ItemRect^.Left, ItemRect^.Top), false);
{$ENDIF}
        // Draw ItemText
        memoryBitmap.canvas.Brush.style := bsClear;
        InflateRect(ItemRect^, -19, 0);
        if Enabled then
          DrawText(memoryBitmap.canvas.Handle, PChar(FItems[counterItem]), Length(FItems[counterItem]), ItemRect^,
            Format)
        else
        begin
          OffsetRect(ItemRect^, 1, 1);
          memoryBitmap.canvas.Font.Color := clBtnHighlight;
          DrawText(memoryBitmap.canvas.Handle, PChar(FItems[counterItem]), Length(FItems[counterItem]), ItemRect^,
            Format);
          OffsetRect(ItemRect^, -1, -1);
          memoryBitmap.canvas.Font.Color := clBtnShadow;
          DrawText(memoryBitmap.canvas.Handle, PChar(FItems[counterItem]), Length(FItems[counterItem]), ItemRect^,
            Format);
        end;
        InflateRect(ItemRect^, 19, 0);
        Inc(counterItem);
      end;
    end;
    // Copy bitmap to screen
    canvas.CopyRect(ClientRect, memoryBitmap.canvas, ClientRect);
  finally
    // delete the memory bitmap
    memoryBitmap.Free;
  end;
end;

procedure TFlatCheckListBox.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  cursorPos: TPoint;
  counterRect: Integer;
  currentRect: ^TRect;
  checkRect: TRect;
begin
  GetCursorPos(cursorPos);
  cursorPos := ScreenToClient(cursorPos);

  if (FItems.Count > 0) and (Button = mbLeft) then
  begin
    for counterRect := 0 to FItemsRect.Count - 1 do
    begin
      currentRect := FItemsRect.Items[counterRect];
{$IFDEF DFS_COMPILER_4_UP}
      if BiDiMode = bdRightToLeft then
        checkRect := Rect(currentRect.Right - 14, currentRect.Top + 3, currentRect.Right - 3, currentRect.Top + 14)
      else
        checkRect := Rect(currentRect.Left + 3, currentRect.Top + 3, currentRect.Left + 14, currentRect.Top + 14);
{$ELSE}
      checkRect := Rect(currentRect.Left + 3, currentRect.Top + 3, currentRect.Left + 14, currentRect.Top + 14);
{$ENDIF}
      if PtInRect(checkRect, cursorPos) then
      begin
        if (firstItem + counterRect) in FChecked then
          Exclude(FChecked, firstItem + counterRect)
        else
          Include(FChecked, firstItem + counterRect);
        SetFocus;
        if Assigned(FOnClickCheck) then
          FOnClickCheck(Self);
        Invalidate;
        Exit;
      end
      else if PtInRect(currentRect^, cursorPos) then
      begin
        FSelected := firstItem + counterRect;
        SetFocus;
        Invalidate;
        Exit;
      end;
    end;
  end;

  if ScrollBars then
  begin
    if PtInRect(Rect(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Top + 11), cursorPos) then
    begin
      if (firstItem - 1) < 0 then
        firstItem := 0
      else
        dec(firstItem);
      SetFocus;
      Invalidate;
      scrollType := up;
      if ScrollTimer.Enabled then
        ScrollTimer.Enabled := false;
      ScrollTimer.OnTimer := ScrollTimerHandler;
      ScrollTimer.Enabled := True;
    end;
    if PtInRect(Rect(ClientRect.Left, ClientRect.Bottom - 11, ClientRect.Right, ClientRect.Bottom), cursorPos) then
    begin
      if firstItem + maxItems + 1 <= FItems.Count then
        Inc(firstItem);
      SetFocus;
      Invalidate;
      scrollType := down;
      if ScrollTimer.Enabled then
        ScrollTimer.Enabled := false;
      ScrollTimer.OnTimer := ScrollTimerHandler;
      ScrollTimer.Enabled := True;
    end;
  end;
  Inherited;
end;

procedure TFlatCheckListBox.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  ScrollTimer.Enabled := false;
  ScrollTimer.Interval := FTimerInterval;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure TFlatCheckListBox.ScrollTimerHandler(Sender: TObject);
begin
  ScrollTimer.Interval := FScrollSpeed;
  if scrollType = up then
    if (firstItem - 1) < 0 then
    begin
      firstItem := 0;
      ScrollTimer.Enabled := false;
    end
    else
      dec(firstItem)
    else if firstItem + maxItems + 1 <= FItems.Count then
      Inc(firstItem)
    else
      ScrollTimer.Enabled := false;
  Invalidate;
end;

procedure TFlatCheckListBox.Loaded;
begin
  inherited;
  SetItemsRect;
end;

procedure TFlatCheckListBox.WMSize(var Message: TWMSize);
begin
  inherited;
  // Calculate the maximum items to draw
  if ScrollBars then
    maxItems := (Height - 24) div (FItemsHeight + 2)
  else
    maxItems := (Height - 4) div (FItemsHeight + 2);

  // Set the new Bounds
  if ScrollBars then
    SetBounds(Left, Top, Width, maxItems * (FItemsHeight + 2) + 24)
  else
    SetBounds(Left, Top, Width, maxItems * (FItemsHeight + 2) + 4);

  // Recalculate the itemRects
  SetItemsRect;
  if not(FTransparent = tmNone) then
    Invalidate;
end;

procedure TFlatCheckListBox.WMMove(var Message: TWMMove);
begin
  inherited;
  if not(FTransparent = tmNone) then
    Invalidate;
end;

procedure TFlatCheckListBox.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TFlatCheckListBox.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatCheckListBox.CMParentColorChanged(var Message: TWMNoParams);
begin
  inherited;
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatCheckListBox.Clear;
begin
  FItems.Clear;
  FChecked := FChecked - [0 .. High(Byte)];
  FSelected := -1;
  Invalidate;
end;

procedure TFlatCheckListBox.SetTransparent(const Value: TTransparentMode);
begin
  FTransparent := Value;
  Invalidate;
end;

procedure TFlatCheckListBox.WMKillFocus(var Message: TWMKillFocus);
begin
  inherited;
  FSelected := -1;
  Invalidate;
end;

procedure TFlatCheckListBox.WMSetFocus(var Message: TWMSetFocus);
begin
  inherited;
  if not(FTransparent = tmNone) then
    Invalidate;
end;

procedure TFlatCheckListBox.CNKeyDown(var Message: TWMKeyDown);
begin
  case Message.CharCode of
    VK_UP:
      if (firstItem - 1) < 0 then
        firstItem := 0
      else
        dec(firstItem);
    VK_DOWN:
      if firstItem + maxItems + 1 <= FItems.Count then
        Inc(firstItem);
    VK_PRIOR:
      if (firstItem - maxItems) < 0 then
        firstItem := 0
      else
        dec(firstItem, maxItems);
    VK_NEXT:
      if firstItem + (maxItems * 2) <= FItems.Count then
        Inc(firstItem, maxItems)
      else
        firstItem := FItems.Count - maxItems;
    VK_SPACE:
      if FSelected in FChecked then
        Exclude(FChecked, FSelected)
      else
        Include(FChecked, FSelected);
  else
    inherited;
  end;
  Invalidate;
end;

function TFlatCheckListBox.GetItemIndex: Integer;
begin
  Result := FSelected;
end;

procedure TFlatCheckListBox.SetItemIndex(Value: Integer);
begin
  if GetItemIndex <> Value then
  begin
    FSelected := Value;
    Invalidate;
  end;
end;

end.
