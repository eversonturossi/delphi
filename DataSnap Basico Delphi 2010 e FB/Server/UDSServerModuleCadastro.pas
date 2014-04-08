unit UDSServerModuleCadastro;

interface

uses
  SysUtils, Classes, DSServer, FMTBcd, DB, SqlExpr, UDataModuleConexao, Provider;

type
  TDSServerModuleCadastro = class(TDSServerModule)
    SQLClifor: TSQLQuery;
    dspClifor: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TDSServerModuleCadastro.DSServerModuleCreate(Sender: TObject);
begin
  SQLClifor.SQLConnection := DataModuleConexao.ConexaoFirebird;
end;

end.
