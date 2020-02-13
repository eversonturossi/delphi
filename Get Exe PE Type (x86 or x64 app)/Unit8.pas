unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TPEBitness = (pebUnknown, peb16, peb32, peb64);

type
  TForm8 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation

{$R *.dfm}

function GetPEBitness(const APath: WideString): TPEBitness;
const
  IMAGE_NT_OPTIONAL_HDR32_MAGIC = $10B;
  IMAGE_NT_OPTIONAL_HDR64_MAGIC = $20B;
var
  HFile, HFileMap: THandle;
  PMapView: Pointer;
  PIDH: PImageDosHeader;
  PINTH: PImageNtHeaders;
begin
  Result := pebUnknown;
  HFile := CreateFileW(PWideChar(APath), GENERIC_READ, FILE_SHARE_READ, nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  if HFile = INVALID_HANDLE_VALUE then
    Exit;
  HFileMap := CreateFileMapping(HFile, nil, PAGE_READONLY, 0, 0, nil);
  CloseHandle(HFile);
  if HFileMap = 0 then
    Exit;
  PMapView := MapViewOfFile(HFileMap, FILE_MAP_READ, 0, 0, 0);
  CloseHandle(HFileMap);
  if PMapView = nil then
    Exit;
  PIDH := PImageDosHeader(PMapView);
  if PIDH^.e_magic = IMAGE_DOS_SIGNATURE then
  begin
    PINTH := PImageNtHeaders(PAnsiChar(PMapView) + PIDH^._lfanew);
    if PINTH^.Signature <> IMAGE_NT_SIGNATURE then
      Result := peb16
    else
      case PINTH^.OptionalHeader.Magic of
        IMAGE_NT_OPTIONAL_HDR32_MAGIC:
          Result := peb32;
        IMAGE_NT_OPTIONAL_HDR64_MAGIC:
          Result := peb64;
      end;
  end;
  UnmapViewOfFile(PMapView);
end;

procedure TForm8.Button1Click(Sender: TObject);
begin
  if (GetPEBitness(ParamStr(0)) = peb32) then
    ShowMessage('32')
  else
    ShowMessage('64');
end;

procedure TForm8.Button2Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    if (GetPEBitness(OpenDialog1.FileName) = peb32) then
      ShowMessage('32')
    else
      ShowMessage('64');
  end;
end;

end.
