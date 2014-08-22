object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 141
  ClientWidth = 293
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
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 51
    Height = 13
    Caption = 'Data Inicio'
  end
  object Label2: TLabel
    Left = 160
    Top = 5
    Width = 97
    Height = 13
    Caption = 'N'#250'mero de Arquivos'
  end
  object DataInicio: TDateTimePicker
    Left = 8
    Top = 24
    Width = 137
    Height = 21
    Date = 41872.578322453700000000
    Time = 41872.578322453700000000
    TabOrder = 0
  end
  object Button1: TButton
    Left = 8
    Top = 51
    Width = 90
    Height = 26
    Caption = 'Gerar'
    TabOrder = 1
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 91
    Width = 273
    Height = 38
    TabOrder = 2
  end
  object EditNumeroArquivos: TEdit
    Left = 160
    Top = 24
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    Text = 'EditNumeroArquivos'
  end
  object Button2: TButton
    Left = 160
    Top = 51
    Width = 125
    Height = 25
    Caption = 'Retrocedor Data'
    TabOrder = 4
    OnClick = Button2Click
  end
end
