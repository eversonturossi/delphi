object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 511
  ClientWidth = 796
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 104
    Top = 8
    Width = 121
    Height = 21
    TabOrder = 1
    Text = 'Edit1'
  end
  object ListBox1: TListBox
    Left = 8
    Top = 39
    Width = 780
    Height = 464
    ItemHeight = 13
    TabOrder = 2
  end
  object Ping1: TPing
    Address = 'localhost2'
    Size = 56
    Timeout = 4000
    TTL = 64
    Flags = 0
    OnDisplay = Ping1Display
    OnEchoReply = Ping1EchoReply
    Left = 256
    Top = 8
  end
end
