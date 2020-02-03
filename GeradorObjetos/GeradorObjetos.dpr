program GeradorObjetos;

uses
  Vcl.Forms,
  UFormulario in 'UFormulario.pas' {Formulario},
  UCampo in 'UCampo.pas',
  UCampoList in 'UCampoList.pas',
  UOrigem in 'UOrigem.pas',
  UFonte in 'UFonte.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormulario, Formulario);
  Application.Run;
end.
