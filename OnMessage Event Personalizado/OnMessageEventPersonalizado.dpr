program OnMessageEventPersonalizado;

uses
  Forms,
  UFormPrincipal in 'UFormPrincipal.pas' {FormPrincipal},
  uMyEvent in 'uMyEvent.pas',
  uFormBase in 'uFormBase.pas' {FormBase},
  uFormTeste3 in 'uFormTeste3.pas' {FormTeste3},
  uFormTeste2 in 'uFormTeste2.pas' {FormTeste2},
  uFormTeste1 in 'uFormTeste1.pas' {FormTeste1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
