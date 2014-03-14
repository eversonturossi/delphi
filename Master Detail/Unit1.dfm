object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 674
  ClientWidth = 1064
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    1064
    674)
  PixelsPerInch = 96
  TextHeight = 13
  object dbgClientes: TDBGrid
    Left = 8
    Top = 39
    Width = 1048
    Height = 314
    Anchors = [akLeft, akTop, akRight]
    DataSource = dtsClientes
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object dbgVendas: TDBGrid
    Left = 8
    Top = 401
    Width = 1048
    Height = 265
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dtsVendas
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBNavigator1: TDBNavigator
    Left = 8
    Top = 8
    Width = 240
    Height = 25
    DataSource = dtsClientes
    Ctl3D = False
    ParentCtl3D = False
    ConfirmDelete = False
    TabOrder = 2
  end
  object DBNavigator2: TDBNavigator
    Left = 8
    Top = 370
    Width = 240
    Height = 25
    DataSource = dtsVendas
    Ctl3D = False
    ParentCtl3D = False
    ConfirmDelete = False
    TabOrder = 3
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      
        'Database=C:\Program Files\Firebird\Firebird_2_5\examples\empbuil' +
        'd\EMPLOYEE.FDB')
    Left = 32
    Top = 24
  end
  object qryClientes: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from CUSTOMER')
    SQLConnection = SQLConnection1
    Left = 40
    Top = 88
  end
  object qryVendas: TSQLQuery
    DataSource = dtsMaster
    MaxBlobSize = -1
    Params = <
      item
        DataType = ftInteger
        Name = 'CUST_NO'
        ParamType = ptInput
      end>
    SQL.Strings = (
      'select * from SALES where CUST_NO = :CUST_NO')
    SQLConnection = SQLConnection1
    Left = 32
    Top = 328
  end
  object dspMaster: TDataSetProvider
    DataSet = qryClientes
    Options = [poCascadeDeletes, poCascadeUpdates, poUseQuoteChar]
    Left = 40
    Top = 144
  end
  object dtsMaster: TDataSource
    DataSet = qryClientes
    Left = 104
    Top = 96
  end
  object cdsClientes: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'dspMaster'
    Left = 32
    Top = 200
    object cdsClientesCUST_NO: TIntegerField
      FieldName = 'CUST_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsClientesCUSTOMER: TStringField
      FieldName = 'CUSTOMER'
      Required = True
      Size = 25
    end
    object cdsClientesCONTACT_FIRST: TStringField
      FieldName = 'CONTACT_FIRST'
      Size = 15
    end
    object cdsClientesCONTACT_LAST: TStringField
      FieldName = 'CONTACT_LAST'
    end
    object cdsClientesPHONE_NO: TStringField
      FieldName = 'PHONE_NO'
    end
    object cdsClientesADDRESS_LINE1: TStringField
      FieldName = 'ADDRESS_LINE1'
      Size = 30
    end
    object cdsClientesADDRESS_LINE2: TStringField
      FieldName = 'ADDRESS_LINE2'
      Size = 30
    end
    object cdsClientesCITY: TStringField
      FieldName = 'CITY'
      Size = 25
    end
    object cdsClientesSTATE_PROVINCE: TStringField
      FieldName = 'STATE_PROVINCE'
      Size = 15
    end
    object cdsClientesCOUNTRY: TStringField
      FieldName = 'COUNTRY'
      Size = 15
    end
    object cdsClientesPOSTAL_CODE: TStringField
      FieldName = 'POSTAL_CODE'
      Size = 12
    end
    object cdsClientesON_HOLD: TStringField
      FieldName = 'ON_HOLD'
      FixedChar = True
      Size = 1
    end
    object cdsClientesqryVendas: TDataSetField
      FieldName = 'qryVendas'
    end
  end
  object cdsVendas: TClientDataSet
    Aggregates = <>
    DataSetField = cdsClientesqryVendas
    Params = <>
    Left = 32
    Top = 400
    object cdsVendasPO_NUMBER: TStringField
      FieldName = 'PO_NUMBER'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
      FixedChar = True
      Size = 8
    end
    object cdsVendasCUST_NO: TIntegerField
      FieldName = 'CUST_NO'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object cdsVendasSALES_REP: TSmallintField
      FieldName = 'SALES_REP'
    end
    object cdsVendasORDER_STATUS: TStringField
      FieldName = 'ORDER_STATUS'
      Required = True
      Size = 7
    end
    object cdsVendasORDER_DATE: TSQLTimeStampField
      FieldName = 'ORDER_DATE'
      Required = True
    end
    object cdsVendasSHIP_DATE: TSQLTimeStampField
      FieldName = 'SHIP_DATE'
    end
    object cdsVendasDATE_NEEDED: TSQLTimeStampField
      FieldName = 'DATE_NEEDED'
    end
    object cdsVendasPAID: TStringField
      FieldName = 'PAID'
      FixedChar = True
      Size = 1
    end
    object cdsVendasQTY_ORDERED: TIntegerField
      FieldName = 'QTY_ORDERED'
      Required = True
    end
    object cdsVendasTOTAL_VALUE: TFMTBCDField
      FieldName = 'TOTAL_VALUE'
      Required = True
      Precision = 9
      Size = 2
    end
    object cdsVendasDISCOUNT: TSingleField
      FieldName = 'DISCOUNT'
      Required = True
    end
    object cdsVendasITEM_TYPE: TStringField
      FieldName = 'ITEM_TYPE'
      Required = True
      Size = 12
    end
    object cdsVendasAGED: TFMTBCDField
      FieldName = 'AGED'
      Precision = 15
      Size = 9
    end
  end
  object dtsClientes: TDataSource
    DataSet = cdsClientes
    Left = 744
    Top = 64
  end
  object dtsVendas: TDataSource
    DataSet = cdsVendas
    Left = 752
    Top = 136
  end
end
