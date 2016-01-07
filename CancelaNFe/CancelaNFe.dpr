program CancelaNFe;

uses
  Forms,
  UCancelaNFe in 'UCancelaNFe.pas' {Form2},
  UMensagem in 'UMensagem.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
