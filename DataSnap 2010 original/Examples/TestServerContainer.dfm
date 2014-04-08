object DSServerContainer: TDSServerContainer
  OldCreateOrder = False
  Height = 205
  Width = 300
  object DSServer1: TDSServer
    AutoStart = True
    HideDSAdmin = False
    Left = 40
    Top = 16
  end
  object DSTCPServerTransport1: TDSTCPServerTransport
    Port = 212
    PoolSize = 0
    Server = DSServer1
    BufferKBSize = 32
    Filters = <>
    Left = 40
    Top = 72
  end
  object DSServerClass1: TDSServerClass
    OnGetClass = DSServerClass1GetClass
    Server = DSServer1
    LifeCycle = 'Session'
    Left = 40
    Top = 128
  end
end
