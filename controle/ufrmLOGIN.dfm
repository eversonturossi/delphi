object frLOGIN: TfrLOGIN
  Left = 306
  Top = 305
  BorderIcons = []
  BorderStyle = bsSingle
  Caption = 'frLOGIN'
  ClientHeight = 188
  ClientWidth = 472
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poDefault
  Visible = True
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 5
    Top = 2
    Width = 461
    Height = 180
    TabOrder = 0
    object Label1: TLabel
      Left = 9
      Top = 12
      Width = 57
      Height = 13
      Caption = 'USUARIO'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 9
      Top = 95
      Width = 43
      Height = 13
      Caption = 'SENHA'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Edit1: TEdit
      Left = 9
      Top = 27
      Width = 320
      Height = 56
      Ctl3D = True
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Verdana'
      Font.Style = []
      ParentCtl3D = False
      ParentFont = False
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 9
      Top = 112
      Width = 320
      Height = 56
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -40
      Font.Name = 'Verdana'
      Font.Style = []
      ParentFont = False
      PasswordChar = 'O'
      TabOrder = 1
    end
    object BitBtn1: TBitBtn
      Left = 337
      Top = 25
      Width = 114
      Height = 143
      Caption = 'OK'
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Verdana'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 2
    end
  end
end
