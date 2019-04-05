program ListarClassesRegistradas;

uses
  Vcl.Forms,
  Unit7 in 'Unit7.pas' {Form7},
  ClassesEnum in 'ClassesEnum.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
