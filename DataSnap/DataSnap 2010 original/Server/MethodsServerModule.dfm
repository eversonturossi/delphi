object ServerModule1: TServerModule1
  OldCreateOrder = False
  OnCreate = DSServerModuleCreate
  OnDestroy = DSServerModuleDestroy
  Height = 150
  Width = 215
  object SQLConnection1: TSQLConnection
    Left = 32
    Top = 24
  end
  object SQLDataSet1: TSQLDataSet
    DbxCommandType = 'Dbx.SQL'
    Params = <>
    Left = 120
    Top = 32
  end
end
