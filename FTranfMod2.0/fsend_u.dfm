object MainSend: TMainSend
  Left = 601
  Top = 210
  BorderStyle = bsSingle
  Caption = 'Enviar arquivo'
  ClientHeight = 274
  ClientWidth = 200
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label3: TLabel
    Left = 8
    Top = 232
    Width = 32
    Height = 13
    Caption = 'Label3'
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 185
    Height = 105
    Caption = 'Conex'#227'o'
    TabOrder = 0
    object LabeledEdit1: TLabeledEdit
      Left = 8
      Top = 40
      Width = 169
      Height = 21
      EditLabel.Width = 46
      EditLabel.Height = 13
      EditLabel.Caption = 'Endere'#231'o'
      TabOrder = 0
      Text = 'p4'
    end
    object btnConectar: TButton
      Left = 104
      Top = 72
      Width = 75
      Height = 25
      Caption = 'Conectar'
      TabOrder = 1
      OnClick = btnConectarClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 120
    Width = 185
    Height = 97
    Caption = 'Envio'
    TabOrder = 1
    object Label1: TLabel
      Left = 8
      Top = 24
      Width = 47
      Height = 13
      Caption = 'Progresso'
    end
    object BarraProgresso: TGauge
      Left = 8
      Top = 40
      Width = 169
      Height = 17
      Progress = 0
    end
    object btnEnviar: TButton
      Left = 104
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Enviar'
      Enabled = False
      TabOrder = 0
      OnClick = btnEnviarClick
    end
    object btnCancelar: TButton
      Left = 24
      Top = 64
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object CSocketStream: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 6660
    OnConnect = CSocketStreamConnect
    OnDisconnect = CSocketStreamDisconnect
    OnError = CSocketStreamError
    Left = 16
    Top = 80
  end
  object CSocketText: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 6661
    OnConnect = CSocketTextConnect
    OnDisconnect = CSocketTextDisconnect
    OnError = CSocketTextError
    Left = 48
    Top = 80
  end
  object OpenDialog: TOpenDialog
    Filter = 'Qualquer tipo de arquivo (*.*)|*.*'
    Title = 'Selecione o arquivo a ser enviado'
    Left = 80
    Top = 80
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = Timer1Timer
    Left = 112
    Top = 120
  end
end
