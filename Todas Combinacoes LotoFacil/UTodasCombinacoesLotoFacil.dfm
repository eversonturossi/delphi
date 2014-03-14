object Form1: TForm1
  Left = 192
  Top = 108
  Caption = 'Form1'
  ClientHeight = 57
  ClientWidth = 213
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    213
    57)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 201
    Height = 25
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Gerar Combina'#231'oes'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ProgressBar1: TProgressBar
    Left = 0
    Top = 41
    Width = 213
    Height = 16
    Align = alBottom
    Max = 3268760
    TabOrder = 1
  end
end
