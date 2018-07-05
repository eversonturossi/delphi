program TodasCombinacoesLotoFacil;

uses
  Forms,
  UTodasCombinacoesLotoFacil in 'UTodasCombinacoesLotoFacil.pas' {Form1},
  UCombinacao in 'UCombinacao.pas',
  USorteio in 'USorteio.pas',
  UAposta in 'UAposta.pas',
  UNumeros in 'UNumeros.pas',
  UNumerosOcorrencias in 'UNumerosOcorrencias.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
