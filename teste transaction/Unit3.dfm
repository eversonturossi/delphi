object Form3: TForm3
  Left = 0
  Top = 0
  Caption = 'Form3'
  ClientHeight = 478
  ClientWidth = 646
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
    Left = 24
    Top = 30
    Width = 31
    Height = 13
    Caption = 'codigo'
  end
  object Label2: TLabel
    Left = 142
    Top = 30
    Width = 46
    Height = 13
    Caption = 'Descricao'
  end
  object Button1: TButton
    Left = 8
    Top = 3
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Edit1: TEdit
    Left = 8
    Top = 46
    Width = 121
    Height = 21
    NumbersOnly = True
    TabOrder = 1
  end
  object Edit2: TEdit
    Left = 142
    Top = 46
    Width = 371
    Height = 21
    TabOrder = 2
    Text = 'Edit2'
  end
  object CheckBox1: TCheckBox
    Left = 416
    Top = 23
    Width = 97
    Height = 17
    Caption = 'Provocar Erro'
    TabOrder = 3
  end
  object SQLConnection1: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=database.fdb'
      'RoleName=RoleName'
      'User_Name=sysdba'
      'Password=masterkey'
      'ServerCharSet='
      'SQLDialect=3'
      'ErrorResourceFile='
      'LocaleCode=0000'
      'BlobSize=-1'
      'CommitRetain=False'
      'WaitOnLocks=True'
      'IsolationLevel=ReadCommitted'
      'Trim Char=False')
    Left = 565
    Top = 40
  end
  object SimpleDataSet1: TSimpleDataSet
    Aggregates = <>
    Connection = SQLConnection1
    DataSet.CommandText = 'select * from teste'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 563
    Top = 126
    object SimpleDataSet1CODIGO: TFMTBCDField
      FieldName = 'CODIGO'
      Required = True
      Precision = 32
    end
    object SimpleDataSet1DESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
  end
  object SimpleDataSet2: TSimpleDataSet
    Aggregates = <>
    Connection = SQLConnection1
    DataSet.CommandText = 'select * from teste2'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 564
    Top = 184
    object SimpleDataSet2CODIGO: TFMTBCDField
      FieldName = 'CODIGO'
      Required = True
      Precision = 32
    end
    object SimpleDataSet2DESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
  end
  object SimpleDataSet3: TSimpleDataSet
    Aggregates = <>
    Connection = SQLConnection1
    DataSet.CommandText = 'select * from teste3'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 564
    Top = 235
    object SimpleDataSet3CODIGO: TFMTBCDField
      FieldName = 'CODIGO'
      Required = True
      Precision = 32
    end
    object SimpleDataSet3DESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
  end
  object SimpleDataSet4: TSimpleDataSet
    Aggregates = <>
    Connection = SQLConnection1
    DataSet.CommandText = 'select * from teste4'
    DataSet.MaxBlobSize = -1
    DataSet.Params = <>
    Params = <>
    Left = 562
    Top = 292
    object SimpleDataSet4CODIGO: TFMTBCDField
      FieldName = 'CODIGO'
      Required = True
      Precision = 32
    end
    object SimpleDataSet4DESCRICAO: TWideStringField
      FieldName = 'DESCRICAO'
      Size = 100
    end
  end
end
