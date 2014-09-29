{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2008 CodeGear            }
{                                                       }
{*******************************************************}

unit TestServerModule;

interface

uses
  SysUtils, Classes, DB, DBXCommon, DataSnapTestData, DBClient, WideStrings, DBXMsSql,
  SqlExpr, DBXBlackfishSQL;

type
/// SERVER SIDE CLASS.
/// For Delphi applications, a TDataModule would be a logical container for
/// server methods because most server methods will need access to components.
/// Howerver this example shows that there are only two requirements for a
/// server methods class:  1) The class must be a descendent of TPersistent,
/// and 2) MethodInfo must be enabled.
///
{$MethodInfo on}
  TSimpleServerModule = class(TDataModule)
    ClientDataSet1: TClientDataSet;
    SQLConnection1: TSQLConnection;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    function EchoDataSet(DataSet: TDataSet): TDataSet;
    function EchoParams(Params: TParams): TParams;
    function EchoStream(Stream: TStream): TStream;
    function GetServerConnection: TDBXConnection;
  end;
{$MethodInfo off}

var
  SimpleServerModule: TSimpleServerModule;

implementation

{$R *.dfm}




constructor TSimpleServerModule.Create(AOwner: TComponent);
begin
  inherited;
end;

destructor TSimpleServerModule.Destroy;
begin
  inherited;
end;


function TSimpleServerModule.EchoDataSet(DataSet: TDataSet): TDataSet;
begin
  // Input parameter will be freed by the caller who created it.
  //
//  TDataGenerator.PopulateDataSet(ClientDataSet1);
//  TDataGenerator.Check(TDataGenerator.DataSetEqual(DataSet, ClientDataSet1));
  DataSet.First;
  Result := ClientDataSet1;
end;

function TSimpleServerModule.EchoParams(Params: TParams): TParams;
begin
  Result := TParams.Create(nil);
//  TDataGenerator.PopulateParams(Result);
//  TDataGenerator.Check(TDataGenerator.ParamsEqual(Params, Result));
end;


function TSimpleServerModule.EchoStream(Stream: TStream): TStream;
var
  MemoryStream: TMemoryStream;
begin
  // Input parameter will be freed by the caller who created it.
  // Maintain a reference to the returned value because it is not possible
  // to specify that a return value should be freed.
  //
  MemoryStream := TMemoryStream.Create;
//  TDataGenerator.PopulateMemoryStream(MemoryStream);
//  TDataGenerator.Check(TDataGenerator.StreamEqual(Stream, MemoryStream));
  MemoryStream.Seek(0, TSeekOrigin.soBeginning);
  Result := MemoryStream;
end;


function TSimpleServerModule.GetServerConnection: TDBXConnection;
begin
  // A client application can share this server side connection by setting
  // the client TDBXPropertyNames.ServerConnection connection property
  // to this string:
  //
  // ServerConnection=ServerMethodsDataModule.GetServerConnection
  //
  SQLConnection1.Open;
  Result := SQLConnection1.DBXConnection;
end;

end.
