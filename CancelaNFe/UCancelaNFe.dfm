object Form2: TForm2
  Left = 71
  Top = 59
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  BorderWidth = 2
  Caption = 'Cancelamento de NF-e / NFC-e'
  ClientHeight = 227
  ClientWidth = 745
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 0
    Top = 81
    Width = 745
    Height = 144
    Align = alTop
    Caption = 'Cancelamento NFe pela Chave'
    TabOrder = 0
    ExplicitWidth = 717
    DesignSize = (
      745
      144)
    object Label2: TLabel
      Left = 10
      Top = 17
      Width = 95
      Height = 13
      Caption = 'Chave de Acesso'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 303
      Top = 17
      Width = 182
      Height = 13
      Caption = 'Justificativa para Cancelamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label4: TLabel
      Left = 596
      Top = 17
      Width = 125
      Height = 13
      Caption = 'Protocolo Autoriza'#231#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label5: TLabel
      Left = 10
      Top = 61
      Width = 23
      Height = 13
      Caption = 'XML'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object btnXML: TSpeedButton
      Left = 713
      Top = 80
      Width = 25
      Height = 21
      Flat = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = []
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFCFCFCFCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCC
        CCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCCD0D0D0FF00FFFF00FF4E9DD34398D2
        4094D03E92CF3E92CE3F92CE3F92CE3F92CE3F92CE3F92CE3F92CE3F92CE3F93
        CF4C9AD1F1F1F1FF00FF4499D23F94D0ABFBFF9BF3FF92F1FF93F1FF93F1FF93
        F1FF93F1FF93F1FF93F1FF93F1FFA6F8FF65B8E3B2CADAFF00FF4398D24FA6D9
        8EDAF5A2EEFF82E5FE84E5FE84E5FE85E6FE85E6FE85E6FE85E6FE84E6FE96EB
        FF8CD8F570A7CFFF00FF4296D16BBEE86DBDE6BBF2FF75DEFD77DEFC78DEFC7B
        DFFC7DDFFC7DDFFC7DDFFC7CDFFC80E0FDADF0FF4D9DD3F1F1F14095D08AD7F5
        44A1D8DDFDFFDAFAFFDBFAFFDEFAFF74DCFC76DBFA75DAFA74DAFA74DAFA72D9
        FAA1E8FF7CBFE6B3CADB3E94D0ABF0FF449DD6368CCB368CCB368CCB378BCB5C
        BEEA6FD9FB6AD6FA68D5F967D4F966D4F982DEFCAAE0F66FA6CE3D92CFB9F4FF
        73DBFB6BCCF26CCDF36CCEF36DCEF3479CD456BAE9DAF8FFD7F6FFD6F6FFD5F6
        FFD5F7FFDBFCFF3E94D03C92CFC0F3FF71DAFB74DBFB75DBFC75DBFC76DCFC73
        DAFA449CD4378CCB368CCB358CCC348DCC3890CE3D94D052A0D63B92CFCAF6FF
        69D5F96CD5F96BD5F969D5F969D5FA6AD7FB68D4FA5EC7F15EC7F25DC8F2B4E3
        F83D94D0B0D1E8FF00FF3B92CFD5F7FF60D1F961D0F8B4EBFDD9F6FFDAF8FFDA
        F8FFDBF9FFDCFAFFDCFAFFDCFBFFE0FFFF3E95D0DAEBF6FF00FF3D94D0DCFCFF
        D8F7FFD8F7FFDBFAFF358ECD3991CE3A92CF3A92CF3A92CF3A92CF3B92CF3D94
        D060A8D9FF00FFFF00FF7DB8E03D94D03A92CF3A92CF3D94D063A9D9FF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF
        FF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00
        FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF
        00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FFFF00FF}
      ParentFont = False
      OnClick = btnXMLClick
    end
    object btnCancelarChave: TButton
      Left = 564
      Top = 110
      Width = 174
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnCancelarChaveClick
    end
    object edtChave: TEdit
      Left = 10
      Top = 33
      Width = 287
      Height = 21
      NumbersOnly = True
      TabOrder = 1
    end
    object edtJustificativa: TEdit
      Left = 303
      Top = 33
      Width = 287
      Height = 21
      TabOrder = 2
    end
    object edtProtocolo: TEdit
      Left = 596
      Top = 33
      Width = 142
      Height = 21
      NumbersOnly = True
      TabOrder = 3
    end
    object edtXML: TEdit
      Left = 10
      Top = 80
      Width = 697
      Height = 21
      ReadOnly = True
      TabOrder = 4
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 0
    Width = 745
    Height = 81
    Align = alTop
    Caption = 'Webservice'
    TabOrder = 1
    ExplicitWidth = 717
    object rgTipoAmb: TRadioGroup
      Left = 7
      Top = 14
      Width = 266
      Height = 60
      Caption = 'Ambiente'
      ItemIndex = 0
      Items.Strings = (
        'Produ'#231#227'o'
        'Homologa'#231#227'o')
      TabOrder = 0
    end
  end
  object ACBrNFe1: TACBrNFe
    Configuracoes.Geral.SSLLib = libCapicomDelphiSoap
    Configuracoes.Geral.FormatoAlerta = 'TAG:%TAGNIVEL% ID:%ID%/%TAG%(%DESCRICAO%) - %MSG%.'
    Configuracoes.Geral.IncluirQRCodeXMLNFCe = False
    Configuracoes.WebServices.UF = 'SP'
    Configuracoes.WebServices.AguardarConsultaRet = 0
    Configuracoes.WebServices.QuebradeLinha = '|'
    Left = 544
    Top = 16
  end
  object OpenDialog1: TOpenDialog
    Left = 464
    Top = 16
  end
end
