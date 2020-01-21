object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 143
  ClientWidth = 252
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
    Left = 16
    Top = 40
    Width = 55
    Height = 13
    Caption = 'Execu'#231#245'es:'
  end
  object Button1: TButton
    Left = 8
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Interface'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 89
    Top = 72
    Width = 75
    Height = 25
    Caption = 'RTTI'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Edit1: TEdit
    Left = 77
    Top = 37
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '1000'
  end
end
