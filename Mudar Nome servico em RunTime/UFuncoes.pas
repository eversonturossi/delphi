unit UFuncoes;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, SvcMgr, Dialogs;
procedure SalvarStringToFile(ANomeArquivo, AStr: String);
function LerStringFromFile(ANomeArquivo: String): String;
function getParametroAplicacao(NomeParametro: String; ValorPadrao: String = ''): String;
function LocalizarParametroAplicacao(const AParametro: String; const IgnoreCase: Boolean = True): Boolean;

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

end.
