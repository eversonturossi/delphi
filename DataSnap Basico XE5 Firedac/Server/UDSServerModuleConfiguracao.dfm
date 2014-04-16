object DSServerModuleConfiguracao: TDSServerModuleConfiguracao
  OldCreateOrder = False
  Height = 464
  Width = 661
  object FDQuery1: TFDQuery
    Connection = DataModuleConexaoBanco.FDConexaoBanco
    SQL.Strings = (
      'SELECT RDB$RELATION_NAME as nome_tabela'
      ' FROM RDB$RELATIONS '
      'WHERE (RDB$VIEW_BLR IS NULL) '
      'AND ((RDB$SYSTEM_FLAG = 0) OR (RDB$SYSTEM_FLAG IS NULL)) ')
    Left = 48
    Top = 24
  end
  object FDPhysDataSnapDriverLink1: TFDPhysDataSnapDriverLink
    Left = 224
    Top = 40
  end
end
