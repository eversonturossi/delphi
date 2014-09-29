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
    Left = 144
    Top = 11
    Width = 409
    Height = 13
    AutoSize = False
    Caption = 'Nome arquivo'
  end
  object Label2: TLabel
    Left = 752
    Top = 11
    Width = 36
    Height = 13
    Anchors = [akTop, akRight]
    Caption = 'Tempo:'
  end
  object LabelTempoDecorrido: TLabel
    Left = 793
    Top = 11
    Width = 48
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '00:00:00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 98
    Top = 11
    Width = 41
    Height = 13
    Caption = 'Arquivo:'
  end
  object ButtonBackup: TButton
    Left = 8
    Top = 6
    Width = 75
    Height = 25
    Caption = 'Backup'
    TabOrder = 0
    OnClick = ButtonBackupClick
  end
  object MemoLog: TMemo
    Left = 8
    Top = 37
    Width = 833
    Height = 485
    TabStop = False
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'MemoLog')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 1
  end
  object CheckBoxVerbose: TCheckBox
    Left = 672
    Top = 8
    Width = 65
    Height = 17
    Anchors = [akTop, akRight]
    Caption = 'Verbose'
    TabOrder = 2
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
    Left = 264
    Top = 160
  end
  object DBLink: TADPhysIBDriverLink
    Left = 176
    Top = 144
  end
end
