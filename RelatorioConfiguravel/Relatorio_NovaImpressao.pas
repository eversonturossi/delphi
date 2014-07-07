unit Relatorio_NovaImpressao;

interface

uses Windows, SysUtils, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms, QuickRpt, QRPrntr, QRCtrls, DB, DBClient, QRPDFFilt,
  CJVQRBarCode;

type
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
    procedure ConfigurarCampoLabel(var Componente: TQRCustomLabel; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; Tipo: Char);
    procedure AdicionarCampoLabel(Texto: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; Tipo: Char);
    procedure AdicionarCampoDBLabel(Field: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; Tipo: Char);
    procedure AdicionarBarCode(Texto: String; Linha, Coluna: Integer; Tipo: Char);
    function GetParent(Tipo: Char): TWinControl;
    procedure RedimensionarParent(Componente: TWinControl);
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

procedure TRelatorioNovaImpressao.AdicionarBarCode(Texto: String; Linha, Coluna: Integer; Tipo: Char);
var
  Componente: TCJVQRBarCode;
begin { http://www.veloso.adm.br/cjvbarcode.asp }
  Componente := TCJVQRBarCode.Create(Self);
  Componente.Parent := GetParent(Tipo);
  Componente.Top := Linha;
  Componente.Left := Coluna;
  Componente.AutoSize := True;
  Componente.Legenda := True;
  Componente.Texto := Texto;
  RedimensionarParent(Componente);
end;

procedure TRelatorioNovaImpressao.AdicionarCampoLabel(Texto: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; Tipo: Char);
var
  Componente: TQRCustomLabel;
begin
  Componente := TQRLabel.Create(Self);
  TQRLabel(Componente).Transparent := True;
  TQRLabel(Componente).Caption := Texto;
  ConfigurarCampoLabel(Componente, Linha, Coluna, TamanhoMaxTexto, TamanhoFonte, Tipo);
end;

procedure TRelatorioNovaImpressao.AdicionarCampoDBLabel(Field: String; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; Tipo: Char);
var
  Componente: TQRCustomLabel;
begin
  Componente := TQRDBText.Create(Self);
  TQRDBText(Componente).Transparent := True;

  if (Tipo = 'D') then
    TQRDBText(Componente).DataSet := Self.DataSet
  else
    if (Tipo = 'S') then
      TQRDBText(Componente).DataSet := QRBandSubDetalhe.DataSet;

  TQRDBText(Componente).DataField := Field;
  ConfigurarCampoLabel(Componente, Linha, Coluna, TamanhoMaxTexto, TamanhoFonte, Tipo);
end;

function TRelatorioNovaImpressao.GetParent(Tipo: Char): TWinControl;
begin
  case Tipo of
    'H': Result := QRBandCabecalhoUnico;
    'C': Result := QRBandCabecalhoGeral;
    'X': Result := QRBandCabecalhoProduto;
    'D': Result := QRBandDetalhe;
    'S': Result := QRBandSubDetalhe;
    'R': Result := QRBandRodape;
  end;
  TWinControl(Result).Visible := True;
end;

procedure TRelatorioNovaImpressao.RedimensionarParent(Componente: TWinControl);
var
  TamanhoOcupadoComponente: Integer;
begin
  TamanhoOcupadoComponente := Componente.Top + Componente.Height;
  if (Componente.Parent.Height < TamanhoOcupadoComponente) then
    Componente.Parent.Height := TamanhoOcupadoComponente;
end;

procedure TRelatorioNovaImpressao.ConfigurarCampoLabel(var Componente: TQRCustomLabel; Linha, Coluna, TamanhoMaxTexto, TamanhoFonte: Integer; Tipo: Char);
begin
  Componente.Parent := GetParent(Tipo);
  Componente.Left := Coluna;
  Componente.Top := Linha;
  Componente.Font.Size := TamanhoFonte;
  Componente.Width := TamanhoMaxTexto;
  Componente.AutoSize := False;
  if (TamanhoMaxTexto = 0) then
    Componente.AutoSize := True;
  RedimensionarParent(Componente);
end;

procedure TRelatorioNovaImpressao.Preview;
begin
  Self.PrevInitialZoom := qrZoom100;
  Self.PreviewInitialState := wsMaximized;
  Self.PrevShowThumbs := False;
  Self.PrevShowSearch := False;
  Self.PreviewModal;
end;

procedure TRelatorioNovaImpressao.QRBandCabecalhoGeralBeforePrint(Sender: TQRCustomBand; var PrintBand: Boolean);
begin
  PrintBand := (Self.PageNumber > 1);
end;

procedure TRelatorioNovaImpressao.MontarRelatorio();
begin
  AdicionarCampoLabel('texto H', 1, 10, 50, 12, 'H');
  AdicionarCampoLabel('Total Itens: ' + IntToStr(Self.DataSet.RecordCount), 1, 300, 0, 12, 'H');
  AdicionarCampoLabel('texto C', 1, 100, 0, 12, 'C');
  AdicionarCampoLabel('texto C', 1, 100, 0, 12, 'X');
  AdicionarCampoLabel('texto R', 1, 10, 50, 12, 'R');

  AdicionarCampoLabel('teste teste', 1, 50, 50, 12, 'D');
  AdicionarCampoDBLabel('numero', 1, 50, 50, 12, 'H');
  AdicionarCampoDBLabel('produto', 1, 10, 50, 20, 'S');
  AdicionarCampoDBLabel('numero', 1, 100, 50, 20, 'S');

  AdicionarBarCode('173000661', 1, 500, 'H');
end;

end.
