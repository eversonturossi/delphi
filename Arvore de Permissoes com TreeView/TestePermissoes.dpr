program TestePermissoes;

uses
  Forms,
  UTestePermissoes in 'UTestePermissoes.pas' {Form1},
  uPermissoes in 'uPermissoes.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
