unit UDSServerModuleRelatorio;

interface

uses
  SysUtils, Classes, DSServer, UDataModuleConexao, FMTBcd, Provider, DB, SqlExpr;

type
  TDSServerModuleRelatorio = class(TDSServerModule)
    SQLTeste: TSQLQuery;
    dspTeste: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{$R *.dfm}

end.
