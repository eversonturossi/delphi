object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 556
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 176
    Top = 312
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object PanelConexao: TPanel
    Left = 0
    Top = 0
    Width = 635
    Height = 35
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 399
    DesignSize = (
      635
      35)
    object LabelBanco: TLabel
      Left = 5
      Top = 1
      Width = 29
      Height = 13
      Caption = 'Banco'
    end
    object LabelCaminhoBanco: TLabel
      Left = 5
      Top = 12
      Width = 86
      Height = 13
      Caption = 'Caminho Banco'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 0
      Top = 30
      Width = 635
      Height = 5
      Align = alBottom
      ExplicitTop = 88
      ExplicitWidth = 986
    end
    object ButtonSelecionaBanco: TButton
      Left = 572
      Top = 1
      Width = 60
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Seleciona'
      TabOrder = 0
      OnClick = ButtonSelecionaBancoClick
      ExplicitLeft = 336
    end
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 200
    Top = 240
  end
  object FDConnection1: TFDConnection
    Left = 136
    Top = 112
  end
  object OpenDialog1: TOpenDialog
    Left = 328
    Top = 144
  end
end
