unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, DBXFirebird, FMTBcd, DB, SqlExpr, Provider, DBClient,
  Grids, DBGrids, ExtCtrls, DBCtrls;

type
  TForm1 = class(TForm)
    SQLConnection1: TSQLConnection;
    qryClientes: TSQLQuery;
    qryVendas: TSQLQuery;
    dspMaster: TDataSetProvider;
    dtsMaster: TDataSource;
    cdsClientes: TClientDataSet;
    cdsVendas: TClientDataSet;
    dtsClientes: TDataSource;
    cdsClientesCUST_NO: TIntegerField;
    cdsClientesCUSTOMER: TStringField;
    cdsClientesCONTACT_FIRST: TStringField;
    cdsClientesCONTACT_LAST: TStringField;
    cdsClientesPHONE_NO: TStringField;
    cdsClientesADDRESS_LINE1: TStringField;
    cdsClientesADDRESS_LINE2: TStringField;
    cdsClientesCITY: TStringField;
    cdsClientesSTATE_PROVINCE: TStringField;
    cdsClientesCOUNTRY: TStringField;
    cdsClientesPOSTAL_CODE: TStringField;
    cdsClientesON_HOLD: TStringField;
    cdsClientesqryVendas: TDataSetField;
    dtsVendas: TDataSource;
    dbgClientes: TDBGrid;
    dbgVendas: TDBGrid;
    DBNavigator1: TDBNavigator;
    DBNavigator2: TDBNavigator;
    cdsVendasPO_NUMBER: TStringField;
    cdsVendasCUST_NO: TIntegerField;
    cdsVendasSALES_REP: TSmallintField;
    cdsVendasORDER_STATUS: TStringField;
    cdsVendasORDER_DATE: TSQLTimeStampField;
    cdsVendasSHIP_DATE: TSQLTimeStampField;
    cdsVendasDATE_NEEDED: TSQLTimeStampField;
    cdsVendasPAID: TStringField;
    cdsVendasQTY_ORDERED: TIntegerField;
    cdsVendasTOTAL_VALUE: TFMTBCDField;
    cdsVendasDISCOUNT: TSingleField;
    cdsVendasITEM_TYPE: TStringField;
    cdsVendasAGED: TFMTBCDField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  SQLConnection1.Open;
  cdsClientes.Open;
end;

end.
