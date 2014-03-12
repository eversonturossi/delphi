unit TFlatAnimWndUnit;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs;

type
  TFlatAnimWnd = class;

  TFlatAnimHookWnd = class(TWinControl)
  private
    FAnimateWindow: TFlatAnimWnd;
    procedure WMCreate(var Message: TMessage); message WM_CREATE;
    procedure WMDestroy(var Message: TMessage); message WM_DESTROY;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TFlatAnimWnd = class(TComponent)
  private
    FOwner: TComponent;
    FNewProc, FOldProc, FNewAppProc, FOldAppProc: TFarProc;
    FOnMinimize: TNotifyEvent;
    FOnRestore: TNotifyEvent;
    procedure NewWndProc(var Message: TMessage);
    procedure NewAppWndProc(var Message: TMessage);
    procedure MinimizeWnd;
    procedure RestoreWnd;
    procedure OwnerWndCreated;
    procedure OwnerWndDestroyed;
  protected
    FHookWnd: TFlatAnimHookWnd;
    procedure SetParentComponent(Value: TComponent); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Minimize;
  published
    property OnMinimize: TNotifyEvent read FOnMinimize write FOnMinimize;
    property OnRestore: TNotifyEvent read FOnRestore write FOnRestore;
  end;

implementation

var
  OwnerList: TList;

constructor TFlatAnimHookWnd.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FAnimateWindow := TFlatAnimWnd(AOwner);
end;

procedure TFlatAnimHookWnd.WMCreate(var Message: TMessage);
begin
  inherited;
  FAnimateWindow.OwnerWndCreated;
end;

procedure TFlatAnimHookWnd.WMDestroy(var Message: TMessage);
begin
  FAnimateWindow.OwnerWndDestroyed;
  inherited;
end;

constructor TFlatAnimWnd.Create(AOwner: TComponent);
begin
  FOwner := AOwner;
  if OwnerList.IndexOf(FOwner) <> -1 then
  begin
    FOwner := nil;
    raise Exception.Create('Owner must be TFORM');
  end;
  inherited Create(AOwner);
  if not(csDesigning in ComponentState) then
  begin
    FHookWnd := TFlatAnimHookWnd.Create(Self);
    if Application.MainForm = nil then
    begin
      FNewAppProc := MakeObjectInstance(NewAppWndProc);
      FOldAppProc := Pointer(GetWindowLong(Application.Handle, GWL_WNDPROC));
      SetWindowLong(Application.Handle, GWL_WNDPROC, Longint(FNewAppProc));
    end;
  end;
  OwnerList.Add(FOwner);
end;

destructor TFlatAnimWnd.Destroy;
begin
  if not(csDesigning in ComponentState) then
  begin
    if Application.MainForm = nil then
    begin
      SetWindowLong(Application.Handle, GWL_WNDPROC, Longint(FOldAppProc));
      FreeObjectInstance(FNewAppProc);
    end;
  end;
  if OwnerList.IndexOf(FOwner) <> -1 then
    OwnerList.Remove(FOwner);
  inherited Destroy;
end;

procedure TFlatAnimWnd.SetParentComponent(Value: TComponent);
begin
  inherited SetParentComponent(Value);
  if not(csDesigning in ComponentState) then
    if Value is TWinControl then
      FHookWnd.Parent := TWinControl(Value);
end;

procedure TFlatAnimWnd.OwnerWndCreated;
begin
  FNewProc := MakeObjectInstance(NewWndProc);
  FOldProc := Pointer(GetWindowLong((FOwner as TForm).Handle, GWL_WNDPROC));
  SetWindowLong((FOwner as TForm).Handle, GWL_WNDPROC, Longint(FNewProc));
end;

procedure TFlatAnimWnd.OwnerWndDestroyed;
begin
  SetWindowLong((FOwner as TForm).Handle, GWL_WNDPROC, Longint(FOldProc));
  FreeObjectInstance(FNewProc);
end;

procedure TFlatAnimWnd.NewAppWndProc(var Message: TMessage);
begin
  with Message do
  begin
    if Msg = WM_SYSCOMMAND then
      case WParam of
        SC_MINIMIZE:
          MinimizeWnd;
        SC_RESTORE:
          RestoreWnd;
      end;
    Result := CallWindowProc(FOldAppProc, Application.Handle, Msg, WParam, lParam);
  end;
end;

procedure TFlatAnimWnd.NewWndProc(var Message: TMessage);
begin
  with Message do
  begin
    if (Msg = WM_SYSCOMMAND) and (WParam = SC_MINIMIZE) then
    begin
      if Application.MainForm = FOwner then
        MinimizeWnd
      else
        PostMessage(Application.Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    end
    else
    begin
      if (Msg = WM_WINDOWPOSCHANGING) and (PWindowPos(lParam)^.flags = (SWP_NOSIZE or SWP_NOMOVE)) then
      begin
        if IsIconic(Application.Handle) then
          PostMessage(Application.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
      end
    end;
    Result := CallWindowProc(FOldProc, (FOwner as TForm).Handle, Msg, WParam, lParam);
  end;
end;

procedure TFlatAnimWnd.MinimizeWnd;
var
  Rect: TRect;
begin
  with Application do
  begin
    if not(IsWindowEnabled(Handle)) then
      EnableWindow(Handle, True);
    GetWindowRect((FOwner as TForm).Handle, Rect);
    SetForegroundWindow(Handle);
    SetWindowPos(Handle, 0, Rect.Left, Rect.Top, Rect.Right - Rect.Left, 0, SWP_NOZORDER);
    DefWindowProc(Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
    ShowWindow(Handle, SW_MINIMIZE);
  end;
  if Assigned(FOnMinimize) then
    FOnMinimize(Application);
end;

procedure TFlatAnimWnd.RestoreWnd;
var
  MainFormPlacement: TWindowPlacement;
  AppWndPlacement: TWindowPlacement;
begin
  with Application do
  begin
    MainFormPlacement.length := SizeOf(TWindowPlacement);
    MainFormPlacement.flags := 0;
    GetWindowPlacement(MainForm.Handle, @MainFormPlacement);
    AppWndPlacement.length := SizeOf(TWindowPlacement);
    AppWndPlacement.flags := 0;
    GetWindowPlacement(Handle, @AppWndPlacement);
    AppWndPlacement.rcNormalPosition := MainFormPlacement.rcNormalPosition;
    AppWndPlacement.rcNormalPosition.Bottom := AppWndPlacement.rcNormalPosition.Top;
    SetWindowPlacement(Handle, @AppWndPlacement);
    SetForegroundWindow(Handle);
    DefWindowProc(Application.Handle, WM_SYSCOMMAND, SC_RESTORE, 0);
    ShowWindow(Handle, SW_RESTORE);
    SetWindowPos(Handle, 0, 0, 0, 0, 0, SWP_NOZORDER);
    if not(MainForm.Visible) then
    begin
      ShowWindow(MainForm.Handle, SW_RESTORE);
      MainForm.Visible := True;
    end;
  end;
  if Assigned(FOnRestore) then
    FOnRestore(Application);
end;

procedure TFlatAnimWnd.Minimize;
begin
  SendMessage((FOwner as TForm).Handle, WM_SYSCOMMAND, SC_MINIMIZE, 0);
end;

initialization

OwnerList := TList.Create;

finalization

OwnerList.Free;

end.
