unit Relatorio_NovaImpressao;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRPrntr, QRCtrls, DB, DBClient, QRPDFFilt,
  CJVQRBarCode;

type
  TTipoBand = (tHeaderUnico, tHeaderPagina, tDetalhe, tSubDetalhe, tRodape);

  TRelatorioNovaImpressao = class(TQuickRep)
    QRPDFFilter1: TQRPDFFilter;
    CabecalhoGeral: TQRBand;
    Principal: TQRBand;
    Cabecalho01: TQRChildBand;
    Detalhe01: TQRSubDetail;
    Rodape01: TQRBand;
    Cabecalho02: TQRBand;
    Detalhe02: TQRSubDetail;
    Rodape02: TQRBand;
    Cabecalho03: TQRBand;
    Detalhe03: TQRSubDetail;
    Rodape03: TQRBand;
    procedure QRBandCabecalhoGeralBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
  private
    procedure ConfigurarCampoLabel(var Componente: TQRCustomLabel; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand: String);
    procedure AdicionarCampoLabel(Texto: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand: String);
    procedure AdicionarCampoDBLabel(Field: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand: String);

    function GetParent(NomeComponente: String): TWinControl;
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
    if (TComponent(Components[I]).ClassType = TQRBand) or (TComponent(Components[I]).ClassType = TQRSubDetail) or (TComponent(Components[I]).ClassType = TQRChildBand) then
    begin
      TQRCustomBand(Components[I]).Visible := False;
      TQRCustomBand(Components[I]).Height := 0;
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

procedure TRelatorioNovaImpressao.AdicionarCampoDBLabel(Field: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; NomeBand: String);
var
  Componente: TQRCustomLabel;
  Parent: TComponent;
begin
  Componente := TQRDBText.Create(Self);
  TQRDBText(Componente).Transparent := True;

  Parent := GetParent(NomeBand);
  if (Parent <> nil) then
  begin
    if (Parent.ClassType = TQRSubDetail) then
      TQRDBText(Componente).DataSet := TQRSubDetail(Parent).DataSet
    else
      if (Parent.ClassType = TQRBand) or (Parent.ClassType = TQRChildBand) then
        TQRDBText(Componente).DataSet := Self.DataSet;
  end;

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

function TRelatorioNovaImpressao.GetParent(NomeComponente: String): TWinControl;
begin
  Result := TWinControl(FindComponent(NomeComponente));
end;

procedure TRelatorioNovaImpressao.RedimensionarParent(Componente: TWinControl);
var
  TamanhoOcupadoComponente: Integer;
begin
  TamanhoOcupadoComponente := Componente.Top + Componente.Height;
  if (Componente.Parent <> nil) then // evitar exception de parent inexistente
    if (Componente.Parent.Height < TamanhoOcupadoComponente) then
      Componente.Parent.Height := TamanhoOcupadoComponente;
end;

procedure TRelatorioNovaImpressao.QRBandCabecalhoGeralBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  // PrintBand := (Self.PageNumber > 1);
end;

procedure TRelatorioNovaImpressao.MontarRelatorio();
const
  CabecalhoGeral = 'CabecalhoGeral';
  BaseRelatorio = 'Principal';
  Cabecalho01 = 'Cabecalho01';
  Cabecalho02 = 'Cabecalho02';
  Cabecalho03 = 'Cabecalho03';
  Detalhe01 = 'Detalhe01';
  Detalhe02 = 'Detalhe02';
  Detalhe03 = 'Detalhe03';
  Rodape01 = 'Rodape01';
  Rodape02 = 'Rodape02';
  Rodape03 = 'Rodape03';
  RodapeGeral = 'QRBandRodape';
begin
  AdicionarCampoLabel('Total Itens: ' + IntToStr(Self.DataSet.RecordCount), 1, 300, 0, 12, CabecalhoGeral);
  AdicionarCampoLabel('texto fixo em toda pagina  ', 1, 100, 0, 12, CabecalhoGeral);

  AdicionarCampoLabel('texto fixo em todo rodape ', 1, 100, 0, 12, RodapeGeral);

  AdicionarCampoLabel('texto corpo', 1, 300, 0, 12, BaseRelatorio);
  AdicionarCampoLabel('texto corpo 2', 30, 300, 0, 12, BaseRelatorio);
  AdicionarCampoDBLabel('numero', 1, 50, 50, 12, BaseRelatorio);
  AdicionarCampoDBLabel('emissao', 1, 150, 0, 12, BaseRelatorio);

  AdicionarCampoLabel('numero-->', 1, 50, 0, 10, Cabecalho01);
  AdicionarCampoDBLabel('numero', 1, 50, 0, 10, Detalhe01);
  AdicionarCampoDBLabel('produto', 1, 200, 0, 10, Detalhe01);
  AdicionarCampoLabel('texto fixo itens', 10, 300, 0, 10, Detalhe01);
  AdicionarCampoLabel('numero<--', 1, 50, 0, 10, Rodape01);

  AdicionarCampoLabel('ordem-->', 1, 50, 0, 10, Cabecalho02);
  AdicionarCampoDBLabel('numero', 1, 1, 0, 10, Detalhe02);
  AdicionarCampoDBLabel('ordem', 1, 50, 0, 10, Detalhe02);
  AdicionarCampoDBLabel('VCTO', 1, 100, 0, 10, Detalhe02);
  AdicionarCampoDBLabel('valor', 1, 250, 0, 10, Detalhe02);
  AdicionarCampoLabel('texto fixo ordem', 1, 400, 0, 10, Detalhe02);
  AdicionarCampoLabel('ordem<--', 1, 50, 0, 10, Rodape02);

  AdicionarCampoLabel('bloqueio-->', 1, 50, 0, 10, Cabecalho03);
  AdicionarCampoDBLabel('numero', 1, 1, 0, 10, Detalhe03);
  AdicionarCampoDBLabel('motivo', 1, 50, 0, 10, Detalhe03);
  AdicionarCampoDBLabel('autorizado', 1, 100, 0, 10, Detalhe03);
  AdicionarCampoLabel('texto fixo bloqueio', 1, 400, 0, 10, Detalhe03);
  AdicionarCampoLabel('bloqueio<--', 1, 50, 0, 10, Rodape03);
end;

end.
