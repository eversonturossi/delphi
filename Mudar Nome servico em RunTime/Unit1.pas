unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs,
  UFuncoes;

type
  TService1 = class(TService)
    procedure ServiceBeforeInstall(Sender: TService);
    procedure ServiceBeforeUninstall(Sender: TService);
    procedure ServiceExecute(Sender: TService);
    procedure ServiceCreate(Sender: TObject);
  private
    procedure RegisterServices(Install, Silent: Boolean);
  public
    function GetServiceController: TServiceController; override;
  end;

var
  Service1: TService1;

implementation

uses
  WinSvC;
{$R *.DFM}

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

procedure TService1.ServiceBeforeInstall(Sender: TService);
var
  AComplemento: String;
begin
  AComplemento := getParametroAplicacao('/complemento');
  if (AComplemento <> EmptyStr) then
  begin
    DisplayName := DisplayName + ' ' + AComplemento;
    Name := Name + AComplemento;
    // SalvarStringToFile('complemento', AComplemento);
  end;
end;

procedure TService1.ServiceBeforeUninstall(Sender: TService);
var
  AComplemento: String;
begin
  AComplemento := getParametroAplicacao('/complemento');
  if (AComplemento <> EmptyStr) then
  begin
    DisplayName := DisplayName + ' ' + AComplemento;
    Name := Name + AComplemento;
  end;
end;

procedure TService1.ServiceCreate(Sender: TObject);
var
  AComplemento: String;
begin
  if not(Application.Installing) then
  begin
    AComplemento := getParametroAplicacao('/complemento');
    Name := Name + AComplemento;
  end;
end;

procedure TService1.ServiceExecute(Sender: TService);
begin
  while not(Self.Terminated) do
    ServiceThread.ProcessRequests(True);
end;

end.
