object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 101
  ClientWidth = 288
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object MedicaoTempoPorData: TButton
    Left = 8
    Top = 8
    Width = 273
    Height = 25
    Caption = 'MedicaoTempoPorData'
    TabOrder = 0
    OnClick = MedicaoTempoPorDataClick
  end
  object MedicaoStopWatch: TButton
    Left = 8
    Top = 70
    Width = 273
    Height = 25
    Caption = 'MedicaoStopWatch'
    TabOrder = 1
    OnClick = MedicaoStopWatchClick
  end
  object MedicaoTickCount: TButton
    Left = 8
    Top = 39
    Width = 273
    Height = 25
    Caption = 'MedicaoTickCount'
    TabOrder = 2
    OnClick = MedicaoTickCountClick
  end
end
