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
    procedure ButtonAbrirDataSetsClick(Sender: TObject);
    procedure ButtonGerarRelatorioClick(Sender: TObject);
  private
    RelatorioNovaImpressao: TRelatorioNovaImpressao;
    cd01: TClientDataSet;
    cd02: TClientDataSet;
    cd03: TClientDataSet;
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

  cd01 := CriarDatasetDinamicoAntigo(Self, SQL_Itens, 'NUMERO', 'NUMERO', Connection, dsRelatorio);
  cd01.Open;
  dsItens.DataSet := cd01;

  cd02 := CriarDatasetDinamicoAntigo(Self, SQL_Ordem, 'NUMERO', 'NUMERO', Connection, dsRelatorio);
  cd02.Open;

  cd03 := CriarDatasetDinamicoAntigo(Self, SQL_Bloqueio, 'PEDIDO', 'NUMERO', Connection, dsRelatorio);
  cd03.Open;
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
    RelatorioNovaImpressao.Detalhe01.DataSet := cd01;
    RelatorioNovaImpressao.Detalhe02.DataSet := cd02;
    RelatorioNovaImpressao.Detalhe03.DataSet := cd03;
    RelatorioNovaImpressao.MontarRelatorio();
    RelatorioNovaImpressao.Preview();
  finally
    FreeAndNil(RelatorioNovaImpressao);
    DBGridMaster.DataSource := dsRelatorio;
    dsItens.DataSet := cd01;
    TButton(Sender).Enabled := True;
    ButtonAbrirDataSets.Enabled := True;
  end;
end;

end.
