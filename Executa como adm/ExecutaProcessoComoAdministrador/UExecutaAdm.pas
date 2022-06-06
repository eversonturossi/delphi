unit UExecutaAdm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    ButtonStart: TButton;
    ButtonStop: TButton;
    Label1: TLabel;
    Button3: TButton;
    Button4: TButton;
    Label2: TLabel;
    edtServiceName: TEdit;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  ShellApi;
{$R *.dfm}

function RunAsAdmin(hWnd: hWnd; filename: string; Parameters: string): Boolean;
{ See Step 3: Redesign for UAC Compatibility (UAC)
  http://msdn.microsoft.com/en-us/library/bb756922.aspx }
var
  sei: TShellExecuteInfo;
begin
  ZeroMemory(@sei, SizeOf(sei));
  sei.cbSize := SizeOf(TShellExecuteInfo);
  sei.Wnd := hWnd;
  sei.fMask := SEE_MASK_FLAG_DDEWAIT or SEE_MASK_FLAG_NO_UI;
  sei.lpVerb := PChar('runas');
  sei.lpFile := PChar(filename); // PAnsiChar;
  if Parameters <> '' then
    sei.lpParameters := PChar(Parameters); // PAnsiChar;
  sei.nShow := SW_SHOWNORMAL; // Integer;
  Result := ShellExecuteEx(@sei);
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  { http://edn.embarcadero.com/article/33942 }
  { http://zewaren.net/site/node/10 }
  RunAsAdmin(Application.Handle, 'cmd.exe', '');
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'cmd.exe', '', '', SW_SHOWNORMAL);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'sc', 'start ' + edtServiceName.Name, '', SW_SHOWNORMAL);
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ShellExecute(Application.Handle, 'open', 'sc', 'stop ' + edtServiceName.Name, '', SW_SHOWNORMAL);
end;

procedure TForm1.ButtonStartClick(Sender: TObject);
begin
  RunAsAdmin(Application.Handle, 'sc', 'start ' + edtServiceName.Name);
end;

procedure TForm1.ButtonStopClick(Sender: TObject);
begin
  RunAsAdmin(Application.Handle, 'sc', 'stop ' + edtServiceName.Name);
end;

end.
