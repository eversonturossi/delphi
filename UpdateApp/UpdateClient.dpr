program UpdateClient;

uses
  Forms,
  UUpdateClient in 'UUpdateClient.pas' {Form1},
  USharedConst in 'USharedConst.pas',
  USharedLibrary in 'USharedLibrary.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
