unit UDataModuleConexaoDataSnap;

interface

uses
  System.SysUtils, System.Classes,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, Data.DB, FireDAC.Comp.Client, Datasnap.DBClient,
  Data.DbxDatasnap, IPPeerClient, Data.DBXCommon, Datasnap.DSConnect,
  Data.SqlExpr, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Phys.TDBXBase,
  FireDAC.Phys.DataSnap;

type
  TDataModuleConexaoDataSap = class(TDataModule)
    FDConexaoDataSnap: TFDConnection;
    ConexaoDataSnap: TSQLConnection;
    DSProviderConfiguracao: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    FDTable1: TFDTable;
    FDPhysDataSnapDriverLink1: TFDPhysDataSnapDriverLink;
    ClientDataSet1NOME_TABELA: TWideStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleConexaoDataSap: TDataModuleConexaoDataSap;

implementation

uses FireDAC.Phys.Datasnap;

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TDataModuleConexaoDataSap.DataModuleCreate(Sender: TObject);
begin
  FDConexaoDataSnap.Open;
end;

procedure TDataModuleConexaoDataSap.DataModuleDestroy(Sender: TObject);
begin
  FDConexaoDataSnap.Close;
end;

end.
