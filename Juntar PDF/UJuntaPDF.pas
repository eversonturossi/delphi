unit UJuntaPDF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

const
  GS_ARG_ENCODING_LOCAL = 0;
  GS_ARG_ENCODING_UTF8 = 1;
  e_Quit = -990;

type
  TGSAPIrevision = packed record
    product: PChar;
    copyright: PChar;
    revision: LongInt;
    revisiondat: LongInt;
  end;

  PGSAPIrevision = ^TGSAPIrevision;
  Pgs_main_instance = Pointer;

  TGsapi_New_Instance = function(pinstance: Pgs_main_instance; caller_handle: Pointer): Integer; stdcall;
  TGsapi_Init_With_Args = function(pinstance: Pgs_main_instance; argc: Integer; argv: PPChar): Integer; stdcall;
  TGsapi_Exit = function(pinstance: Pgs_main_instance): Integer; stdcall;
  TGsapi_Delete_Instance = procedure(pinstance: Pgs_main_instance); stdcall;
  TGsapi_Set_Arg_Encoding = function(pinstance: Pgs_main_instance; ENCODING: Integer): Integer; stdcall;

  TJuntaPDF = class(TObject)
  private
    HandleDLL: THandle;
    gsapi_new_instance: TGsapi_New_Instance;
    gsapi_init_with_args: TGsapi_Init_With_Args;
    gsapi_exit: TGsapi_Exit;
    gsapi_delete_instance: TGsapi_Delete_Instance;
    gsapi_set_arg_encoding: TGsapi_Set_Arg_Encoding;
    function JuntaPdfs(AoutPdf: AnsiString; AFiles: array of AnsiString): Integer;
    procedure DescarregarDLL;
  public
    constructor Create;
    destructor Destroy; override;
    procedure CarregarDLL;
  end;

implementation

{ TJuntaPDF }

function TJuntaPDF.JuntaPdfs(AoutPdf: AnsiString; AFiles: array of AnsiString): Integer;
const
  GS_ARG_ENCODING_UTF8 = 1;
var
  code, code1, gsargc, i: Integer;
  gsargv: array of PAnsiChar;
  minst: PGSAPIrevision;
begin
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[high(gsargv)] := 'gs';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[high(gsargv)] := '-dBATCH';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[high(gsargv)] := '-dNOPAUSE';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[high(gsargv)] := '-q';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[high(gsargv)] := '-sDEVICE=pdfwrite';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[high(gsargv)] := PAnsiChar('-sOutputFile=' + AoutPdf);
  for i := Low(AFiles) to High(AFiles) do
  begin
    SetLength(gsargv, Length(gsargv) + 1);
    gsargv[high(gsargv)] := PAnsiChar(AFiles[i]);
  end;
  gsargc := Length(gsargv);
  code := gsapi_new_instance(@minst, nil);
  if (code < 0) then
  begin
    result := 1;
    exit;
  end;
  code := gsapi_set_arg_encoding(minst, GS_ARG_ENCODING_UTF8);
  if (code = 0) then
    code := gsapi_init_with_args(minst, gsargc, @gsargv[0]);
  code1 := gsapi_exit(minst);
  if ((code = 0) or (code = e_Quit)) then
    code := code1;
  gsapi_delete_instance(minst);
  if ((code = 0) or (code = e_Quit)) then
  begin
    result := 0;
    exit;
  end;
  result := 1;
end;

procedure TJuntaPDF.CarregarDLL;
begin
  HandleDLL := LoadLibrary('gsdll32.dll');

  if HandleDLL = 0 then
    raise Exception.Create('DLL não encontrada');

  if HandleDLL <> 0 then
  begin
    gsapi_new_instance := GetProcAddress(HandleDLL, 'gsapi_new_instance');
    gsapi_init_with_args := GetProcAddress(HandleDLL, 'gsapi_init_with_args');
    gsapi_exit := GetProcAddress(HandleDLL, 'gsapi_exit');
    gsapi_delete_instance := GetProcAddress(HandleDLL, 'gsapi_delete_instance');
    gsapi_set_arg_encoding := GetProcAddress(HandleDLL, 'gsapi_set_arg_encoding');

    if (@gsapi_new_instance = nil) then
      raise Exception.Create('DLL gsdll32.dll inválida. Método gsapi_new_instance não encontrado.');
    if (@gsapi_init_with_args = nil) then
      raise Exception.Create('DLL gsdll32.dll inválida. Método gsapi_init_with_args não encontrado.');
    if (@gsapi_exit = nil) then
      raise Exception.Create('DLL gsdll32.dll inválida. Método gsapi_exit não encontrado.');
    if (@gsapi_delete_instance = nil) then
      raise Exception.Create('DLL gsdll32.dll inválida. Método gsapi_delete_instance não encontrado.');
    if (@gsapi_set_arg_encoding = nil) then
      raise Exception.Create('DLL gsdll32.dll inválida. Método gsapi_set_arg_encoding não encontrado.');
  end;
end;

procedure TJuntaPDF.DescarregarDLL;
begin
  FreeLibrary(HandleDLL);
end;

constructor TJuntaPDF.Create;
begin
  CarregarDLL;
end;

destructor TJuntaPDF.Destroy;
begin
  DescarregarDLL;
  inherited;
end;

end.
