object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 468
  ClientWidth = 738
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ButtonGerar: TButton
    Left = 8
    Top = 64
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 1
    OnClick = ButtonGerarClick
  end
  object ButtonLeitura1: TButton
    Left = 8
    Top = 95
    Width = 75
    Height = 25
    Caption = 'Leitura1'
    TabOrder = 2
    OnClick = ButtonLeitura1Click
  end
  object ListBox1: TListBox
    Left = 96
    Top = 8
    Width = 634
    Height = 457
    ItemHeight = 13
    TabOrder = 3
  end
  object ButtonLeitura2: TButton
    Left = 8
    Top = 126
    Width = 75
    Height = 25
    Caption = 'Leitura2'
    TabOrder = 4
    OnClick = ButtonLeitura2Click
  end
  object ButtonLeitura3: TButton
    Left = 8
    Top = 196
    Width = 75
    Height = 25
    Caption = 'Leitura3'
    TabOrder = 5
    OnClick = ButtonLeitura3Click
  end
  object ButtonGerar2: TButton
    Left = 8
    Top = 165
    Width = 75
    Height = 25
    Caption = 'Gerar2'
    TabOrder = 6
    OnClick = ButtonGerar2Click
  end
  object XMLDocument1: TXMLDocument
    Left = 552
    Top = 8
    DOMVendorDesc = 'MSXML'
  end
end
