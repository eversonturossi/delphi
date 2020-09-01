object ServicoAlteradoRunTime: TServicoAlteradoRunTime
  OldCreateOrder = False
  DisplayName = 'AAA Servico Alterado Run Time'
  AfterInstall = ServiceAfterInstall
  OnExecute = ServiceExecute
  OnStart = ServiceStart
  Height = 548
  Width = 773
  object HttpServer1: THttpServer
    ListenBacklog = 15
    MultiListenSockets = <>
    Port = '8585'
    Addr = '0.0.0.0'
    SocketFamily = sfIPv4
    MaxClients = 0
    DocDir = 'c:\wwwroot'
    TemplateDir = 'c:\wwwroot\templates'
    DefaultDoc = 'index.html'
    LingerOnOff = wsLingerNoSet
    LingerTimeout = 0
    Options = []
    KeepAliveTimeSec = 10
    KeepAliveTimeXferSec = 300
    MaxRequestsKeepAlive = 100
    SizeCompressMin = 5000
    SizeCompressMax = 5000000
    MaxBlkSize = 8192
    BandwidthLimit = 0
    BandwidthSampling = 1000
    ServerHeader = 'Server: ICS-HttpServer-8.64'
    AuthTypes = []
    AuthRealm = 'ics'
    SocketErrs = wsErrTech
    ExclusiveAddr = True
    Left = 200
    Top = 120
  end
end
