object DataModule2: TDataModule2
  OldCreateOrder = False
  Height = 386
  Width = 700
  object DSProviderCadastro: TDSProviderConnection
    ServerClassName = 'TrdmCadastro'
    Connected = True
    SQLConnection = DataModuleConexao.Conexao
    Left = 40
    Top = 16
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DataSetProvider1'
    RemoteServer = DSProviderCadastro
    Left = 40
    Top = 80
  end
end
