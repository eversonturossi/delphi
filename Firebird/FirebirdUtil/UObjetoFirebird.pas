{
  SELECT RDB$GET_CONTEXT('SYSTEM', 'ENGINE_VERSION')
  FROM RDB$DATABASE;
}

unit UObjetoFirebird;

interface

uses
  Windows, Classes, SysUtils, Registry, Tlhelp32, PsAPI;

type
  TFileUtil = class(TObject)
  private
  public
    class function getPathProcesso(exeFileName: String): String; static;
    class function getVersaoExecutavelExterno(Executavel: String): Double; static;
  end;

  TFirebirdUtil = class(TObject)
  private
  public
    class function getVersaoFirebird(): Double; static;
    class function getPathFirebird(): String; static;
    class function isFirebird21(): Boolean; static;
    class function isFirebird25(): Boolean; static;
    class function isFirebird30(): Boolean; static;
  end;

implementation

{ TFileUtil }

class function TFileUtil.getPathProcesso(exeFileName: String): String;
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32w;

  function GetPathFromPID(const PID: cardinal): String;
  var
    hProcess: THandle;
    Path: array [0 .. MAX_PATH - 1] of char;
  begin
    hProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, PID);
    if hProcess <> 0 Then
      try
        if GetModuleFileNameEx(hProcess, 0, Path, MAX_PATH) = 0 Then
          RaiseLastOSError;
        Result := Path;
      finally
        CloseHandle(hProcess)
      end
    else
      RaiseLastOSError;
  end;

begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  Result := '';
  while Integer(ContinueLoop) <> 0 do
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase(exeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase(exeFileName))) Then
    begin
      Result := GetPathFromPID(FProcessEntry32.th32ProcessID); // Essa linha nao funciona
    end;
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
  end;
  CloseHandle(FSnapshotHandle);
end;

class function TFileUtil.getVersaoExecutavelExterno(Executavel: String): Double;
var
  VerInfoSize: DWORD;
  VerInfo: Pointer;
  VerValueSize: DWORD;
  VerValue: PVSFixedFileInfo;
  Dummy: DWORD;
  VersaoStr: String;
begin
  Result := 0;
  VersaoStr := '';
  VerInfoSize := GetFileVersionInfoSize(PChar(Executavel), Dummy);
  if VerInfoSize = 0 Then
    Exit;
  GetMem(VerInfo, VerInfoSize);
  GetFileVersionInfo(PChar(Executavel), 0, VerInfoSize, VerInfo);
  VerQueryValue(VerInfo, '\', Pointer(VerValue), VerValueSize);
  with VerValue^ do
  begin
    VersaoStr := IntToStr(dwFileVersionMS shr 16);
    VersaoStr := VersaoStr + ',' + IntToStr(dwFileVersionMS and $FFFF);
    VersaoStr := VersaoStr + IntToStr(dwFileVersionLS shr 16);
    VersaoStr := VersaoStr + IntToStr(dwFileVersionLS and $FFFF);
  end;
  FreeMem(VerInfo, VerInfoSize);
  Result := StrToFloatDef(VersaoStr, 0);
end;

{ TFirebirdUtil }

class function TFirebirdUtil.getPathFirebird(): String;
begin
  Result := TFileUtil.getPathProcesso('fbserver.exe');
  if (Result = EmptyStr) Then
    Result := TFileUtil.getPathProcesso('fbguard.exe');
end;

class function TFirebirdUtil.getVersaoFirebird(): Double;
var
  PathExecutavelFB: String;
begin
  Result := 0;
  PathExecutavelFB := TFirebirdUtil.getPathFirebird;
  if (PathExecutavelFB <> EmptyStr) Then
    Result := TFileUtil.getVersaoExecutavelExterno(PathExecutavelFB);
end;

class function TFirebirdUtil.isFirebird21(): Boolean;
var
  Versao: Double;
begin
  Versao := TFirebirdUtil.getVersaoFirebird;
  Result := (Versao >= 2.1) and (Versao < 2.2);
end;

class function TFirebirdUtil.isFirebird25(): Boolean;
var
  Versao: Double;
begin
  Versao := TFirebirdUtil.getVersaoFirebird;
  Result := (Versao >= 2.5) and (Versao < 2.6);
end;

class function TFirebirdUtil.isFirebird30(): Boolean;
var
  Versao: Double;
begin
  Versao := TFirebirdUtil.getVersaoFirebird;
  Result := (Versao >= 3.0) and (Versao < 3.1);
end;

end.
