unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, ExtCtrls;

type
  TForm2 = class(TForm)
    EditHost: TEdit;
    EditUsuario: TEdit;
    EditSenha: TEdit;
    Label1: TLabel;
    Usuario: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    EditPorta: TEdit;
    ButtonConectar: TButton;
    ButtonNoop: TButton;
    ListBox1: TListBox;
    IdFTP1: TIdFTP;
    LabelTempo: TLabel;
    ButtonDesconectar: TButton;
    TimerTempo: TTimer;
    ButtonListar: TButton;
    procedure TimerTempoTimer(Sender: TObject);
    procedure IdFTP1Connected(Sender: TObject);
    procedure IdFTP1Disconnected(Sender: TObject);
    procedure IdFTP1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure ButtonConectarClick(Sender: TObject);
    procedure ButtonDesconectarClick(Sender: TObject);
    procedure ButtonNoopClick(Sender: TObject);
    procedure IdFTP1BannerWarning(ASender: TObject; const AMsg: string);
    procedure IdFTP1BannerBeforeLogin(ASender: TObject; const AMsg: string);
    procedure IdFTP1BannerAfterLogin(ASender: TObject; const AMsg: string);
    procedure ButtonListarClick(Sender: TObject);
  private
    fTempoInicial: Tdatetime;
    procedure Log(AMensagem: string);
  public
    property TempoInicial: Tdatetime read fTempoInicial write fTempoInicial;
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Log(AMensagem: string);
begin
  ListBox1.Items.Add(FormatDateTime('tt', Now) + ' - ' + AMensagem);
end;

procedure TForm2.ButtonConectarClick(Sender: TObject);
begin
  try
    IdFTP1.Host := EditHost.Text;
    IdFTP1.Port := StrToIntDef(EditPorta.Text, 21);
    IdFTP1.Username := EditUsuario.Text;
    IdFTP1.Password := EditSenha.Text;

    IdFTP1.Connect;
  except
    on E: Exception do
      Log('ERRO: ' + E.Message);
  end;
end;

procedure TForm2.ButtonDesconectarClick(Sender: TObject);
begin
  try
    IdFTP1.Disconnect;
    IdFTP1.IOHandler.InputBuffer.clear;
  except
    on E: Exception do
    begin
      IdFTP1.IOHandler.InputBuffer.clear;
      Log('ERRO: ' + E.Message);
    end;
  end;
end;

procedure TForm2.ButtonListarClick(Sender: TObject);
begin
  try
    IdFTP1.List;
  except
    on E: Exception do
      Log('ERRO: ' + E.Message);
  end;
end;

procedure TForm2.ButtonNoopClick(Sender: TObject);
begin
  try
    IdFTP1.Noop;
  except
    on E: Exception do
      Log('ERRO: ' + E.Message);
  end;
end;

procedure TForm2.IdFTP1BannerAfterLogin(ASender: TObject; const AMsg: string);
begin
  Log('BANNER AFTER LOGIN: ' + AMsg);
end;

procedure TForm2.IdFTP1BannerBeforeLogin(ASender: TObject; const AMsg: string);
begin
  Log('BANNER BEFORE LOGIN: ' + AMsg);
end;

procedure TForm2.IdFTP1BannerWarning(ASender: TObject; const AMsg: string);
begin
  Log('BANNER WARNING: ' + AMsg);
end;

procedure TForm2.IdFTP1Connected(Sender: TObject);
begin
  Log('CONECTADO');
  TempoInicial := Now;
  TimerTempo.Enabled := true;
end;

procedure TForm2.IdFTP1Disconnected(Sender: TObject);
begin
  Log('DESCONECTADO');
  TimerTempo.Enabled := False;
end;

procedure TForm2.IdFTP1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  Log(AStatusText);
end;

procedure TForm2.TimerTempoTimer(Sender: TObject);
begin
  LabelTempo.Caption := FormatDateTime('hh:nn:ss', Now - TempoInicial);
end;

end.
