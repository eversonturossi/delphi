object DataModuleConexao: TDataModuleConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 328
  Width = 604
  object ConexaoFirebird: TSQLConnection
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'Database=C:\Program Files\Top System\ERP\Dados\vida_e_cia.FDB')
    VendorLib = 'fbclient.dll'
    Connected = True
    Left = 64
    Top = 40
  end
end
