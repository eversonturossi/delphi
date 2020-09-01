unit UFuncoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;

procedure SalvarStringToFile(ANomeArquivo, AStr: String);
function LerStringFromFile(ANomeArquivo: String): String;
function getValorParametroAplicacao(ANomeParametro: String; AValorPadrao: String = ''): String;
function LocalizarParametroAplicacao(const AParametro: String; const AIgnoreCase: Boolean = True): Boolean;

implementation

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

function getValorParametroAplicacao(ANomeParametro: String; AValorPadrao: String = ''): String;
var
  I: Integer;
  LParametroAtual, LParametro: String;
begin
  Result := AValorPadrao;
  if (ParamCount > 0) then
  begin
    LParametro := AnsiUpperCase(Trim(ANomeParametro));
    for I := 1 to ParamCount do
    begin
      LParametroAtual := AnsiUpperCase(Trim(ParamStr(I)));
      if ('/' + LParametro = LParametroAtual) or ('-' + LParametro = LParametroAtual) or (LParametro = LParametroAtual) then
        if (I < ParamCount) then
          Result := Trim(ParamStr(I + 1));
    end;
  end;
end;

function LocalizarParametroAplicacao(const AParametro: String): Boolean;
begin
  Result := FindCmdLineSwitch(AParametro, ['-', '/'], True);
end;

function getParametros(ANomeParametro: String): String;
var
  I: Integer;
begin
  Result := '';

end;

end.
