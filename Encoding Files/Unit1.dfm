object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 299
  ClientWidth = 635
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
    Top = 266
    Width = 209
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object EncodingComboBox: TComboBox
    Left = 8
    Top = 8
    Width = 385
    Height = 21
    TabOrder = 1
    Text = 'EncodingComboBox'
    Items.Strings = (
      'ASCII'
      'UTF-8'
      'UTF-16 LE (Little-endian)'
      'UTF-16 BE (Big-endian)')
  end
  object Memo1: TMemo
    Left = 8
    Top = 35
    Width = 385
    Height = 225
    Lines.Strings = (
      'Memo1')
    TabOrder = 2
  end
  object ListBox1: TListBox
    Left = 399
    Top = 35
    Width = 228
    Height = 225
    ItemHeight = 13
    TabOrder = 3
  end
end
