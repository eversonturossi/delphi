object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'Firebird MetaData'
  ClientHeight = 710
  ClientWidth = 1096
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1096
    Height = 89
    Align = alTop
    TabOrder = 0
    DesignSize = (
      1096
      89)
    object ButtonSelecionaDB: TButton
      Left = 1063
      Top = 20
      Width = 28
      Height = 21
      Anchors = [akTop, akRight]
      Caption = '...'
      TabOrder = 0
      OnClick = ButtonSelecionaDBClick
    end
    object LabeledEditDB: TLabeledEdit
      Left = 7
      Top = 20
      Width = 1050
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      EditLabel.Width = 13
      EditLabel.Height = 13
      EditLabel.Caption = 'DB'
      TabOrder = 1
    end
    object ButtonListarTabela: TButton
      Left = 407
      Top = 47
      Width = 114
      Height = 25
      Caption = 'Listar Tabelas'
      TabOrder = 2
      OnClick = ButtonListarTabelaClick
    end
    object ButtonListarTrigger: TButton
      Left = 7
      Top = 47
      Width = 130
      Height = 25
      Caption = 'Listar Triggers'
      TabOrder = 3
      OnClick = ButtonListarTriggerClick
    end
    object ButtonListarView: TButton
      Left = 143
      Top = 47
      Width = 130
      Height = 25
      Caption = 'Listar Views'
      TabOrder = 4
      OnClick = ButtonListarViewClick
    end
    object ButtonListarProcedure: TButton
      Left = 279
      Top = 47
      Width = 122
      Height = 25
      Caption = 'Listar Procedures'
      TabOrder = 5
      OnClick = ButtonListarProcedureClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 691
    Width = 1096
    Height = 19
    Panels = <
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 89
    Width = 1096
    Height = 602
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 2
    object TabSheet1: TTabSheet
      Caption = 'Listagem'
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 1088
        Height = 574
        Align = alClient
        DataSource = DataSource1
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Registro'
      ImageIndex = 1
      DesignSize = (
        1088
        574)
      object DBEdit1: TDBEdit
        Left = 12
        Top = 3
        Width = 1061
        Height = 21
        Anchors = [akLeft, akTop, akRight]
        DataField = 'NAME'
        DataSource = DataSource1
        TabOrder = 0
      end
      object DBMemo1: TDBMemo
        Left = 12
        Top = 30
        Width = 1061
        Height = 531
        Anchors = [akLeft, akTop, akRight, akBottom]
        DataField = 'SOURCE'
        DataSource = DataSource1
        TabOrder = 1
      end
    end
  end
  object FDQuery1: TFDQuery
    AfterOpen = FDQuery1AfterOpen
    AfterScroll = FDQuery1AfterScroll
    Connection = FDConnection
    Left = 72
    Top = 304
  end
  object DataSource1: TDataSource
    DataSet = FDQuery1
    Left = 72
    Top = 368
  end
  object FDConnection: TFDConnection
    LoginPrompt = False
    Left = 72
    Top = 240
  end
  object OpenDialogDB: TOpenDialog
    Left = 72
    Top = 448
  end
  object FDPhysFBDriverLink1: TFDPhysFBDriverLink
    Left = 72
    Top = 512
  end
end
