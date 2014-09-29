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
  object ADIBBackup1: TADIBBackup
    OnError = ADIBBackup1Error
    BeforeExecute = ADIBBackup1BeforeExecute
    AfterExecute = ADIBBackup1AfterExecute
    DriverLink = ADPhysIBDriverLink1
    OnProgress = ADIBBackup1Progress
    Left = 72
    Top = 144
  end
  object OpenDialog1: TOpenDialog
    Left = 320
    Top = 176
  end
  object ADPhysIBDriverLink1: TADPhysIBDriverLink
    Left = 176
    Top = 144
  end
end
