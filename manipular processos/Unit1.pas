unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, TLHelp32, PsAPI;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ListBoxProcessos: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure ListBoxProcessosDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure ListaProcesso(List: TStrings);
var { TLHelp32 }
  ProcEntry: TProcessEntry32;
  Hnd: THandle;
  Fnd: Boolean;
begin
  List.Clear;
  Hnd := CreateToolhelp32Snapshot(TH32CS_SNAPALL, 0);
  if (Hnd > -1) then
  begin
    ProcEntry.dwSize := SizeOf(TProcessEntry32);
    Fnd := Process32First(Hnd, ProcEntry);
    while (Fnd) do
    begin
      List.Add(ProcEntry.szExeFile);
      Fnd := Process32Next(Hnd, ProcEntry);
    end;
    CloseHandle(Hnd);
  end;
end;

function TerminateProcesso(sFile: string): Bool;
var { TLHelp32, PsAPI }
  { http: // www.prosige.com.br/portal/index.php?option=com_content&view=article&id=57:listando-e-finalizando-processos-do-windows&catid=30:delphi&Itemid=55 }
  verSystem: TOSVersionInfo;
  hdlSnap, hdlProcess: THandle;
  bPath, bLoop: Bool;
  peEntry: TProcessEntry32;
  arrPid: array [0 .. 1023] of DWord;
  iC: DWord;
  k, iCount: Integer;
  arrModul: array [0 .. 299] of Char;
  hdlModul: HMODULE;
begin
  Result := false;
  if ExtractFileName(sFile) = sFile then
    bPath := false
  else
    bPath := true;
  verSystem.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(verSystem);
  if verSystem.dwPlatformId = VER_PLATFORM_WIN32_WINDOWS then
  begin
    hdlSnap := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
    peEntry.dwSize := SizeOf(peEntry);
    bLoop := Process32First(hdlSnap, peEntry);
    while Integer(bLoop) > 0 do
    begin
      if bPath then
      begin
        if CompareText(peEntry.szExeFile, sFile) = 0 then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE, false, peEntry.th32ProcessID), 0);
          Result := true;
        end;
      end
      else
      begin
        if CompareText(ExtractFileName(peEntry.szExeFile), sFile) = 0 then
        begin
          TerminateProcess(OpenProcess(PROCESS_TERMINATE, false, peEntry.th32ProcessID), 0);
          Result := true;
        end;
      end;
      bLoop := Process32Next(hdlSnap, peEntry);
    end;
    CloseHandle(hdlSnap);
  end
  else
    if verSystem.dwPlatformId = VER_PLATFORM_WIN32_NT then
    begin
      EnumProcesses(@arrPid, SizeOf(arrPid), iC);
      iCount := iC div SizeOf(DWord);
      for k := 0 to Pred(iCount) do
      begin
        hdlProcess := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, false, arrPid[k]);
        if (hdlProcess > 0) then
        begin
          EnumProcessModules(hdlProcess, @hdlModul, SizeOf(hdlModul), iC);
          GetModuleFilenameEx(hdlProcess, hdlModul, arrModul, SizeOf(arrModul));
          if bPath then
          begin
            if CompareText(arrModul, sFile) = 0 then
            begin
              TerminateProcess(OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, false, arrPid[k]), 0);
              Result := true;
            end;
          end
          else
          begin
            if CompareText(ExtractFileName(arrModul), sFile) = 0 then
            begin
              TerminateProcess(OpenProcess(PROCESS_TERMINATE or PROCESS_QUERY_INFORMATION, false, arrPid[k]), 0);
              Result := true;
            end;
          end;
          CloseHandle(hdlProcess);
        end;
      end;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ListaProcesso(ListBoxProcessos.Items);
  ListBoxProcessos.Sorted := true;
end;

procedure TForm1.ListBoxProcessosDblClick(Sender: TObject);
begin
  if (ListBoxProcessos.ItemIndex >= 0) then
  begin
    TerminateProcesso(ListBoxProcessos.Items[ListBoxProcessos.ItemIndex]);
    ListBoxProcessos.DeleteSelected;
  end;
end;

end.
