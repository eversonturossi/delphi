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

  TGSApi_New_Instance = function(pinstance: Pgs_main_instance; caller_handle: Pointer): Integer; stdcall;
  TGSApi_Init_With_Args = function(pinstance: Pgs_main_instance; argc: Integer; argv: PPChar): Integer; stdcall;
  TGSApi_Exit = function(pinstance: Pgs_main_instance): Integer; stdcall;
  TGSApi_Delete_Instance = procedure(pinstance: Pgs_main_instance); stdcall;
  TGSApi_Set_Arg_Encoding = function(pinstance: Pgs_main_instance; ENCODING: Integer): Integer; stdcall;

  TJuntaPDF = class(TObject)
  private
    FHandleDLL: THandle;
    gsapi_new_instance: TGSApi_New_Instance;
    gsapi_init_with_args: TGSApi_Init_With_Args;
    gsapi_exit: TGSApi_Exit;
    gsapi_delete_instance: TGSApi_Delete_Instance;
    gsapi_set_arg_encoding: TGSApi_Set_Arg_Encoding;
    FNomeArquivo: AnsiString;
    FArquivosJuntar: array of AnsiString;
    FArquivos: TStringList;
    function JuntaPDFs(): Integer;
    procedure CarregarDLL;
    procedure DescarregarDLL;
    procedure ConverteStringListParaArray();
  public
    constructor Create;
    destructor Destroy; override;
    procedure SelecionaArquivos;
    procedure SalvaArquivo;
    procedure AdicionarArquivos(AArquivos: TStringList);

    procedure Executa;

    property NomeArquivo: AnsiString read FNomeArquivo write FNomeArquivo;
    property Arquivos: TStringList read FArquivos write FArquivos;
  end;

implementation

uses
  UJuntaPDF.SelecionaArquivos,
  UJuntaPDF.SalvaArquivo;

{ TJuntaPDF }

function TJuntaPDF.JuntaPDFs(): Integer;
const
  GS_ARG_ENCODING_UTF8 = 1;
var
  code, code1, gsargc, I: Integer;
  gsargv: array of PAnsiChar;
  minst: PGSAPIrevision;
begin
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[High(gsargv)] := 'gs';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[High(gsargv)] := '-dBATCH';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[High(gsargv)] := '-dNOPAUSE';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[High(gsargv)] := '-q';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[High(gsargv)] := '-sDEVICE=pdfwrite';
  SetLength(gsargv, Length(gsargv) + 1);
  gsargv[High(gsargv)] := PAnsiChar('-sOutputFile=' + FNomeArquivo);
  for I := Low(FArquivosJuntar) to High(FArquivosJuntar) do
  begin
    SetLength(gsargv, Length(gsargv) + 1);
    gsargv[high(gsargv)] := PAnsiChar(FArquivosJuntar[I]);
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

procedure TJuntaPDF.SalvaArquivo;
var
  LSalvaArquivo: TJuntaPDFSalvaArquivo;
begin
  LSalvaArquivo := TJuntaPDFSalvaArquivo.Create(Self);
  try
    LSalvaArquivo.Executa;
  finally
    FreeAndNil(LSalvaArquivo);
  end;
end;

procedure TJuntaPDF.SelecionaArquivos;
var
  LSelecionaArquivos: TJuntaPDFSelecionaArquivos;
begin
  LSelecionaArquivos := TJuntaPDFSelecionaArquivos.Create(Self);
  try
    LSelecionaArquivos.Executa;
  finally
    FreeAndNil(LSelecionaArquivos);
  end;
end;

procedure TJuntaPDF.AdicionarArquivos(AArquivos: TStringList);
begin
  Self.Arquivos.AddStrings(AArquivos);
end;

procedure TJuntaPDF.CarregarDLL;
begin
  FHandleDLL := LoadLibrary('gsdll32.dll');

  if (FHandleDLL = 0) then
    raise Exception.Create('DLL gsdll32.dll não encontrada');

  if (FHandleDLL <> 0) then
  begin
    gsapi_new_instance := GetProcAddress(FHandleDLL, 'gsapi_new_instance');
    gsapi_init_with_args := GetProcAddress(FHandleDLL, 'gsapi_init_with_args');
    gsapi_exit := GetProcAddress(FHandleDLL, 'gsapi_exit');
    gsapi_delete_instance := GetProcAddress(FHandleDLL, 'gsapi_delete_instance');
    gsapi_set_arg_encoding := GetProcAddress(FHandleDLL, 'gsapi_set_arg_encoding');

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
  FreeLibrary(FHandleDLL);
end;

procedure TJuntaPDF.ConverteStringListParaArray();
var
  I: Integer;
begin
  SetLength(FArquivosJuntar, FArquivos.Count);
  for I := 0 to Pred(FArquivos.Count) do
    FArquivosJuntar[I] := AnsiString(FArquivos[I]);
end;

constructor TJuntaPDF.Create;
begin
  CarregarDLL;
  FArquivos := TStringList.Create;
  SetLength(FArquivosJuntar, 0);
end;

destructor TJuntaPDF.Destroy;
begin
  DescarregarDLL;
  FreeAndNil(FArquivos);
  SetLength(FArquivosJuntar, 0);
  inherited;
end;

procedure TJuntaPDF.Executa;
begin
  if (Self.FArquivos.Count = 0) then
    raise Exception.Create('Nenhum Arquivo selecionado');
  Self.ConverteStringListParaArray();
  Self.JuntaPDFs();
end;

end.
