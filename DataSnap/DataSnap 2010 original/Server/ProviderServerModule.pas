{ ******************************************************* }
{ }
{ CodeGear Delphi Visual Component Library }
{ }
{ Copyright (c) 1995-2008 CodeGear }
{ }
{ ******************************************************* }

unit ProviderServerModule;

interface

uses
  SysUtils, Classes, DSServer, WideStrings, DbxBlackfishSQL, FMTBcd, DB,
  SqlExpr, Provider, dialogs;

type
  TDSServerModule2 = class(TDSServerModule)
    SQLConnection1: TSQLConnection;
    DataSnapTestData: TDataSetProvider;
    DataSnapTestDataQuery: TSQLQuery;
    procedure DataSnapTestDataQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DSServerModule2: TDSServerModule2;

implementation

{$R *.dfm}

procedure TDSServerModule2.DataSnapTestDataQueryBeforeOpen(DataSet: TDataSet);
begin
  showmessage('abriu a query ' + TSQLQuery(DataSet).Name);
end;

end.
