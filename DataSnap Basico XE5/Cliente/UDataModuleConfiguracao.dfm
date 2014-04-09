object DataModule1: TDataModule1
  OldCreateOrder = False
  Height = 522
  Width = 667
  object ConexaoDataSnap: TSQLConnection
    ConnectionName = 'DataSnapCONNECTION'
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverUnit=Data.DBXDataSnap'
      'CommunicationProtocol=tcp/ip'
      'DatasnapContext=datasnap/'
      
        'DriverAssemblyLoader=Borland.Data.TDBXClientDriverLoader,Borland' +
        '.Data.DbxClientDriver,Version=19.0.0.0,Culture=neutral,PublicKey' +
        'Token=91d62ebb5b0d1b1b'
      'DriverName=DataSnap'
      'HostName=localhost'
      'Port=214'
      'Filters={}'
      'DSAuthenticationUser=aaa'
      'DSProxyPassword=aaa')
    Left = 96
    Top = 32
  end
  object DSProviderConfiguracao: TDSProviderConnection
    ServerClassName = 'TDSServerModuleConfiguracao'
    SQLConnection = ConexaoDataSnap
    Left = 104
    Top = 144
  end
end
