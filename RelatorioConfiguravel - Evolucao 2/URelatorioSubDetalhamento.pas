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
    fBandSeparador: TQRChildBand;

    {fRelatorioParentX: TWinControl;}
    fTipoDetalhe: TTipoDetalhe;
    procedure SetDataSet(const Value: TDataSet);
    property BandDetalhe: TQRCustomBand read fBandDetalhe;
    property BandCabecalho: TQRBand read fBandCabecalho;
    property BandRodape: TQRBand read fBandRodape;
    property BandSeparador : TQRChildBand read fBandSeparador;
  public
    procedure Cores(CorCabecalho, CorDetalhe, CorRodape: TColor); virtual;

    constructor Create(AOwner: TComponent; ANomeDetalhamento: String); virtual;
    destructor Destroy; override;

    property TipoDetalhe: TTipoDetalhe read fTipoDetalhe;

{    property RelatorioParentX: TWinControl read fRelatorioParentX write fRelatorioParentX;}
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
  begin
    fBandDetalhe := TQRBand.Create(AOwner);
    fBandSeparador := TQRChildBand.Create(AOwner);
  end;
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
    TQRBand(fBandDetalhe).ForceNewPage := True;
    TQRBand(fBandDetalhe).HasChild := True;
    fBandRodape.BandType := rbPageFooter;

    fBandSeparador.ParentBand := TQRBand(fBandDetalhe);
  end;

  if (TipoDetalhe = tdSubDetalhe) then
  begin
    fBandCabecalho.BandType := rbGroupHeader;
    TQRSubDetail(fBandDetalhe).HeaderBand := fBandCabecalho;
    TQRSubDetail(fBandDetalhe).FooterBand := fBandRodape;
    TQRSubDetail(fBandDetalhe).Master := TQuickRep(AOwner);
    TQRSubDetail(fBandDetalhe).PrintIfEmpty := False;
    fBandRodape.BandType := rbGroupFooter;
  end;

  fBandCabecalho.Height := 0;
  fBandDetalhe.Height := 0;
  fBandRodape.Height := 0;

  fCabecalho := TDesenho.Create(TWinControl(AOwner), fBandCabecalho);
  fDetalhe := TDesenho.Create(TWinControl(AOwner), fBandDetalhe);
  fRodape := TDesenho.Create(TWinControl(AOwner), fBandRodape);
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
 { if (TipoDetalhe = tdDetalhe) then
    TQuickRep(RelatorioParentX).DataSet := fDataSet; }
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
