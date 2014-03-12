unit TFlatTitlebarUnit;

{ *************************************************************** }
{ }
{ TFlatTitlebar }
{ Copyright ©2000 Lloyd Kinsella. }
{ }
{ FlatStyle is Copyright ©1998-2000 Maik Porkert. }
{ }
{ E-Mail: lloydk@iname.com }
{ Web:    http://www.flatstyle.de/ }
{ }
{ *************************************************************** }

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FlatGraphics;

const
  SParentForm = 'TFlatTitlebar can only be placed on a descndant of a TCustomForm';

type
  TFlatTitlebar = class(TCustomControl)
  private
    FForm: TCustomForm;
    FWndProcInstance: Pointer;
    FDefProc: LongInt;
    FActive: Boolean;
    FDown: Boolean;
    FOldX, FOldY: Integer;
    FActiveTextColor: TColor;
    FInactiveTextColor: TColor;
    FTitlebarColor: TColor;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    procedure FormWndProc(var Message: TMessage);
    procedure DoActivateMessage(var Message: TWMActivate);
    procedure DoActivation;
    procedure DoDeactivation;
    procedure SetActiveTextColor(Value: TColor);
    procedure SetInactiveTextColor(Value: TColor);
    procedure SetTitlebarColor(Value: TColor);
    procedure SetParent(AParent: TWinControl); override;
    procedure CMFontChanged(var Message: TMessage); message CM_FONTCHANGED;
    procedure CMTextChanged(var Message: TMessage); message CM_TEXTCHANGED;
  protected
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Loaded; override;
    procedure Paint; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
  public
    { Public declarations }
  published
    property ActiveTextColor: TColor read FActiveTextColor write SetActiveTextColor;
    property InactiveTextColor: TColor read FInactiveTextColor write SetInactiveTextColor;
    property TitlebarColor: TColor read FTitlebarColor write SetTitlebarColor;
    property Align;
    property Font;
    property Caption;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
  end;

procedure Register;

implementation

constructor TFlatTitlebar.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 100;
  Height := 19;
  ControlStyle := ControlStyle + [csAcceptsControls];
  TitlebarColor := ecCaptionBackground;
  ActiveTextColor := ecActiveCaption;
  InactiveTextColor := ecInactiveCaption;
  if csDesigning in ComponentState then
  begin
    FActive := True;
  end;
end;

destructor TFlatTitlebar.Destroy;
begin
  inherited Destroy;
end;

procedure TFlatTitlebar.Loaded;
var
  Wnd: HWND;
begin
  inherited Loaded;
  if not(csDesigning in ComponentState) and (FForm <> nil) then
  begin
    if FForm <> nil then
    begin
      Wnd := FForm.Handle;
      FWndProcInstance := MakeObjectInstance(FormWndProc);
      FDefProc := SetWindowLong(Wnd, GWL_WNDPROC, LongInt(FWndProcInstance));
    end;
  end;
end;

procedure TFlatTitlebar.FormWndProc(var Message: TMessage);
begin
  case Message.Msg of
    WM_ACTIVATE:
      DoActivateMessage(TWMActivate(Message));
  end;
  Message.Result := CallWindowProc(Pointer(FDefProc), FForm.Handle, Message.Msg, Message.WParam, Message.LParam);
end;

procedure TFlatTitlebar.DoActivateMessage(var Message: TWMActivate);
begin
  case Message.Active of
    WA_ACTIVE:
      DoActivation;
    WA_CLICKACTIVE:
      DoActivation;
    WA_INACTIVE:
      DoDeactivation;
  end;
end;

procedure TFlatTitlebar.DoActivation;
begin
  FActive := True;
  Invalidate;
  if Assigned(FOnActivate) then
    FOnActivate(Self);
end;

procedure TFlatTitlebar.DoDeactivation;
begin
  FActive := False;
  Invalidate;
  if Assigned(FOnDeactivate) then
    FOnDeactivate(Self);
end;

procedure TFlatTitlebar.Paint;
var
  iCaptionWidth, iCaptionHeight, iX, iY: Integer;
begin
  with Canvas do
  begin
    with ClientRect do
    begin
      Canvas.Font.Assign(Self.Font);
      case FActive of
        True:
          Canvas.Font.Color := FActiveTextColor;
        False:
          Canvas.Font.Color := FInactiveTextColor;
      end;
      iCaptionWidth := TextWidth(Caption);
      iCaptionHeight := TextHeight(Caption);
      Brush.Color := TitlebarColor;
      FillRect(ClientRect);
      iX := Width div 2 - iCaptionWidth div 2;
      iY := Height div 2 - iCaptionHeight div 2;
      TextOut(iX, iY, Caption);
    end;
  end;
end;

procedure TFlatTitlebar.MouseMove;
begin
  if FDown then
  begin
    TCustomForm(Owner).Left := TCustomForm(Owner).Left + X - FOldX;
    TCustomForm(Owner).Top := TCustomForm(Owner).Top + Y - FOldY;
  end;
end;

procedure TFlatTitlebar.MouseUp;
begin
  FDown := False;
end;

procedure TFlatTitlebar.MouseDown;
begin
  if (Button = mbleft) and not FDown then
    FDown := True;
  FOldX := X;
  FOldY := Y;
end;

procedure TFlatTitlebar.SetActiveTextColor(Value: TColor);
begin
  if Value <> FActiveTextColor then
  begin
    FActiveTextColor := Value;
    Invalidate;
  end;
end;

procedure TFlatTitlebar.SetInactiveTextColor(Value: TColor);
begin
  if Value <> FInactiveTextColor then
  begin
    FInactiveTextColor := Value;
    Invalidate;
  end;
end;

procedure TFlatTitlebar.SetTitlebarColor(Value: TColor);
begin
  if Value <> FTitlebarColor then
  begin
    FTitlebarColor := Value;
    Invalidate;
  end;
end;

procedure TFlatTitlebar.SetParent(AParent: TWinControl);
begin
  if (AParent <> nil) and not(AParent is TCustomForm) then
    raise EInvalidOperation.Create(SParentForm);
  FForm := TCustomForm(AParent);
  inherited;
end;

procedure TFlatTitlebar.CMFontChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure TFlatTitlebar.CMTextChanged(var Message: TMessage);
begin
  Invalidate;
end;

procedure Register;
begin
  RegisterComponents('FlatStyle', [TFlatTitlebar]);
end;

end.
