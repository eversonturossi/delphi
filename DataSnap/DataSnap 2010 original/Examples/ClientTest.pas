unit ClientTest;
{ *********************************************************************** }
{                                                                         }
{ DataSnap ServerMethod example.                                          }
{                                                                         }
{ Copyright (c) 1995-2008 CodeGear                                        }
{                                                                         }
{ *********************************************************************** }
///
///  This unit provides examples of basic DataSnap 2008 usage for server methods.
///  The server and client included in this project.  Normally these would be in
///  separate projects and executed in separate processes.  In this example, the
///  client and server are combined into the same project and execute in
///  the same process to provide a concise single executable example of usage.
///  Units that would normally execute in a server process have "Server" in their
///  name. Units that would normall execute in a client process have "Client" in
///  their name.
///
///  This client is a collection of dunit tests.  These are not rigorous tests.
///  They are made simple to provide easy to read examples of how to use the
///  new DataSnap 2008 features.
///
interface
uses
  DB,
  Classes,
  DataSnapTestData,
  TestFramework,
  DBXTest,
  DBXCommon,
  DBXCommonTable,
  DSPlatform,
  DBXDBReaders,
  DSServer,
  DSCommonServer,
  DataBkr,
  DSTCPServerTransport,
  FmtBcd,
  SqlTimSt,
  SysUtils,
  DbClient,
  WideStrings,
  SqlExpr,
  DSProxy;


type


  /// CLIENT SIDE TEST
  ///
  TServerMethodTests = class(TDBXTestCase)
  private
    procedure SetConnectionParams(SQLConnection: TSQLConnection);
  published
    {$IFDEF CLR}[test]{$endif}
    procedure TestCreateClientProxies; virtual;
    {$IFDEF CLR}[test]{$endif}
    procedure TestEchoDataSet; virtual;
    {$IFDEF CLR}[test]{$endif}
    procedure TestEchoParams; virtual;
    {$IFDEF CLR}[test]{$endif}
    procedure TestEchoStream; virtual;
    {$IFDEF CLR}[test]{$endif}
    procedure TestServerConnection; virtual;
  end;



implementation
uses
  DBXDataSnap,
  DBXPlatform,
  DBXTableFactory,
  DSCommonTable,
  DSNames
  ;



procedure TServerMethodTests.SetConnectionParams(SQLConnection: TSQLConnection);
var
  Params: TStrings;
begin
  Params := SQLConnection.Params;
  // Connect to DataSnap server using DataSnap driver.  This is in the
  // DBXClientDriver package that is also used for the Blackfish SQL
  // server.
  //
  SQLConnection.DriverName := 'Datasnap';
  Params.Add(TDBXPropertyNames.DriverName+'=DataSnap');
  Params.Add(TDBXPropertyNames.HostName+'=localhost');
  Params.Add(TDBXPropertyNames.Port+'=212');
  Params.Add(TDBXPropertyNames.UserName+'=sysdba');
  Params.Add(TDBXPropertyNames.Password+'=masterkey');
end;



procedure TServerMethodTests.TestEchoParams;
var
  SQLConnection: TSQLConnection;
  SQLServerMethod: TSqlServerMethod;
  Params: TParams;
begin

  SQLServerMethod := nil;
  SQLConnection   := nil;
  Params          := nil;
  try
    SQLConnection := TSQLConnection.Create(nil);
    SetConnectionParams(SQLConnection);
    SQLConnection.Open;

    SQLServerMethod := TSqlServerMethod.Create(nil);
    SQLServerMethod.SQLConnection := SQLConnection;
    // Omit the preceeding 'T' in the class name.
    //
    SQLServerMethod.CommandText := 'TSimpleServerModule.EchoParams';
    Params := TParams.Create(nil);
//    TDataGenerator.PopulateParams(Params);
    SQLServerMethod.Params[0].AsParams := Params;
    // Internal call to prepare will automatically add parameters of the correct type.
    // Return value is always available as the last parameter.
    // By default DataType for a TParams return value is ftDataSet.
    // Force it to ftParams.
    //
    SQLServerMethod.Params[1].DataType := ftParams;
    SQLServerMethod.ExecuteMethod;

    // After execution, SQLServerMethod DataSet should have same contents as the
    // params we sent as an input parameter.
    //
//    Check(TDataGenerator.ParamsEqual(SQLServerMethod.Params[1].AsParams, Params));

    // Return parameter is always sent as last parameter.
    //
    Check(SQLServerMethod.Params.Count = 2);

  finally
    FreeAndNil(SQLServerMethod);
    FreeAndNil(SQLConnection);
    FreeAndNil(Params);
  end;

end;


procedure TServerMethodTests.TestEchoStream;
var
  SQLConnection: TSQLConnection;
  SQLServerMethod: TSqlServerMethod;
  Stream: TMemoryStream;
  ParamStream: TStream;
begin

  SQLServerMethod := nil;
  SQLConnection   := nil;
  Stream          := nil;
  ParamStream     := nil;
  try
    SQLConnection := TSQLConnection.Create(nil);
    SetConnectionParams(SQLConnection);
    SQLConnection.Open;

    SQLServerMethod := TSqlServerMethod.Create(nil);
    SQLServerMethod.SQLConnection := SQLConnection;
    // Omit the preceeding 'T' in the class name.
    //
    SQLServerMethod.CommandText := 'TSimpleServerModule.EchoStream';
    Stream := TMemoryStream.Create;
//    TDataGenerator.PopulateMemoryStream(Stream);
    SQLServerMethod.Params[0].AsStream := Stream;
    // Temporary.  Default type after prepare should be ftStream, but is currently
    // ftBlob
    //
//    SQLServerMethod.Params[1].DataType := ftStream;
    // Internal call to prepare will automatically add parameters of the correct type.
    // Return value is always available as the last parameter.
    //
    SQLServerMethod.ExecuteMethod;

    // After execution, SQLServerMethod Stream should have same contents as the
    // Stream we sent as an input parameter.
    //
    Stream.Seek(0, TSeekOrigin.soBeginning);
    ParamStream := SQLServerMethod.Params[1].AsStream;
//    Check(TDataGenerator.StreamEqual(ParamStream, Stream));
    FreeAndNil(ParamStream);

    // Return parameter is always sent as last parameter.
    //
    Check(SQLServerMethod.Params.Count = 2);

  finally
    FreeAndNil(ParamStream);
    FreeAndNil(SQLServerMethod);
    FreeAndNil(SQLConnection);
    FreeAndNil(Stream);
  end;
end;



procedure TServerMethodTests.TestCreateClientProxies;
var
  DSProxyGenerator: TDSProxyGenerator;
begin
  // Normally this would be performed by invoking the DSProxyGen.exe utility.
  //
  DSProxyGenerator := nil;
  try
    DSProxyGenerator := TDSProxyGenerator.Create('Delphi.Personality');
    DSProxyGenerator.OutputFileName := 'ClientTestClasses.pas';
    DSProxyGenerator.GenerateProxy;
  finally
    FreeAndNil(DSProxyGenerator);
  end;
end;

procedure TServerMethodTests.TestEchoDataSet;
var
  SQLConnection: TSQLConnection;
  SQLServerMethod: TSqlServerMethod;
  Dataset: TClientDataSet;
begin

  SQLServerMethod := nil;
  SQLConnection   := nil;
  DataSet         := nil;
  try
    SQLConnection := TSQLConnection.Create(nil);
    SetConnectionParams(SQLConnection);
    SQLConnection.Open;

    SQLServerMethod := TSqlServerMethod.Create(nil);
    SQLServerMethod.SQLConnection := SQLConnection;
    // Omit the preceeding 'T' in the class name.
    //
    SQLServerMethod.CommandText := 'TSimpleServerModule.EchoDataSet';
    DataSet := TClientDataSet.Create(nil);
//    TDataGenerator.PopulateDataSet(DataSet);
    SQLServerMethod.Params[0].AsDataSet := DataSet;
    // Internal call to prepare will automatically add parameters of the correct
    // type.  Return value is always available as the last parameter.
    //
    SQLServerMethod.Open;

    // After execution, SQLServerMethod DataSet should have same contents as the
    // DataSet we sent as an input parameter.
    //
//    Check(TDataGenerator.DataSetEqual(SQLServerMethod, DataSet));

    // Return parameter is always sent as last parameter.
    //
    Check(SQLServerMethod.Params.Count = 2);
    // TSQLServerMethod populates itself with the result.
    //
    Check(SQLServerMethod.Params[1].AsDataSet = SQLServerMethod);

  finally
    FreeAndNil(SQLServerMethod);
    FreeAndNil(SQLConnection);
    FreeAndNil(DataSet);
  end;
end;

procedure TServerMethodTests.TestServerConnection;
var
  SQLConnection: TSQLConnection;
  SQLQuery: TSqlQuery;
begin
  SQLQuery      := nil;
  SQLConnection := nil;
  try
    SQLConnection := TSQLConnection.Create(nil);
    SetConnectionParams(SQLConnection);
    SQLConnection.Params.Add(
      TDBXPropertyNames.ServerConnection+'=TSimpleServerModule.GetServerConnection');
    SQLConnection.Open;

    SQLQuery := TSqlQuery.Create(nil);
    SQLQuery.SQLConnection := SQLConnection;
    SQLQuery.CommandText := 'select * from employee';
    SQLQuery.Open;

  finally
    FreeAndNil(SQLQuery);
    FreeAndNil(SQLConnection);
  end;
end;



initialization
  RegisterTest(TServerMethodTests.Suite);
end.
