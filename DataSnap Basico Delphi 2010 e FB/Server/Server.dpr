program Server;

uses
  Forms,
  UFormServer in 'UFormServer.pas' { FormServer } ,
  ServerMethodsUnit1 in 'ServerMethodsUnit1.pas' { ServerMethods1: TDSServerModule } ,
  UDatasnapContainer in 'UDatasnapContainer.pas' { DatasnapContainer: TDataModule } ,
  URdmCadastro in 'URdmCadastro.pas' { RdmCadastro: TDSServerModule } ,
  UDataModuleConexao in 'UDataModuleConexao.pas' { DataModuleConexao: TDataModule } ;
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.CreateForm(TFormServer, FormServer);
  Application.Run;

end.
