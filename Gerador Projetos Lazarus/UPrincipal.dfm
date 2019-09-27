object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 89
  ClientWidth = 166
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonGerar: TButton
    Left = 8
    Top = 36
    Width = 121
    Height = 25
    Caption = 'Gerar'
    TabOrder = 0
    OnClick = ButtonGerarClick
  end
  object SpinEditQuantidade: TSpinEdit
    Left = 8
    Top = 8
    Width = 121
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 1000
  end
end
