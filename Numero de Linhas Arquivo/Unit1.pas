unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button2Click(Sender: TObject);
  private
    fNomeArquivo: String;
    property NomeArquivo: String read fNomeArquivo write fNomeArquivo;
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button2Click(Sender: TObject);
var
  ArquivoTexto: TextFile;
  Text: String;
  TempoInicial, TempoFinal, TempoTotal: TTime;
  Linhas: Double;
begin
  Label2.Caption := '';
  NomeArquivo := '';
  if OpenDialog1.Execute then
    NomeArquivo := OpenDialog1.FileName;

  if not FileExists(NomeArquivo) then
    raise Exception.Create('arquivo nao encontrado');

  Linhas := 0;
  TempoInicial := Now;
  AssignFile(ArquivoTexto, NomeArquivo);
  try
    Reset(ArquivoTexto);
    while not Eof(ArquivoTexto) do
    begin
      ReadLn(ArquivoTexto, Text);
      Linhas := Linhas + 1;
    end;
    TempoFinal := Now;
    TempoTotal := TempoFinal - TempoInicial;
    ShowMessage(TimeToStr(TempoTotal));

    Label2.Caption := FormatFloat('#,###', Linhas);
  finally
    CloseFile(ArquivoTexto);
  end;
end;

end.
