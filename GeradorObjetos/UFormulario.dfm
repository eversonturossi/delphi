object Formulario: TFormulario
  Left = 0
  Top = 0
  Caption = 'Formulario'
  ClientHeight = 587
  ClientWidth = 922
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 209
    Width = 922
    Height = 5
    Cursor = crVSplit
    Align = alTop
    Color = 12829635
    ParentColor = False
    ExplicitLeft = 40
    ExplicitTop = 408
    ExplicitWidth = 1074
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 922
    Height = 49
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      922
      49)
    object ButtonGerar: TButton
      Left = 612
      Top = 4
      Width = 305
      Height = 41
      Anchors = [akTop, akRight]
      Caption = 'Gerar'
      TabOrder = 0
      OnClick = ButtonGerarClick
    end
    object RadioGroupOrigem: TRadioGroup
      Left = 328
      Top = 4
      Width = 273
      Height = 39
      Caption = 'Origem'
      Columns = 3
      Items.Strings = (
        'variavel'
        'property'
        'interface')
      TabOrder = 1
    end
    object LabeledEditNomeClasse: TLabeledEdit
      Left = 8
      Top = 22
      Width = 314
      Height = 21
      EditLabel.Width = 61
      EditLabel.Height = 13
      EditLabel.Caption = 'Nome Classe'
      TabOrder = 2
    end
  end
  object MemoOrigem: TMemo
    Left = 0
    Top = 49
    Width = 922
    Height = 160
    Align = alTop
    Lines.Strings = (
      '    procedure SetID(AValue: Int64);'
      '    function GetID: Int64;'
      ''
      '    procedure SetModelo(AValue: String);'
      '    function GetModelo: String;'
      ''
      '    procedure SetAutorizado(AValue: Boolean);'
      '    function GetAutorizado: Boolean;'
      ''
      '    procedure SetCancelado(AValue: Boolean);'
      '    function GetCancelado: Boolean;'
      ''
      '    procedure SetInutilizado(AValue: Boolean);'
      '    function GetInutilizado: Boolean;'
      ''
      '    procedure SetDenegado(AValue: Boolean);'
      '    function GetDenegado: Boolean;'
      ''
      '    procedure SetChaveAcesso(AValue: String);'
      '    function GetChaveAcesso: String;'
      ''
      '    procedure SetProtocolo(AValue: String);'
      '    function GetProtocolo: String;')
    TabOrder = 1
  end
  object MemoFonte: TMemo
    Left = 0
    Top = 214
    Width = 922
    Height = 373
    Align = alClient
    ReadOnly = True
    ScrollBars = ssBoth
    TabOrder = 2
  end
end
