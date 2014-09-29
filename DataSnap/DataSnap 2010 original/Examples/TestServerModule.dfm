object SimpleServerModule: TSimpleServerModule
  OldCreateOrder = False
  Height = 150
  Width = 215
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 88
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'EMPLOYEE'
    DriverName = 'BLACKFISHSQL'
    LoadParamsOnConnect = True
    LoginPrompt = False
    Params.Strings = (
      'DriverName=BLACKFISHSQL'
      'User_Name=sysdba'
      'Password=masterkey'
      'Database=c:\tmp\employee'
      'HostName=localhost'
      'UserName=sysdba'
      'Port=2508')
    Left = 48
    Top = 24
  end
end
