object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 544
  ClientWidth = 769
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
    Width = 769
    Height = 61
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 42
      Width = 41
      Height = 13
      Caption = 'Arquivo:'
    end
    object lblArquivo: TLabel
      Left = 54
      Top = 42
      Width = 67
      Height = 13
      Caption = 'Nome Arquivo'
    end
    object Label2: TLabel
      Left = 281
      Top = 13
      Width = 41
      Height = 13
      Caption = 'Texto 1:'
    end
    object Label3: TLabel
      Left = 537
      Top = 13
      Width = 41
      Height = 13
      Caption = 'Texto 2:'
    end
    object edtTexto2: TEdit
      Left = 582
      Top = 10
      Width = 179
      Height = 21
      TabOrder = 0
    end
    object edtTexto1: TEdit
      Left = 334
      Top = 10
      Width = 187
      Height = 21
      TabOrder = 1
    end
    object Button1: TButton
      Left = 9
      Top = 8
      Width = 112
      Height = 25
      Caption = 'Selecionar Arquivo'
      TabOrder = 2
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 127
      Top = 8
      Width = 112
      Height = 25
      Caption = 'Processar'
      TabOrder = 3
      OnClick = Button2Click
    end
  end
  object ListBoxResultado: TListBox
    Left = 0
    Top = 61
    Width = 769
    Height = 483
    Align = alClient
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Courier New'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    ExplicitLeft = 56
    ExplicitTop = 120
    ExplicitWidth = 121
    ExplicitHeight = 97
  end
  object OpenDialog1: TOpenDialog
    Left = 240
    Top = 352
  end
end
