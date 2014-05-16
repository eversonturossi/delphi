object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 493
  ClientWidth = 764
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    764
    493)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonOpen: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 33
    Caption = 'Open'
    TabOrder = 0
    OnClick = ButtonOpenClick
  end
  object ButtonInsert: TButton
    Left = 89
    Top = 8
    Width = 75
    Height = 33
    Caption = 'Insert'
    Enabled = False
    TabOrder = 1
    OnClick = ButtonInsertClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 47
    Width = 748
    Height = 438
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSourceLista
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ProgressBar1: TProgressBar
    Left = 392
    Top = 16
    Width = 364
    Height = 17
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 3
  end
  object EditMax: TEdit
    Left = 288
    Top = 12
    Width = 81
    Height = 21
    NumbersOnly = True
    TabOrder = 4
    Text = '1000'
  end
  object CheckBoxInserirViaSQL: TCheckBox
    Left = 170
    Top = 8
    Width = 97
    Height = 17
    Caption = 'Inserir via SQL'
    TabOrder = 5
  end
  object CheckBoxResetarDados: TCheckBox
    Left = 170
    Top = 24
    Width = 97
    Height = 17
    Caption = 'Resetar dados'
    TabOrder = 6
  end
  object ADConnection1: TADConnection
    Params.Strings = (
      'Database=banco.sqlite'
      'DriverID=SQLite')
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    LoginPrompt = False
    Left = 33
    Top = 56
  end
  object ADQueryLista: TADQuery
    CachedUpdates = True
    Connection = ADConnection1
    Left = 112
    Top = 56
  end
  object ADQueryInsert: TADQuery
    Connection = ADConnection1
    Left = 192
    Top = 56
  end
  object ADPhysSQLiteDriverLink1: TADPhysSQLiteDriverLink
    Left = 216
    Top = 408
  end
  object ADGUIxWaitCursor1: TADGUIxWaitCursor
    Left = 72
    Top = 408
  end
  object DataSourceLista: TDataSource
    DataSet = ADQueryLista
    Left = 112
    Top = 112
  end
end
