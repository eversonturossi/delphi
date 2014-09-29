object DataModuleConexaoDataSap: TDataModuleConexaoDataSap
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
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
      'Filters={}')
    Left = 248
    Top = 32
  end
  object DSProviderConfiguracao: TDSProviderConnection
    ServerClassName = 'TDSServerModuleConfiguracao'
    SQLConnection = ConexaoDataSnap
    Left = 248
    Top = 88
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspTabelas'
    RemoteServer = DSProviderConfiguracao
    Left = 248
    Top = 144
    object ClientDataSet1NOME_TABELA: TWideStringField
      FieldName = 'NOME_TABELA'
      Origin = 'RDB$RELATION_NAME'
      FixedChar = True
      Size = 31
    end
  end
  object FDConexaoDataSnap: TFDConnection
    Params.Strings = (
      'Port=214'
      'DriverID=DS')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 40
  end
  object FDPhysDSDriverLink1: TFDPhysDSDriverLink
    Left = 64
    Top = 104
  end
end
