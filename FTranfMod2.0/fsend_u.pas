// Envio de Arquivo usando TClientSocket, enviando pacotes independentes
// Desenvolvido por Rafael Redü Eslabão (rafael.eslabao@gmail.com)

unit fsend_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Gauges, StdCtrls, ExtCtrls, ScktComp;

const
  // TAmanhoPacote = 1024;
  // TAmanhoPacote = 2048;
  TAmanhoPacote = 8192;

  TempoDeEsperaEntrePacotes = 5;

type
  TArquivoEnvia = Class(TObject)
    Nome: string;
    Enviado: Int64;
    Stream: TFileStream;
  end;

  TMainSend = class(TForm)
    btnConectar: TButton;
    btnEnviar: TButton;
    btnCancelar: TButton;
    CSocketStream: TClientSocket;
    CSocketText: TClientSocket;
    BarraProgresso: TGauge;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    LabeledEdit1: TLabeledEdit;
    OpenDialog: TOpenDialog;
    Timer1: TTimer;
    procedure btnConectarClick(Sender: TObject);
    procedure btnEnviarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure CSocketStreamConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketStreamDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketStreamError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure CSocketTextConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketTextDisconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CSocketTextError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    Arquivos: TList;
    procedure EnviaArquivo;

    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;

  end;

var
  MainSend: TMainSend;

implementation

{$R *.dfm}

procedure TMainSend.btnConectarClick(Sender: TObject);
begin
  CSocketText.Address := LabeledEdit1.Text;
  CSocketText.Host := LabeledEdit1.Text;
  CSocketText.Open;

  CSocketStream.Address := CSocketText.Address;
  CSocketStream.Host := CSocketText.Host;
  // CSocketStream.Open;
end;

procedure TMainSend.EnviaArquivo;
var
  Buffer: Pointer;
  Pacote: Int64;
  TamanhoArquivo: Int64;
begin
  if Arquivos.Count = 0 then
  begin
    CSocketStream.Close;
    Exit;
  end;
  TArquivoEnvia(Arquivos[0]).Enviado := 0;
  TArquivoEnvia(Arquivos[0]).Stream := TFileStream.Create(TArquivoEnvia(Arquivos[0]).Nome, fmOpenRead);
  BarraProgresso.MaxValue := 100;
  TamanhoArquivo := TArquivoEnvia(Arquivos[0]).Stream.Size;
  CSocketText.Socket.SendText('FILE ' + ExtractFileName(TArquivoEnvia(Arquivos[0]).Nome) + #32 + IntToStr(TamanhoArquivo));
  while (TArquivoEnvia(Arquivos[0]).Enviado < TamanhoArquivo) and (CSocketStream.Active = True) do
  begin
    if TamanhoArquivo - TArquivoEnvia(Arquivos[0]).Enviado < TAmanhoPacote then
      Pacote := TamanhoArquivo - TArquivoEnvia(Arquivos[0]).Enviado
    else
      Pacote := TAmanhoPacote;

    GetMem(Buffer, Pacote);
    TArquivoEnvia(Arquivos[0]).Stream.Seek(TArquivoEnvia(Arquivos[0]).Enviado, soFromBeginning);
    TArquivoEnvia(Arquivos[0]).Stream.Read(Buffer^, Pacote);
    while CSocketStream.Socket.SendBuf(Buffer^, Pacote) = -1 do
    begin
      Sleep(TempoDeEsperaEntrePacotes);
      Application.ProcessMessages;
    end;
    Inc(TArquivoEnvia(Arquivos[0]).Enviado, Pacote);
    BarraProgresso.Progress := Round((TArquivoEnvia(Arquivos[0]).Enviado * 100) / TamanhoArquivo);
    Dispose(Buffer);
  end;
  TArquivoEnvia(Arquivos[0]).Stream.Free;

  Arquivos.Delete(0);
  CSocketStream.Close;
end;

procedure TMainSend.btnEnviarClick(Sender: TObject);
begin
  if OpenDialog.Execute then
  begin
    Arquivos.Add(TArquivoEnvia.Create);
    TArquivoEnvia(Arquivos[Arquivos.Count - 1]).Nome := OpenDialog.FileName;
    if CSocketStream.Active = False then
      CSocketStream.Open;
  end;
end;

constructor TMainSend.Create(AOwner: TComponent);
begin
  inherited;
  Arquivos := TList.Create;
end;

procedure TMainSend.CSocketStreamConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  EnviaArquivo;
end;

procedure TMainSend.CSocketStreamDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  if Arquivos.Count > 0 then
    Timer1.Enabled := True;
end;

procedure TMainSend.btnCancelarClick(Sender: TObject);
begin
  CSocketStream.Close;
  CSocketText.Close;
end;

procedure TMainSend.CSocketTextConnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  btnConectar.Enabled := False;
  btnCancelar.Enabled := True;
  btnEnviar.Enabled := True;
end;

procedure TMainSend.CSocketTextDisconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
  btnConectar.Enabled := True;
  btnCancelar.Enabled := False;
  btnEnviar.Enabled := False;
end;

procedure TMainSend.CSocketTextError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  // ErrorCode := 0;
end;

destructor TMainSend.Destroy;
begin
  inherited;
  FreeAndNil(Arquivos);
end;

procedure TMainSend.CSocketStreamError(Sender: TObject; Socket: TCustomWinSocket; ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
  // ErrorCode := 0;
end;

procedure TMainSend.Timer1Timer(Sender: TObject);
begin
  Timer1.Enabled := False;
  CSocketStream.Open;
end;

end.
