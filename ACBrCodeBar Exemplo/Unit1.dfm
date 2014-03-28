object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Teste de c'#243'digo de Barras'
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
    Width = 193
    Height = 122
  end
  object Label3: TLabel
    Left = 514
    Top = 11
    Width = 25
    Height = 13
    Caption = 'Ratio'
  end
  object Label4: TLabel
    Left = 600
    Top = 11
    Width = 28
    Height = 13
    Caption = 'Modul'
  end
  object Label1: TLabel
    Left = 420
    Top = 11
    Width = 29
    Height = 13
    Caption = 'Altura'
  end
  object Label2: TLabel
    Left = 219
    Top = 11
    Width = 20
    Height = 13
    Caption = 'Tipo'
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
    Left = 545
    Top = 8
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 2
  end
  object SpinEditModul: TSpinEdit
    Left = 634
    Top = 8
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 4
    Value = 1
  end
  object SpinEditAltura: TSpinEdit
    Left = 455
    Top = 8
    Width = 49
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 50
  end
  object ComboBoxTipo: TComboBox
    Left = 245
    Top = 8
    Width = 161
    Height = 22
    Style = csOwnerDrawFixed
    TabOrder = 5
    Items.Strings = (
      'bcCode_2_5_interleaved'
      'bcCode_2_5_industrial'
      'bcCode_2_5_matrix'
      'bcCode39'
      'bcCode39Extended'
      'bcCode128A'
      'bcCode128B'
      'bcCode128C'
      'bcCode93'
      'bcCode93Extended'
      'bcCodeMSI'
      'bcCodePostNet'
      'bcCodeCodabar'
      'bcCodeEAN8'
      'bcCodeEAN13'
      'bcCodeUPC_A'
      'bcCodeUPC_E0'
      'bcCodeUPC_E1'
      'bcCodeUPC_Supp2'
      'bcCodeUPC_Supp5'
      'bcCodeEAN128A'
      'bcCodeEAN128B'
      'bcCodeEAN128C')
  end
  object CheckBoxLegenda: TCheckBox
    Left = 712
    Top = 10
    Width = 97
    Height = 17
    Caption = 'Legenda'
    TabOrder = 6
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 533
    Width = 1032
    Height = 19
    Panels = <
      item
        Width = 50
      end>
    ExplicitLeft = 528
    ExplicitTop = 288
    ExplicitWidth = 0
  end
end
