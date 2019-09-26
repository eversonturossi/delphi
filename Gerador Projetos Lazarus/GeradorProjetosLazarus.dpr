program GeradorProjetosLazarus;

uses
  Vcl.Forms,
  UPrincipal in 'UPrincipal.pas' {Form7},
  UGUID in 'UGUID.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
