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
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
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

    cdsRelatorio.Open;
    cdsItens.Open;

    RelatorioNovaImpressao.Gerar();
    RelatorioNovaImpressao.Preview();

  finally
    FreeAndNil(RelatorioNovaImpressao);
  end;
end;

end.
