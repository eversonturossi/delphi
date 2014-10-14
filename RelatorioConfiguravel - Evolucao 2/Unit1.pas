unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, FMTBcd, DBClient, DB, SqlExpr, Provider, StdCtrls,
  DBXFirebird, Relatorio_NovaImpressao, Grids, DBGrids, URelatorioUtil;

type
  TForm1 = class(TForm)
    ButtonAbrirDataSets: TButton;
    ButtonGerarRelatorio: TButton;
    cdsRelatorio: TClientDataSet;
    Connection: TSQLConnection;
    DBGridMaster: TDBGrid;
    DBGridDetalhe: TDBGrid;
    dsItens: TDataSource;
    dspRelatorio: TDataSetProvider;
    dsRelatorio: TDataSource;
    SQLRelatorio: TSQLQuery;
    Button1: TButton;
    procedure ButtonAbrirDataSetsClick(Sender: TObject);
    procedure ButtonGerarRelatorioClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    RelatorioNovaImpressao: TRelatorioNovaImpressao;
    cdItens: TClientDataSet;
    cdOrdem: TClientDataSet;
    cdBloqueio: TClientDataSet;
  public
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

destructor TForm1.Destroy;
begin
  inherited;
end;

procedure TForm1.ButtonAbrirDataSetsClick(Sender: TObject);
var
  SQL_Itens, SQL_Ordem, SQL_Bloqueio: String;
begin
  Connection.DriverName := 'Firebird';
  Connection.GetDriverFunc := 'getSQLDriverINTERBASE';
  Connection.LibraryName := 'dbxfb.dll';
  Connection.VendorLib := 'fbclient.dll';

  Connection.Params.Values['Database'] := ExtractFilePath(ParamStr(0)) + '\DADOS.FDB';
  Connection.Params.Values['UserName'] := 'sysdba';
  Connection.Params.Values['Password'] := 'masterkey';

  SQLRelatorio.SQL.Clear;
  SQLRelatorio.SQL.Add('SELECT PEDIDO.* FROM PEDIDO WHERE (NUMERO > 1) AND (NUMERO <25)');
  SQL_Itens := 'SELECT ITEMPEDIDO.* FROM ITEMPEDIDO WHERE (ITEMPEDIDO.NUMERO = :NUMERO) ORDER BY NUMERO,PRODUTO';
  SQL_Ordem := 'SELECT ORDEMPEDIDO.* FROM ORDEMPEDIDO WHERE (ORDEMPEDIDO.NUMERO = :NUMERO) ';
  SQL_Bloqueio := 'SELECT BLOQUEIOPEDIDO.* FROM BLOQUEIOPEDIDO WHERE (BLOQUEIOPEDIDO.PEDIDO = :NUMERO)';
  cdsRelatorio.Open;

  cdItens := CriarDatasetDinamicoAntigo(Self, SQL_Itens, 'NUMERO', 'NUMERO', Connection, dsRelatorio);
  cdItens.Open;
  dsItens.DataSet := cdItens;

  cdOrdem := CriarDatasetDinamicoAntigo(Self, SQL_Ordem, 'NUMERO', 'NUMERO', Connection, dsRelatorio);
  cdOrdem.Open;

  cdBloqueio := CriarDatasetDinamicoAntigo(Self, SQL_Bloqueio, 'PEDIDO', 'NUMERO', Connection, dsRelatorio);
  cdBloqueio.Open;
end;

procedure TForm1.ButtonGerarRelatorioClick(Sender: TObject);
begin
  TButton(Sender).Enabled := False;
  ButtonAbrirDataSets.Enabled := False;
  DBGridMaster.DataSource := nil;
  dsItens.DataSet := nil;
  try
    RelatorioNovaImpressao := TRelatorioNovaImpressao.Create(Self);
    RelatorioNovaImpressao.DataSet := cdsRelatorio;
    RelatorioNovaImpressao.Detalhe01.DataSet := cdItens;
    RelatorioNovaImpressao.Detalhe02.DataSet := cdOrdem;
    RelatorioNovaImpressao.Detalhe03.DataSet := cdBloqueio;
    RelatorioNovaImpressao.MontarRelatorio();
    RelatorioNovaImpressao.Preview();
  finally
    FreeAndNil(RelatorioNovaImpressao);
    DBGridMaster.DataSource := dsRelatorio;
    dsItens.DataSet := cdItens;
    TButton(Sender).Enabled := True;
    ButtonAbrirDataSets.Enabled := True;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  TButton(Sender).Enabled := False;
  try
    RelatorioNovaImpressao := TRelatorioNovaImpressao.Create(Self);
    RelatorioNovaImpressao.MontarRelatorioDinamico();
    RelatorioNovaImpressao.Preview();
  finally
    FreeAndNil(RelatorioNovaImpressao);
    TButton(Sender).Enabled := True;
  end;
end;

end.
