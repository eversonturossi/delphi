object DSServerModuleCadastro: TDSServerModuleCadastro
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  Height = 405
  Width = 654
  object SQLClifor: TSQLQuery
    MaxBlobSize = 1
    Params = <>
    SQL.Strings = (
      'select * from clifor')
    SQLConnection = DataModuleConexao.ConexaoFirebird
    Left = 64
    Top = 40
  end
  object dspClifor: TDataSetProvider
    DataSet = SQLClifor
    Left = 160
    Top = 40
  end
  object SQLTeste: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = DataModuleConexao.ConexaoFirebird
    Left = 64
    Top = 136
  end
  object dspTeste: TDataSetProvider
    DataSet = SQLTeste
    Left = 160
    Top = 136
  end
end
