object DSServerModuleConfiguracao: TDSServerModuleConfiguracao
  OldCreateOrder = False
  Height = 464
  Width = 661
  object SQLTabelasFirebird: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'SELECT RDB$RELATION_NAME as nome_tabela'
      ' FROM RDB$RELATIONS '
      'WHERE (RDB$VIEW_BLR IS NULL) '
      'AND ((RDB$SYSTEM_FLAG = 0) OR (RDB$SYSTEM_FLAG IS NULL)) ')
    SQLConnection = DataModuleConexaoBanco.ConexaoBanco
    Left = 56
    Top = 48
  end
  object dspTabelasFirebird: TDataSetProvider
    DataSet = SQLTabelasFirebird
    Left = 176
    Top = 56
  end
end
