unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

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

procedure SalvarStringToFile(ANomeArquivo, AStr: String);
var
  StrList: TStringList;
begin
  try
    StrList := TStringList.Create;
    StrList.Add(AStr);
    StrList.SaveToFile(ANomeArquivo);
  finally
    FreeAndNil(StrList);
  end;
end;

function LerStringFromFile(ANomeArquivo: String): String;
var
  StrList: TStringList;
begin
  StrList := TStringList.Create;
  try
    Result := '';
    if (FileExists(ANomeArquivo)) then
      StrList.LoadFromFile(ANomeArquivo);
    Result := Trim(StrList.Text);
  finally
    FreeAndNil(StrList);
  end;
end;

procedure ServiceController(CtrlCode: DWord); stdcall;
begin
  Service1.Controller(CtrlCode);
end;

function TService1.GetServiceController: TServiceController;
begin
  Result := ServiceController;
end;

function getParametroAplicacao(NomeParametro: String; ValorPadrao: String = ''): String;
var
  I: Integer;
  AParametroAtual, AParametro: String;
begin
  Result := ValorPadrao;
  if (ParamCount > 0) then
  begin
    AParametro := AnsiUpperCase(Trim(NomeParametro));
    for I := 1 to ParamCount do
    begin
      AParametroAtual := AnsiUpperCase(Trim(ParamStr(I)));
      if ('/' + AParametro = AParametroAtual) or ('-' + AParametro = AParametroAtual) or (AParametro = AParametroAtual) then
        if (I < ParamCount) then
          Result := Trim(ParamStr(I + 1));
    end;
  end;
end;

function LocalizarParametroAplicacao(const AParametro: String; const IgnoreCase: Boolean = True): Boolean;
const
  cSwitchChars = ['/', '-'];
var
  I: Integer;
  S: String;
begin
  Result := False;
  for I := 1 to ParamCount do
  begin
    S := ParamStr(I);
    if (S[1] in cSwitchChars) then
      if IgnoreCase then
        if (AnsiCompareText(Copy(S, 2, Maxint), AParametro) = 0) then
          Result := True;
  end;
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
    //SalvarStringToFile('complemento', AComplemento);
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
