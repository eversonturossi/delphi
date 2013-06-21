object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 556
  ClientWidth = 759
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
    Top = 5
    Width = 59
    Height = 13
    Caption = 'Nome Regra'
  end
  object Label2: TLabel
    Left = 8
    Top = 53
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object Label3: TLabel
    Left = 8
    Top = 101
    Width = 45
    Height = 13
    Caption = 'Aplicacao'
  end
  object EditNomeRegra: TEdit
    Left = 8
    Top = 24
    Width = 225
    Height = 21
    TabOrder = 0
  end
  object EditPorta: TEdit
    Left = 8
    Top = 72
    Width = 59
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object EditAplicacao: TEdit
    Left = 8
    Top = 120
    Width = 225
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object Button1: TButton
    Left = 239
    Top = 118
    Width = 75
    Height = 25
    Caption = 'Abrir'
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Porta'
    TabOrder = 4
  end
  object Button3: TButton
    Left = 158
    Top = 160
    Width = 75
    Height = 25
    Caption = 'Aplicacao'
    TabOrder = 5
  end
  object OpenDialog1: TOpenDialog
    Left = 352
    Top = 48
  end
end
