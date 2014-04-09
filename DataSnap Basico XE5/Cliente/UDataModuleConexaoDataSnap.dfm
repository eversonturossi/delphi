object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 563
  Width = 733
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
      
        'Filters={"PC1":{"Key":"wbu8CqgAiJEmcrIc"},"RSA":{"UseGlobalKey":' +
        '"true","KeyLength":"1024","KeyExponent":"3"},"ZLibCompression":{' +
        '"CompressMoreThan":"1024"}}')
    Left = 96
    Top = 32
  end
  object DSProviderConfiguracao: TDSProviderConnection
    ServerClassName = 'TDSServerModuleConfiguracao'
    SQLConnection = ConexaoDataSnap
    Left = 120
    Top = 112
  end
end
