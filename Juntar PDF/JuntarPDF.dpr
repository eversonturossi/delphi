program JuntarPDF;

uses
  Vcl.Forms,
  Unit7 in 'Unit7.pas' {Form7},
  UJuntaPDF in 'UJuntaPDF.pas',
  UJuntaPDF.SelecionaArquivos in 'UJuntaPDF.SelecionaArquivos.pas',
  UJuntaPDF.SalvaArquivo in 'UJuntaPDF.SalvaArquivo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
