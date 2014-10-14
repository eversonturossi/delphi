unit URelatorioSubDetalhamento;

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  QuickRpt,
  QRPrntr,
  QRCtrls,
  DB,
  DBClient,
  QRPDFFilt,
  URelatorioDesenho;

type
  TSubDetalhamento = class(TObject)
  private
    fDataSet: TDataSet;
    fCabecalho: TDesenho;
    fBandCabecalho: TQRBand;
    fNomeDetalhamento: String;
    fDetalhe: TDesenho;
    fBandDetalhe: TQRCustomBand;
    fRodape: TDesenho;
    fBandRodape: TQRBand;
    fBandSeparador: TQRChildBand;

    fRelatorioParent: TWinControl;
    fDataSource: TDataSource;
    procedure SetDataSet(const Value: TDataSet);
    procedure Configurar();
    property BandDetalhe: TQRCustomBand read fBandDetalhe;
    property BandCabecalho: TQRBand read fBandCabecalho;
    property BandRodape: TQRBand read fBandRodape;
    property BandSeparador: TQRChildBand read fBandSeparador;
  public
    procedure Cores(CorCabecalho, CorDetalhe, CorRodape: TColor); virtual;

    constructor Create(AOwner: TComponent; ANomeDetalhamento: String); overload;
    constructor Create(AOwner: TComponent; ANomeDetalhamento: String; ACabecaho, ADetalhe, ARodape: TQRCustomBand); overload;
    destructor Destroy; override;

    property NomeDetalhamento: String read fNomeDetalhamento;
    property RelatorioParent: TWinControl read fRelatorioParent write fRelatorioParent;
    property DataSet: TDataSet read fDataSet write SetDataSet;
    property DataSource: TDataSource read fDataSource;

    property Detalhe: TDesenho read fDetalhe;
    property Cabecalho: TDesenho read fCabecalho;
    property Rodape: TDesenho read fRodape;
  end;

implementation

{ TSubDetalhamento }

constructor TSubDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String);
begin
  fNomeDetalhamento := ANomeDetalhamento;
  fRelatorioParent := TWinControl(AOwner);

  fBandCabecalho := TQRBand.Create(RelatorioParent);
  fBandDetalhe := TQRSubDetail.Create(RelatorioParent);
  fBandRodape := TQRBand.Create(RelatorioParent);

  fBandCabecalho.Name := 'Cabecalho' + NomeDetalhamento;
  fBandDetalhe.Name := 'Detalhe' + NomeDetalhamento;
  fBandRodape.Name := 'Rodape' + NomeDetalhamento;

  fBandCabecalho.Parent := RelatorioParent;
  fBandDetalhe.Parent := RelatorioParent;
  fBandRodape.Parent := RelatorioParent;

  fBandCabecalho.BandType := rbGroupHeader;
  TQRSubDetail(fBandDetalhe).HeaderBand := fBandCabecalho;
  TQRSubDetail(fBandDetalhe).FooterBand := fBandRodape;
  TQRSubDetail(fBandDetalhe).Master := TQuickRep(RelatorioParent);
  TQRSubDetail(fBandDetalhe).PrintIfEmpty := False;
  { ------- }
  TQRSubDetail(fBandDetalhe).AlignToBottom := False;
  TQRSubDetail(fBandDetalhe).ForceNewColumn := False;
  TQRSubDetail(fBandDetalhe).ForceNewPage := False;
  TQRSubDetail(fBandDetalhe).KeepOnOnePage := False;
  TQRSubDetail(fBandDetalhe).PreCaluculateBandHeight := False;
  TQRSubDetail(fBandDetalhe).PrintBefore := False;
  TQRSubDetail(fBandDetalhe).TransparentBand := False;
  { -------- }
  fBandRodape.BandType := rbGroupFooter;

  fDataSource := TDataSource.Create(RelatorioParent);
  Configurar();
end;

constructor TSubDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String; ACabecaho, ADetalhe, ARodape: TQRCustomBand);
begin
  fNomeDetalhamento := ANomeDetalhamento;
  fRelatorioParent := TWinControl(AOwner);

  fBandCabecalho := TQRBand(ACabecaho);
  fBandDetalhe := TQRSubDetail(ADetalhe);
  fBandRodape := TQRBand(ARodape);

  fDataSource := TDataSource.Create(RelatorioParent);
  Configurar();
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
  fRelatorioParent := nil;
  fDataSet := nil;
  inherited;
end;

procedure TSubDetalhamento.Cores(CorCabecalho, CorDetalhe, CorRodape: TColor);
begin
  BandCabecalho.Color := CorCabecalho;
  BandDetalhe.Color := CorDetalhe;
  BandRodape.Color := CorRodape;
end;

procedure TSubDetalhamento.Configurar();
begin
  BandCabecalho.Height := 0;
  BandDetalhe.Height := 0;
  BandRodape.Height := 0;

  fCabecalho := TDesenho.Create(RelatorioParent, BandCabecalho);
  fDetalhe := TDesenho.Create(RelatorioParent, BandDetalhe);
  fRodape := TDesenho.Create(RelatorioParent, BandRodape);
end;

procedure TSubDetalhamento.SetDataSet(const Value: TDataSet);
begin
  fDataSet := Value;
  TQRSubDetail(fBandDetalhe).DataSet := DataSet;
  fDataSource.DataSet := DataSet;
end;

end.
