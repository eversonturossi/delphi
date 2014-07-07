unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, FMTBcd, DBClient, DB, SqlExpr, Provider, StdCtrls,
  DBXFirebird, Relatorio_NovaImpressao, Grids, DBGrids;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    cdsRelatorio: TClientDataSet;
    Connection: TSQLConnection;
    DBGridMaster: TDBGrid;
    DBGridDetalhe: TDBGrid;
    dsItens: TDataSource;
    dspRelatorio: TDataSetProvider;
    dsRelatorio: TDataSource;
    SQLRelatorio: TSQLQuery;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    RelatorioNovaImpressao: TRelatorioNovaImpressao;
    cd01: TClientDataSet;
    cd02: TClientDataSet;
    cd03: TClientDataSet;
    function CriarDatasetDinamico(ASql, NomeParametro: String; Con: TSQLConnection; MasterSource: TDataSource): TClientDataSet;
  public
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.CriarDatasetDinamico(ASql, NomeParametro: String; Con: TSQLConnection; MasterSource: TDataSource): TClientDataSet;
var
  AQuery: TSQLQuery;
  AProvider: TDataSetProvider;
  ADataSet: TClientDataSet;
  AParam: TParam;
begin
  AQuery := TSQLQuery.Create(Self);
  AProvider := TDataSetProvider.Create(Self);
  ADataSet := TClientDataSet.Create(Self);

  AQuery.SQLConnection := Con;
  AQuery.SQL.Add(ASql);
  AProvider.DataSet := AQuery;
  ADataSet.SetProvider(AProvider);
  ADataSet.IndexFieldNames := NomeParametro;
  ADataSet.MasterFields := NomeParametro;
  // ADataSet.FetchOnDemand := False;       nao usar

  if (MasterSource <> nil) then
  begin
    ADataSet.MasterSource := MasterSource;
    ADataSet.PacketRecords := 0;
  end;

  if (NomeParametro <> '') then
  begin
    AParam := TParam.Create(nil);
    AParam.DataType := ftInteger;
    AParam.Name := NomeParametro;
    AQuery.Params.AddParam(AParam);
    ADataSet.Params.AddParam(AParam);
  end;

  Result := ADataSet;
end;

destructor TForm1.Destroy;
begin
  inherited;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  ASqlItens: String;
begin
  Connection.DriverName := 'Firebird';
  Connection.GetDriverFunc := 'getSQLDriverINTERBASE';
  Connection.LibraryName := 'dbxfb.dll';
  Connection.VendorLib := 'fbclient.dll';

  Connection.Params.Values['Database'] := ExtractFilePath(ParamStr(0)) + '\DADOS.FDB';
  Connection.Params.Values['UserName'] := 'sysdba';
  Connection.Params.Values['Password'] := 'masterkey';

  SQLRelatorio.SQL.Clear;
  SQLRelatorio.SQL.Add('select pedido.* from pedido where (numero > 1) and (numero <500)');
  ASqlItens := 'select itempedido.* from itempedido where (itempedido.numero = :numero) order by numero,produto';

  cdsRelatorio.Open;

  cd01 := CriarDatasetDinamico(ASqlItens, 'numero', Connection, dsRelatorio);
  cd01.Open;
  dsItens.DataSet := cd01;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  DBGridMaster.DataSource := nil;
  dsItens.DataSet := nil;
  RelatorioNovaImpressao := TRelatorioNovaImpressao.Create(Self);
  try
    RelatorioNovaImpressao.DataSet := cdsRelatorio;
    RelatorioNovaImpressao.QRBandSubDetalhe.DataSet := cd01;
    RelatorioNovaImpressao.MontarRelatorio();
    RelatorioNovaImpressao.Preview();
  finally
    FreeAndNil(RelatorioNovaImpressao);
    DBGridMaster.DataSource := dsRelatorio;
    dsItens.DataSet := cd01;
  end;
end;

end.
