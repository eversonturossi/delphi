unit UDSServerModuleConfiguracao;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider, Data.DB, Data.SqlExpr;

type
  TDSServerModuleConfiguracao = class(TDSServerModule)
    SQLTabelasFirebird: TSQLQuery;
    dspTabelasFirebird: TDataSetProvider;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UDataModuleConexaoBanco;

{$R *.dfm}

end.

