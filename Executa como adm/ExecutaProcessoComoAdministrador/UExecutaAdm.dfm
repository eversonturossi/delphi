object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 586
  ClientWidth = 1256
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
    Left = 336
    Top = 77
    Width = 22
    Height = 13
    Caption = 'ADM'
  end
  object Label2: TLabel
    Left = 512
    Top = 77
    Width = 45
    Height = 13
    Caption = 'Sem ADM'
  end
  object Button1: TButton
    Left = 40
    Top = 96
    Width = 75
    Height = 25
    Caption = 'Com ADM'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 40
    Top = 127
    Width = 75
    Height = 25
    Caption = 'Sem ADM'
    TabOrder = 1
    OnClick = Button2Click
  end
  object ButtonStart: TButton
    Left = 336
    Top = 96
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 2
    OnClick = ButtonStartClick
  end
  object ButtonStop: TButton
    Left = 336
    Top = 127
    Width = 75
    Height = 25
    Caption = 'stop'
    TabOrder = 3
    OnClick = ButtonStopClick
  end
  object Button3: TButton
    Left = 512
    Top = 96
    Width = 75
    Height = 25
    Caption = 'start'
    TabOrder = 4
    OnClick = Button3Click
  end
  object Button4: TButton
    Left = 512
    Top = 127
    Width = 75
    Height = 25
    Caption = 'stop'
    TabOrder = 5
    OnClick = Button4Click
  end
  object edtServiceName: TEdit
    Left = 336
    Top = 32
    Width = 121
    Height = 21
    TabOrder = 6
    Text = 'ServiceName'
  end
end
