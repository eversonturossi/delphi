object DataModuleCadastro: TDataModuleCadastro
  OldCreateOrder = False
  Height = 386
  Width = 700
  object cdClifor: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspClifor'
    RemoteServer = DataModuleConexao.DSProviderCadastro
    Left = 40
    Top = 80
  end
end
