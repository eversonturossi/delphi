object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 520
  ClientWidth = 772
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 321
    Height = 54
    Caption = 'Chave de Acesso'
    TabOrder = 0
    object Edit1: TEdit
      Left = 11
      Top = 19
      Width = 302
      Height = 21
      TabOrder = 0
    end
  end
  object Button1: TButton
    Left = 654
    Top = 15
    Width = 113
    Height = 44
    Caption = 'Button1'
    TabOrder = 1
  end
  object RadioGroup1: TRadioGroup
    Left = 335
    Top = 8
    Width = 122
    Height = 54
    Caption = 'Ambiente'
    Items.Strings = (
      'Produ'#231#227'o'
      'Homologa'#231#227'o')
    TabOrder = 2
  end
  object RadioGroup2: TRadioGroup
    Left = 463
    Top = 8
    Width = 185
    Height = 54
    Caption = 'Webservice'
    Columns = 2
    Items.Strings = (
      'NF-e'
      'NFC-e'
      'CT-e'
      'MDF-e')
    TabOrder = 3
  end
  object PageControl1: TPageControl
    Left = 8
    Top = 65
    Width = 756
    Height = 447
    ActivePage = TabSheet1
    TabOrder = 4
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object WebBrowser1: TWebBrowser
        Left = 0
        Top = 0
        Width = 748
        Height = 419
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 17
        ExplicitTop = 40
        ExplicitWidth = 300
        ExplicitHeight = 150
        ControlData = {
          4C0000004F4D00004E2B00000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.IncluirQRCodeXMLNFCe = False
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 96
    Top = 136
  end
  object ACBrCTe1: TACBrCTe
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 208
    Top = 136
  end
  object ACBrMDFe1: TACBrMDFe
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 321
    Top = 144
  end
end
