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
    Left = 176
    Top = 40
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 176
    Top = 112
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 184
    Top = 176
  end
end
