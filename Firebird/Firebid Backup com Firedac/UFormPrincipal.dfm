object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Backup  Firebird'
  ClientHeight = 530
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    849
    530)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelArquivoBanco: TLabel
    Left = 96
    Top = 21
    Width = 25
    Height = 13
    Caption = 'Label'
  end
  object ButtonBackup: TButton
    Left = 8
    Top = 16
    Width = 75
    Height = 25
    Caption = 'Backup'
    TabOrder = 0
    OnClick = ButtonBackupClick
  end
  object MemoLog: TMemo
    Left = 8
    Top = 47
    Width = 833
    Height = 475
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'MemoLog')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object DBBackup: TADIBBackup
    OnError = DBBackupError
    BeforeExecute = DBBackupBeforeExecute
    AfterExecute = DBBackupAfterExecute
    DriverLink = DBLink
    OnProgress = DBBackupProgress
    Left = 72
    Top = 144
  end
  object OpenDialogDB: TOpenDialog
    Left = 256
    Top = 136
  end
  object DBLink: TADPhysIBDriverLink
    Left = 176
    Top = 144
  end
end
