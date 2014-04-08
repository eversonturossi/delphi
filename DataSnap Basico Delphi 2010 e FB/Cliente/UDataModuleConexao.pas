unit UDataModuleConexao;

interface

uses
  SysUtils, Classes, WideStrings, DB, SqlExpr, DbxDatasnap;

type
  TDataModuleConexao = class(TDataModule)
    Conexao: TSQLConnection;
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
