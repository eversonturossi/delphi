object DSServerModuleMovimento: TDSServerModuleMovimento
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 452
  Width = 672
  object SQLFinanceiro: TSQLQuery
    MaxBlobSize = 1
    Params = <>
    SQL.Strings = (
      'select * from financeiro')
    SQLConnection = DataModuleConexao.ConexaoFirebird
    Left = 64
    Top = 40
  end
  object dspFinanceiro: TDataSetProvider
    DataSet = SQLFinanceiro
    Left = 160
    Top = 40
  end
end
