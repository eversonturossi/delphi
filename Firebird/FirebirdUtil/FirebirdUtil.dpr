program FirebirdUtil;

uses
  Forms,
  UFormPrincipal in 'UFormPrincipal.pas' {FormPrincipal},
  UObjetoFirebird in 'UObjetoFirebird.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
