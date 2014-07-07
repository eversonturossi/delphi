unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, FMTBcd, DBClient, DB, SqlExpr, Provider, StdCtrls,
  DBXFirebird, Relatorio_NovaImpressao, Grids, DBGrids;

type
  TForm1 = class(TForm)
    Connection: TSQLConnection;
    SQLRelatorio: TSQLQuery;
    SQLItens: TSQLQuery;
    cdsRelatorio: TClientDataSet;
    cdsItens: TClientDataSet;
    dspItens: TDataSetProvider;
    dspRelatorio: TDataSetProvider;
    Button1: TButton;
    DBGrid1: TDBGrid;
    dsRelatorio: TDataSource;
    dsItens: TDataSource;
    DBGrid2: TDBGrid;
    procedure Button1Click(Sender: TObject);
  private
    RelatorioNovaImpressao: TRelatorioNovaImpressao;
    function CriarDatasetDinamico(ASql, NomeParametro: String; Con: TSQLConnection; Master: TDataSource): TClientDataSet;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function TForm1.CriarDatasetDinamico(ASql, NomeParametro: String; Con: TSQLConnection; Master: TDataSource): TClientDataSet;
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

  if (Master <> nil) then
  begin
    ADataSet.MasterSource := Master;
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

procedure TForm1.Button1Click(Sender: TObject);
var
  AParam: TParam;
begin
  try
    Connection.DriverName := 'Firebird';
    Connection.GetDriverFunc := 'getSQLDriverINTERBASE';
    Connection.LibraryName := 'dbxfb.dll';
    Connection.VendorLib := 'fbclient.dll';

    Connection.Params.Values['Database'] := ExtractFilePath(ParamStr(0)) + '\DADOS.FDB';
    Connection.Params.Values['UserName'] := 'sysdba';
    Connection.Params.Values['Password'] := 'masterkey';

    RelatorioNovaImpressao := TRelatorioNovaImpressao.Create(Self);

    RelatorioNovaImpressao.DataSet := cdsRelatorio;
    RelatorioNovaImpressao.QRBandSubDetalhe.DataSet := cdsItens;

    SQLRelatorio.SQL.Add('select');
    SQLRelatorio.SQL.Add('pedido.*');
    SQLRelatorio.SQL.Add('from pedido');

    SQLItens.SQL.Add('select');
    SQLItens.SQL.Add('itempedido.*');
    SQLItens.SQL.Add('from itempedido');
    SQLItens.SQL.Add('where itempedido.numero = :numero');

    // link dinamico
    // cdsItens.MasterSource := dsRelatorio;
    // cdsItens.PacketRecords := 0;
    // cdsItens.IndexFieldNames := 'numero';
    // cdsItens.MasterFields := 'numero';
    // AParam := TParam.Create(nil);
    // AParam.DataType := ftInteger;
    // AParam.Name := 'numero';
    // cdsItens.Params.Clear;
    // cdsItens.Params.AddParam(AParam);

    cdsRelatorio.Open;
    cdsItens.Open;

    RelatorioNovaImpressao.MontarRelatorio();
    RelatorioNovaImpressao.Preview();

  finally
    FreeAndNil(RelatorioNovaImpressao);
  end;
end;

end.
