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
  TTipoDetalhe = (tdDetalhe, tdSubDetalhe);

  TBaseDetalhamento = class(TObject)
  private
    fDataSet: TDataSet;
    fCabecalho: TDesenho;
    fBandCabecalho: TQRBand;
    fNomeDetalhamento: String;
    fDetalhe: TDesenho;
    fBandDetalhe: TQRCustomBand;
    fRodape: TDesenho;
    fBandRodape: TQRBand;
    fRelatorioParent: TWinControl;
    fTipoDetalhe: TTipoDetalhe;
    procedure SetDataSet(const Value: TDataSet);
    property BandDetalhe: TQRCustomBand read fBandDetalhe;
    property BandCabecalho: TQRBand read fBandCabecalho;
    property BandRodape: TQRBand read fBandRodape;
  public
    procedure Cores(CorCabecalho, CorDetalhe, CorRodape: TColor); virtual;

    constructor Create(AOwner: TComponent; ANomeDetalhamento: String); virtual;
    destructor Destroy; override;

    property TipoDetalhe: TTipoDetalhe read fTipoDetalhe;

    property RelatorioParent: TWinControl read fRelatorioParent write fRelatorioParent;
    property DataSet: TDataSet read fDataSet write SetDataSet;
    property NomeDetalhamento: String read fNomeDetalhamento;

    property Detalhe: TDesenho read fDetalhe;
    property Cabecalho: TDesenho read fCabecalho;
    property Rodape: TDesenho read fRodape;
  end;

  TDetalhamento = class(TBaseDetalhamento)
  private
  public
    constructor Create(AOwner: TComponent; ANomeDetalhamento: String); override;
  end;

  TSubDetalhamento = class(TBaseDetalhamento)
  private
  public
    constructor Create(AOwner: TComponent; ANomeDetalhamento: String); override;
  end;

implementation

{ TBaseDetalhamento }

procedure TBaseDetalhamento.Cores(CorCabecalho, CorDetalhe, CorRodape: TColor);
begin
  fBandCabecalho.Color := CorCabecalho;
  fBandDetalhe.Color := CorDetalhe;
  fBandRodape.Color := CorRodape;
end;

constructor TBaseDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String);
begin
  fNomeDetalhamento := ANomeDetalhamento;

  fBandCabecalho := TQRBand.Create(AOwner);
  if (TipoDetalhe = tdDetalhe) then
    fBandDetalhe := TQRBand.Create(AOwner);
  if (TipoDetalhe = tdSubDetalhe) then
    fBandDetalhe := TQRSubDetail.Create(AOwner);
  fBandRodape := TQRBand.Create(AOwner);

  fBandCabecalho.Name := 'Cabecalho' + fNomeDetalhamento;
  fBandDetalhe.Name := 'Detalhe' + fNomeDetalhamento;
  fBandRodape.Name := 'Rodape' + fNomeDetalhamento;

  fBandCabecalho.Parent := TWinControl(AOwner);
  fBandDetalhe.Parent := TWinControl(AOwner);
  fBandRodape.Parent := TWinControl(AOwner);

  if (TipoDetalhe = tdDetalhe) then { testar }
  begin
    fBandCabecalho.BandType := rbPageHeader;
    TQRBand(fBandDetalhe).BandType := rbDetail;
    fBandRodape.BandType := rbPageFooter;
  end;

  if (TipoDetalhe = tdSubDetalhe) then
  begin
    fBandCabecalho.BandType := rbGroupHeader;
    TQRSubDetail(fBandDetalhe).HeaderBand := fBandCabecalho;
    TQRSubDetail(fBandDetalhe).FooterBand := fBandRodape;
    fBandRodape.BandType := rbGroupFooter;
  end;

  fBandCabecalho.Height := 0;
  fBandDetalhe.Height := 0;
  fBandRodape.Height := 0;

  fCabecalho := TDesenho.Create(TQuickRep(AOwner), fBandCabecalho);
  fDetalhe := TDesenho.Create(TQuickRep(AOwner), fBandDetalhe);
  fRodape := TDesenho.Create(TQuickRep(AOwner), fBandRodape);
end;

destructor TBaseDetalhamento.Destroy;
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

procedure TBaseDetalhamento.SetDataSet(const Value: TDataSet);
begin
  fDataSet := Value;
  if (TipoDetalhe = tdDetalhe) then
    TQuickRep(RelatorioParent).DataSet := fDataSet;
  if (TipoDetalhe = tdSubDetalhe) then
    TQRSubDetail(fBandDetalhe).DataSet := fDataSet;
end;

{ TSubDetalhamento }

constructor TSubDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String);
begin
  fTipoDetalhe := tdSubDetalhe;
  inherited;
end;

{ TDetalhamento }

constructor TDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String);
begin
  fTipoDetalhe := tdDetalhe;
  inherited;
end;

end.
