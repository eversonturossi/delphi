object Form1: TForm1
  Left = 192
  Top = 122
  Caption = 'Recebimento de arquivo'
  ClientHeight = 60
  ClientWidth = 270
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 8
    Width = 63
    Height = 13
    Caption = 'Recebimento'
  end
  object BarraProgresso: TGauge
    Left = 16
    Top = 24
    Width = 225
    Height = 17
    Progress = 0
  end
  object SSocketStream: TServerSocket
    Active = False
    Port = 6660
    ServerType = stNonBlocking
    OnClientRead = SSocketStreamClientRead
    Left = 56
    Top = 8
  end
  object SSocketText: TServerSocket
    Active = False
    Port = 6661
    ServerType = stNonBlocking
    OnListen = SSocketTextListen
    OnClientRead = SSocketTextClientRead
    Left = 128
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 16
    object Cancelardownwload1: TMenuItem
      Caption = 'Cancelar Download'
    end
  end
end
