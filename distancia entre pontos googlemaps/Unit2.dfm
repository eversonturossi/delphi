object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 300
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 84
    Height = 13
    Caption = 'Latitude Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 144
    Top = 8
    Width = 93
    Height = 13
    Caption = 'Longitude Inicial'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 144
    Top = 64
    Width = 85
    Height = 13
    Caption = 'Longitude Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 8
    Top = 64
    Width = 76
    Height = 13
    Caption = 'Latitude Final'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 56
    Top = 181
    Width = 43
    Height = 13
    Caption = 'Dist'#226'ncia'
  end
  object EditLatInicial: TEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
  end
  object EditLongInicial: TEdit
    Left = 144
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
  end
  object EditDistancia: TEdit
    Left = 56
    Top = 200
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object Button1: TButton
    Left = 88
    Top = 120
    Width = 75
    Height = 25
    Caption = 'Calcular'
    TabOrder = 3
    OnClick = Button1Click
  end
  object EditLatFinal: TEdit
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 4
  end
  object EditLongFinal: TEdit
    Left = 144
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 5
  end
end
