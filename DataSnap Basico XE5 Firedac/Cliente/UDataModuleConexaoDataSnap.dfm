object DataModuleConexaoDataSap: TDataModuleConexaoDataSap
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 563
  Width = 733
  object FDConexaoDataSnap: TFDConnection
    Params.Strings = (
      'Port=214'
      'DriverID=DataSnap')
    Connected = True
    LoginPrompt = False
    Left = 64
    Top = 32
  end
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
    Connected = True
    Left = 248
    Top = 32
  end
  object DSProviderConfiguracao: TDSProviderConnection
    ServerClassName = 'TDSServerModuleConfiguracao'
    Connected = True
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
      FixedChar = True
      Size = 31
    end
  end
  object FDTable1: TFDTable
    Connection = FDConexaoDataSnap
    SchemaName = 'TDSServerModuleConfiguracao'
    Left = 64
    Top = 152
  end
  object FDPhysDataSnapDriverLink1: TFDPhysDataSnapDriverLink
    Left = 65
    Top = 96
  end
end
