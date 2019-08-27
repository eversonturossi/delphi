program CertificadoStringACBr;

uses
  Vcl.Forms,
  Unit7 in 'Unit7.pas' {Form7},
  UCertificadoPFX in 'UCertificadoPFX.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
