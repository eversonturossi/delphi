unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ACBrBase, ACBrDFe, ACBrNFe,
  UCertificadoPFX;

type
  TForm7 = class(TForm)
    ACBrNFe1: TACBrNFe;
    EditSenha: TEdit;
    EditCertificado: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    ButtonSelecionaCertificado: TButton;
    ButtonConsultaStatus: TButton;
    MemoDados: TMemo;
    Memo1: TMemo;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditCertificadoCNPJ: TEdit;
    EditCertificadoVencimento: TEdit;
    EditCertificadoNumeroSerie: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    procedure ButtonSelecionaCertificadoClick(Sender: TObject);
    procedure ButtonConsultaStatusClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    FCertificado: TCertificadoPFX;
  public
    property Certificado: TCertificadoPFX read FCertificado;
  end;

var
  Form7: TForm7;

implementation

uses
  ACBrDFeConfiguracoes, ACBrDFeSSL, synautil, pcnConversao, synacode, ACBrUtil;

{$R *.dfm}

procedure TForm7.ButtonConsultaStatusClick(Sender: TObject);
var
  LCertificado: AnsiString;
begin
  LCertificado := DecodeBase64(FCertificado.DadosPFXBase64);
  ACBrNFe1.Configuracoes.Geral.SSLLib := libWinCrypt;
  ACBrNFe1.Configuracoes.Certificados.DadosPFX := LCertificado;
  ACBrNFe1.Configuracoes.Certificados.Senha := FCertificado.Senha;
  ACBrNFe1.Configuracoes.Arquivos.PathSchemas := 'C:\ACBr\trunk2\Exemplos\ACBrDFe\Schemas\NFe';

  ACBrNFe1.Configuracoes.WebServices.UF := 'SC';
  ACBrNFe1.Configuracoes.WebServices.Ambiente := taHomologacao;

  ACBrNFe1.WebServices.StatusServico.Executar;

  MemoDados.Lines.Clear;
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
var
  LCertificadoBase64: AnsiString;
begin
  EditCertificado.Text := FCertificado.Arquivo;
  FCertificado.SelecionaArquivo;
  FCertificado.Senha := EditSenha.Text;
  FCertificado.CarregarCertificado;

  EditCertificadoVencimento.Text := FormatDateBr(FCertificado.DataVencimento);
  EditCertificadoCNPJ.Text := FCertificado.CNPJ;
  EditCertificadoNumeroSerie.Text := FCertificado.NumeroSerie;

  LCertificadoBase64 := EncodeBase64(FCertificado.DadosPFX); // uses  synacode
  Memo1.Lines.Clear;
  Memo1.Lines.Add(LCertificadoBase64);
  // Memo1.Lines.SaveToFile('certificado.txt');
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  FCertificado := TCertificadoPFX.Create;
end;

procedure TForm7.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCertificado);
end;

end.
