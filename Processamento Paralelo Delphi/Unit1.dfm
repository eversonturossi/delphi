object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 201
  ClientWidth = 447
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonSemThread: TButton
    Left = 48
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Sem Thread'
    TabOrder = 0
    OnClick = ButtonSemThreadClick
  end
  object ButtonComThread: TButton
    Left = 144
    Top = 56
    Width = 75
    Height = 25
    Caption = 'Com Thread'
    TabOrder = 1
    OnClick = ButtonComThreadClick
  end
  object ButtonMuitasThreads: TButton
    Left = 48
    Top = 104
    Width = 171
    Height = 25
    Caption = 'ButtonMuitasThreads'
    TabOrder = 2
    OnClick = ButtonMuitasThreadsClick
  end
end
