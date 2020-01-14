object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Listar USB'
  ClientHeight = 289
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
    289)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonListaImpressoras: TButton
    Left = 8
    Top = 8
    Width = 121
    Height = 25
    Caption = 'Listar Impressoas'
    TabOrder = 0
    OnClick = ButtonListaImpressorasClick
  end
  object MemoDispositivos: TMemo
    Left = 8
    Top = 39
    Width = 619
    Height = 242
    Anchors = [akLeft, akTop, akRight, akBottom]
    TabOrder = 1
  end
  object ButtonListaTodos: TButton
    Left = 135
    Top = 8
    Width = 130
    Height = 25
    Caption = 'Listar Todos'
    TabOrder = 2
    OnClick = ButtonListaTodosClick
  end
  object ACBrPosPrinter1: TACBrPosPrinter
    ConfigBarras.MostrarCodigo = False
    ConfigBarras.LarguraLinha = 0
    ConfigBarras.Altura = 0
    ConfigBarras.Margem = 0
    ConfigQRCode.Tipo = 2
    ConfigQRCode.LarguraModulo = 4
    ConfigQRCode.ErrorLevel = 0
    LinhasEntreCupons = 0
    Left = 64
    Top = 80
  end
end
