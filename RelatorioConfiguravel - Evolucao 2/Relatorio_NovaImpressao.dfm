object RelatorioNovaImpressao: TRelatorioNovaImpressao
  Left = 0
  Top = 0
  Width = 559
  Height = 794
  Frame.Color = clBlack
  Frame.DrawTop = False
  Frame.DrawBottom = False
  Frame.DrawLeft = False
  Frame.DrawRight = False
  DataSet = cdRelatorio
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Arial'
  Font.Style = []
  Functions.Strings = (
    'PAGENUMBER'
    'COLUMNNUMBER'
    'REPORTTITLE'
    'QRLOOPBAND1')
  Functions.DATA = (
    '0'
    '0'
    #39#39
    '0')
  Options = [FirstPageHeader, LastPageFooter]
  Page.Columns = 1
  Page.Orientation = poPortrait
  Page.PaperSize = A5
  Page.Values = (
    100.000000000000000000
    2100.000000000000000000
    100.000000000000000000
    1480.000000000000000000
    100.000000000000000000
    100.000000000000000000
    0.000000000000000000)
  PrinterSettings.Copies = 1
  PrinterSettings.OutputBin = Auto
  PrinterSettings.Duplex = False
  PrinterSettings.FirstPage = 0
  PrinterSettings.LastPage = 0
  PrinterSettings.UseStandardprinter = False
  PrinterSettings.UseCustomBinCode = False
  PrinterSettings.CustomBinCode = 0
  PrinterSettings.ExtendedDuplex = 0
  PrinterSettings.UseCustomPaperCode = False
  PrinterSettings.CustomPaperCode = 0
  PrinterSettings.PrintMetaFile = False
  PrinterSettings.PrintQuality = 0
  PrinterSettings.Collate = 0
  PrinterSettings.ColorOption = 0
  PrintIfEmpty = True
  ReportTitle = 'Impress'#227'o'
  SnapToGrid = True
  Units = MM
  Zoom = 100
  PrevFormStyle = fsNormal
  PreviewInitialState = wsNormal
  PrevShowThumbs = False
  PrevShowSearch = False
  PrevInitialZoom = qrZoom100
  PreviewDefaultSaveType = stQRP
  object CabecalhoGeral: TQRBand
    Left = 38
    Top = 38
    Width = 483
    Height = 40
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      105.833333333333300000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageHeader
  end
  object Principal: TQRBand
    Left = 38
    Top = 78
    Width = 483
    Height = 93
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 10790052
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = True
    Size.Values = (
      246.062500000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbDetail
  end
  object SeparadorPrincipal: TQRChildBand
    Left = 38
    Top = 171
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 15000804
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    ParentBand = Principal
    PrintOrder = cboAfterParent
  end
  object Detalhe01: TQRSubDetail
    Left = 38
    Top = 208
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 10207993
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    DataSet = cdDetalhe01
    FooterBand = Rodape01
    HeaderBand = Cabecalho01
    PrintBefore = False
    PrintIfEmpty = True
  end
  object Rodape01: TQRBand
    Left = 38
    Top = 226
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 13755388
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
  end
  object Cabecalho02: TQRBand
    Left = 38
    Top = 244
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 13691766
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupHeader
  end
  object Detalhe02: TQRSubDetail
    Left = 38
    Top = 262
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 14939051
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    DataSet = cdDetalhe02
    FooterBand = Rodape02
    HeaderBand = Cabecalho02
    PrintBefore = False
    PrintIfEmpty = True
  end
  object Rodape02: TQRBand
    Left = 38
    Top = 280
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 12510016
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
  end
  object Cabecalho03: TQRBand
    Left = 38
    Top = 298
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 16755801
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupHeader
  end
  object Detalhe03: TQRSubDetail
    Left = 38
    Top = 316
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 16767152
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    Master = Owner
    DataSet = cdDetalhe03
    FooterBand = Rodape03
    HeaderBand = Cabecalho03
    PrintBefore = False
    PrintIfEmpty = True
  end
  object Rodape03: TQRBand
    Left = 38
    Top = 334
    Width = 483
    Height = 18
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 16763025
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      47.625000000000000000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupFooter
  end
  object Cabecalho01: TQRBand
    Left = 38
    Top = 189
    Width = 483
    Height = 19
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = 6266613
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      50.270833333333330000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbGroupHeader
  end
  object RodapeGeral: TQRBand
    Left = 38
    Top = 352
    Width = 483
    Height = 40
    Frame.Color = clBlack
    Frame.DrawTop = False
    Frame.DrawBottom = False
    Frame.DrawLeft = False
    Frame.DrawRight = False
    AlignToBottom = False
    Color = clWhite
    TransparentBand = False
    ForceNewColumn = False
    ForceNewPage = False
    Size.Values = (
      105.833333333333300000
      1277.937500000000000000)
    PreCaluculateBandHeight = False
    KeepOnOnePage = False
    BandType = rbPageFooter
  end
  object QRPDFFilter1: TQRPDFFilter
    CompressionOn = False
    TextEncoding = ASCIIEncoding
    Left = 744
    Top = 16
  end
  object cdRelatorio: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 432
  end
  object cdDetalhe01: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 480
  end
  object cdDetalhe02: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 528
  end
  object cdDetalhe03: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 72
    Top = 576
  end
  object cdMontaItens: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 392
    Top = 520
  end
  object cdListaDetalhamentos: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 448
    Top = 448
  end
  object cdMontaRelatorio: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 344
    Top = 448
  end
end
