unit UDataModuleConexao;

interface

uses
  SysUtils, Classes, WideStrings, DB, SqlExpr, DbxDatasnap, DBClient, DSConnect;

type
  TDataModuleConexao = class(TDataModule)
    Conexao: TSQLConnection;
    DSProviderCadastro: TDSProviderConnection;
    DSProviderMovimento: TDSProviderConnection;
    DSProviderRelatorio: TDSProviderConnection;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleConexao: TDataModuleConexao;

implementation

{$R *.dfm}

end.
