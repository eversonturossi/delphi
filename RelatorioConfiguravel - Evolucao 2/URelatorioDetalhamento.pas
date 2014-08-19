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

    property RelatorioParent: TWinControl read fRelatorioParent write fRelatorioParent;
    property DataSet: TDataSet read fDataSet write SetDataSet;
    property NomeDetalhamento: String read fNomeDetalhamento;

    property Detalhe: TDesenho read fDetalhe;
    property Cabecalho: TDesenho read fCabecalho;
    property Rodape: TDesenho read fRodape;
  end;

implementation

{ TDetalhamento }

procedure TDetalhamento.Cores(CorCabecalho, CorDetalhe, CorRodape: TColor);
begin
  fBandCabecalho.Color := CorCabecalho;
  fBandDetalhe.Color := CorDetalhe;
  fBandRodape.Color := CorRodape;
end;

procedure TDetalhamento.Configurar();
begin
  fBandCabecalho.Height := 0;
  fBandDetalhe.Height := 0;
  fBandRodape.Height := 0;

  fCabecalho := TDesenho.Create(fRelatorioParent, fBandCabecalho);
  fDetalhe := TDesenho.Create(fRelatorioParent, fBandDetalhe);
  fRodape := TDesenho.Create(fRelatorioParent, fBandRodape);
end;

constructor TDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String);
begin
  fNomeDetalhamento := ANomeDetalhamento;
  fRelatorioParent := TWinControl(AOwner);

  fBandCabecalho := TQRBand.Create(fRelatorioParent);
  fBandDetalhe := TQRBand.Create(fRelatorioParent);
  fBandSeparador := TQRChildBand.Create(fRelatorioParent);
  fBandRodape := TQRBand.Create(fRelatorioParent);

  fBandCabecalho.Name := 'Cabecalho' + fNomeDetalhamento;
  fBandDetalhe.Name := 'Detalhe' + fNomeDetalhamento;
  fBandRodape.Name := 'Rodape' + fNomeDetalhamento;

  fBandCabecalho.Parent := fRelatorioParent;
  fBandDetalhe.Parent := fRelatorioParent;
  fBandRodape.Parent := fRelatorioParent;

  fBandCabecalho.BandType := rbPageHeader;
  TQRBand(fBandDetalhe).BandType := rbDetail;
  TQRBand(fBandDetalhe).ForceNewPage := true;
  TQRBand(fBandDetalhe).HasChild := true;
  fBandRodape.BandType := rbPageFooter;

  fBandSeparador.ParentBand := TQRBand(fBandDetalhe);

  Configurar();
end;

constructor TDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String; ACabecaho, ADetalhe, ARodape: TQRCustomBand);
begin
  fNomeDetalhamento := ANomeDetalhamento;
  fRelatorioParent := TWinControl(AOwner);

  fBandCabecalho := TQRBand(ACabecaho);
  fBandDetalhe := TQRBand(ADetalhe);
  fBandRodape := TQRBand(ARodape);

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

procedure TDetalhamento.SetDataSet(const Value: TDataSet);
begin
  fDataSet := Value;
  { if (TipoDetalhe = tdDetalhe) then
    TQuickRep(RelatorioParentX).DataSet := fDataSet; }
end;

end.
