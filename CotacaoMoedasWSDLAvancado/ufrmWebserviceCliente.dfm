object frmWebserviceCliente: TfrmWebserviceCliente
  Left = 0
  Top = 0
  Caption = 'frmWebserviceCliente'
  ClientHeight = 484
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 257
    Width = 633
    Height = 7
    Cursor = crVSplit
    Align = alTop
    Color = clSilver
    ParentColor = False
    ExplicitTop = 170
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 81
    Align = alTop
    TabOrder = 0
    object lblResultado: TLabel
      Left = 472
      Top = 34
      Width = 24
      Height = 13
      Caption = '0,00'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 16
      Top = 12
      Width = 13
      Height = 13
      Caption = 'De'
    end
    object Label2: TLabel
      Left = 167
      Top = 12
      Width = 22
      Height = 13
      Caption = 'Para'
    end
    object ButtonConverter: TButton
      Left = 328
      Top = 29
      Width = 75
      Height = 25
      Caption = 'Converter'
      TabOrder = 0
      OnClick = ButtonConverterClick
    end
    object ComboBoxFrom: TComboBox
      Left = 16
      Top = 31
      Width = 145
      Height = 21
      TabOrder = 1
      Text = 'ComboBoxFrom'
    end
    object ComboBoxTo: TComboBox
      Left = 167
      Top = 31
      Width = 145
      Height = 21
      TabOrder = 2
      Text = 'ComboBox1'
    end
  end
  object MemoRequest: TMemo
    Left = 0
    Top = 81
    Width = 633
    Height = 176
    Align = alTop
    TabOrder = 1
  end
  object MemoResponse: TMemo
    Left = 0
    Top = 264
    Width = 633
    Height = 220
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 232
    ExplicitTop = 216
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
end
