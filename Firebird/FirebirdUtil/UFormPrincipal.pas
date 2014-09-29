unit UFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UObjetoFirebird, Tlhelp32, psapi;

type
  TFormPrincipal = class(TForm)
    EditVersaoFirebird: TEdit;
    ButtonGetVersaoFirebird: TButton;
    OpenDialog1: TOpenDialog;
    CheckBox21: TCheckBox;
    CheckBox25: TCheckBox;
    CheckBox30: TCheckBox;
    EditPathFirebird: TEdit;
    ButtonGetPathFirebird: TButton;
    ListBoxProcessos: TListBox;
    ButtonProcessosRodandoComPath: TButton;
    procedure ButtonGetVersaoFirebirdClick(Sender: TObject);
    procedure ButtonGetPathFirebirdClick(Sender: TObject);
    procedure ButtonProcessosRodandoComPathClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.ButtonGetVersaoFirebirdClick(Sender: TObject);
var
  Versao: double;
begin
  Versao := TFirebirdUtil.getVersaoFirebird;
  EditVersaoFirebird.Text := FloatToStr(Versao);
  CheckBox21.Checked := TFirebirdUtil.isFirebird21();
  CheckBox25.Checked := TFirebirdUtil.isFirebird25();
  CheckBox30.Checked := TFirebirdUtil.isFirebird30();
end;

procedure TFormPrincipal.ButtonGetPathFirebirdClick(Sender: TObject);
begin
  EditPathFirebird.Text := TFirebirdUtil.getPathFirebird;
  if (EditPathFirebird.Text = '') then
    EditPathFirebird.Text := TFirebirdUtil.getPathFirebird;
end;

procedure TFormPrincipal.ButtonProcessosRodandoComPathClick(Sender: TObject);
  function RunningProcessesList(const List: TStrings; FullPath: Boolean): Boolean;
    function BuildListTH: Boolean;
    var
      SnapProcHandle: THandle;
      ProcEntry: TProcessEntry32;
      NextProc: Boolean;
      FileName: string;
      Handle: THandle;
    begin
      SnapProcHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
      Result := (SnapProcHandle <> INVALID_HANDLE_VALUE);
      if Result then
        try
          ProcEntry.dwSize := SizeOf(ProcEntry);
          NextProc := Process32First(SnapProcHandle, ProcEntry);
          while NextProc do
          begin
            if ProcEntry.th32ProcessID = 0 then
            begin
              FileName := 'System Idle Process';
            end
            else
            begin
              FileName := ProcEntry.szExeFile;
              if not FullPath then
              begin
                FileName := ExtractFileName(FileName);
              end
              else
              begin
                Handle := OpenProcess(PROCESS_QUERY_INFORMATION or PROCESS_VM_READ, False, ProcEntry.th32ProcessID);
                if Handle <> 0 then
                  try
                    SetLength(FileName, MAX_PATH);
                    if GetModuleFileNameEx(Handle, 0, PChar(FileName), MAX_PATH) > 0 then
                      SetLength(FileName, StrLen(PChar(FileName)))
                    else
                      FileName := '';
                  finally
                    CloseHandle(Handle);
                  end;
              end;
            end;
            List.AddObject(FileName, Pointer(ProcEntry.th32ProcessID));
            NextProc := Process32Next(SnapProcHandle, ProcEntry);
          end;
        finally
          CloseHandle(SnapProcHandle);
        end;
    end;

  begin
    Result := BuildListTH;
  end;

begin
  RunningProcessesList(ListBoxProcessos.Items, true);
end;

end.
