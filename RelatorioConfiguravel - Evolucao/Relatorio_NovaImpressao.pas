unit Relatorio_NovaImpressao;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRPrntr, QRCtrls, DB, DBClient, QRPDFFilt,
  CJVQRBarCode;

type
  TTipoBand = (tHeaderUnico, tHeaderPagina, tDetalhe, tSubDetalhe, tRodape);

  TRelatorioNovaImpressao = class(TQuickRep)
    QRBandCabecalhoUnico: TQRBand;
    QRBandRodape: TQRBand;
    QRPDFFilter1: TQRPDFFilter;
    QRBandSubDetalhe: TQRSubDetail;
    QRBandCabecalhoProduto: TQRChildBand;
    QRBandDetalhe: TQRChildBand;
    QRBandCabecalhoGeral: TQRBand;
    QRBand1: TQRBand;
    QRBand2: TQRBand;
    procedure QRBandCabecalhoGeralBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    procedure ConfigurarCampoLabel(var Componente: TQRCustomLabel; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand: String);
    procedure AdicionarCampoLabel(Texto: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand: String);
    procedure AdicionarCampoDBLabel(Field: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand, TipoBand: String);

    function GetParent(Tipo: String): TWinControl;
    procedure RedimensionarParent(Componente: TWinControl);

    procedure AdicionarBand(Nome: String; TipoBand: TTipoBand);
  public
    Constructor Create(AOwner: TComponent); override;
    procedure MontarRelatorio();
    procedure Preview();
  end;

implementation

{$R *.DFM}
{ TRelatorioNovaImpressao }

Constructor TRelatorioNovaImpressao.Create(AOwner: TComponent);
var
  I: Integer;
begin
  inherited;
  for I := 0 to ComponentCount - 1 do
    if (TComponent(Components[I]).ClassType = TQRBand) or (TComponent(Components[I]).ClassType = TQRSubDetail) then
    begin
      TQRCustomBand(Components[I]).Visible := False;
      TQRCustomBand(Components[I]).Height := 1;
      TQRCustomBand(Components[I]).TransparentBand := False;
    end;
end;

procedure TRelatorioNovaImpressao.Preview;
begin
  Self.PrevInitialZoom := qrZoom100;
  Self.PreviewInitialState := wsMaximized;
  Self.PrevShowThumbs := False;
  Self.PrevShowSearch := False;
  Self.PreviewModal;
end;

procedure TRelatorioNovaImpressao.ConfigurarCampoLabel(var Componente: TQRCustomLabel; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand: String);
begin
  Componente.Parent := GetParent(NomeBand);
  Componente.Left := Coluna;
  Componente.Top := Linha;
  Componente.Font.Size := TamanhoFonte;
  Componente.Width := TamanhoMaxTexto;
  Componente.AutoSize := False;
  if (TamanhoMaxTexto = 0) then
    Componente.AutoSize := True;
  RedimensionarParent(Componente);
end;

procedure TRelatorioNovaImpressao.AdicionarCampoLabel(Texto: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand: String);
var
  Componente: TQRCustomLabel;
begin
  Componente := TQRLabel.Create(Self);
  TQRLabel(Componente).Transparent := True;
  TQRLabel(Componente).Caption := Texto;
  ConfigurarCampoLabel(Componente, Linha, Coluna, TamanhoMaxTexto, TamanhoFonte, NomeBand);
end;

procedure TRelatorioNovaImpressao.AdicionarCampoDBLabel(Field: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand, TipoBand: String);
var
  Componente: TQRCustomLabel;
begin
  Componente := TQRDBText.Create(Self);
  TQRDBText(Componente).Transparent := True;

  if (TipoBand = 'D') then
    TQRDBText(Componente).DataSet := Self.DataSet
  else
    if (TipoBand = 'S') then
      TQRDBText(Componente).DataSet := QRBandSubDetalhe.DataSet;

  TQRDBText(Componente).DataField := Field;
  ConfigurarCampoLabel(Componente, Linha, Coluna, TamanhoMaxTexto, TamanhoFonte, NomeBand);
end;

procedure TRelatorioNovaImpressao.AdicionarBand(Nome: String; TipoBand: TTipoBand);
var
  ABand: TComponent;
begin
  case TipoBand of
    tHeaderUnico: ABand := TComponent.Create(Self);
    tHeaderPagina: ABand := TComponent.Create(Self);
    tDetalhe: ABand := TComponent.Create(Self);
    tSubDetalhe: ABand := TComponent.Create(Self);
    tRodape: ABand := TComponent.Create(Self);
  end;
end;

function TRelatorioNovaImpressao.GetParent(Tipo: String): TWinControl;
begin
  Result := TWinControl(FindComponent(Tipo));
end;

procedure TRelatorioNovaImpressao.RedimensionarParent(Componente: TWinControl);
var
  TamanhoOcupadoComponente: Integer;
begin
  TamanhoOcupadoComponente := Componente.Top + Componente.Height;
  if (Componente.Parent.Height < TamanhoOcupadoComponente) then
    Componente.Parent.Height := TamanhoOcupadoComponente;
end;

procedure TRelatorioNovaImpressao.QRBandCabecalhoGeralBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  // PrintBand := (Self.PageNumber > 1);
end;

procedure TRelatorioNovaImpressao.MontarRelatorio();
begin
  AdicionarCampoLabel('texto cabeçalho unico', 1, 10, 0, 12, 'QRBandCabecalhoUnico');
  AdicionarCampoLabel('Total Itens: ' + IntToStr(Self.DataSet.RecordCount), 1, 300, 0, 12, 'QRBandCabecalhoUnico');
  AdicionarCampoLabel('texto fixo geral  ', 1, 100, 0, 12, 'QRBandCabecalhoGeral');
  AdicionarCampoLabel('texto fixo produto', 1, 100, 0, 12, 'QRBandCabecalhoProduto');
  AdicionarCampoLabel('texto fixo rodape ', 1, 100, 0, 12, 'QRBandRodape');

  AdicionarCampoDBLabel('numero', 1, 50, 50, 12, 'QRBandCabecalhoUnico', 'D');
  AdicionarCampoLabel('texto fixo detalhe', 1, 50, 0, 12, 'QRBandDetalhe');
  AdicionarCampoDBLabel('numero', 100, 50, 0, 12, 'QRBandDetalhe', 'D');

  AdicionarCampoDBLabel('numero', 2, 50, 0, 12, 'QRBand2', 'D');

  AdicionarCampoDBLabel('numero', 1, 50, 0, 20, 'QRBandSubDetalhe', 'S');
  AdicionarCampoDBLabel('produto', 1, 200, 0, 20, 'QRBandSubDetalhe', 'S');
  AdicionarCampoLabel('texto fixo sub detalhe', 100, 200, 0, 10, 'QRBandSubDetalhe');
end;

end.
