object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 207
  ClientWidth = 282
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
    Left = 8
    Top = 153
    Width = 60
    Height = 13
    Caption = 'Dist'#226'ncia KM'
  end
  object Label6: TLabel
    Left = 144
    Top = 153
    Width = 79
    Height = 13
    Caption = 'Dist'#226'ncia Metros'
  end
  object EditLatitudeInicio: TEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = '-27.104736'
  end
  object EditLongitudeInicio: TEdit
    Left = 144
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '-52.614220'
  end
  object EditDistanciaKM: TEdit
    Left = 8
    Top = 172
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
  object EditLatitudeFim: TEdit
    Left = 8
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 4
    Text = '-27.068345'
  end
  object EditLongitudeFim: TEdit
    Left = 144
    Top = 80
    Width = 121
    Height = 21
    TabOrder = 5
    Text = '-52.624298'
  end
  object EditDistanciaMetros: TEdit
    Left = 144
    Top = 172
    Width = 121
    Height = 21
    TabOrder = 6
  end
end
