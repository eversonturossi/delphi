program Server;

uses
  Vcl.Forms,
  UFormServer in 'UFormServer.pas' {FormServer} ,
  UServerMethods in 'UServerMethods.pas' {ServerMethods: TDSServerModule} ,
  UServerContainer in 'UServerContainer.pas' {ServerContainer: TDataModule} ,
  UDataModuleConexaoBanco in 'UDataModuleConexaoBanco.pas' {DataModuleConexaoBanco: TDataModule} ,
  UDSServerModuleCadastro in 'UDSServerModuleCadastro.pas' {DSServerModuleCadastro: TDSServerModule} ,
  UDSServerModuleMovimento in 'UDSServerModuleMovimento.pas' {DSServerModuleMovimento: TDSServerModule} ,
  UDSServerModuleConfiguracao in 'UDSServerModuleConfiguracao.pas' {DSServerModuleConfiguracao: TDSServerModule} ,
  UDSServerModuleRelatorio in 'UDSServerModuleRelatorio.pas' {DSServerModuleRelatorio: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleConexaoBanco, DataModuleConexaoBanco);
  Application.CreateForm(TFormServer, FormServer);
  Application.Run;

end.
