unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ACBrBase, ACBrDFe, ACBrNFe;

type
  TForm7 = class(TForm)
    ACBrNFe1: TACBrNFe;
    EditSenha: TEdit;
    EditCertificado: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ButtonSelecionaCertificado: TButton;
    OpenDialog1: TOpenDialog;
    ButtonConsultaStatus: TButton;
    MemoDados: TMemo;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure ButtonSelecionaCertificadoClick(Sender: TObject);
    procedure ButtonConsultaStatusClick(Sender: TObject);
  private
  public
  end;

var
  Form7: TForm7;

implementation

uses
  ACBrDFeConfiguracoes, ACBrDFeSSL, synautil, pcnConversao, synacode;

{$R *.dfm}

function GetCertificado(APFXFile: String): AnsiString;
var
  FS: TFileStream;
begin
  FS := TFileStream.Create(APFXFile, fmOpenRead);
  try
    Result := ReadStrFromStream(FS, FS.Size); // de USES no pacote synautil
  finally
    FS.Free;
  end;
end;

procedure TForm7.ButtonConsultaStatusClick(Sender: TObject);
var
  LCertificadoBase64: AnsiString;
begin
  ACBrNFe1.Configuracoes.Geral.SSLLib := libWinCrypt;
  ACBrNFe1.Configuracoes.Certificados.DadosPFX := GetCertificado(EditCertificado.Text);
  ACBrNFe1.Configuracoes.Certificados.Senha := EditSenha.Text;
  ACBrNFe1.Configuracoes.Arquivos.PathSchemas := 'C:\ACBr\trunk2\Exemplos\ACBrDFe\Schemas\NFe';

  ACBrNFe1.Configuracoes.WebServices.UF := 'SC';
  ACBrNFe1.Configuracoes.WebServices.Ambiente := taHomologacao;

  LCertificadoBase64 := EncodeBase64(ACBrNFe1.Configuracoes.Certificados.DadosPFX); // uses  synacode
  memo1.Lines.Clear;
  Memo1.Lines.Add(LCertificadoBase64);
  memo1.Lines.SaveToFile('certificado.txt');

  ACBrNFe1.WebServices.StatusServico.Executar;

  MemoDados.Lines.clear;
  MemoDados.Lines.Add('');
  MemoDados.Lines.Add('Status Serviço');
  MemoDados.Lines.Add('tpAmb: ' + TpAmbToStr(ACBrNFe1.WebServices.StatusServico.tpAmb));
  MemoDados.Lines.Add('verAplic: ' + ACBrNFe1.WebServices.StatusServico.verAplic);
  MemoDados.Lines.Add('cStat: ' + IntToStr(ACBrNFe1.WebServices.StatusServico.cStat));
  MemoDados.Lines.Add('xMotivo: ' + ACBrNFe1.WebServices.StatusServico.xMotivo);
  MemoDados.Lines.Add('cUF: ' + IntToStr(ACBrNFe1.WebServices.StatusServico.cUF));
  MemoDados.Lines.Add('dhRecbto: ' + DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRecbto));
  MemoDados.Lines.Add('tMed: ' + IntToStr(ACBrNFe1.WebServices.StatusServico.TMed));
  MemoDados.Lines.Add('dhRetorno: ' + DateTimeToStr(ACBrNFe1.WebServices.StatusServico.dhRetorno));
  MemoDados.Lines.Add('xObs: ' + ACBrNFe1.WebServices.StatusServico.xObs);
end;

procedure TForm7.ButtonSelecionaCertificadoClick(Sender: TObject);
begin
  if OpenDialog1.Execute then
    EditCertificado.Text := OpenDialog1.FileName;
end;

end.
