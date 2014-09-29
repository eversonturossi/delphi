program VerificacaoArquivosFonteDelphi;

uses
  Forms,
  UFormPrincipal in 'UFormPrincipal.pas' {FormPrincipal},
  UFormMetodos in 'UFormMetodos.pas' {FormMetodos};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
