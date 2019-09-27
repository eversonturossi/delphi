unit UGUID;

interface

uses
  ComObj, ActiveX, System.SysUtils;

function GuidCreate38: string;
function GuidCreate32: string;
function GetGuid2(AGuid: String): String;

implementation

function GuidCreate38: string;
var
  ID: TGUID;
begin
  Result := '';
  if CoCreateGuid(ID) = S_OK then
    Result := GUIDToString(ID);
end;

function GuidCreate32: string;
var
  LGuid: String;
begin
  LGuid := GuidCreate38;
  LGuid := StringReplace(LGuid, '{', '', [rfReplaceAll]);
  LGuid := StringReplace(LGuid, '}', '', [rfReplaceAll]);
  LGuid := StringReplace(LGuid, '-', '', [rfReplaceAll]);
  Result := LGuid;
end;

function GetGuid2(AGuid: String): String;
begin
  Result := Copy(AGuid, 1, 2);
end;

end.
