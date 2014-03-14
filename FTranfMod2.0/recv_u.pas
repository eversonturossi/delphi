// Recebimento de Arquivo usando TServerSocket, recebendo pacotes independentes
// Desenvolvido por Rafael Redü Eslabão (rafael.eslabao@gmail.com)

unit recv_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, ScktComp, Gauges, StrUtils;

type
  TArquivoRecebe = record
    Nome: string;
    Tamanho: Int64;
    Recebido: Int64;
    Stream: TFileStream;
  end;

  TForm1 = class(TForm)
    BarraProgresso: TGauge;
    Cancelardownwload1: TMenuItem;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    SSocketStream: TServerSocket;
    SSocketText: TServerSocket;
    procedure FormCreate(Sender: TObject);
    procedure SSocketStreamClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure SSocketTextClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure SSocketTextListen(Sender: TObject; Socket: TCustomWinSocket);
  private
    Arquivo: TArquivoRecebe;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.SSocketTextClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  Buffer, CMD, TamanhoStr: string;
  Posicao1, Posicao2, LengthBuffer: Int64;
begin
  Buffer := Socket.ReceiveText;
  Posicao1 := Pos(#32, Buffer);
  Posicao2 := PosEx(#32, Buffer, Posicao1 + 1);
  LengthBuffer := Length(Buffer);

  CMD := Copy(Buffer, 1, Posicao1 - 1);
  if CMD = 'FILE' then
  begin
    Arquivo.Nome := Copy(Buffer, Posicao1 + 1, Posicao2 - Posicao1 - 1);
    TamanhoStr := Copy(Buffer, Posicao2 + 1, LengthBuffer - Posicao2);
    Arquivo.Tamanho := StrToInt64(TamanhoStr);
    Self.Caption := 'Recebendo ' + Arquivo.Nome + ' Tamanho ' + IntToStr(Arquivo.Tamanho);
    // ---------    BarraProgresso.MaxValue := Arquivo.Tamanho;
    Arquivo.Recebido := 0;
  end;
  if (Arquivo.Tamanho > 0) then
    Arquivo.Stream := TFileStream.Create(Arquivo.Nome, fmCreate);
end;

procedure TForm1.SSocketTextListen(Sender: TObject; Socket: TCustomWinSocket);
begin

  //

end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  SSocketStream.Port := 6660;
  SSocketText.Port := 6661;
  SSocketStream.Open;
  SSocketText.Open;
end;

procedure TForm1.SSocketStreamClientRead(Sender: TObject; Socket: TCustomWinSocket);
var
  Buffer: Pointer;
  Pacote: Int64;
begin
  if (Arquivo.Nome <> EmptyStr) and (Arquivo.Tamanho > 0) then
  begin
    Pacote := Socket.ReceiveLength;
    if Arquivo.Recebido < Arquivo.Tamanho then
    begin
      GetMem(Buffer, Pacote);
      Socket.ReceiveBuf(Buffer^, Pacote);
      Arquivo.Stream.Seek(Arquivo.Recebido, soFromBeginning);
      Arquivo.Stream.Write(Buffer^, Pacote);
      Inc(Arquivo.Recebido, Pacote);
      BarraProgresso.Progress := Arquivo.Recebido;
      Dispose(Buffer);
      Self.Caption := 'Recebendo ' + Arquivo.Nome + ' ' + IntToStr(Arquivo.Tamanho) + '/' + IntToStr(Arquivo.Recebido);
    end;
    if Arquivo.Recebido = Arquivo.Tamanho then
    begin
      Self.Caption := 'Concluido ' + Arquivo.Nome;
      Arquivo.Stream.Free;
    end;
  end;
end;

end.
