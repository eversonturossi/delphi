object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 509
  ClientWidth = 749
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 749
    Height = 56
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 16
      Top = 5
      Width = 61
      Height = 13
      Caption = 'Date Inicio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 136
      Top = 5
      Width = 50
      Height = 13
      Caption = 'Data Fim'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 612
      Top = 29
      Width = 56
      Height = 13
      Caption = 'Testando:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object LabelDataTeste: TLabel
      Left = 674
      Top = 29
      Width = 68
      Height = 13
      Caption = '00/00/0000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ButtonParar: TButton
      Left = 328
      Top = 24
      Width = 75
      Height = 21
      Caption = 'Parar'
      TabOrder = 0
    end
    object ButtonIniciar: TButton
      Left = 247
      Top = 24
      Width = 75
      Height = 21
      Caption = 'Iniciar'
      TabOrder = 1
    end
    object dtDataInicio: TDateTimePicker
      Left = 16
      Top = 24
      Width = 105
      Height = 21
      Date = 42020.481245636580000000
      Time = 42020.481245636580000000
      TabOrder = 2
    end
    object dtDataFim: TDateTimePicker
      Left = 136
      Top = 24
      Width = 105
      Height = 21
      Date = 42020.481245636580000000
      Time = 42020.481245636580000000
      TabOrder = 3
    end
  end
  object WebBrowser1: TWebBrowser
    Left = 0
    Top = 56
    Width = 749
    Height = 434
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 112
    ExplicitTop = 128
    ExplicitWidth = 300
    ExplicitHeight = 150
    ControlData = {
      4C000000694D0000DB2C00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 490
    Width = 749
    Height = 19
    Panels = <>
    ExplicitLeft = 384
    ExplicitTop = 264
    ExplicitWidth = 0
  end
end
