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

{ TSubDetalhamento }

procedure TSubDetalhamento.Cores(CorCabecalho, CorDetalhe, CorRodape: TColor);
begin
  fBandCabecalho.Color := CorCabecalho;
  fBandDetalhe.Color := CorDetalhe;
  fBandRodape.Color := CorRodape;
end;

procedure TSubDetalhamento.Configurar();
begin
  fBandCabecalho.Height := 0;
  fBandDetalhe.Height := 0;
  fBandRodape.Height := 0;

  fCabecalho := TDesenho.Create(fRelatorioParent, fBandCabecalho);
  fDetalhe := TDesenho.Create(fRelatorioParent, fBandDetalhe);
  fRodape := TDesenho.Create(fRelatorioParent, fBandRodape);
end;

constructor TSubDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String);
begin
  fNomeDetalhamento := ANomeDetalhamento;
  fRelatorioParent := TWinControl(AOwner);

  fBandCabecalho := TQRBand.Create(fRelatorioParent);
  fBandDetalhe := TQRSubDetail.Create(fRelatorioParent);
  fBandRodape := TQRBand.Create(fRelatorioParent);

  fBandCabecalho.Name := 'Cabecalho' + fNomeDetalhamento;
  fBandDetalhe.Name := 'Detalhe' + fNomeDetalhamento;
  fBandRodape.Name := 'Rodape' + fNomeDetalhamento;

  fBandCabecalho.Parent := fRelatorioParent;
  fBandDetalhe.Parent := fRelatorioParent;
  fBandRodape.Parent := fRelatorioParent;

  fBandCabecalho.BandType := rbGroupHeader;
  TQRSubDetail(fBandDetalhe).HeaderBand := fBandCabecalho;
  TQRSubDetail(fBandDetalhe).FooterBand := fBandRodape;
  TQRSubDetail(fBandDetalhe).Master := TQuickRep(fRelatorioParent);
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

  Configurar();
end;

constructor TSubDetalhamento.Create(AOwner: TComponent; ANomeDetalhamento: String; ACabecaho, ADetalhe, ARodape: TQRCustomBand);
begin
  fNomeDetalhamento := ANomeDetalhamento;
  fRelatorioParent := TWinControl(AOwner);

  fBandCabecalho := TQRBand(ACabecaho);
  fBandDetalhe := TQRSubDetail(ADetalhe);
  fBandRodape := TQRBand(ARodape);

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
  inherited;
end;

procedure TSubDetalhamento.SetDataSet(const Value: TDataSet);
begin
  fDataSet := Value;
  TQRSubDetail(fBandDetalhe).DataSet := fDataSet;
end;

end.
