object DataModuleMovimento: TDataModuleMovimento
  OldCreateOrder = False
  Height = 406
  Width = 716
  object cdFinanceiro: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspFinanceiro'
    RemoteServer = DataModuleConexao.DSProviderMovimento
    Left = 40
    Top = 32
  end
end
