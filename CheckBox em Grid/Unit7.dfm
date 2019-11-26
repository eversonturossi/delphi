object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 763
  ClientWidth = 1304
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 1304
    Height = 249
    Align = alTop
    DataSource = DataSource1
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnDrawDataCell = DBGrid1DrawDataCell
    OnDrawColumnCell = DBGrid1DrawColumnCell
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'ID'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NOME'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ATIVO'
        Width = 50
        Visible = True
      end>
  end
  object DBCtrlGrid1: TDBCtrlGrid
    Left = 0
    Top = 249
    Width = 1304
    Height = 260
    Color = clBtnFace
    DataSource = DataSource1
    PanelHeight = 26
    PanelWidth = 1287
    ParentColor = False
    TabOrder = 1
    RowCount = 10
    SelectedColor = 13290186
    object DBText1: TDBText
      Left = 16
      Top = 4
      Width = 81
      Height = 17
      DataField = 'ID'
      DataSource = DataSource1
    end
    object DBText2: TDBText
      Left = 103
      Top = 4
      Width = 570
      Height = 17
      DataField = 'NOME'
      DataSource = DataSource1
    end
    object DBCheckBox1: TDBCheckBox
      Left = 688
      Top = 4
      Width = 121
      Height = 17
      Caption = 'Ativo'
      Color = clWhite
      Ctl3D = False
      DataField = 'ATIVO'
      DataSource = DataSource1
      ParentColor = False
      ParentCtl3D = False
      TabOrder = 0
      ValueChecked = 'S'
      ValueUnchecked = 'N'
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSetPessoa
    Left = 152
    Top = 240
  end
  object ClientDataSetPessoa: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 192
    object ClientDataSetPessoaID: TLargeintField
      FieldName = 'ID'
    end
    object ClientDataSetPessoaNOME: TStringField
      FieldName = 'NOME'
      Size = 200
    end
    object ClientDataSetPessoaATIVO: TStringField
      FieldName = 'ATIVO'
      Size = 1
    end
  end
end
