object DataModuleConexao: TDataModuleConexao
  OldCreateOrder = False
  Height = 356
  Width = 595
  object Conexao: TSQLConnection
    ConnectionName = 'DataSnapCONNECTION'
    DriverName = 'DataSnap'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=DataSnap'
      'Port=213')
    Left = 88
    Top = 24
  end
end
