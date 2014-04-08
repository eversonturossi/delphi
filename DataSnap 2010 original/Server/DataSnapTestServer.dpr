{ ******************************************************* }
{ }
{ CodeGear Delphi Visual Component Library }
{ }
{ Copyright (c) 1995-2008 CodeGear }
{ }
{ ******************************************************* }

program DataSnapTestServer;

uses
{$IF DEFINED(DEBUG)}
  // FastMM4,
{$IFEND}
  Forms,
  SysUtils,
  ServerContainerForm in 'ServerContainerForm.pas' { Form8 } ,
  MethodsServerModule in 'MethodsServerModule.pas' { ServerModule1: TDataModule } ,
  ParametersServerModule in 'ParametersServerModule.pas' { ParametersServerModule1: TDSServerModule } ,
  ProviderServerModule in 'ProviderServerModule.pas' { DSServerModule2: TDSServerModule } ,
  DataSnapTestData in '..\examples\DataSnapTestData.pas';
{$R *.res}

begin
  try
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TForm8, Form8);
    Application.CreateForm(TServerModule1, ServerModule1);
    Application.CreateForm(TParametersServerModule1, ParametersServerModule1);
    Application.CreateForm(TDSServerModule2, DSServerModule2);
    Application.Run;
    Form8.DSServer1.Stop;
  except
    on Ex: Exception do
      Application.ShowException(Ex);
  end;

end.
