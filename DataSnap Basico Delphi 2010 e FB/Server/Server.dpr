program Server;

uses
  Forms,
  UFormServer in 'UFormServer.pas' { FormServer },
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' { ServerMethods1: TDSServerModule},
  UDatasnapContainer in 'UDatasnapContainer.pas' { DatasnapContainer: TDataModule},
  UDSServerModuleCadastro in 'UDSServerModuleCadastro.pas' {DSServerModuleCadastro: TDSServerModule},
  UDataModuleConexao in 'UDataModuleConexao.pas' { DataModuleConexao: TDataModule},
  UDSServerModuleMovimento in 'UDSServerModuleMovimento.pas' {DSServerModuleMovimento: TDSServerModule},
  UDSServerModuleRelatorio in 'UDSServerModuleRelatorio.pas' {DSServerModuleRelatorio: TDSServerModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.CreateForm(TFormServer, FormServer);
  Application.Run;
end.
