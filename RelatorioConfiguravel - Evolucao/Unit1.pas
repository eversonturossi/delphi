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
    cdsRelatorio: TClientDataSet;
    dspRelatorio: TDataSetProvider;
    Button1: TButton;
    DBGrid1: TDBGrid;
    dsRelatorio: TDataSource;
    dsItens: TDataSource;
    DBGrid2: TDBGrid;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    RelatorioNovaImpressao: TRelatorioNovaImpressao;
    cd01: TClientDataSet;
    cd02: TClientDataSet;
    cd03: TClientDataSet;
    function CriarDatasetDinamico(ASql, NomeParametro: String; Con: TSQLConnection; Master: TDataSource): TClientDataSet;
    procedure EnableDisableControls(EnableControls: Boolean);
  public
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

const
  ASqlItens = 'select itempedido.* from itempedido where (itempedido.numero = :numero)';

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

destructor TForm1.Destroy;
begin
  inherited;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Connection.DriverName := 'Firebird';
  Connection.GetDriverFunc := 'getSQLDriverINTERBASE';
  Connection.LibraryName := 'dbxfb.dll';
  Connection.VendorLib := 'fbclient.dll';

  Connection.Params.Values['Database'] := ExtractFilePath(ParamStr(0)) + '\DADOS.FDB';
  Connection.Params.Values['UserName'] := 'sysdba';
  Connection.Params.Values['Password'] := 'masterkey';

  SQLRelatorio.SQL.Clear;
  SQLRelatorio.SQL.Add('select pedido.* from pedido where (numero > 490) and (numero <500)');

  cdsRelatorio.Open;

  cd01 := CriarDatasetDinamico(ASqlItens, 'numero', Connection, dsRelatorio);
  cd01.Open;
  dsItens.DataSet := cd01;
end;

procedure TForm1.EnableDisableControls(EnableControls: Boolean);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if (Components[I] is TClientDataSet) then
    begin
      if EnableControls then
        TClientDataSet(Components[I]).EnableControls
      else
        TClientDataSet(Components[I]).DisableControls;
    end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  EnableDisableControls(False);
  RelatorioNovaImpressao := TRelatorioNovaImpressao.Create(Self);
  try
    RelatorioNovaImpressao.DataSet := cdsRelatorio;
    RelatorioNovaImpressao.QRBandSubDetalhe.DataSet := cd01;
    RelatorioNovaImpressao.MontarRelatorio();
    RelatorioNovaImpressao.Preview();
  finally
    FreeAndNil(RelatorioNovaImpressao);
    EnableDisableControls(True);
  end;
end;

end.
