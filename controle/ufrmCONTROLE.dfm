object frPrincipal: TfrPrincipal
  Left = 255
  Top = 211
  Caption = 'frPrincipal'
  ClientHeight = 370
  ClientWidth = 592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIForm
  Menu = MainMenu1
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 0
    Top = 65
    Width = 592
    Height = 286
    Align = alClient
    AutoSize = True
    ExplicitWidth = 600
    ExplicitHeight = 299
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 351
    Width = 592
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object CoolBar1: TCoolBar
    Left = 0
    Top = 0
    Width = 592
    Height = 65
    Bands = <
      item
        Control = ToolBar1
        ImageIndex = -1
        MinHeight = 59
        Width = 586
      end>
    object ToolBar1: TToolBar
      Left = 11
      Top = 0
      Width = 577
      Height = 59
      ButtonHeight = 52
      ButtonWidth = 53
      Caption = 'ToolBar1'
      DisabledImages = ImageList1
      Images = ImageList1
      TabOrder = 0
      object ToolButton1: TToolButton
        Left = 0
        Top = 0
        Caption = 'ToolButton1'
        ImageIndex = 0
        OnClick = ToolButton1Click
      end
      object ToolButton2: TToolButton
        Left = 53
        Top = 0
        Caption = 'ToolButton2'
        ImageIndex = 1
      end
      object ToolButton3: TToolButton
        Left = 106
        Top = 0
        Caption = 'ToolButton3'
        ImageIndex = 2
      end
      object ToolButton4: TToolButton
        Left = 159
        Top = 0
        Caption = 'ToolButton4'
        ImageIndex = 3
      end
      object ToolButton5: TToolButton
        Left = 212
        Top = 0
        Caption = 'ToolButton5'
        ImageIndex = 4
      end
      object ToolButton7: TToolButton
        Left = 265
        Top = 0
        Caption = 'ToolButton7'
        ImageIndex = 5
        OnClick = ToolButton7Click
      end
      object ToolButton6: TToolButton
        Left = 318
        Top = 0
        Width = 8
        Caption = 'ToolButton6'
        ImageIndex = 5
        Style = tbsSeparator
      end
    end
  end
  object ImageList1: TImageList
    Left = 192
    Top = 104
  end
  object MainMenu1: TMainMenu
    Left = 440
    Top = 80
    object a1: TMenuItem
      Caption = 'a'
    end
  end
end
