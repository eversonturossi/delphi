unit UUpdateServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.ComCtrls;

const
  SERVER_PORT_DEFAULT = 18888;
  VERSION_DEFAULT = 0;

type
  TForm1 = class(TForm)
    ServerSocket1: TServerSocket;
    Panel1: TPanel;
    ListBox1: TListBox;
    StatusBar1: TStatusBar;
    Button1: TButton;
    procedure ServerSocket1Listen(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure ServerSocket1ClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
  private
    FVersion: Integer;
    FServerPort: Integer;
  public
    Constructor Create(AOwner: TComponent); override;
    Destructor Destroy; override;

    property ServerPort: Integer read FServerPort write FServerPort;
    property Version: Integer read FVersion write FVersion;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}
{ TForm1 }

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited;
  ServerPort := SERVER_PORT_DEFAULT;
  Version := VERSION_DEFAULT;
  ServerSocket1.Port := ServerPort;
  ServerSocket1.Open;
end;

destructor TForm1.Destroy;
begin

  inherited;
end;

procedure TForm1.ServerSocket1ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  ListBox1.Items.Add('Cliente Conectado');
end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  ListBox1.Items.Add('Cliente desconectado');
end;

procedure TForm1.ServerSocket1ClientError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  ListBox1.Items.Add('erro');
end;

procedure TForm1.ServerSocket1ClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  RecText: String;
begin
  RecText := Socket.ReceiveText;
  ListBox1.Items.Add(RecText);
  if (Pos('#VERSION#', RecText) > 0) then
  begin
    Socket.SendText('#VERSION#' + IntToStr(Version));
  end;
end;

procedure TForm1.ServerSocket1Listen(Sender: TObject; Socket: TCustomWinSocket);
begin
  ListBox1.Items.Add('Listen');
end;

end.
