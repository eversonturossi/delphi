unit UUpdateClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ClientSocket1: TClientSocket;
    Panel1: TPanel;
    btnConnect: TButton;
    btnDisconnect: TButton;
    edtServerHost: TEdit;
    Label1: TLabel;
    edtServerPort: TEdit;
    Label2: TLabel;
    ListBox1: TListBox;
    procedure ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure btnConnectClick(Sender: TObject);
    procedure ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
  private
    FVersion: Integer;
    FServerPort: Integer;
    FServerHost: String;
    procedure UpdateButtons;
    procedure Connect();
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    property ServerHost: String read FServerHost write FServerHost;
    property ServerPort: Integer read FServerPort write FServerPort;
    property Version: Integer read FVersion write FVersion;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses USharedConst;
{ TForm1 }

procedure TForm1.UpdateButtons;
begin
  btnConnect.Enabled := ClientSocket1.Active = False;
  btnDisconnect.Enabled := ClientSocket1.Active = True;
end;

procedure TForm1.btnConnectClick(Sender: TObject);
begin
  Connect();
end;

procedure TForm1.ClientSocket1Connect(Sender: TObject; Socket: TCustomWinSocket);
begin
  UpdateButtons;
  Socket.SendText('#VERSION#');
end;

procedure TForm1.ClientSocket1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  UpdateButtons;
end;

procedure TForm1.ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  UpdateButtons;
end;

procedure TForm1.ClientSocket1Read(Sender: TObject; Socket: TCustomWinSocket);
var
  RecText: String;
begin
  RecText := Socket.ReceiveText;
  if (pos('#VERSION#', RecText) > 0) then
    ListBox1.Items.Add(RecText);
end;

procedure TForm1.Connect;
begin
  try
    ServerHost := edtServerHost.Text;
    ServerPort := StrToInt(edtServerPort.Text);

    ClientSocket1.Address := ServerHost;
    ClientSocket1.Host := ServerHost;
    ClientSocket1.Port := ServerPort;
    ClientSocket1.Open;
  except

  end;
end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited;
  UpdateButtons;
  ServerPort := SERVER_PORT_DEFAULT;
  Version := VERSION_DEFAULT;
end;

destructor TForm1.Destroy;
begin

  inherited;
end;

end.
