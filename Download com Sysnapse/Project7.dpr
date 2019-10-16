program Project7;

uses
  Vcl.Forms,
  Unit7 in 'Unit7.pas' {Form7},
  uhttpdownloader in 'uhttpdownloader.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm7, Form7);
  Application.Run;
end.
