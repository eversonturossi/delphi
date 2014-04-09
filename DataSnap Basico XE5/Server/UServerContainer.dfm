object ServerContainer: TServerContainer
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 664
  Width = 897
  object DataSnapServer: TDSServer
    Left = 96
    Top = 11
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Port = 214
    Server = DataSnapServer
    Filters = <
      item
        FilterId = 'PC1'
        Properties.Strings = (
          'Key=wbu8CqgAiJEmcrIc')
      end
      item
        FilterId = 'RSA'
        Properties.Strings = (
          'UseGlobalKey=true'
          'KeyLength=1024'
          'KeyExponent=3')
      end
      item
        FilterId = 'ZLibCompression'
        Properties.Strings = (
          'CompressMoreThan=1024')
      end>
    AuthenticationManager = DSAuthenticationManager1
    Left = 96
    Top = 73
  end
  object DSAuthenticationManager1: TDSAuthenticationManager
    OnUserAuthenticate = DSAuthenticationManager1UserAuthenticate
    OnUserAuthorize = DSAuthenticationManager1UserAuthorize
    Roles = <>
    Left = 88
    Top = 133
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DataSnapServer
    Left = 448
    Top = 51
  end
  object DSServerClassConfiguracao: TDSServerClass
    OnGetClass = DSServerClassConfiguracaoGetClass
    Server = DataSnapServer
    Left = 104
    Top = 496
  end
  object DSServerClassRelatorio: TDSServerClass
    OnGetClass = DSServerClassRelatorioGetClass
    Server = DataSnapServer
    Left = 104
    Top = 448
  end
  object DSServerClassLancamento: TDSServerClass
    OnGetClass = DSServerClassLancamentoGetClass
    Server = DataSnapServer
    Left = 104
    Top = 392
  end
  object DSServerClassCadastro: TDSServerClass
    OnGetClass = DSServerClassCadastroGetClass
    Server = DataSnapServer
    Left = 104
    Top = 336
  end
end
