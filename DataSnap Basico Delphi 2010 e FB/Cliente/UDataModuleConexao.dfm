object DataModuleConexao: TDataModuleConexao
  OldCreateOrder = False
  Height = 356
  Width = 595
  object Conexao: TSQLConnection
    ConnectionName = 'DataSnapCONNECTION'
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=DataSnap'
      'Port=213')
    Connected = True
    Left = 88
    Top = 24
  end
  object DSProviderCadastro: TDSProviderConnection
    ServerClassName = 'TDSServerModuleCadastro'
    Connected = True
    SQLConnection = Conexao
    Left = 216
    Top = 104
  end
  object DSProviderMovimento: TDSProviderConnection
    ServerClassName = 'TDSServerModuleMovimento'
    Connected = True
    SQLConnection = Conexao
    Left = 80
    Top = 104
  end
  object DSProviderRelatorio: TDSProviderConnection
    ServerClassName = 'TDSServerModuleRelatorio'
    Connected = True
    SQLConnection = Conexao
    Left = 352
    Top = 104
  end
end
