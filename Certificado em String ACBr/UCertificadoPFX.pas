unit UCertificadoPFX;

interface

uses
  Winapi.Windows, System.SysUtils, System.Classes,
  synautil, synacode,
  ACBrDFeSSL,
  ACBrBase, ACBrDFe, ACBrNFe;

type
  TCertificadoPFX = class(TObject)
  private
    FACBrNFe: TACBrNFe;
    FCNPJ: String;
    FDataVencimento: TDateTime;
    FArquivo: String;
    FNumeroSerie: String;
    FSenha: String;
    FDadosPFX: AnsiString;
    FDadosPFXBase64: AnsiString;
    property ACBrNFe: TACBrNFe read FACBrNFe;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    procedure SelecionaArquivo;
    procedure CarregarCertificado;

    property Arquivo: String read FArquivo write FArquivo;
    property Senha: String read FSenha write FSenha;
    property DadosPFX: AnsiString read FDadosPFX;
    property DadosPFXBase64: AnsiString read FDadosPFXBase64;

    property DataVencimento: TDateTime read FDataVencimento;
    property CNPJ: String read FCNPJ;
    property NumeroSerie: String read FNumeroSerie;
  end;

implementation

uses
  Vcl.Dialogs;

function GetCertificado(APFXFile: String): AnsiString;
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(APFXFile, fmOpenRead);
  try
    Result := ReadStrFromStream(FS, FS.Size);
  finally
    FS.Free;
  end;
end;

{ TCertificadoPFX }

procedure TCertificadoPFX.Clear;
begin
  FArquivo := '';
  FSenha := '';
  FDadosPFX := '';
  FDadosPFXBase64 := '';

  FCNPJ := '';
  FDataVencimento := 0;
  FNumeroSerie := '';
end;

constructor TCertificadoPFX.Create;
begin
  Self.Clear;
  FACBrNFe := TACBrNFe.Create(nil);
end;

destructor TCertificadoPFX.Destroy;
begin
  FreeAndNil(FACBrNFe);
  inherited;
end;

procedure TCertificadoPFX.SelecionaArquivo;
var
  LOpenDialog: TOpenDialog;
begin
  LOpenDialog := TOpenDialog.Create(nil);
  LOpenDialog.DefaultExt := '*.pfx';
  LOpenDialog.Filter := 'Certificado Digital PFX|*.pfx';
  LOpenDialog.Title := 'Selecione o Certificado';
  LOpenDialog.Options := [ofHideReadOnly, ofEnableSizing, ofFileMustExist];
  try
    Self.Clear;
    if (LOpenDialog.Execute) then
      FArquivo := LOpenDialog.FileName;
  finally
    FreeAndNil(LOpenDialog);
  end;
end;

procedure TCertificadoPFX.CarregarCertificado;
begin
  if (FArquivo.IsEmpty) then
    raise Exception.Create('Selecione o Certificado .pfx');
  if not(FileExists(FArquivo)) then
    raise Exception.CreateFmt('Arquivo %D não encontrado', [FArquivo]);

  if (FSenha.IsEmpty) then
    raise Exception.Create('Senha não informada');

  FDadosPFX := GetCertificado(FArquivo);
  FDadosPFXBase64 := EncodeBase64(FDadosPFX);

  FACBrNFe.Configuracoes.Geral.SSLLib := libWinCrypt;
  FACBrNFe.Configuracoes.Certificados.DadosPFX := FDadosPFX;
  FACBrNFe.Configuracoes.Certificados.Senha := FSenha;

  FDataVencimento := FACBrNFe.SSL.CertDataVenc;
  FCNPJ := FACBrNFe.SSL.CertCNPJ;
  FNumeroSerie := FACBrNFe.SSL.CertNumeroSerie;
end;

end.
