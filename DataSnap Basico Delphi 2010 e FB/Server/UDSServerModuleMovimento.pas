unit UDSServerModuleMovimento;

interface

uses
  SysUtils, Classes, DSServer, FMTBcd, Provider, DB, SqlExpr, UDataModuleConexao;

type
  TDSServerModuleMovimento = class(TDSServerModule)
    SQLFinanceiro: TSQLQuery;
    dspFinanceiro: TDataSetProvider;
    procedure DSServerModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

procedure TDSServerModuleMovimento.DSServerModuleCreate(Sender: TObject);
begin
  SQLFinanceiro.SQLConnection := DataModuleConexao.ConexaoFirebird;
end;

end.
