object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 695
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    628
    695)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonVariaveis: TButton
    Left = 8
    Top = 8
    Width = 200
    Height = 25
    Caption = 'Variaveis'
    TabOrder = 0
    OnClick = ButtonVariaveisClick
  end
  object ButtonStopWatch: TButton
    Left = 214
    Top = 8
    Width = 200
    Height = 25
    Caption = 'StopWatch'
    TabOrder = 1
    OnClick = ButtonStopWatchClick
  end
  object ButtonTimeSpan: TButton
    Left = 420
    Top = 8
    Width = 200
    Height = 25
    Caption = 'TimeSpan'
    TabOrder = 2
    OnClick = ButtonTimeSpanClick
  end
  object ListBoxLog: TListBox
    Left = 8
    Top = 39
    Width = 612
    Height = 648
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 3
  end
end
