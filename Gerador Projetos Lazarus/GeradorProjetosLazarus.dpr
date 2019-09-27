program GeradorProjetosLazarus;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {FormGerador},
  UGUID in 'UGUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormGerador, FormGerador);
  Application.Run;
end.
