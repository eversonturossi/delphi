object FormGerador: TFormGerador
  Left = 0
  Top = 0
  Caption = 'Gerador Projetos'
  ClientHeight = 115
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
    Left = 8
    Top = 13
    Width = 42
    Height = 13
    Caption = 'Classes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 88
    Top = 13
    Width = 59
    Height = 13
    Caption = 'Linhas Min'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 167
    Top = 13
    Width = 63
    Height = 13
    Caption = 'Linhas Max'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object ButtonGerar: TButton
    Left = 8
    Top = 82
    Width = 162
    Height = 25
    Caption = 'Gerar'
    TabOrder = 0
    OnClick = ButtonGerarClick
  end
  object SpinEditClasses: TSpinEdit
    Left = 9
    Top = 32
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 1
    Value = 1000
  end
  object SpinEditLinhaMin: TSpinEdit
    Left = 88
    Top = 32
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 100
  end
  object SpinEditLinhaMax: TSpinEdit
    Left = 167
    Top = 32
    Width = 73
    Height = 22
    MaxValue = 0
    MinValue = 0
    TabOrder = 3
    Value = 1000
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 60
    Width = 232
    Height = 17
    TabOrder = 4
  end
  object ButtonParar: TButton
    Left = 173
    Top = 83
    Width = 67
    Height = 25
    Caption = 'Parar'
    TabOrder = 5
    OnClick = ButtonPararClick
  end
end
