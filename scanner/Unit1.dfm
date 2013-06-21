object Form1: TForm1
  Left = 529
  Top = 233
  Caption = 'Form1'
  ClientHeight = 320
  ClientWidth = 426
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 42
    Height = 13
    Caption = 'Servidor:'
  end
  object lbStatus: TLabel
    Left = 208
    Top = 248
    Width = 30
    Height = 13
    Caption = 'Status'
  end
  object Label2: TLabel
    Left = 8
    Top = 56
    Width = 33
    Height = 13
    Caption = 'Portas:'
  end
  object Label3: TLabel
    Left = 64
    Top = 76
    Width = 7
    Height = 13
    Caption = 'A'
  end
  object Label4: TLabel
    Left = 8
    Top = 104
    Width = 37
    Height = 13
    Caption = 'Refresh'
  end
  object mLista: TMemo
    Left = 208
    Top = 8
    Width = 185
    Height = 233
    TabOrder = 0
  end
  object btTesta: TButton
    Left = 8
    Top = 272
    Width = 113
    Height = 25
    Caption = 'Testar por Loop'
    TabOrder = 1
    OnClick = btTestaClick
  end
  object edServer: TEdit
    Left = 8
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 2
    Text = '10.1.13.129'
  end
  object btChega: TButton
    Left = 280
    Top = 272
    Width = 113
    Height = 25
    Caption = 'Chega!'
    TabOrder = 3
    OnClick = btChegaClick
  end
  object btTimer: TButton
    Left = 144
    Top = 272
    Width = 113
    Height = 25
    Caption = 'Testar por Timer'
    TabOrder = 4
    OnClick = btTimerClick
  end
  object edPortaIni: TEdit
    Left = 8
    Top = 72
    Width = 49
    Height = 21
    TabOrder = 5
    Text = '80'
  end
  object edPortaFin: TEdit
    Left = 80
    Top = 72
    Width = 49
    Height = 21
    TabOrder = 6
    Text = '4000'
  end
  object cbSincron: TCheckBox
    Left = 8
    Top = 152
    Width = 97
    Height = 17
    Caption = 'Sincronizado'
    TabOrder = 7
  end
  object cbRefresh: TCheckBox
    Left = 8
    Top = 176
    Width = 97
    Height = 17
    Caption = 'Refresh no loop'
    Checked = True
    State = cbChecked
    TabOrder = 8
    OnClick = cbRefreshClick
  end
  object edPMT: TSpinEdit
    Left = 8
    Top = 120
    Width = 121
    Height = 22
    MaxValue = 250
    MinValue = 1
    TabOrder = 9
    Value = 1
  end
  object cbProcess: TCheckBox
    Left = 24
    Top = 200
    Width = 121
    Height = 17
    Caption = 'Processa Mensagens'
    Checked = True
    State = cbChecked
    TabOrder = 10
  end
  object cbRepaint: TCheckBox
    Left = 24
    Top = 224
    Width = 97
    Height = 17
    Caption = 'Repaint'
    TabOrder = 11
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 1
    OnTimer = Timer1Timer
    Left = 256
    Top = 48
  end
end
