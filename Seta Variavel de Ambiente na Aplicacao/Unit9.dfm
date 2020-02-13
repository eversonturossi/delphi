object Form9: TForm9
  Left = 0
  Top = 0
  Caption = 'Form9'
  ClientHeight = 546
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    635
    546)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonAlteraTemp: TButton
    Left = 8
    Top = 16
    Width = 217
    Height = 25
    Caption = 'Altera Temp'
    TabOrder = 0
    OnClick = ButtonAlteraTempClick
  end
  object ButtonAlteraPath: TButton
    Left = 231
    Top = 16
    Width = 217
    Height = 25
    Caption = 'Altera Path'
    TabOrder = 1
    OnClick = ButtonAlteraPathClick
  end
  object MemoPathOriginal: TMemo
    Left = 8
    Top = 47
    Width = 619
    Height = 219
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'MemoPathOriginal')
    TabOrder = 2
  end
  object MemoPathAlterado: TMemo
    Left = 8
    Top = 272
    Width = 619
    Height = 266
    Anchors = [akLeft, akTop, akRight, akBottom]
    Lines.Strings = (
      'MemoPathAlterado')
    TabOrder = 3
  end
end
