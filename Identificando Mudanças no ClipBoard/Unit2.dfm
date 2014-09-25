object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 463
  ClientWidth = 770
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
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 770
    Height = 463
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    ExplicitLeft = 248
    ExplicitTop = 152
    ExplicitWidth = 289
    ExplicitHeight = 193
    object TabSheet1: TTabSheet
      Caption = 'Texto'
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 762
        Height = 435
        Align = alClient
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
        ExplicitLeft = -473
        ExplicitTop = 30
        ExplicitWidth = 754
        ExplicitHeight = 135
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Imagem'
      ImageIndex = 1
      ExplicitWidth = 281
      ExplicitHeight = 165
      object Image1: TImage
        Left = 0
        Top = 0
        Width = 762
        Height = 435
        Align = alClient
        ExplicitLeft = 328
        ExplicitTop = 168
        ExplicitWidth = 105
        ExplicitHeight = 105
      end
    end
  end
end
