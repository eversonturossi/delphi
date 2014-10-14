unit URelatorioDetalhamento;

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
  TDetalhamento = class(TObject)
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
    procedure setDataSource(const Value: TDataSource);
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

{ TDetalhamento }

constructor TDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String);
begin
  fNomeDetalhamento := ANomeDetalhamento;
  fRelatorioParent := TWinControl(AOwner);

  fBandCabecalho := TQRBand.Create(RelatorioParent);
  fBandDetalhe := TQRBand.Create(RelatorioParent);
  fBandSeparador := TQRChildBand.Create(RelatorioParent);
  fBandRodape := TQRBand.Create(RelatorioParent);

  fBandCabecalho.Name := 'Cabecalho' + NomeDetalhamento;
  fBandDetalhe.Name := 'Detalhe' + NomeDetalhamento;
  fBandRodape.Name := 'Rodape' + NomeDetalhamento;

  fBandCabecalho.Parent := RelatorioParent;
  fBandDetalhe.Parent := RelatorioParent;
  fBandRodape.Parent := RelatorioParent;

  fBandCabecalho.BandType := rbPageHeader;
  TQRBand(fBandDetalhe).BandType := rbDetail;
  TQRBand(fBandDetalhe).ForceNewPage := true;
  TQRBand(fBandDetalhe).HasChild := true;
  fBandRodape.BandType := rbPageFooter;

  fBandSeparador.ParentBand := TQRBand(fBandDetalhe);

  fDataSource := TDataSource.Create(RelatorioParent);
  Configurar();
end;

constructor TDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String; ACabecaho, ADetalhe, ARodape: TQRCustomBand);
begin
  fNomeDetalhamento := ANomeDetalhamento;
  fRelatorioParent := TWinControl(AOwner);

  fBandCabecalho := TQRBand(ACabecaho);
  fBandDetalhe := TQRBand(ADetalhe);
  fBandRodape := TQRBand(ARodape);

  fDataSource := TDataSource.Create(RelatorioParent);
  Configurar();
end;

destructor TDetalhamento.Destroy;
begin
  FreeAndNil(fCabecalho);
  FreeAndNil(fDetalhe);
  FreeAndNil(fRodape);

  fDataSet := nil;
  fBandCabecalho := nil;
  fBandDetalhe := nil;
  fBandRodape := nil;
  fRelatorioParent := nil;
  inherited;
end;

procedure TDetalhamento.Cores(CorCabecalho, CorDetalhe, CorRodape: TColor);
begin
  BandCabecalho.Color := CorCabecalho;
  BandDetalhe.Color := CorDetalhe;
  BandRodape.Color := CorRodape;
end;

procedure TDetalhamento.Configurar();
begin
  BandCabecalho.Height := 0;
  BandDetalhe.Height := 0;
  BandRodape.Height := 0;

  fCabecalho := TDesenho.Create(RelatorioParent, BandCabecalho);
  fDetalhe := TDesenho.Create(RelatorioParent, BandDetalhe);
  fRodape := TDesenho.Create(RelatorioParent, BandRodape);
end;

procedure TDetalhamento.SetDataSet(const Value: TDataSet);
begin
  fDataSet := Value;
  TQuickRep(RelatorioParent).DataSet := fDataSet; // estava comentado
  fDataSource.DataSet := DataSet;
end;

procedure TDetalhamento.setDataSource(const Value: TDataSource);
begin
  fDataSource := Value;
end;

end.
