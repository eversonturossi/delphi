object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 514
  ClientWidth = 934
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    934
    514)
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 5
    Width = 22
    Height = 13
    Caption = 'Host'
  end
  object Usuario: TLabel
    Left = 295
    Top = 5
    Width = 36
    Height = 13
    Caption = 'Usuario'
  end
  object Label3: TLabel
    Left = 422
    Top = 5
    Width = 30
    Height = 13
    Caption = 'Senha'
  end
  object Label4: TLabel
    Left = 247
    Top = 5
    Width = 26
    Height = 13
    Caption = 'Porta'
  end
  object LabelTempo: TLabel
    Left = 882
    Top = 24
    Width = 44
    Height = 13
    Anchors = [akTop, akRight]
    Caption = '00:00:00'
  end
  object EditHost: TEdit
    Left = 8
    Top = 21
    Width = 233
    Height = 21
    TabOrder = 0
  end
  object EditUsuario: TEdit
    Left = 295
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 2
  end
  object EditSenha: TEdit
    Left = 422
    Top = 21
    Width = 121
    Height = 21
    TabOrder = 3
  end
  object EditPorta: TEdit
    Left = 247
    Top = 21
    Width = 42
    Height = 21
    TabOrder = 1
    Text = '21'
  end
  object ButtonConectar: TButton
    Left = 549
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Conectar'
    TabOrder = 5
    OnClick = ButtonConectarClick
  end
  object ButtonNoop: TButton
    Left = 630
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Noop'
    TabOrder = 6
    OnClick = ButtonNoopClick
  end
  object ListBox1: TListBox
    Left = 8
    Top = 50
    Width = 918
    Height = 456
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 4
  end
  object ButtonDesconectar: TButton
    Left = 711
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Desconectar'
    TabOrder = 7
    OnClick = ButtonDesconectarClick
  end
  object ButtonListar: TButton
    Left = 792
    Top = 19
    Width = 75
    Height = 25
    Caption = 'Listar'
    TabOrder = 8
    OnClick = ButtonListarClick
  end
  object IdFTP1: TIdFTP
    OnStatus = IdFTP1Status
    OnDisconnected = IdFTP1Disconnected
    OnConnected = IdFTP1Connected
    IPVersion = Id_IPv4
    AutoLogin = True
    ProxySettings.ProxyType = fpcmNone
    ProxySettings.Port = 0
    OnBannerBeforeLogin = IdFTP1BannerBeforeLogin
    OnBannerAfterLogin = IdFTP1BannerAfterLogin
    OnBannerWarning = IdFTP1BannerWarning
    Left = 432
    Top = 104
  end
  object TimerTempo: TTimer
    Enabled = False
    OnTimer = TimerTempoTimer
    Left = 632
    Top = 96
  end
end
