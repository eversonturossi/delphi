program Client;

uses
  Forms,
  UClient in 'UClient.pas' {Form1},
  Hashes in 'Hashes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
