object DataModuleConexaoBanco: TDataModuleConexaoBanco
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 439
  Width = 595
  object FDConexaoBanco: TFDConnection
    Params.Strings = (
      
        'Database=D:\github_delphi\DataSnap Basico XE5 Firedac\Banco\EMPL' +
        'OYEE.FDB'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=FB')
    LoginPrompt = False
    Left = 64
    Top = 32
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 320
    Top = 32
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 328
    Top = 112
  end
end
