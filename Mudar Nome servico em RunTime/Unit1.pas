unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  UFuncoes, OverbyteIcsWndControl, OverbyteIcsHttpSrv;

const
  cParametroInstancia = 'instancia';

type
  TServicoAlteradoRunTime = class(TService)
    HttpServer1: THttpServer;
    procedure ServiceExecute(Sender: TService);
    procedure ServiceAfterInstall(Sender: TService);
    procedure ServiceStart(Sender: TService; var Started: Boolean);
  private
    FInstancia: String;
    procedure ServiceLoadInfo(Sender: TObject);
    procedure ServiceSaveInfo(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
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

constructor TServicoAlteradoRunTime.Create(AOwner: TComponent);
begin
  inherited;
  FInstancia := getParametroAplicacao(cParametroInstancia);
  ServiceLoadInfo(Self);
end;

function TServicoAlteradoRunTime.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TServicoAlteradoRunTime.ServiceAfterInstall(Sender: TService);
begin
  if not(FInstancia.IsEmpty) then
    ServiceSaveInfo(Sender);
end;

procedure TServicoAlteradoRunTime.ServiceExecute(Sender: TService);
begin
  while not(Self.Terminated) do
    ServiceThread.ProcessRequests(True);
end;

procedure TServicoAlteradoRunTime.ServiceLoadInfo(Sender: TObject);
begin
  if not(FInstancia.IsEmpty) then
  begin
    TService(Sender).DisplayName := Format('%S %S', [DisplayName, FInstancia]);
    TService(Sender).Name := Name + FInstancia;
  end;
end;

procedure TServicoAlteradoRunTime.ServiceSaveInfo(Sender: TObject);
var
  LRegistro: TRegistry;
  LChaveRegistro, LImagePath: String;
begin
  LRegistro := TRegistry.Create;
  try
    FInstancia := getValorParametroAplicacao(cParametroInstancia);
    LRegistro.RootKey := HKEY_LOCAL_MACHINE;
    LChaveRegistro := 'SYSTEM\CurrentControlSet\Services\' + TService(Sender).Name;
    LImagePath := QuotedStr(ParamStr(0));

    { if not(FInstancia.IsEmpty) then
      LImagePath := Format('%S -%S %S', [LImagePath, cParametroInstancia, FInstancia]); }

    if (ParamCount > 1) then
      LImagePath := LImagePath + ' ' + getParametros();

    if (LRegistro.OpenKey(LChaveRegistro, True)) then
    begin
      LRegistro.WriteString('ImagePath', LImagePath);
      LRegistro.CloseKey;
    end;
  finally
    FreeAndNil(LRegistro);
  end;
end;

procedure TServicoAlteradoRunTime.ServiceStart(Sender: TService; var Started: Boolean);
begin
  HttpServer1.DocDir := ExtractFileDir(ParamStr(0));
  HttpServer1.Start();
end;

end.
