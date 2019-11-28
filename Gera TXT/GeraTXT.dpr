program GeraTXT;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  {System.Win.ComObj, Winapi.ActiveX,} {System.Classes,} System.SysUtils;

{ function GuidCreate38: string;
  var
  ID: TGUID;
  begin
  Result := '';
  if CoCreateGuid(ID) = S_OK then
  Result := GUIDToString(ID);
  end; }

function GetDiretorioTXT: String;
begin
  Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingBackslash(Result);
  Result := Result + 'txt\';
end;

procedure Procedure058CF6E6AD694DF8AEE4C038AA280E34;
var
  LTextFile: TextFile;
  LDiterorioTXT, LNomeArquivo: String;
begin
  LDiterorioTXT := GetDiretorioTXT();
  ForceDirectories(LDiterorioTXT);
  LNomeArquivo := ParamStr(0);
  LNomeArquivo := ExtractFileName(LNomeArquivo);
  LNomeArquivo := ChangeFileExt(LNomeArquivo, '.txt');
  AssignFile(LTextFile, LDiterorioTXT + '\' + LNomeArquivo);
  Rewrite(LTextFile);
  writeln(LTextFile, ParamStr(0));
  CloseFile(LTextFile);
end;

begin
  try
    Procedure058CF6E6AD694DF8AEE4C038AA280E34;
  except
    on E: Exception do
      writeln(E.ClassName, ': ', E.Message);
  end;

end.
