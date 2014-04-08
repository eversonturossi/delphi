object ParametersServerModule1: TParametersServerModule1
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 202
  Width = 271
  object SQLConnection1: TSQLConnection
    DriverName = 'BlackfishSQL'
    LoginPrompt = False
    Params.Strings = (
      'Create=True'
      'Database=|DataDirectory|DataSnapTest'
      'ReadOnlyDb=-1')
    Left = 32
    Top = 24
  end
  object ReturnSqlQuery: TSQLQuery
    BeforeOpen = ReturnSqlQueryBeforeOpen
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from DATASNAP_TEST_DATA')
    SQLConnection = SQLConnection1
    Left = 216
    Top = 112
  end
  object OutSqlQuery: TSQLQuery
    BeforeOpen = OutSqlQueryBeforeOpen
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from DATASNAP_TEST_DATA')
    SQLConnection = SQLConnection1
    Left = 32
    Top = 120
  end
  object VarSqlQuery: TSQLQuery
    BeforeOpen = VarSqlQueryBeforeOpen
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from DATASNAP_TEST_DATA')
    SQLConnection = SQLConnection1
    Left = 120
    Top = 120
  end
end
