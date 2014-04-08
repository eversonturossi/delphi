unit UDataModuleConexao;

interface

uses
  SysUtils, Classes, WideStrings, DBXFirebird, DB, SqlExpr;

type
  TDataModuleConexao = class(TDataModule)
    ConexaoFirebird: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleConexao: TDataModuleConexao;

implementation

{$R *.dfm}

procedure TDataModuleConexao.DataModuleCreate(Sender: TObject);
begin
  ConexaoFirebird.Connected := True;
end;

procedure TDataModuleConexao.DataModuleDestroy(Sender: TObject);
begin
  ConexaoFirebird.Connected := False;
end;

end.
