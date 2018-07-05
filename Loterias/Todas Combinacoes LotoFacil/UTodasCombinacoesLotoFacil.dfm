object Form1: TForm1
  Left = 192
  Top = 108
  Caption = 'Form1'
  ClientHeight = 125
  ClientWidth = 198
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    198
    125)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 187
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Caption = 'Gerar Combina'#231'oes'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 109
    Width = 198
    Height = 16
    Align = alBottom
    Max = 3268760
    TabOrder = 1
  end
  object Button2: TButton
    Left = 8
    Top = 39
    Width = 187
    Height = 25
    Caption = '10d'
    TabOrder = 2
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 8
    Top = 70
    Width = 187
    Height = 25
    Caption = '08d'
    TabOrder = 3
    OnClick = Button3Click
  end
end
