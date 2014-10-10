object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 377
  ClientWidth = 444
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    444
    377)
  PixelsPerInch = 96
  TextHeight = 13
  object ButtonAbrirDataSets: TButton
    Left = 8
    Top = 8
    Width = 177
    Height = 81
    Caption = 'Abrir Datasets'
    TabOrder = 0
    OnClick = ButtonAbrirDataSetsClick
  end
  object DBGridMaster: TDBGrid
    Left = 8
    Top = 95
    Width = 428
    Height = 120
    Anchors = [akLeft, akTop, akRight]
    DataSource = dsRelatorio
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGridDetalhe: TDBGrid
    Left = 8
    Top = 221
    Width = 428
    Height = 150
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = dsItens
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object ButtonGerarRelatorio: TButton
    Left = 191
    Top = 8
    Width = 177
    Height = 81
    Caption = 'Gerar Relat'#243'rio'
    TabOrder = 3
    OnClick = ButtonGerarRelatorioClick
  end
  object Connection: TSQLConnection
    ConnectionName = 'FBConnection'
    DriverName = 'Firebird'
    GetDriverFunc = 'getSQLDriverINTERBASE'
    LibraryName = 'dbxfb.dll'
    LoginPrompt = False
    Params.Strings = (
      'DriverName=Firebird'
      'Database=database.gdb'
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
    VendorLib = 'fbclient.dll'
    Left = 48
    Top = 48
  end
  object SQLRelatorio: TSQLQuery
    MaxBlobSize = -1
    Params = <>
    SQLConnection = Connection
    Left = 168
    Top = 56
  end
  object cdsRelatorio: TClientDataSet
    Aggregates = <>
    FetchOnDemand = False
    Params = <>
    ProviderName = 'dspRelatorio'
    Left = 168
    Top = 168
  end
  object dspRelatorio: TDataSetProvider
    DataSet = SQLRelatorio
    Left = 168
    Top = 112
  end
  object dsRelatorio: TDataSource
    DataSet = cdsRelatorio
    Left = 168
    Top = 224
  end
  object dsItens: TDataSource
    Left = 376
    Top = 312
  end
end
