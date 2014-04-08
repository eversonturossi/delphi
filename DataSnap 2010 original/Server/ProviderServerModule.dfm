object DSServerModule2: TDSServerModule2
  OldCreateOrder = False
  Height = 240
  Width = 273
  object SQLConnection1: TSQLConnection
    DriverName = 'BlackfishSQL'
    LoginPrompt = False
    Params.Strings = (
      'Database=|DataDirectory|DataSnapTest')
    Connected = True
    Left = 56
    Top = 24
  end
  object DataSnapTestData: TDataSetProvider
    DataSet = DataSnapTestDataQuery
    Left = 56
    Top = 96
  end
  object DataSnapTestDataQuery: TSQLQuery
    BeforeOpen = DataSnapTestDataQueryBeforeOpen
    MaxBlobSize = -1
    Params = <>
    SQL.Strings = (
      'select * from DATASNAP_TEST_DATA')
    SQLConnection = SQLConnection1
    Left = 56
    Top = 168
  end
end
