unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    DataInicio: TDateTimePicker;
    Button1: TButton;
    ProgressBar1: TProgressBar;
    EditNumeroArquivos: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  Arquivo: TextFile;
  NomeArquivo, DiretorioArquivos: String;
  DataArquivo, fHoraEvento: TDateTime;
  I, QuantidadeARquivos: Integer;
begin
  TButton(Sender).Enabled := false;
  try
    DiretorioArquivos := ExcludeTrailingBackslash(ExtractFilePath(ParamStr(0))) + '\Logs\';
    if not(DirectoryExists(DiretorioArquivos)) then
      ForceDirectories(DiretorioArquivos);

    QuantidadeARquivos := StrToInt(EditNumeroArquivos.Text);
    DataArquivo := DataInicio.DateTime;

    ProgressBar1.Position := 0;
    ProgressBar1.Max := QuantidadeARquivos;

    for I := 0 to QuantidadeARquivos - 1 do
    begin
      fHoraEvento := Now;
      NomeArquivo := 'Log_' + FormatDateTime('yyyy-mm-dd', DataArquivo + I) + '.log';
      try
        AssignFile(Arquivo, DiretorioArquivos + NomeArquivo);
        Rewrite(Arquivo);
        WriteLn(Arquivo, FormatDateTime('tt', fHoraEvento) + ' -> ');
      finally
        CloseFile(Arquivo);
      end;
      ProgressBar1.Position := I;
    end;
  finally
    TButton(Sender).Enabled := true;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DataInicio.DateTime := Now;
  EditNumeroArquivos.Text := '10000';
end;

end.
