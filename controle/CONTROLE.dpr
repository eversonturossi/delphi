program CONTROLE;

uses
  Forms,
  ufrmCONTROLE in 'ufrmCONTROLE.pas' {frPrincipal},
  ufrmCliente in 'ufrmCliente.pas' {frCliente},
  ufrmLOGIN in 'ufrmLOGIN.pas' {frLOGIN},
  UFuncoes in 'UFuncoes.pas',
  uObjCliente in 'uObjCliente.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TfrPrincipal, frPrincipal);
  Application.Run;
end.
