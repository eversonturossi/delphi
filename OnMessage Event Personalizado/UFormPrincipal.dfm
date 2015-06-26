object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'FormPrincipal'
  ClientHeight = 214
  ClientWidth = 515
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 0
    Top = 0
    Width = 515
    Height = 214
    Align = alClient
    ReadOnly = True
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 56
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object MainMenu1: TMainMenu
    Left = 248
    Top = 112
    object FormulariosAbertos1: TMenuItem
      Caption = 'Formularios Abertos'
      OnClick = FormulariosAbertos1Click
    end
    object este11: TMenuItem
      Caption = 'Teste1'
      OnClick = este11Click
    end
    object este21: TMenuItem
      Caption = 'Teste2'
      OnClick = este21Click
    end
    object este31: TMenuItem
      Caption = 'Teste3'
      OnClick = este31Click
    end
  end
end
