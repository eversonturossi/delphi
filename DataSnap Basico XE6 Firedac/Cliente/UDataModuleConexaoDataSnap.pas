unit UDataModuleConexaoDataSnap;

interface

uses
  System.SysUtils, System.Classes,

  Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool,
  FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.DS, FireDAC.Phys.TDBXBase,
  FireDAC.Comp.Client, Data.DB, Datasnap.DBClient, Datasnap.DSConnect,
  Data.SqlExpr;

type
  TDataModuleConexaoDataSap = class(TDataModule)
    ConexaoDataSnap: TSQLConnection;
    DSProviderConfiguracao: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
    ClientDataSet1NOME_TABELA: TWideStringField;
    FDConexaoDataSnap: TFDConnection;
    FDPhysDSDriverLink1: TFDPhysDSDriverLink;
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

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TDataModuleConexaoDataSap.DataModuleCreate(Sender: TObject);
begin
  // FDConexaoDataSnap.Open;
end;

procedure TDataModuleConexaoDataSap.DataModuleDestroy(Sender: TObject);
begin
  // FDConexaoDataSnap.Close;
end;

end.
