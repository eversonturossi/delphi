unit Unit1;

{
  https://stackoverflow.com/questions/923350/delphi-prompt-for-uac-elevation-when-needed
  https://pastebin.com/w4X4pHpC
}
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure StartWait;
    procedure EndWait;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  RunElevatedSupport;
{$R *.dfm}

const
  ArgInstallUpdate = '/install_update';
  ArgRegisterExtension = '/register_global_file_associations';

procedure TForm1.FormCreate(Sender: TObject);
begin
  Label1.Caption := Format('IsAdministrator: %s', [BoolToStr(IsAdministrator, True)]);
  Label2.Caption := Format('IsAdministratorAccount: %s', [BoolToStr(IsAdministratorAccount, True)]);
  Label3.Caption := Format('IsUACEnabled: %s', [BoolToStr(IsUACEnabled, True)]);
  Label4.Caption := Format('IsElevated: %s', [BoolToStr(IsElevated, True)]);

  Button1.Caption := 'Install updates';
  SetButtonElevated(Button1.Handle);
  Button2.Caption := 'Register file associations for all users';
  SetButtonElevated(Button2.Handle);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  StartWait;
  try
    SetLastError(RunElevated(ArgInstallUpdate, Handle, Application.ProcessMessages));
    if GetLastError <> ERROR_SUCCESS then
      RaiseLastOSError;
  finally
    EndWait;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  StartWait;
  try
    SetLastError(RunElevated(ArgRegisterExtension, Handle, Application.ProcessMessages));
    if GetLastError <> ERROR_SUCCESS then
      RaiseLastOSError;
  finally
    EndWait;
  end;
end;

function DoElevatedTask(const AParameters: String): Cardinal;

  procedure InstallUpdate;
  var
    Msg: String;
  begin
    Msg := 'Hello from InstallUpdate!' + sLineBreak + sLineBreak + 'This function is running elevated under full administrator rights.' + sLineBreak +
      'This means that you have write-access to Program Files folder and you''re able to overwrite files (e.g. install updates).' + sLineBreak + 'However, note that your executable is still running.' + sLineBreak + sLineBreak + 'IsAdministrator: ' +
      BoolToStr(IsAdministrator, True) + sLineBreak + 'IsAdministratorAccount: ' + BoolToStr(IsAdministratorAccount, True) + sLineBreak + 'IsUACEnabled: ' + BoolToStr(IsUACEnabled, True) + sLineBreak + 'IsElevated: ' + BoolToStr(IsElevated, True);
    MessageBox(0, PChar(Msg), 'Hello from InstallUpdate!', MB_OK or MB_ICONINFORMATION);
  end;

  procedure RegisterExtension;
  var
    Msg: String;
  begin
    Msg := 'Hello from RegisterExtension!' + sLineBreak + sLineBreak + 'This function is running elevated under full administrator rights.' + sLineBreak +
      'This means that you have write-access to HKEY_LOCAL_MACHINE key and you''re able to write keys and values (e.g. register file extensions globally/for all users).' + sLineBreak +
      'However, note that this is usually not a good idea. It is better to register your file extensions under HKEY_CURRENT_USER\Software\Classes.' + sLineBreak + sLineBreak + 'IsAdministrator: ' + BoolToStr(IsAdministrator, True)
      + sLineBreak + 'IsAdministratorAccount: ' + BoolToStr(IsAdministratorAccount, True) + sLineBreak + 'IsUACEnabled: ' + BoolToStr(IsUACEnabled, True) + sLineBreak + 'IsElevated: ' + BoolToStr(IsElevated, True);
    MessageBox(0, PChar(Msg), 'Hello from RegisterExtension!', MB_OK or MB_ICONINFORMATION);
  end;

begin
  Result := ERROR_SUCCESS;
  if AParameters = ArgInstallUpdate then
    InstallUpdate
  else
    if AParameters = ArgRegisterExtension then
      RegisterExtension
    else
      Result := ERROR_GEN_FAILURE;
end;

procedure TForm1.StartWait;
begin
  Cursor := crHourglass;
  Screen.Cursor := crHourglass;
  Button1.Enabled := False;
  Button2.Enabled := False;
  Application.ProcessMessages;
end;

procedure TForm1.EndWait;
begin
  Cursor := crDefault;
  Screen.Cursor := crDefault;
  Button1.Enabled := True;
  Button2.Enabled := True;
  Application.ProcessMessages;
end;

initialization

OnElevateProc := DoElevatedTask;
CheckForElevatedTask;

end.
