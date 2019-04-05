object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 693
  ClientWidth = 834
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 21
    Width = 96
    Height = 13
    Caption = 'Caminho Certificado'
  end
  object Label2: TLabel
    Left = 8
    Top = 77
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label3: TLabel
    Left = 352
    Top = 189
    Width = 109
    Height = 13
    Caption = 'Certificado em BASE64'
  end
  object Label4: TLabel
    Left = 408
    Top = 360
    Width = 31
    Height = 13
    Caption = 'Label4'
  end
  object Label5: TLabel
    Left = 8
    Top = 189
    Width = 93
    Height = 13
    Caption = 'Resultado Consulta'
  end
  object EditSenha: TEdit
    Left = 8
    Top = 96
    Width = 441
    Height = 21
    TabOrder = 0
    Text = 'EditSenha'
  end
  object EditCertificado: TEdit
    Left = 8
    Top = 40
    Width = 441
    Height = 21
    TabOrder = 1
    Text = 'EditCertificado'
  end
  object ButtonSelecionaCertificado: TButton
    Left = 455
    Top = 38
    Width = 25
    Height = 25
    Caption = '...'
    TabOrder = 2
    OnClick = ButtonSelecionaCertificadoClick
  end
  object ButtonConsultaStatus: TButton
    Left = 80
    Top = 136
    Width = 273
    Height = 25
    Caption = 'Consulta Status'
    TabOrder = 3
    OnClick = ButtonConsultaStatusClick
  end
  object MemoDados: TMemo
    Left = 8
    Top = 208
    Width = 321
    Height = 465
    Lines.Strings = (
      'MemoDados')
    TabOrder = 4
  end
  object Memo1: TMemo
    Left = 352
    Top = 208
    Width = 474
    Height = 465
    Lines.Strings = (
      'Memo1')
    TabOrder = 5
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libCustom
    Configuracoes.Geral.SSLCryptLib = cryWinCrypt
    Configuracoes.Geral.SSLHttpLib = httpNone
    Configuracoes.Geral.SSLXmlSignLib = xsNone
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.VersaoDF = ve400
    Configuracoes.Geral.VersaoQRCode = veqr000
    Configuracoes.Arquivos.OrdenacaoPath = <>
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Configuracoes.WebServices.SSLType = LT_TLSv1_2
    Left = 264
    Top = 320
  end
  object OpenDialog1: TOpenDialog
    Left = 408
    Top = 352
  end
end
