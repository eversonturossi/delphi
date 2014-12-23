object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 504
  ClientWidth = 852
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    852
    504)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelNomeArquivo: TLabel
    Left = 208
    Top = 13
    Width = 71
    Height = 13
    Caption = 'Nome Arquivo:'
  end
  object ButtonLerUsuarios: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 25
    Caption = 'Ler Usu'#225'rios'
    TabOrder = 0
    OnClick = ButtonLerUsuariosClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 39
    Width = 836
    Height = 457
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 1
  end
  object OpenDialog1: TOpenDialog
    Left = 512
    Top = 128
  end
  object XMLDocument1: TXMLDocument
    Left = 768
    Top = 16
    DOMVendorDesc = 'MSXML'
  end
end
