object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 254
  ClientWidth = 713
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    713
    254)
  PixelsPerInch = 96
  TextHeight = 13
  object Gauge1: TGauge
    Left = 552
    Top = 8
    Width = 153
    Height = 25
    Anchors = [akLeft, akTop, akRight]
    Progress = 0
  end
  object btnConectar: TButton
    Left = 8
    Top = 8
    Width = 57
    Height = 25
    Caption = 'Conecta'
    TabOrder = 0
    OnClick = btnConectarClick
  end
  object btnPut: TButton
    Left = 385
    Top = 8
    Width = 42
    Height = 25
    Caption = 'put'
    TabOrder = 1
    OnClick = btnPutClick
  end
  object btnDesconectar: TButton
    Left = 475
    Top = 8
    Width = 71
    Height = 25
    Caption = 'Desconecta'
    TabOrder = 2
    OnClick = btnDesconectarClick
  end
  object Memo_Relatorio_FTP: TMemo
    Left = 8
    Top = 39
    Width = 697
    Height = 114
    Anchors = [akLeft, akTop, akRight]
    Lines.Strings = (
      'Memo_Relatorio_FTP')
    TabOrder = 3
  end
  object btnCriaDir: TButton
    Left = 71
    Top = 8
    Width = 50
    Height = 25
    Caption = 'makedir'
    TabOrder = 4
    OnClick = btnCriaDirClick
  end
  object btnDeleteDir: TButton
    Left = 127
    Top = 8
    Width = 66
    Height = 25
    Caption = 'removedir'
    TabOrder = 5
    OnClick = btnDeleteDirClick
  end
  object btnGet: TButton
    Left = 433
    Top = 8
    Width = 36
    Height = 25
    Caption = 'get'
    TabOrder = 6
    OnClick = btnGetClick
  end
  object TreeView1: TTreeView
    Left = 8
    Top = 159
    Width = 697
    Height = 87
    Anchors = [akLeft, akTop, akRight, akBottom]
    Indent = 19
    TabOrder = 7
  end
  object btnListarArquivos: TButton
    Left = 296
    Top = 8
    Width = 83
    Height = 25
    Caption = 'listar arquivos'
    TabOrder = 8
    OnClick = btnListarArquivosClick
  end
  object btnChanceDir: TButton
    Left = 215
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Change dir'
    TabOrder = 9
    OnClick = btnChanceDirClick
  end
  object IdFTP1: TIdFTP
    OnStatus = IdFTP1Status
    OnWork = IdFTP1Work
    OnWorkBegin = IdFTP1WorkBegin
    IPVersion = Id_IPv4
    Passive = True
    PassiveUseControlHost = True
    NATKeepAlive.UseKeepAlive = False
    NATKeepAlive.IdleTimeMS = 0
    NATKeepAlive.IntervalMS = 0
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    Left = 240
    Top = 128
  end
  object OpenDialog1: TOpenDialog
    Left = 328
    Top = 128
  end
end
