program FirebirdBackupComFiredac;

uses
  Forms,
  UFormPrincipal in 'UFormPrincipal.pas' {FormPrincipal},
  UThreadBackup in 'UThreadBackup.pas',
  UBackupFirebird in 'UBackupFirebird.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
