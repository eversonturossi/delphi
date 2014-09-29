unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComObj,
  ActiveX;

type
{$IFDEF WINVISTA_UP}
const
  IID_IFileIsInUse: TGUID = (D1: $64A1CBF0; D2: $3A1A; D3: $4461; D4: ($91, $58, $37, $69, $69, $69, $39, $50));

type
{$ALIGN 4}
  tagFILE_USAGE_TYPE = (FUT_PLAYING = 0, FUT_EDITING = 1, FUT_GENERIC = 2);
  FILE_USAGE_TYPE = tagFILE_USAGE_TYPE;
  TFileUsageType = FILE_USAGE_TYPE;

const
  OF_CAP_CANSWITCHTO = $0001;
  OF_CAP_CANCLOSE = $0002;

type
  IFileIsInUse = interface(IUnknown)
    ['{64a1cbf0-3a1a-4461-9158-376969693950}']
    function GetAppName(out ppszName: LPWSTR): HRESULT; stdcall;
    function GetUsage(out pfut: FILE_USAGE_TYPE): HRESULT; stdcall;
    function GetCapabilities(out pdwCapFlags: DWORD): HRESULT; stdcall;
    function GetSwitchToHWND(out phwnd: HWND): HRESULT; stdcall;
    function CloseFile(): HRESULT; stdcall;
  end;
{$ENDIF WINVISTA_UP}

  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
  function IsFileInUse(FileName: TFileName): Boolean;
  var
    HFileRes: HFILE;
  begin
    Result := False;
    if not FileExists(FileName) then
      Exit;
    HFileRes := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
    Result := (HFileRes = INVALID_HANDLE_VALUE);
    if not Result then
      CloseHandle(HFileRes);
  end;

begin
  if IsFileInUse('c:\Programs\delphi6\bin\delphi32.exe') then
    ShowMessage('File is in use.')
  else
    ShowMessage('File not in use.');
  // http://www.swissdelphicenter.ch/torry/showcode.php?id=104

  // verificar mais detalhes da mesma função para arquivos com atributos somente leitura
  // http://delphi.about.com/od/delphitips2009/qt/is-file-in-use.htm
end;

procedure TForm1.Button2Click(Sender: TObject);
  function EmUso(FileName: String): Boolean;
  var
    S: TStream;
  begin
    try
      Result := true;
      try
        S := TFileStream.Create(FileName, fmOpenRead or fmShareExclusive);
      except
        on EStreamError do
          Result := False; // EFOpenError
      end;
    finally
      S.Free;
    end;
  end;

begin
  if EmUso('c:\Programs\delphi6\bin\delphi32.exe') then
    ShowMessage('File is in use.')
  else
    ShowMessage('File not in use.');
  // http://www.planetadelphi.com.br/dica/7186/-verifica-se-um-determinado-arquivo-esta-aberto.-
end;

procedure TForm1.Button3Click(Sender: TObject);

  function GetFileInUseInfo(const FileName: WideString): IFileIsInUse;
  var
    ROT: IRunningObjectTable;
    mFile, enumIndex, Prefix: IMoniker;
    enumMoniker: IEnumMoniker;
    MonikerType: LongInt;
    unkInt: IInterface;
  begin
    Result := nil;

    OleCheck(GetRunningObjectTable(0, ROT));
    OleCheck(CreateFileMoniker(PWideChar(FileName), mFile));

    OleCheck(ROT.EnumRunning(enumMoniker));

    while (enumMoniker.Next(1, enumIndex, nil) = S_OK) do
    begin
      OleCheck(enumIndex.IsSystemMoniker(MonikerType));
      if MonikerType = MKSYS_FILEMONIKER then
      begin
        if Succeeded(mFile.CommonPrefixWith(enumIndex, Prefix)) and (mFile.IsEqual(Prefix) = S_OK) then
        begin
          if Succeeded(ROT.GetObject(enumIndex, unkInt)) then
          begin
            if Succeeded(unkInt.QueryInterface(IID_IFileIsInUse, Result)) then
            begin
              Result := unkInt as IFileIsInUse;
              Exit;
            end;
          end;
        end;
      end;
    end;
  end;

begin

end;

end.
