program FirebirdMetaData;

uses
  Vcl.Forms,
  Unit7 in 'Unit7.pas' {FormPrincipal};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormPrincipal, FormPrincipal);
  Application.Run;
end.
