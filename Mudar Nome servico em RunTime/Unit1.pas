unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  UFuncoes;

const
  cParametroIdentificacao = 'id';
  cEspaco = ' ';
  cHifen = '-';

type
  TServicoAlteradoRunTime = class(TService)
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
    procedure ServiceAfterInstall(Sender: TService);
  private
    procedure ServiceLoadInfo(Sender: TObject);
    procedure ServiceChangeInfo(Sender: TObject);
  public
    function GetServiceController: TServiceController; override;
  end;

var
  ServicoAlteradoRunTime: TServicoAlteradoRunTime;

implementation

uses
  WinSvC, Registry;
{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  ServicoAlteradoRunTime.Controller(CtrlCode);
end;

function TServicoAlteradoRunTime.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TServicoAlteradoRunTime.ServiceBeforeInstall(Sender: TService);
begin
  ServiceLoadInfo(Self);
end;

procedure TServicoAlteradoRunTime.ServiceBeforeUninstall(Sender: TService);
begin
  ServiceLoadInfo(Self);
end;

procedure TServicoAlteradoRunTime.ServiceCreate(Sender: TObject);
begin
  if not(Application.Installing) then
  begin
    ServiceLoadInfo(Self);
  end;
end;

procedure TServicoAlteradoRunTime.ServiceExecute(Sender: TService);
begin
  while not(Self.Terminated) do
    ServiceThread.ProcessRequests(True);
end;

procedure TServicoAlteradoRunTime.ServiceLoadInfo(Sender: TObject);
var
  LServiceID: String;
begin
  LServiceID := getParametroAplicacao(cParametroIdentificacao);
  if (LServiceID <> EmptyStr) then
  begin
    TService(Sender).DisplayName := DisplayName + cEspaco + LServiceID;
    TService(Sender).Name := Name + LServiceID;
  end;
end;

procedure TServicoAlteradoRunTime.ServiceChangeInfo(Sender: TObject);
var
  LRegistro: TRegistry;
  LServiceID, LChaveRegistro, LImagePath: String;
begin
  LRegistro := TRegistry.Create;
  try
    LServiceID := getParametroAplicacao(cParametroIdentificacao);
    LRegistro.RootKey := HKEY_LOCAL_MACHINE;
    LChaveRegistro := 'SYSTEM\CurrentControlSet\Services\' + TService(Sender).Name;
    LImagePath := ParamStr(0);
    if (LServiceID <> EmptyStr) then
      LImagePath := ParamStr(0) + cEspaco + cHifen + cParametroIdentificacao + cEspaco + LServiceID;

    if (LRegistro.OpenKey(LChaveRegistro, True)) then
    begin
      LRegistro.WriteString('ImagePath', LImagePath);
      LRegistro.CloseKey;
    end;
  finally
    FreeAndNil(LRegistro);
  end;
end;

procedure TServicoAlteradoRunTime.ServiceAfterInstall(Sender: TService);
begin
  ServiceChangeInfo(Self);
end;

end.
