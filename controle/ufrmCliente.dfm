object frCliente: TfrCliente
  Left = 175
  Top = 110
  Caption = 'frCliente'
  ClientHeight = 426
  ClientWidth = 614
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
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 614
    Height = 134
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label3: TLabel
      Left = 353
      Top = 48
      Width = 42
      Height = 13
      Caption = 'Telefone'
    end
    object Label2: TLabel
      Left = 8
      Top = 48
      Width = 46
      Height = 13
      Caption = 'Endere'#231'o'
    end
    object Label1: TLabel
      Left = 8
      Top = 8
      Width = 28
      Height = 13
      Caption = 'Nome'
    end
    object Label4: TLabel
      Left = 353
      Top = 8
      Width = 20
      Height = 13
      Caption = 'CPF'
    end
    object edtTelefone: TEdit
      Left = 352
      Top = 64
      Width = 209
      Height = 21
      TabOrder = 0
    end
    object edtEndereco: TEdit
      Left = 8
      Top = 64
      Width = 337
      Height = 21
      TabOrder = 1
    end
    object edtNome: TEdit
      Left = 8
      Top = 24
      Width = 337
      Height = 21
      TabOrder = 2
    end
    object Button1: TButton
      Left = 386
      Top = 100
      Width = 90
      Height = 30
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 3
    end
    object btnCadastro: TButton
      Left = 10
      Top = 100
      Width = 90
      Height = 30
      Caption = 'Cadastrar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 4
      OnClick = btnCadastroClick
    end
    object Button3: TButton
      Left = 103
      Top = 100
      Width = 90
      Height = 30
      Caption = 'Limpar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 5
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 197
      Top = 100
      Width = 90
      Height = 30
      Caption = 'Localizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 6
      OnClick = Button4Click
    end
    object Button5: TButton
      Left = 291
      Top = 100
      Width = 90
      Height = 30
      Caption = 'Excluir'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'MS Sans Serif'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 7
    end
    object GroupBox1: TGroupBox
      Left = 9
      Top = 86
      Width = 553
      Height = 10
      TabOrder = 8
    end
    object edtCpf: TEdit
      Left = 352
      Top = 24
      Width = 209
      Height = 21
      TabOrder = 9
    end
  end
  object StringGrid1: TStringGrid
    Left = 0
    Top = 134
    Width = 614
    Height = 292
    Align = alClient
    Ctl3D = True
    DefaultRowHeight = 18
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goDrawFocusSelected, goColSizing, goRowSelect]
    ParentCtl3D = False
    ScrollBars = ssVertical
    TabOrder = 1
    OnClick = StringGrid1Click
    OnDrawCell = StringGrid1DrawCell
    ColWidths = (
      41
      285
      307
      160
      148)
  end
end
