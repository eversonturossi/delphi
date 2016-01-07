unit UCancelaNFe;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, IniFiles, SHDocVw, ShellAPI,
  ACBrBase, ACBrDFe, ACBrNFe, ACBrNFeDANFEClass, ACBrNFeDANFeRLClass,
  pcnRetConsReciNFe, pcnConversao, ACBrUtil, ACBrNFeDANFeESCPOS, ACBrMail, ACBrDFeSSL,
  pcnConversaoNFe, ACBrDFeUtil,
  XMLIntf, XMLDoc, zlib, UMensagem;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    btnCancelarChave: TButton;
    GroupBox3: TGroupBox;
    rgTipoAmb: TRadioGroup;
    edtChave: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    edtJustificativa: TEdit;
    Label4: TLabel;
    edtProtocolo: TEdit;
    ACBrNFe1: TACBrNFe;
    edtXML: TEdit;
    Label5: TLabel;
    btnXML: TSpeedButton;
    OpenDialog1: TOpenDialog;
    procedure btnCancelarChaveClick(Sender: TObject);
    procedure btnXMLClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.btnCancelarChaveClick(Sender: TObject);
var
  AChave, AProtocoloAutorizacao, AJustificativa: String;
  ACNPJ, AModeloStr, APath: String;
  AUF: Integer;
  AModelo: TpcnModeloDF;
  AAmbiente: TpcnTipoAmbiente;
  AMensagem: TMensagem;
begin
  AMensagem := TMensagem.Create;
  try
    btnCancelarChave.Enabled := False;
    Self.Enabled := False;

    AChave := OnlyNumber(edtChave.Text);
    AProtocoloAutorizacao := OnlyNumber(edtProtocolo.Text);
    AJustificativa := Trim(edtJustificativa.Text);

    if (AChave = EmptyStr) then
      raise Exception.Create('Chave não Informada');
    if (Length(AChave) <> 44) then
      raise Exception.Create('Chave inválida');
    if (AJustificativa = EmptyStr) then
      raise Exception.Create('Justificativa não informada');
    if (AProtocoloAutorizacao = EmptyStr) then
      raise Exception.Create('Protocolo de autorização não informado');

    AMensagem.Add('Deseja Cancelar esta Nota?');
    if not(AMensagem.Confirma()) then
      raise Exception.Create('Cancelado');

    ACNPJ := Copy(AChave, 7, 14);
    AUF := StrToIntDef(Copy(AChave, 1, 2), 0);
    AModeloStr := Copy(AChave, 21, 2);
    case StrToIntDef(AModeloStr, 0) of
      55: AModelo := moNFe;
      65: AModelo := moNFCe;
    else
      raise Exception.CreateFmt('Modelo de documento inválido (%S)', [AModeloStr]);
    end;

    case rgTipoAmb.ItemIndex of
      0: AAmbiente := taProducao;
      1: AAmbiente := taHomologacao;
    end;

    APath := ExtractFilePath(ParamStr(0));
    APath := ExcludeTrailingBackslash(APath);

    ACBrNFe1.Configuracoes.Arquivos.Salvar := True;
    ACBrNFe1.Configuracoes.Arquivos.SalvarEvento := True;
    ACBrNFe1.Configuracoes.Arquivos.SepararPorMes := True;
    ACBrNFe1.Configuracoes.Arquivos.SepararPorModelo := True;
    ACBrNFe1.Configuracoes.Arquivos.SepararPorCNPJ := True;
    ACBrNFe1.Configuracoes.Arquivos.AdicionarLiteral := True;
    ACBrNFe1.Configuracoes.Arquivos.PathSalvar := APath;
    ACBrNFe1.Configuracoes.Arquivos.PathSchemas := APath + '\Schemas\';
    ACBrNFe1.Configuracoes.Geral.AtualizarXMLCancelado := True;
    ACBrNFe1.Configuracoes.Geral.RetirarAcentos := True;
    ACBrNFe1.Configuracoes.Geral.ModeloDF := AModelo;
    ACBrNFe1.Configuracoes.Geral.VersaoDF := ve310;
    ACBrNFe1.Configuracoes.Geral.FormaEmissao := teNormal;
    ACBrNFe1.Configuracoes.Geral.Salvar := True;
    ACBrNFe1.Configuracoes.Geral.ExibirErroSchema := True;
    ACBrNFe1.Configuracoes.Geral.SSLLib := libCapicom;
    ACBrNFe1.Configuracoes.Certificados.NumeroSerie := ACBrNFe1.SSL.SelecionarCertificado;
    ACBrNFe1.Configuracoes.WebServices.Ambiente := AAmbiente;
    ACBrNFe1.Configuracoes.WebServices.UF := CUFtoUF(AUF);
    ACBrNFe1.Configuracoes.WebServices.Visualizar := False;

    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.EventoNFe.Evento.Clear;
    with ACBrNFe1.EventoNFe.Evento.Add do
    begin
      infEvento.chNFe := AChave;
      infEvento.CNPJ := ACNPJ;
      infEvento.dhEvento := Now;
      infEvento.tpEvento := teCancelamento;
      infEvento.detEvento.xJust := AJustificativa;
      infEvento.detEvento.nProt := AProtocoloAutorizacao;
    end;
    ACBrNFe1.EnviarEvento(1);

    AMensagem.Clear;
    AMensagem.Add('Stat: %D', [ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.cStat]);
    AMensagem.Add('Motivo: %S', [ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.xMotivo]);
    AMensagem.Add('Protocolo: %S', [ACBrNFe1.WebServices.EnvEvento.EventoRetorno.retEvento.Items[0].RetInfEvento.nProt]);
    AMensagem.Show();
  finally
    btnCancelarChave.Enabled := True;
    Self.Enabled := True;
    FreeAndNil(AMensagem);
  end;
end;

procedure TForm2.btnXMLClick(Sender: TObject);
begin
  edtChave.Clear;
  edtProtocolo.Clear;
  edtXML.Clear;
  ACBrNFe1.NotasFiscais.Clear;

  OpenDialog1.Title := 'Selecione a NFE';
  OpenDialog1.DefaultExt := '*.XML';
  OpenDialog1.Filter := 'Arquivos NFE (Arquivos XML (*.XML)|*.XML|Todos os Arquivos (*.*)|*.*';
  OpenDialog1.InitialDir := ACBrNFe1.Configuracoes.Arquivos.PathSalvar;

  if OpenDialog1.Execute then
  begin
    ACBrNFe1.NotasFiscais.Clear;
    ACBrNFe1.NotasFiscais.LoadFromFile(OpenDialog1.FileName);

    if (ACBrNFe1.NotasFiscais.Count <= 0) then
      raise Exception.Create('Arquivo XML inválido');

    edtChave.Text := ACBrNFe1.NotasFiscais[0].NFe.procNFe.chNFe;
    edtProtocolo.Text := ACBrNFe1.NotasFiscais[0].NFe.procNFe.nProt;
    edtXML.Text := OpenDialog1.FileName;
  end;
end;

end.
