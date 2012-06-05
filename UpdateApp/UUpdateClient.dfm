object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 254
  ClientWidth = 535
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 535
    Height = 41
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 11
      Width = 26
      Height = 13
      Caption = 'Host:'
    end
    object Label2: TLabel
      Left = 168
      Top = 11
      Width = 24
      Height = 13
      Caption = 'Port:'
    end
    object btnConnect: TButton
      Left = 264
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Connect'
      TabOrder = 0
      OnClick = btnConnectClick
    end
    object btnDisconnect: TButton
      Left = 352
      Top = 8
      Width = 75
      Height = 25
      Caption = 'Disconnect'
      TabOrder = 1
    end
    object edtServerHost: TEdit
      Left = 40
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 2
      Text = 'localhost'
    end
    object edtServerPort: TEdit
      Left = 198
      Top = 8
      Width = 41
      Height = 21
      NumbersOnly = True
      TabOrder = 3
      Text = '18888'
    end
  end
  object ListBox1: TListBox
    Left = 0
    Top = 41
    Width = 535
    Height = 213
    Align = alClient
    ItemHeight = 13
    TabOrder = 1
  end
  object ClientSocket1: TClientSocket
    Active = False
    ClientType = ctNonBlocking
    Port = 0
    OnConnect = ClientSocket1Connect
    OnDisconnect = ClientSocket1Disconnect
    OnRead = ClientSocket1Read
    OnError = ClientSocket1Error
    Left = 232
    Top = 136
  end
end
