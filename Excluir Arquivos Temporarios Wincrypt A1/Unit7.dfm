object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 699
  ClientWidth = 1035
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1035
    Height = 41
    Align = alTop
    TabOrder = 0
    object ButtonListarExcluir: TButton
      Left = 8
      Top = 8
      Width = 353
      Height = 25
      Caption = 'Listar e Excluir'
      TabOrder = 0
      OnClick = ButtonListarExcluirClick
    end
  end
  object ListBoxTempFiles: TListBox
    Left = 0
    Top = 41
    Width = 1035
    Height = 658
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
    ExplicitLeft = 464
    ExplicitTop = 320
    ExplicitWidth = 121
    ExplicitHeight = 97
  end
end
