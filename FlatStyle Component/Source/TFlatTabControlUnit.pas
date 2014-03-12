unit TFlatTabControlUnit;

interface

{$I DFS.inc}

uses
  Windows, Messages, Classes, Controls, Forms, Graphics, StdCtrls, SysUtils, FlatUtilitys;

type
  TFlatTabControl = class(TCustomControl)
  private
    FUseAdvColors: Boolean;
    FAdvColorBorder: TAdvColors;
    FTabPosition: TFlatTabPosition;
    FTabs: TStringList;
    FTabsRect: TList;
    FTabHeight: Integer;
    FTabSpacing: Integer;
    FActiveTab: Integer;
    FUnselectedColor: TColor;
    FBorderColor: TColor;
    FOnTabChanged: TNotifyEvent;
    FBorderWidth: Integer;
    procedure SetTabs(Value: TStringList);
    procedure SetTabPosition(Value: TFlatTabPosition);
    procedure SetTabHeight(Value: Integer);
    procedure SetTabSpacing(Value: Integer);
    procedure SetActiveTab(Value: Integer);
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    procedure SetTabRect;
    procedure CMDialogChar(var Message: TCMDialogChar); message CM_DIALOGCHAR;
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;
    procedure CMDesignHitTest(var Message: TCMDesignHitTest); message CM_DESIGNHITTEST;
    procedure WMMove(var Message: TWMMove); message WM_MOVE;
    procedure SetBorderWidth(const Value: Integer);
  protected
    procedure CalcAdvColors;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure AlignControls(AControl: TControl; var Rect: TRect); override;
    procedure TabsChanged(Sender: TObject);
{$IFDEF DFS_COMPILER_4_UP}
    procedure SetBiDiMode(Value: TBiDiMode); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Align;
    property BorderWidth: Integer read FBorderWidth write SetBorderWidth default 0;
    property ColorBorder: TColor index 0 read FBorderColor write SetColors default $008396A0;
    property ColorUnselectedTab: TColor index 1 read FUnselectedColor write SetColors default $00996633;
    property AdvColorBorder: TAdvColors index 0 read FAdvColorBorder write SetAdvColors default 50;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default false;
    property Tabs: TStringList read FTabs write SetTabs;
    property TabHeight: Integer read FTabHeight write SetTabHeight default 16;
    property TabSpacing: Integer read FTabSpacing write SetTabSpacing default 4;
    property TabPosition: TFlatTabPosition read FTabPosition write SetTabPosition default tpTop;
    property ActiveTab: Integer read FActiveTab write SetActiveTab default 0;
    property Font;
    property Color;
    property ParentColor;
    property Enabled;
    property Visible;
    property Cursor;
    property ParentShowHint;
    property ParentFont;
    property ShowHint;
    property TabOrder;
    property TabStop;

    property OnEnter;
    property OnExit;
    property OnMouseMove;
    property OnMouseDown;
    property OnMouseUp;
    property OnTabChanged: TNotifyEvent read FOnTabChanged write FOnTabChanged;
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

procedure TFlatTabControl.CMDesignHitTest(var Message: TCMDesignHitTest);
begin
  case FTabPosition of
    tpTop:
      if PtInRect(Rect(ClientRect.Left, ClientRect.Top, ClientRect.Right, ClientRect.Top + FTabHeight + 1),
        Point(message.XPos, message.YPos)) then
        Message.Result := 1
      else
        Message.Result := 0;
    tpBottom:
      if PtInRect(Rect(ClientRect.Left, ClientRect.Bottom - FTabHeight, ClientRect.Right, ClientRect.Bottom),
        Point(message.XPos, message.YPos)) then
        Message.Result := 1
      else
        Message.Result := 0;
  end;
end;

constructor TFlatTabControl.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := ControlStyle + [csAcceptsControls, csOpaque];
  SetBounds(Left, Top, 289, 193);
  FTabs := TStringList.Create;
  FTabs.OnChange := TabsChanged;
  FTabsRect := TList.Create;
  FTabHeight := 16;
  FTabSpacing := 4;
  FTabPosition := tpTop;
  FActiveTab := 0;
  Color := $00E1EAEB;
  FBorderColor := $008396A0;
  FUnselectedColor := $00996633;
  ParentColor := true;
  ParentFont := true;
  FUseAdvColors := false;
  FAdvColorBorder := 50;
end;

destructor TFlatTabControl.Destroy;
begin
  FTabs.Free;
  FTabsRect.Free;
  inherited;
end;

procedure TFlatTabControl.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FBorderColor := CalcAdvancedColor(Color, FBorderColor, FAdvColorBorder, darken);
  end;
end;

procedure TFlatTabControl.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorBorder := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatTabControl.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    ParentColor := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatTabControl.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
  begin
    ParentColor := true;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatTabControl.CMParentColorChanged(var Message: TWMNoParams);
begin
  inherited;
  if FUseAdvColors then
  begin
    ParentColor := true;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatTabControl.Loaded;
begin
  inherited;
  SetTabRect;
  Invalidate;
end;

procedure TFlatTabControl.WMSize(var Message: TWMSize);
begin
  inherited;
  SetTabRect;
  Invalidate;
end;

procedure TFlatTabControl.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TFlatTabControl.SetTabPosition(Value: TFlatTabPosition);
var
  I: Integer;
  r: TRect;
begin
  if Value <> FTabPosition then
  begin
    for I := 0 to ControlCount - 1 do // reposition client-controls
    begin
      if Value = tpTop then
        Controls[I].Top := Controls[I].Top + TabHeight
      else
        Controls[I].Top := Controls[I].Top - TabHeight;
    end;
    FTabPosition := Value;
    SetTabRect;
    Invalidate;
    r := ClientRect;
    AlignControls(self, r);
  end;
end;

procedure TFlatTabControl.SetActiveTab(Value: Integer);
begin
  if FTabs <> nil then
  begin
    if Value > (FTabs.Count - 1) then
      Value := FTabs.Count - 1
    else if Value < 0 then
      Value := 0;

    FActiveTab := Value;
    if Assigned(FOnTabChanged) then
      FOnTabChanged(self);
    Invalidate;
  end
  else
    FActiveTab := 0;
  if csDesigning in ComponentState then
    if (GetParentForm(self) <> nil) and (GetParentForm(self).Designer <> nil) then
      GetParentForm(self).Designer.Modified;
end;

procedure TFlatTabControl.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FBorderColor := Value;
    1:
      FUnselectedColor := Value;
  end;
  Invalidate;
end;

procedure TFlatTabControl.SetTabs(Value: TStringList);
var
  counter: Integer;
begin
  FTabs.Assign(Value);
  if FTabs.Count = 0 then // no tabs? then active tab = 0
    FActiveTab := 0
  else
  begin
    if (FTabs.Count - 1) < FActiveTab then // if activeTab > last-tab the activeTab = last-tab
      FActiveTab := FTabs.Count - 1;
    for counter := 0 to FTabs.Count - 1 do
      FTabs[counter] := Trim(FTabs[counter]); // delete all spaces at left and right
  end;
  SetTabRect;
  Invalidate;
end;

procedure TFlatTabControl.SetTabHeight(Value: Integer);
var
  r: TRect;
begin
  if Value < 0 then
    Value := 0; // TabHeigh can't negative
  FTabHeight := Value;
  SetTabRect;
  r := ClientRect;
  AlignControls(self, r);
  Invalidate;
end;

procedure TFlatTabControl.SetTabSpacing(Value: Integer);
begin
  if Value < 1 then
    Value := 1; // minimal tabspacing = 1 dot
  FTabSpacing := Value;
  SetTabRect;
  Invalidate;
end;

procedure TFlatTabControl.SetTabRect;
var
  TabCount: Integer;
  TabRect: ^TRect;
  position: TPoint;
  CaptionTextWidth: Integer;
  CaptionTextString: string;
begin
  // set the font and clear the tab-rect-list
  canvas.Font := self.Font;
  FTabsRect.Clear;

  // set left/top position for the the first tab
  case FTabPosition of
    tpTop:
{$IFDEF DFS_COMPILER_4_UP}
      if BiDiMode = bdRightToLeft then
        position := Point(ClientRect.Right, ClientRect.Top)
      else
        position := Point(ClientRect.Left, ClientRect.Top);
{$ELSE}
    position := Point(ClientRect.Left, ClientRect.Top);
{$ENDIF}
    tpBottom:
{$IFDEF DFS_COMPILER_4_UP}
      if BiDiMode = bdRightToLeft then
        position := Point(ClientRect.Right, ClientRect.Bottom - FTabHeight)
      else
        position := Point(ClientRect.Left, ClientRect.Bottom - FTabHeight);
{$ELSE}
    position := Point(ClientRect.Left, ClientRect.Bottom - FTabHeight);
{$ENDIF}
    end;

    for TabCount := 0 to (FTabs.Count - 1) do begin New(TabRect); // create a new Tab-Rect
    if Pos('&', FTabs[TabCount]) <> 0 then // if & in an caption
      begin CaptionTextString := FTabs[TabCount]; // read the caption text
    Delete(CaptionTextString, Pos('&', FTabs[TabCount]), 1); // delete the &
    CaptionTextWidth := canvas.TextWidth(CaptionTextString); // calc the caption-width withou the &
    end else // else calc the caption-width
      CaptionTextWidth := canvas.TextWidth(FTabs[TabCount]);
{$IFDEF DFS_COMPILER_4_UP}
    if BiDiMode = bdRightToLeft then begin case FTabPosition of // set the rect
      tpTop:
      TabRect^ := Rect(position.X - CaptionTextWidth - 20, position.Y, position.X, FTabHeight);
    tpBottom:
      TabRect^ := Rect(position.X - CaptionTextWidth - 20, position.Y, position.X, position.Y + FTabHeight);
  end;
  position := Point(position.X - CaptionTextWidth - 20 - FTabSpacing, position.Y);
  // set left/top position for next rect
end
else
begin
  case FTabPosition of // set the rect
    tpTop:
      TabRect^ := Rect(position.X, position.Y, position.X + CaptionTextWidth + 20, FTabHeight);
    tpBottom:
      TabRect^ := Rect(position.X, position.Y, position.X + CaptionTextWidth + 20, position.Y + FTabHeight);
  end;
  position := Point(position.X + CaptionTextWidth + 20 + FTabSpacing, position.Y);
  // set left/top position for next rect
end;
{$ELSE}
case FTabPosition of // set the rect
  tpTop:
    TabRect^ := Rect(position.X, position.Y, position.X + CaptionTextWidth + 20, FTabHeight);
  tpBottom:
    TabRect^ := Rect(position.X, position.Y, position.X + CaptionTextWidth + 20, position.Y + FTabHeight);
end;
position := Point(position.X + CaptionTextWidth + 20 + FTabSpacing, position.Y); // set left/top position for next rect
{$ENDIF}
FTabsRect.Add(TabRect); // add the tab-rect to the tab-rect-list
end;
end;

procedure TFlatTabControl.CMDialogChar(var Message: TCMDialogChar);
var
  currentTab: Integer;
begin
  with Message do
  begin
    if FTabs.Count > 0 then
    begin
      for currentTab := 0 to FTabs.Count - 1 do
      begin
        if IsAccel(CharCode, FTabs[currentTab]) then
        begin
          if (FActiveTab <> currentTab) then
          begin
            SetActiveTab(currentTab);
            SetFocus;
          end;
          Result := 1;
          break;
        end;
      end;
    end
    else
      inherited;
  end;
end;

procedure TFlatTabControl.Paint;
var
  memoryBitmap: TBitmap;
  TabCount: Integer;
  TempRect: ^TRect;
begin
  memoryBitmap := TBitmap.Create; // create memory-bitmap to draw flicker-free
  try
    memoryBitmap.Height := ClientRect.Bottom;
    memoryBitmap.Width := ClientRect.Right;
    memoryBitmap.canvas.Font := self.Font;

    // Clear Background
    if FTabs.Count > 0 then
      DrawParentImage(self, memoryBitmap.canvas)
    else
    begin
      memoryBitmap.canvas.Brush.Color := self.Color;
      memoryBitmap.canvas.FillRect(ClientRect);
    end;

    // Draw Border
    if FTabs.Count = 0 then
    begin
      memoryBitmap.canvas.Brush.Color := FBorderColor;
      memoryBitmap.canvas.FrameRect(ClientRect)
    end
    else
    begin
      memoryBitmap.canvas.Pen.Color := FBorderColor;
      TempRect := FTabsRect.Items[FActiveTab];
      if ClientRect.Left <> TempRect^.Left then // if Active Tab not first tab then __|Tab|___
      begin
        case FTabPosition of
          tpTop:
            begin
              memoryBitmap.canvas.Polyline([Point(ClientRect.Left, ClientRect.Top + FTabHeight),
                Point(TempRect^.Left, ClientRect.Top + FTabHeight)]);
              memoryBitmap.canvas.Polyline([Point(TempRect^.Right - 1, ClientRect.Top + FTabHeight),
                Point(ClientRect.Right, ClientRect.Top + FTabHeight)]);
            end;
          tpBottom:
            begin
              memoryBitmap.canvas.Polyline([Point(ClientRect.Left, ClientRect.Bottom - FTabHeight - 1),
                Point(TempRect^.Left, ClientRect.Bottom - FTabHeight - 1)]);
              memoryBitmap.canvas.Polyline([Point(TempRect^.Right - 1, ClientRect.Bottom - FTabHeight - 1),
                Point(ClientRect.Right, ClientRect.Bottom - FTabHeight - 1)]);
            end;
        end;
      end
      else // else |Tab|___
        case FTabPosition of
          tpTop:
            memoryBitmap.canvas.Polyline([Point(TempRect^.Right - 1, ClientRect.Top + FTabHeight),
              Point(ClientRect.Right, ClientRect.Top + FTabHeight)]);
          tpBottom:
            memoryBitmap.canvas.Polyline([Point(TempRect^.Right - 1, ClientRect.Bottom - FTabHeight - 1),
              Point(ClientRect.Right, ClientRect.Bottom - FTabHeight - 1)]);
        end;
      // border of the control
      case FTabPosition of
        tpTop:
          memoryBitmap.canvas.Polyline([Point(ClientRect.Left, ClientRect.Top + FTabHeight),
            Point(ClientRect.Left, ClientRect.Bottom - 1), Point(ClientRect.Right - 1, ClientRect.Bottom - 1),
            Point(ClientRect.Right - 1, ClientRect.Top + FTabHeight)]);
        tpBottom:
          memoryBitmap.canvas.Polyline([Point(ClientRect.Left, ClientRect.Bottom - FTabHeight - 1),
            Point(ClientRect.Left, ClientRect.Top), Point(ClientRect.Right - 1, ClientRect.Top),
            Point(ClientRect.Right - 1, ClientRect.Bottom - FTabHeight - 1)]);
      end;
    end;

    case FTabPosition of
      tpTop:
        begin
          memoryBitmap.canvas.Brush.Color := Color;
          memoryBitmap.canvas.FillRect(Rect(ClientRect.Left + 1, ClientRect.Top + FTabHeight + 1, ClientRect.Right - 1,
              ClientRect.Bottom - 1));
        end;
      tpBottom:
        begin
          memoryBitmap.canvas.Brush.Color := Color;
          memoryBitmap.canvas.FillRect(Rect(ClientRect.Left + 1, ClientRect.Top + 1, ClientRect.Right - 1,
              ClientRect.Bottom - FTabHeight - 1));
        end;
    end;

    // Draw Tabs
    for TabCount := 0 to FTabs.Count - 1 do
    begin
      TempRect := FTabsRect.Items[TabCount];
      memoryBitmap.canvas.Brush.style := bsclear;
      memoryBitmap.canvas.Pen.Color := clBlack;
      if TabCount = FActiveTab then // if Active Tab not first tab then draw border |^^^|
      begin
        memoryBitmap.canvas.Font.Color := self.Font.Color;
        memoryBitmap.canvas.Brush.Color := Color;
        memoryBitmap.canvas.Pen.Color := FBorderColor;
        case FTabPosition of
          tpTop:
            begin
              memoryBitmap.canvas.FillRect(Rect(TempRect^.Left, TempRect^.Top, TempRect^.Right - 1,
                  TempRect^.Bottom + 1));
              memoryBitmap.canvas.Polyline([Point(TempRect^.Left, TempRect^.Bottom),
                Point(TempRect^.Left, TempRect^.Top), Point(TempRect^.Right - 1, TempRect^.Top),
                Point(TempRect^.Right - 1, TempRect^.Bottom)]);
            end;
          tpBottom:
            begin
              memoryBitmap.canvas.FillRect(Rect(TempRect^.Left, TempRect^.Top - 1, TempRect^.Right - 1,
                  TempRect^.Bottom));
              memoryBitmap.canvas.Polyline([Point(TempRect^.Left, TempRect^.Top - 1),
                Point(TempRect^.Left, TempRect^.Bottom - 1), Point(TempRect^.Right - 1, TempRect^.Bottom - 1),
                Point(TempRect^.Right - 1, TempRect^.Top - 1)]);
            end;
        end;
      end
      else // else only fill the tab
      begin
        memoryBitmap.canvas.Font.Color := Color;
        memoryBitmap.canvas.Brush.Color := FUnselectedColor;
        memoryBitmap.canvas.FillRect(TempRect^);
      end;
      memoryBitmap.canvas.Brush.style := bsclear;
      if (TabCount = FActiveTab) and not Enabled then
      begin
        memoryBitmap.canvas.Font.Color := FUnselectedColor;
        DrawText(memoryBitmap.canvas.Handle, PChar(FTabs[TabCount]), Length(FTabs[TabCount]), TempRect^,
          DT_CENTER or DT_VCENTER or DT_SINGLELINE)
      end
      else
        DrawText(memoryBitmap.canvas.Handle, PChar(FTabs[TabCount]), Length(FTabs[TabCount]), TempRect^,
          DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    end;
    canvas.CopyRect(ClientRect, memoryBitmap.canvas, ClientRect); // Copy bitmap to screen
  finally
    memoryBitmap.Free; // delete the bitmap
  end;
end;

procedure TFlatTabControl.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  cursorPos: TPoint;
  currentTab: Integer;
  currentRect: ^TRect;
begin
  GetCursorPos(cursorPos);
  cursorPos := ScreenToClient(cursorPos);

  if FTabs.Count > 0 then
  begin
    for currentTab := 0 to FTabs.Count - 1 do
    begin
      currentRect := FTabsRect.Items[currentTab];
      if PtInRect(currentRect^, cursorPos) then
        if (FActiveTab <> currentTab) then // only change when new tab selected
        begin
          SetActiveTab(currentTab);
          SetFocus;
        end;
    end;
  end;
  inherited;
end;

procedure TFlatTabControl.AlignControls(AControl: TControl; var Rect: TRect);
begin
  case FTabPosition of
    tpTop:
      SetRect(Rect, ClientRect.Left + 1 + FBorderWidth, ClientRect.Top + TabHeight + 1 + FBorderWidth,
        ClientRect.Right - 1 - FBorderWidth, ClientRect.Bottom - 1 - FBorderWidth);
    tpBottom:
      SetRect(Rect, ClientRect.Left + 1 + FBorderWidth, ClientRect.Top + 1 + FBorderWidth,
        ClientRect.Right - 1 - FBorderWidth, ClientRect.Bottom - TabHeight - 1 - FBorderWidth);
  end;
  inherited;
end;

procedure TFlatTabControl.WMMove(var Message: TWMMove);
begin
  inherited;
  Invalidate;
end;
{$IFDEF DFS_COMPILER_4_UP}

procedure TFlatTabControl.SetBiDiMode(Value: TBiDiMode);
begin
  inherited;
  SetTabRect;
  Invalidate;
end;
{$ENDIF}

procedure TFlatTabControl.TabsChanged(Sender: TObject);
begin
  SetTabRect;
  Invalidate;
end;

procedure TFlatTabControl.SetBorderWidth(const Value: Integer);
var
  r: TRect;
begin
  if Value <> FBorderWidth then
  begin
    FBorderWidth := Value;
    r := ClientRect;
    AlignControls(self, r);
  end;
end;

end.
