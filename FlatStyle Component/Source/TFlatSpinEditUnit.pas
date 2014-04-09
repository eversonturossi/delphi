unit TFlatSpinEditUnit;

interface

{$I DFS.inc}

uses Windows, Classes, Controls, Messages, SysUtils, FlatUtilitys, TFlatEditUnit, TFlatSpinButtonUnit;

type
  TFlatSpinEditInteger = class(TCustomFlatEdit)
  private
    FMinValue: LongInt;
    FMaxValue: LongInt;
    FIncrement: LongInt;
    FButton: TSpinButton;
    FEditorEnabled: Boolean;
    function GetMinHeight: Integer;
    function GetValue: LongInt;
    function CheckValue(NewValue: LongInt): LongInt;
    procedure SetValue(NewValue: LongInt);
    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    procedure WMCut(var Message: TWMCut); message WM_CUT;
  protected
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure UpClick(Sender: TObject); virtual;
    procedure DownClick(Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Button: TSpinButton read FButton;
  published
    property ColorFocused;
    property ColorBorder;
    property ColorFlat;
    property AdvColorFocused;
    property AdvColorBorder;
    property UseAdvColors;
    property AutoSelect;
    property AutoSize;
    property DragCursor;
    property DragMode;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Enabled;
    property Font;
    property Increment: LongInt read FIncrement write FIncrement default 1;
    property MaxValue: LongInt read FMaxValue write FMaxValue;
    property MinValue: LongInt read FMinValue write FMinValue;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value: LongInt read GetValue write SetValue;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
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
    property OnStartDrag;
{$IFDEF DFS_COMPILER_4_UP}
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

  TFlatSpinEditFloat = class(TCustomFlatEdit)
  private
    FPrecision, FDigits: Integer;
    FFloatFormat: TFloatFormat;
    FMinValue: Extended;
    FMaxValue: Extended;
    FIncrement: Extended;
    FButton: TSpinButton;
    FEditorEnabled: Boolean;
    function GetMinHeight: Integer;
    function GetValue: Extended;
    function CheckValue(Value: Extended): Extended;
    procedure SetValue(Value: Extended);
    procedure SetPrecision(Value: Integer);
    procedure SetDigits(Value: Integer);
    procedure SetFloatFormat(Value: TFloatFormat);

    procedure SetEditRect;
    procedure WMSize(var Message: TWMSize); message WM_SIZE;
    procedure CMEnter(var Message: TCMGotFocus); message CM_ENTER;
    procedure CMExit(var Message: TCMExit); message CM_EXIT;
    procedure WMPaste(var Message: TWMPaste); message WM_PASTE;
    procedure WMCut(var Message: TWMCut); message WM_CUT;
  protected
    function IsValidChar(Key: Char): Boolean; virtual;
    procedure UpClick(Sender: TObject); virtual;
    procedure DownClick(Sender: TObject); virtual;
    procedure KeyDown(var Key: Word; Shift: TShiftState); override;
    procedure KeyPress(var Key: Char); override;
    procedure CreateParams(var Params: TCreateParams); override;
    procedure Loaded; override;
    procedure CreateWnd; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    property Button: TSpinButton read FButton;
  published
    property ColorFocused;
    property ColorBorder;
    property ColorFlat;
    property AdvColorFocused;
    property AdvColorBorder;
    property UseAdvColors;
    property AutoSelect;
    property AutoSize;
    property DragCursor;
    property DragMode;
    property Digits: Integer read FDigits write SetDigits;
    property Precision: Integer read FPrecision write SetPrecision;
    property FloatFormat: TFloatFormat read FFloatFormat write SetFloatFormat;
    property EditorEnabled: Boolean read FEditorEnabled write FEditorEnabled default True;
    property Enabled;
    property Font;
    property Increment: Extended read FIncrement write FIncrement;
    property MaxValue: Extended read FMaxValue write FMaxValue;
    property MinValue: Extended read FMinValue write FMinValue;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ReadOnly;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Value: Extended read GetValue write SetValue;
    property Visible;

    property OnChange;
    property OnClick;
    property OnDblClick;
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
    property OnStartDrag;
{$IFDEF DFS_COMPILER_4_UP}
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

{ TFlatSpinEditInteger }

constructor TFlatSpinEditInteger.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TSpinButton.Create(Self);
  FButton.Parent := Self;
  FButton.Width := 22;
  FButton.Height := 10;
  FButton.Visible := True;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  Value := 0;
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 1;
  FEditorEnabled := True;
end;

destructor TFlatSpinEditInteger.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;

procedure TFlatSpinEditInteger.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP:
      UpClick(Self);
    VK_DOWN:
      DownClick(Self);
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TFlatSpinEditInteger.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then
    inherited KeyPress(Key);
end;

function TFlatSpinEditInteger.IsValidChar(Key: Char): Boolean;
begin  {d2010: DecimalSeparator - System.Char (está na classe SysUtils)}
  Result := (Key in [{$IF CompilerVersion <= 21}DecimalSeparator{$IFEND}{$IFDEF VER260}TFormatSettings.DecimalSeparator{$ENDIF}, '+', '-', '0' .. '9']) or ((Key < #32) and (Key <> Chr(VK_RETURN)));
  if not FEditorEnabled and Result and ((Key >= #32) or (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then
    Result := False;
end;

procedure TFlatSpinEditInteger.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TFlatSpinEditInteger.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc := Rect(0, 0, ClientWidth - FButton.Width - 3, ClientHeight);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
end;

procedure TFlatSpinEditInteger.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
  { text edit bug: if size to less than minheight, then edit ctrl does
    not display the text }
  if Height < MinHeight then
    Height := MinHeight
  else if FButton <> nil then
  begin
    FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 6);
    SetEditRect;
  end;
end;

function TFlatSpinEditInteger.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight + 7;
end;

procedure TFlatSpinEditInteger.UpClick(Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    Value := GetValue + FIncrement;
end;

procedure TFlatSpinEditInteger.DownClick(Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    Value := GetValue - FIncrement;
end;

procedure TFlatSpinEditInteger.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then
    Exit;
  inherited;
end;

procedure TFlatSpinEditInteger.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then
    Exit;
  inherited;
end;

procedure TFlatSpinEditInteger.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue(Value) <> Value then
    SetValue(Value);
end;

function TFlatSpinEditInteger.GetValue: LongInt;
begin
  try
    Result := StrToInt(Text);
  except
    Result := FMinValue;
  end;
end;

procedure TFlatSpinEditInteger.SetValue(NewValue: LongInt);
begin
  Text := IntToStr(CheckValue(NewValue));
end;

function TFlatSpinEditInteger.CheckValue(NewValue: LongInt): LongInt;
begin
  Result := NewValue;
  if (FMaxValue <> FMinValue) then
  begin
    if NewValue < FMinValue then
      Result := FMinValue
    else if NewValue > FMaxValue then
      Result := FMaxValue;
  end;
end;

procedure TFlatSpinEditInteger.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not(csLButtonDown in ControlState) then
    SelectAll;
  inherited;
end;

procedure TFlatSpinEditInteger.Loaded;
begin
  SetEditRect;
  FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 6);
  inherited;
end;

procedure TFlatSpinEditInteger.CreateWnd;
begin
  inherited;
  SetEditRect;
  FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 6);
end;

{ TFlatSpinEditFloat }

constructor TFlatSpinEditFloat.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FButton := TSpinButton.Create(Self);
  FButton.Parent := Self;
  FButton.Width := 22;
  FButton.Height := 10;
  FButton.Visible := True;
  FButton.FocusControl := Self;
  FButton.OnUpClick := UpClick;
  FButton.OnDownClick := DownClick;
  Text := '0' + DecimalSeparator + '00';
  ControlStyle := ControlStyle - [csSetCaption];
  FIncrement := 0.5;
  FEditorEnabled := True;
  FDigits := 2;
  FPrecision := 9;
end;

destructor TFlatSpinEditFloat.Destroy;
begin
  FButton := nil;
  inherited Destroy;
end;

procedure TFlatSpinEditFloat.KeyDown(var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_UP:
      UpClick(Self);
    VK_DOWN:
      DownClick(Self);
  end;
  inherited KeyDown(Key, Shift);
end;

procedure TFlatSpinEditFloat.KeyPress(var Key: Char);
begin
  if not IsValidChar(Key) then
  begin
    Key := #0;
    MessageBeep(0)
  end;
  if Key <> #0 then
    inherited KeyPress(Key);
end;

function TFlatSpinEditFloat.IsValidChar(Key: Char): Boolean;
begin
  Result := (Key in [DecimalSeparator, '+', '-', '0' .. '9']) or ((Key < #32) and (Key <> Chr(VK_RETURN)));
  if not FEditorEnabled and Result and ((Key >= #32) or (Key = Char(VK_BACK)) or (Key = Char(VK_DELETE))) then
    Result := False;
end;

procedure TFlatSpinEditFloat.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_MULTILINE or WS_CLIPCHILDREN;
end;

procedure TFlatSpinEditFloat.SetEditRect;
var
  Loc: TRect;
begin
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
  Loc := Rect(0, 0, ClientWidth - FButton.Width - 3, ClientHeight);
  SendMessage(Handle, EM_SETRECTNP, 0, LongInt(@Loc));
  SendMessage(Handle, EM_GETRECT, 0, LongInt(@Loc));
end;

procedure TFlatSpinEditFloat.WMSize(var Message: TWMSize);
var
  MinHeight: Integer;
begin
  inherited;
  MinHeight := GetMinHeight;
  { text edit bug: if size to less than minheight, then edit ctrl does
    not display the text }
  if Height < MinHeight then
    Height := MinHeight
  else if FButton <> nil then
  begin
    FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 6);
    SetEditRect;
  end;
end;

function TFlatSpinEditFloat.GetMinHeight: Integer;
var
  DC: HDC;
  SaveFont: HFont;
  SysMetrics, Metrics: TTextMetric;
begin
  DC := GetDC(0);
  GetTextMetrics(DC, SysMetrics);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Metrics);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
  Result := Metrics.tmHeight + 7;
end;

procedure TFlatSpinEditFloat.UpClick(Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    Value := Value + FIncrement;
end;

procedure TFlatSpinEditFloat.DownClick(Sender: TObject);
begin
  if ReadOnly then
    MessageBeep(0)
  else
    Value := Value - FIncrement;
end;

procedure TFlatSpinEditFloat.WMPaste(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then
    Exit;
  inherited;
end;

procedure TFlatSpinEditFloat.WMCut(var Message: TWMPaste);
begin
  if not FEditorEnabled or ReadOnly then
    Exit;
  inherited;
end;

procedure TFlatSpinEditFloat.CMExit(var Message: TCMExit);
begin
  inherited;
  if CheckValue(Value) <> Value then
    SetValue(Value);
end;

function TFlatSpinEditFloat.GetValue: Extended;
var
  s: string;
begin
  try
    s := Text;
    {d2010: CurrencyString - System.string (está em SysUtils)}
    while Pos(CurrencyString, s) > 0 do
      Delete(s, Pos(CurrencyString, s), Length(CurrencyString));
    while Pos(' ', s) > 0 do
      Delete(s, Pos(' ', s), 1);
    while Pos(ThousandSeparator, s) > 0 do  {d2010: ThousandSeparator - System.Char (está em SysUtils)}
      Delete(s, Pos(ThousandSeparator, s), Length(ThousandSeparator));

    // Delete negative numbers in format Currency
    if Pos('(', s) > 0 then
    begin
      Delete(s, Pos('(', s), 1);
      if Pos(')', s) > 0 then
        Delete(s, Pos(')', s), 1);
      Result := StrToFloat(s) * -1;
    end
    else
      Result := StrToFloat(s);
  except
    Result := FMinValue;
  end;
end;

procedure TFlatSpinEditFloat.SetFloatFormat(Value: TFloatFormat);
begin
  FFloatFormat := Value;
  Text := FloatToStrF(CheckValue(GetValue), FloatFormat, Precision, Digits);
end;

procedure TFlatSpinEditFloat.SetDigits(Value: Integer);
begin
  FDigits := Value;
  Text := FloatToStrF(CheckValue(GetValue), FloatFormat, Precision, Digits);
end;

procedure TFlatSpinEditFloat.SetPrecision(Value: Integer);
begin
  FPrecision := Value;
  Text := FloatToStrF(CheckValue(GetValue), FloatFormat, Precision, Digits);
end;

procedure TFlatSpinEditFloat.SetValue(Value: Extended);
begin
  Text := FloatToStrF(CheckValue(Value), FloatFormat, Precision, Digits);
end;

function TFlatSpinEditFloat.CheckValue(Value: Extended): Extended;
begin
  Result := Value;
  if (FMaxValue <> FMinValue) then
  begin
    if Value < FMinValue then
      Result := FMinValue
    else if Value > FMaxValue then
      Result := FMaxValue;
  end;
end;

procedure TFlatSpinEditFloat.CMEnter(var Message: TCMGotFocus);
begin
  if AutoSelect and not(csLButtonDown in ControlState) then
    SelectAll;
  inherited;
end;

procedure TFlatSpinEditFloat.Loaded;
begin
  SetEditRect;
  FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 6);
  inherited;
end;

procedure TFlatSpinEditFloat.CreateWnd;
begin
  inherited;
  SetEditRect;
  FButton.SetBounds(Width - FButton.Width - 5, 0, FButton.Width, Height - 6);
end;

end.
