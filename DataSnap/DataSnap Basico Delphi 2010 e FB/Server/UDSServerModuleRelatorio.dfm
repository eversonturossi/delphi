object DSServerModuleRelatorio: TDSServerModuleRelatorio
  OldCreateOrder = False
  Height = 348
  Width = 667
  object SQLTeste: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DataModuleConexao.ConexaoFirebird
    Left = 72
    Top = 56
  end
  object dspTeste: TDataSetProvider
    DataSet = SQLTeste
    Left = 168
    Top = 56
  end
end
