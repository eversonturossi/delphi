unit UServiceDelphi;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

type
  TsrvPrincipal = class(TService)
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceAfterUninstall(Sender: TService);
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceContinue(Sender: TService; var Continued: Boolean);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceDestroy(Sender: TObject);
    procedure ServiceExecute(Sender: TService);
    procedure ServicePause(Sender: TService; var Paused: Boolean);
    procedure ServiceShutdown(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
    procedure ServiceStop(Sender: TService; var Stopped: Boolean);
  private
  public
    function GetServiceController: TServiceController; override;
  end;

var
  srvPrincipal: TsrvPrincipal;

implementation

{$R *.DFM}

procedure doSaveLog(Msg: String);
var
  loLista: Tstringlist;
begin
  try
    loLista := Tstringlist.create;
    try
      if FileExists('c:\log.log') then
        loLista.LoadFromFile('c:\log.log');
      loLista.add(TimeToStr(now) + ': ' + Msg);
    except
      on E: Exception do
        loLista.add(TimeToStr(now) + ': erro ' + E.Message);
    end;
  finally
    loLista.SaveToFile('c:\log.log');
    loLista.free;
  end;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  srvPrincipal.Controller(CtrlCode);
end;

function TsrvPrincipal.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TsrvPrincipal.ServiceAfterInstall(Sender: TService);
begin
  doSaveLog('ServiceAfterInstall');
end;

procedure TsrvPrincipal.ServiceAfterUninstall(Sender: TService);
begin
  doSaveLog('ServiceAfterUninstall');
end;

procedure TsrvPrincipal.ServiceBeforeInstall(Sender: TService);
begin
  doSaveLog('ServiceBeforeInstall');
end;

procedure TsrvPrincipal.ServiceBeforeUninstall(Sender: TService);
begin
  doSaveLog('ServiceBeforeUninstall');
end;

procedure TsrvPrincipal.ServiceContinue(Sender: TService;
  var Continued: Boolean);
begin
  doSaveLog('ServiceContinue');
end;

procedure TsrvPrincipal.ServiceCreate(Sender: TObject);
begin
  doSaveLog('ServiceCreate');
end;

procedure TsrvPrincipal.ServiceDestroy(Sender: TObject);
begin
  doSaveLog('ServiceDestroy');
end;

procedure TsrvPrincipal.ServiceExecute(Sender: TService);
begin
  doSaveLog('ServiceExecute');
  while not self.Terminated do
    ServiceThread.ProcessRequests(true);
end;

procedure TsrvPrincipal.ServicePause(Sender: TService; var Paused: Boolean);
begin
  doSaveLog('ServicePause');
end;

procedure TsrvPrincipal.ServiceShutdown(Sender: TService);
begin
  doSaveLog('ServiceShutdown');
end;

procedure TsrvPrincipal.ServiceStart(Sender: TService; var Started: Boolean);
begin
  doSaveLog('ServiceStart');
end;

procedure TsrvPrincipal.ServiceStop(Sender: TService; var Stopped: Boolean);
begin
  doSaveLog('ServiceStop');
end;

// Leia mais em: Criando um Windows Service http://www.devmedia.com.br/criando-um-windows-service/7867#ixzz1wyo1XkDh

end.
