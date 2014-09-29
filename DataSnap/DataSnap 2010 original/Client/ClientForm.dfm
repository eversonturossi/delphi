object Form13: TForm13
  Left = 0
  Top = 0
  Caption = 'Form13'
  ClientHeight = 382
  ClientWidth = 705
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  DesignSize = (
    705
    382)
  PixelsPerInch = 96
  TextHeight = 12
  object Button1: TButton
    Left = 18
    Top = 66
    Width = 151
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Test Provider'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 18
    Top = 6
    Width = 151
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Test ServerMethod Class'
    TabOrder = 1
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 18
    Top = 36
    Width = 151
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Test ServerMethod Component'
    TabOrder = 2
    OnClick = Button3Click
  end
  object DBGrid1: TDBGrid
    Left = 18
    Top = 96
    Width = 681
    Height = 271
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 3
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -10
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object SQLConnection1: TSQLConnection
    DriverName = 'Datasnap'
    LoginPrompt = False
    Params.Strings = (
      'Port=212'
      'DriverUnit=DBXDataSnap'
      'HostName=192.168.50.172')
    Connected = True
    Left = 296
    Top = 8
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TDSServerModule2'
    Connected = True
    SQLConnection = SQLConnection1
    Left = 168
    Top = 136
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    FieldDefs = <
      item
        Name = 'CINT64'
        DataType = ftLargeint
      end
      item
        Name = 'CVARCHAR'
        DataType = ftWideString
        Size = 1
      end
      item
        Name = 'CSTREAM'
        DataType = ftBytes
        Size = 5000
      end>
    IndexDefs = <>
    Params = <>
    ProviderName = 'DataSnapTestData'
    RemoteServer = DSProviderConnection1
    StoreDefs = True
    Left = 288
    Top = 136
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 384
    Top = 144
  end
  object SqlServerMethod1: TSqlServerMethod
    GetMetadata = False
    Params = <
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'IncomingMessage'
        ParamType = ptInput
      end
      item
        DataType = ftWideString
        Precision = 2000
        Name = 'ReturnParameter'
        ParamType = ptResult
        Size = 2000
      end>
    SQLConnection = SQLConnection1
    ServerMethodName = 'TServerModule1.Hello'
    Left = 296
    Top = 72
  end
  object SQLConnection2: TSQLConnection
    DriverName = 'BlackfishSQL'
    LoginPrompt = False
    Params.Strings = (
      'Database=|DataDirectory|DataSnapTest'
      'Create=False')
    Left = 512
    Top = 16
  end
end
