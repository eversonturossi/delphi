object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 691
  ClientWidth = 1106
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
    Width = 1106
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitLeft = 472
    ExplicitTop = 344
    ExplicitWidth = 185
    object Button1: TButton
      Left = 16
      Top = 10
      Width = 169
      Height = 25
      Caption = 'Executar com Thread'
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 216
      Top = 10
      Width = 265
      Height = 25
      Caption = 'Executar sem Thread'
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 520
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Button3'
      TabOrder = 2
      OnClick = Button3Click
    end
  end
  object Memo1: TMemo
    Left = 0
    Top = 41
    Width = 1106
    Height = 650
    Align = alClient
    TabOrder = 1
    ExplicitLeft = 408
    ExplicitTop = 240
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
end
