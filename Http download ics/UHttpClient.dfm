object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 317
  ClientWidth = 432
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
    Top = 11
    Width = 47
    Height = 13
    Caption = 'Url Down:'
  end
  object Label2: TLabel
    Left = 8
    Top = 39
    Width = 41
    Height = 13
    Caption = 'Arquivo:'
  end
  object Label3: TLabel
    Left = 208
    Top = 39
    Width = 155
    Height = 13
    Caption = 'Maximum Bandwidth (bytes/sec)'
  end
  object lblInfo: TLabel
    Left = 8
    Top = 80
    Width = 30
    Height = 13
    Caption = 'lblInfo'
  end
  object btnDownload: TButton
    Left = 8
    Top = 99
    Width = 97
    Height = 25
    Caption = 'download'
    TabOrder = 0
    OnClick = btnDownloadClick
  end
  object FileNameEdit: TEdit
    Left = 61
    Top = 36
    Width = 132
    Height = 21
    TabOrder = 1
    Text = 'NovoNome.exe'
  end
  object URLEdit: TEdit
    Left = 61
    Top = 8
    Width = 364
    Height = 21
    TabOrder = 2
    Text = '192.168.50.172:8181/mod.exe'
  end
  object BandwidthLimitEdit: TEdit
    Left = 369
    Top = 35
    Width = 56
    Height = 21
    NumbersOnly = True
    TabOrder = 3
    Text = '10000'
    OnChange = BandwidthLimitEditChange
  end
  object btnAbort: TButton
    Left = 118
    Top = 99
    Width = 75
    Height = 25
    Caption = 'Abort'
    TabOrder = 4
    OnClick = btnAbortClick
  end
  object Button1: TButton
    Left = 45
    Top = 224
    Width = 75
    Height = 25
    Caption = 'MD5'
    TabOrder = 5
    OnClick = Button1Click
  end
  object edtMd5: TEdit
    Left = 126
    Top = 226
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'edtMd5'
  end
  object ProgressBar1: TProgressBar
    Left = 8
    Top = 130
    Width = 416
    Height = 17
    TabOrder = 7
  end
  object Client: THttpCli
    LocalAddr = '0.0.0.0'
    ProxyPort = '80'
    Agent = 'Mozilla/4.0 (compatible; ICS)'
    Accept = 'image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*'
    NoCache = False
    ContentTypePost = 'application/x-www-form-urlencoded'
    MultiThreaded = False
    RequestVer = '1.0'
    FollowRelocation = True
    LocationChangeMaxCount = 5
    ServerAuth = httpAuthNone
    ProxyAuth = httpAuthNone
    BandwidthLimit = 10000
    BandwidthSampling = 1000
    Options = []
    Timeout = 30
    OnHeaderData = ClientHeaderData
    OnDocData = ClientDocData
    SocksAuthentication = socksNoAuthentication
    Left = 280
    Top = 96
  end
  object OpenDialog1: TOpenDialog
    Left = 376
    Top = 224
  end
end
