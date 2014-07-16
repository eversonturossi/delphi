object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 161
  ClientWidth = 214
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object edtAnoInicial: TLabeledEdit
    Left = 8
    Top = 32
    Width = 81
    Height = 21
    EditLabel.Width = 49
    EditLabel.Height = 13
    EditLabel.Caption = 'Ano Inicial'
    NumbersOnly = True
    TabOrder = 0
    Text = '0'
  end
  object edtAnoFinal: TLabeledEdit
    Left = 112
    Top = 32
    Width = 81
    Height = 21
    EditLabel.Width = 44
    EditLabel.Height = 13
    EditLabel.Caption = 'Ano Final'
    NumbersOnly = True
    TabOrder = 1
    Text = '3000'
  end
  object Button1: TButton
    Left = 8
    Top = 128
    Width = 185
    Height = 25
    Caption = 'Gerar'
    TabOrder = 2
    OnClick = Button1Click
  end
end
