unit Relatorio_NovaImpressao;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRPrntr, QRCtrls, DB, DBClient, QRPDFFilt,
  CJVQRBarCode;

type
  TTipoBand = (tHeaderUnico, tHeaderPagina, tDetalhe, tSubDetalhe, tRodape);
  TTipoShape = (tsLinha, tsRetangulo);

  TDesenho = class(TObject)
  private
    fComponenteParent: TWinControl;
    fRelatorioParent: TWinControl;
    procedure RedimensionarParent();
    procedure VerificaParent;
  public
    property ComponenteParent: TWinControl read fComponenteParent write fComponenteParent;
    property RelatorioParent: TWinControl read fRelatorioParent write fRelatorioParent;

    procedure AdicionarCampoDBLabel(NomeField: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer);
    procedure AdicionarCampoLabel(Texto: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer);
    procedure AdicionarIncrementoAlturaBand(NomeBand: String; IncrementoAltura: Integer);
    procedure AdicionarShape(TipoShape: String; Linha, Coluna, Comprimento, Altura: Integer);
    procedure ConfigurarCampoLabel(var Componente: TQRCustomLabel; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer);

    constructor Create(ARelatorioParent, AComponenteParent: TWinControl);
    destructor Destroy; override;
  end;

  // TFonte = class(TObject)
  // private
  // fCor: TColor;
  // fSublinhado: Boolean;
  // fNegrito: Boolean;
  // fNome: String;
  // fItalico: Boolean;
  // fTamanho: Integer;
  // public
  // property Nome: String read fNome write fNome;
  // property Tamanho: Integer read fTamanho write fTamanho;
  // property Negrito: Boolean read fNegrito write fNegrito;
  // property Italico: Boolean read fItalico write fItalico;
  // property Sublinhado: Boolean read fSublinhado write fSublinhado;
  // property Cor: TColor read fCor write fCor;
  // end;
  TRelatorio = class(TObject)
  private
  public
  end;

  TSubDetalhamento = class(TObject)
  private
    fDataSet: TDataSet;
    fCabecalho: TDesenho;
    fBandCabecalho: TQRBand;
    fNomeDetalhamento: String;
    fDetalhe: TDesenho;
    fBandDetalhe: TQRSubDetail;
    fRodape: TDesenho;
    fBandRodape: TQRBand;
    fRelatorioParent: TWinControl;
    procedure SetDataSet(const Value: TDataSet);
    property BandDetalhe: TQRSubDetail read fBandDetalhe;
    property BandCabecalho: TQRBand read fBandCabecalho;
    property BandRodape: TQRBand read fBandRodape;
  public
    procedure Cores(CorCabecalho, CorDetalhe, CorRodape: TColor);

    constructor Create(AOwner: TComponent; ANomeDetalhamento: String);
    destructor Destroy; override;

    property RelatorioParent: TWinControl read fRelatorioParent write fRelatorioParent;
    property DataSet: TDataSet read fDataSet write SetDataSet;
    property NomeDetalhamento: String read fNomeDetalhamento;

    property Detalhe: TDesenho read fDetalhe;
    property Cabecalho: TDesenho read fCabecalho;
    property Rodape: TDesenho read fRodape;
  end;

  TRelatorioNovaImpressao = class(TQuickRep)
    Cabecalho01: TQRBand;
    Cabecalho02: TQRBand;
    Cabecalho03: TQRBand;
    CabecalhoGeral: TQRBand;
    Detalhe01: TQRSubDetail;
    Detalhe02: TQRSubDetail;
    Detalhe03: TQRSubDetail;
    Principal: TQRBand;
    QRPDFFilter1: TQRPDFFilter;
    Rodape01: TQRBand;
    Rodape02: TQRBand;
    Rodape03: TQRBand;
    SeparadorPrincipal: TQRChildBand;
    procedure QRBandCabecalhoGeralBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private

  public
    constructor Create(AOwner: TComponent); override;
    procedure MontarRelatorio();
    procedure Preview();
  end;

implementation

uses
  StrUtils;
{$R *.DFM}
{ TDesenho }

constructor TDesenho.Create(ARelatorioParent, AComponenteParent: TWinControl);
begin
  fRelatorioParent := ARelatorioParent;
  fComponenteParent := AComponenteParent;
end;

destructor TDesenho.Destroy;
begin
  fComponenteParent := nil;
  fRelatorioParent := nil;
  inherited;
end;

procedure TDesenho.ConfigurarCampoLabel(var Componente: TQRCustomLabel; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer);
begin
  VerificaParent();
  Componente.Parent := ComponenteParent;
  Componente.Left := Coluna;
  Componente.Top := Linha;
  Componente.Font.Size := TamanhoFonte;
  Componente.Width := TamanhoMaxTexto;
  Componente.AutoSize := False;
  if (TamanhoMaxTexto = 0) then
    Componente.AutoSize := True;
  RedimensionarParent();
end;

procedure TDesenho.AdicionarCampoLabel(Texto: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer);
var
  Componente: TQRCustomLabel;
begin
  VerificaParent();
  Componente := TQRLabel.Create(RelatorioParent);
  TQRLabel(Componente).Transparent := True;
  TQRLabel(Componente).Caption := Texto;
  ConfigurarCampoLabel(Componente, Linha, Coluna, TamanhoMaxTexto, TamanhoFonte);
end;

procedure TDesenho.AdicionarCampoDBLabel(NomeField: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer);
var
  Componente: TQRCustomLabel;
begin
  VerificaParent();
  Componente := TQRDBText.Create(RelatorioParent);
  TQRDBText(Componente).Transparent := True;

  if (ComponenteParent.ClassType = TQRSubDetail) then
    TQRDBText(Componente).DataSet := TQRSubDetail(ComponenteParent).DataSet
  else
    if (ComponenteParent.ClassType = TQRBand) or (ComponenteParent.ClassType = TQRChildBand) then
      TQRDBText(Componente).DataSet := TQuickRep(RelatorioParent).DataSet
    else
      raise Exception.CreateFmt('Não identificado Parent para adicionar campo DBLabel %S', [NomeField]);

  TQRDBText(Componente).DataField := NomeField;
  ConfigurarCampoLabel(Componente, Linha, Coluna, TamanhoMaxTexto, TamanhoFonte);
end;

procedure TDesenho.AdicionarShape(TipoShape: String; Linha, Coluna, Comprimento, Altura: Integer);
var
  Componente: TQRShape;
begin
  VerificaParent();
  Componente := TQRShape.Create(RelatorioParent);
  case AnsiIndexStr(UpperCase(TipoShape), ['LINHA', 'RETANGULO', 'OPCAO3']) of
    0: Componente.Shape := qrsHorLine;
    1: Componente.Shape := qrsRectangle;
    2: Componente.Shape := qrsHorLine;
  end;
  Componente.Pen.Style := psDot; { linha tracejada }
  Componente.Parent := ComponenteParent;
  Componente.Left := Coluna;
  Componente.Top := Linha;
  Componente.Width := Comprimento;
  Componente.Height := Altura;
  if (Comprimento = 0) then
    Componente.Width := ComponenteParent.Width - Coluna;
  if (Altura <= 0) then
    raise Exception.Create('Obrigatório Informar Altura');
  RedimensionarParent();
end;

procedure TDesenho.RedimensionarParent();
var
  TamanhoOcupadoComponente: Integer;
begin
  VerificaParent();
  TamanhoOcupadoComponente := ComponenteParent.Top + ComponenteParent.Height;
  if (ComponenteParent.Parent.Height < TamanhoOcupadoComponente) then
    ComponenteParent.Parent.Height := TamanhoOcupadoComponente;
  { Result := TWinControl(FindComponent(NomeComponente)); }
end;

procedure TDesenho.AdicionarIncrementoAlturaBand(NomeBand: String; IncrementoAltura: Integer);
begin
  VerificaParent();
  TQRCustomBand(ComponenteParent).Height := TQRCustomBand(ComponenteParent).Height + IncrementoAltura;
end;

procedure TDesenho.VerificaParent();
begin
  if (RelatorioParent = nil) then
    raise Exception.Create('Relatório Parent não informado');
  if (ComponenteParent = nil) then
    raise Exception.Create('Componente Parent não informado');
end;
{ TSubDetalhamento }

procedure TSubDetalhamento.Cores(CorCabecalho, CorDetalhe, CorRodape: TColor);
begin
  fBandCabecalho.Color := CorCabecalho;
  fBandDetalhe.Color := CorDetalhe;
  fBandRodape.Color := CorRodape;
end;

constructor TSubDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String);
begin
  fNomeDetalhamento := ANomeDetalhamento;

  fBandCabecalho := TQRBand.Create(AOwner);
  fBandDetalhe := TQRSubDetail.Create(AOwner);
  fBandRodape := TQRBand.Create(AOwner);

  fBandCabecalho.Name := 'Cabecalho' + fNomeDetalhamento;
  fBandDetalhe.Name := 'Detalhe' + fNomeDetalhamento;
  fBandRodape.Name := 'Rodape' + fNomeDetalhamento;

  fBandCabecalho.Parent := TWinControl(AOwner);
  fBandDetalhe.Parent := TWinControl(AOwner);
  fBandRodape.Parent := TWinControl(AOwner);

  fBandCabecalho.BandType := rbGroupHeader;
  fBandRodape.BandType := rbGroupFooter;

  fBandDetalhe.HeaderBand := fBandCabecalho;
  fBandDetalhe.FooterBand := fBandRodape;

  fBandCabecalho.Height := 0;
  fBandDetalhe.Height := 0;
  fBandRodape.Height := 0;

  fCabecalho := TDesenho.Create(TQuickRep(AOwner), fBandCabecalho);
  fDetalhe := TDesenho.Create(TQuickRep(AOwner), fBandDetalhe);
  fRodape := TDesenho.Create(TQuickRep(AOwner), fBandRodape);
end;

destructor TSubDetalhamento.Destroy;
begin
  FreeAndNil(fCabecalho);
  FreeAndNil(fDetalhe);
  FreeAndNil(fRodape);

  fDataSet := nil;
  fBandCabecalho := nil;
  fBandDetalhe := nil;
  fBandRodape := nil;
  inherited;
end;

procedure TSubDetalhamento.SetDataSet(const Value: TDataSet);
begin
  fDataSet := Value;
  fBandDetalhe.DataSet := fDataSet;
end;

{ TRelatorioNovaImpressao }

constructor TRelatorioNovaImpressao.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited;
  { podera ser removido codigo abaixo }
  for I := 0 to ComponentCount - 1 do
    if (TComponent(Components[I]).ClassType = TQRBand) or (TComponent(Components[I]).ClassType = TQRSubDetail) or (TComponent(Components[I]).ClassType = TQRChildBand) then
    begin
      TQRCustomBand(Components[I]).Visible := False;
      TQRCustomBand(Components[I]).Height := 0;
      TQRCustomBand(Components[I]).TransparentBand := False;
    end;
end;

procedure TRelatorioNovaImpressao.Preview;
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if (Components[I].ClassType = TQRSubDetail) then
      TQRSubDetail(Components[I]).PrintIfEmpty := False;

  Self.PrevInitialZoom := qrZoom100;
  Self.PreviewInitialState := wsMaximized;
  Self.PrevShowThumbs := False;
  Self.PrevShowSearch := False;
  Self.PreviewModal;
end;

procedure TRelatorioNovaImpressao.QRBandCabecalhoGeralBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  // PrintBand := (Self.PageNumber > 1);
end;

procedure TRelatorioNovaImpressao.MontarRelatorio();
const
  _CabecalhoGeral = 'CabecalhoGeral';
  _BaseRelatorio = 'Principal';
  _RodapeGeral = 'QRBandRodape';
var
  ItensPedido, Ordem, Bloqueio: TSubDetalhamento;
begin

  // AdicionarCampoLabel('Total Itens: ' + IntToStr(Self.DataSet.RecordCount), 1, 300, 0, 12, _CabecalhoGeral);
  // AdicionarCampoLabel('texto fixo em toda pagina  ', 1, 100, 0, 12, _CabecalhoGeral);
  //
  // AdicionarCampoLabel('texto fixo em todo rodape ', 1, 100, 0, 12, _RodapeGeral);
  //
  // AdicionarCampoLabel('texto corpo', 1, 300, 0, 12, _BaseRelatorio);
  // AdicionarCampoLabel('texto corpo 2', 30, 300, 0, 12, _BaseRelatorio);
  // AdicionarCampoDBLabel('numero', 1, 50, 50, 12, _BaseRelatorio);
  // AdicionarCampoDBLabel('emissao', 1, 150, 0, 12, _BaseRelatorio);
  // // AdicionarShape('retangulo', 1, 1, 0, 18, _BaseRelatorio);
  // AdicionarShape('linha', 50, 0, 0, 5, _BaseRelatorio);
  // AdicionarIncrementoAlturaBand(_BaseRelatorio, 50);
  //
  // AdicionarShape('linha', 1, 0, 0, 18, 'SeparadorPrincipal');

  ItensPedido := TSubDetalhamento.Create(Self, 'ItensPedido');
  ItensPedido.Cores($005F9EF5, $009BC2F9, $00D1E3FC);
  ItensPedido.DataSet := Detalhe01.DataSet;
  ItensPedido.Cabecalho.AdicionarCampoLabel('numero-->', 1, 50, 0, 10);
  ItensPedido.Detalhe.AdicionarCampoDBLabel('NUMERO', 1, 50, 0, 10);
  ItensPedido.Detalhe.AdicionarCampoDBLabel('PRODUTO', 1, 200, 0, 10);
  ItensPedido.Detalhe.AdicionarCampoLabel('texto fixo itens', 10, 300, 0, 10);
  ItensPedido.Rodape.AdicionarCampoLabel('numero<--', 1, 50, 0, 10);
  FreeAndNil(ItensPedido);

  Ordem := TSubDetalhamento.Create(Self, 'Ordem');
  Ordem.Cores($00D0EB76, $00E3F3AB, $00BEE340);
  Ordem.DataSet := Detalhe02.DataSet;
  Ordem.Cabecalho.AdicionarCampoLabel('ordem-->', 1, 50, 0, 10);
  Ordem.Detalhe.AdicionarCampoDBLabel('NUMERO', 1, 1, 0, 10);
  Ordem.Detalhe.AdicionarCampoDBLabel('ORDEM', 1, 50, 0, 10);
  Ordem.Detalhe.AdicionarCampoDBLabel('VCTO', 1, 100, 0, 10);
  Ordem.Detalhe.AdicionarCampoDBLabel('VALOR', 1, 250, 0, 10);
  Ordem.Detalhe.AdicionarCampoLabel('texto fixo ordem', 1, 400, 0, 10);
  Ordem.Rodape.AdicionarCampoLabel('ordem<--', 1, 50, 0, 10);
  FreeAndNil(Ordem);

  Bloqueio := TSubDetalhamento.Create(Self, 'Bloqueio');
  Bloqueio.Cores($00FFAC59, $00FFD8B0, $00FFC891);
  Bloqueio.DataSet := Detalhe03.DataSet;
  Bloqueio.Cabecalho.AdicionarCampoLabel('bloqueio-->', 1, 50, 0, 10);
  Bloqueio.Detalhe.AdicionarCampoDBLabel('PEDIDO', 1, 1, 0, 10);
  Bloqueio.Detalhe.AdicionarCampoDBLabel('MOTIVO', 1, 50, 0, 10);
  Bloqueio.Detalhe.AdicionarCampoDBLabel('AUTORIZADO', 1, 100, 0, 10);
  Bloqueio.Detalhe.AdicionarCampoLabel('texto fixo bloqueio', 1, 400, 0, 10);
  Bloqueio.Rodape.AdicionarCampoLabel('bloqueio<--', 1, 50, 0, 10);
  FreeAndNil(Bloqueio);

end;

end.
