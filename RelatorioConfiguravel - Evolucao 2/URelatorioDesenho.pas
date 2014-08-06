unit URelatorioDesenho;

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
  DBClient,
  QRPDFFilt;

type
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
    procedure AdicionarIncrementoAlturaBand(IncrementoAltura: Integer);
    procedure AdicionarShape(TipoShape: TTipoShape; Linha, Coluna, Comprimento, Altura: Integer);
    procedure ConfigurarCampoLabel(var Componente: TQRCustomLabel; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer);

    constructor Create(ARelatorioParent, AComponenteParent: TWinControl);
    destructor Destroy; override;
  end;

implementation

uses StrUtils;

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

procedure TDesenho.AdicionarShape(TipoShape: TTipoShape; Linha, Coluna, Comprimento, Altura: Integer);
var
  Componente: TQRShape;
begin
  VerificaParent();
  Componente := TQRShape.Create(RelatorioParent);
  case TipoShape of
    tsLinha: Componente.Shape := qrsHorLine;
    tsRetangulo: Componente.Shape := qrsRectangle;
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

procedure TDesenho.AdicionarIncrementoAlturaBand(IncrementoAltura: Integer);
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

end.
