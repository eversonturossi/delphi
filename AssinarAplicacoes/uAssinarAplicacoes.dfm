object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Assinar A'
  ClientHeight = 435
  ClientWidth = 505
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    505
    435)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 45
    Height = 13
    Caption = 'Aplica'#231#227'o'
  end
  object EditAplicacao: TEdit
    Left = 8
    Top = 24
    Width = 458
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    ReadOnly = True
    TabOrder = 0
  end
  object ButtonSelecionaAplicacao: TButton
    Left = 472
    Top = 24
    Width = 26
    Height = 22
    Anchors = [akTop, akRight]
    Caption = '...'
    TabOrder = 1
    OnClick = ButtonSelecionaAplicacaoClick
  end
  object ButtonAssinarAplicacao: TButton
    Left = 8
    Top = 74
    Width = 150
    Height = 25
    Caption = 'Assinar Execut'#225'vel'
    TabOrder = 2
    OnClick = ButtonAssinarAplicacaoClick
  end
  object ButtonInstalarCertificado: TButton
    Left = 164
    Top = 74
    Width = 150
    Height = 25
    Caption = 'Instalar Certificado'
    TabOrder = 3
  end
  object CheckBoxCompactarUPX: TCheckBox
    Left = 8
    Top = 51
    Width = 129
    Height = 17
    Caption = 'Compactar com UPX'
    TabOrder = 4
  end
  object MemoLog: TMemo
    Left = 8
    Top = 105
    Width = 490
    Height = 322
    Anchors = [akLeft, akTop, akRight, akBottom]
    ReadOnly = True
    TabOrder = 5
  end
  object OpenDialog1: TOpenDialog
    Left = 368
  end
end
