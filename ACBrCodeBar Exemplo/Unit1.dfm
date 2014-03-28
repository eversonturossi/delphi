object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 552
  ClientWidth = 1032
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 8
    Top = 39
    Width = 57
    Height = 29
  end
  object Label3: TLabel
    Left = 227
    Top = 11
    Width = 25
    Height = 13
    Caption = 'Ratio'
  end
  object Label4: TLabel
    Left = 313
    Top = 11
    Width = 28
    Height = 13
    Caption = 'Modul'
  end
  object ButtonGerar: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Gerar'
    TabOrder = 0
    OnClick = ButtonGerarClick
  end
  object Edit1: TEdit
    Left = 89
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = '123456789'
  end
  object SpinEditRatio: TSpinEdit
    Left = 258
    Top = 8
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 2
  end
  object SpinEditModul: TSpinEdit
    Left = 347
    Top = 8
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 1
  end
end
