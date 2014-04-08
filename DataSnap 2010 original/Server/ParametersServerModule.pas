{ ******************************************************* }
{ }
{ CodeGear Delphi Visual Component Library }
{ }
{ Copyright (c) 1995-2008 CodeGear }
{ }
{ ******************************************************* }

unit ParametersServerModule;

interface

uses
  SysUtils, Classes, DSServer, db, WideStrings, DbxBlackfishSQL, SqlExpr,
  DataSnapTestData, DBXCommon, FMTBcd, dialogs;

type
  TParametersServerModule1 = class(TDSServerModule)
    SQLConnection1: TSQLConnection;
    ReturnSqlQuery: TSQLQuery;
    OutSqlQuery: TSQLQuery;
    VarSqlQuery: TSQLQuery;
    procedure DSServerModuleCreate(Sender: TObject);
    procedure DSServerModuleDestroy(Sender: TObject);
    procedure OutSqlQueryBeforeOpen(DataSet: TDataSet);
    procedure VarSqlQueryBeforeOpen(DataSet: TDataSet);
    procedure ReturnSqlQueryBeforeOpen(DataSet: TDataSet);
  private
    { Private declarations }
    FDataSnapTestData: TDataSnapTestData;
    FReturnCommand: TDBXCommand;
    FOutCommand: TDBXCommand;
    FVarCommand: TDBXCommand;
  public
    { Public declarations }
    function DataSetMethod(InDataSet: TDataSet; out OutDataSet: TDataSet; var VarDataSet: TDataSet): TDataSet;
    function ParamsMethod(InParams: TParams; out OutParams: TParams; var VarParams: TParams): TParams;
    function StreamMethod(InStream: TStream; out OutStream: TStream; var VarStream: TStream): TStream;
    function DBXReaderMethod(InDBXReader: TDBXReader; out OutDBXReader: TDBXReader; var VarDBXReader: TDBXReader): TDBXReader;
    function VariantMethod(InVariant: OleVariant; out OutVariant: OleVariant; var VarVariant: OleVariant): OleVariant;
    function StringMethod(InString: String; out OutString: OleVariant; var VarString: OleVariant): String;
    function Int64Method(InInt64: Int64; out OutInt64: Int64; var VarInt64: Int64): Int64;
    procedure NoparametersMethod;
  end;

var
  ParametersServerModule1: TParametersServerModule1;

implementation

{$R *.dfm}

var
  TableCreated: Boolean;

  { TDSServerModule1 }

procedure TParametersServerModule1.DSServerModuleCreate(Sender: TObject);
begin
  SQLConnection1.Open;
  FDataSnapTestData := TDataSnapTestData.Create(SQLConnection1.DBXConnection);
  if not TableCreated then
  begin
    TableCreated := True;
    FDataSnapTestData.CreateTestTable;
  end;
  FOutCommand := SQLConnection1.DBXConnection.CreateCommand;
  FOutCommand.Text := 'select * from DATASNAP_TEST_DATA';
  FVarCommand := SQLConnection1.DBXConnection.CreateCommand;
  FVarCommand.Text := 'select * from DATASNAP_TEST_DATA';
  FReturnCommand := SQLConnection1.DBXConnection.CreateCommand;
  FReturnCommand.Text := 'select * from DATASNAP_TEST_DATA';
end;

procedure TParametersServerModule1.DSServerModuleDestroy(Sender: TObject);
begin
  FreeAndNil(FDataSnapTestData);
  FreeAndNil(FOutCommand);
  FreeAndNil(FVarCommand);
  FreeAndNil(FReturnCommand);
end;

function TParametersServerModule1.Int64Method(InInt64: Int64; out OutInt64: Int64; var VarInt64: Int64): Int64;
begin
  FDataSnapTestData.ValidateInt64(InInt64);
  FDataSnapTestData.ValidateInt64(VarInt64);

  FDataSnapTestData.PopulateInt64(OutInt64);
  FDataSnapTestData.PopulateInt64(VarInt64);
  FDataSnapTestData.PopulateInt64(Result);
end;

procedure TParametersServerModule1.NoparametersMethod;
begin
end;

procedure TParametersServerModule1.OutSqlQueryBeforeOpen(DataSet: TDataSet);
begin
  showmessage('abriu a query ' + TSQLQuery(DataSet).Name);
end;

function TParametersServerModule1.DBXReaderMethod(InDBXReader: TDBXReader; out OutDBXReader: TDBXReader; var VarDBXReader: TDBXReader): TDBXReader;
begin
  FDataSnapTestData.ValidateReader(InDBXReader);
  FDataSnapTestData.ValidateReader(VarDBXReader);

  OutDBXReader := FOutCommand.ExecuteQuery;
  VarDBXReader := FVarCommand.ExecuteQuery;
  Result := FReturnCommand.ExecuteQuery;
end;

function TParametersServerModule1.VariantMethod(InVariant: OleVariant; out OutVariant: OleVariant; var VarVariant: OleVariant): OleVariant;
begin
  FDataSnapTestData.ValidateVariant(InVariant);
  FDataSnapTestData.ValidateVariant(VarVariant);

  FDataSnapTestData.PopulateVariant(VarVariant);
  FDataSnapTestData.PopulateVariant(OutVariant);
  FDataSnapTestData.PopulateVariant(Result);
end;

procedure TParametersServerModule1.VarSqlQueryBeforeOpen(DataSet: TDataSet);
begin
  showmessage('abriu a query ' + TSQLQuery(DataSet).Name);
end;

function TParametersServerModule1.DataSetMethod(InDataSet: TDataSet; out OutDataSet: TDataSet; var VarDataSet: TDataSet): TDataSet;
begin
  // Validate the contents of the incoming DataSets
  // Incomming DataSets are automatically freed.
  //
  FDataSnapTestData.ValidateDataSet(InDataSet);
  FDataSnapTestData.ValidateDataSet(VarDataSet);

  // None of the outgoing DataSets will be automatically freed because their
  // component owner is not nil.
  //
  OutSqlQuery.Open;
  OutSqlQuery.Refresh;
  OutDataSet := OutSqlQuery;

  VarSqlQuery.Open;
  VarSqlQuery.Refresh;
  VarDataSet := VarSqlQuery;

  ReturnSqlQuery.Open;
  ReturnSqlQuery.Refresh;
  Result := ReturnSqlQuery;
end;

function TParametersServerModule1.ParamsMethod(InParams: TParams; out OutParams: TParams; var VarParams: TParams): TParams;
begin
  // Validate the contents of the incoming DataSets.
  //
  FDataSnapTestData.ValidateParams(InParams);
  FDataSnapTestData.ValidateParams(VarParams);

  // All of these outgoing return values will be automatically freed.
  //
  OutParams := FDataSnapTestData.CreateTestParams;
  VarParams := FDataSnapTestData.CreateTestParams;
  Result := FDataSnapTestData.CreateTestParams;
end;

procedure TParametersServerModule1.ReturnSqlQueryBeforeOpen(DataSet: TDataSet);
begin
  showmessage('abriu a query ' + TSQLQuery(DataSet).Name);
end;

function TParametersServerModule1.StreamMethod(InStream: TStream; out OutStream: TStream; var VarStream: TStream): TStream;
begin
  // Validate the contents of the incoming Streams.
  //
  FDataSnapTestData.ValidateStream(InStream);
  FDataSnapTestData.ValidateStream(VarStream);

  // All of these outgoing values will be automatically freed.
  //
  OutStream := FDataSnapTestData.CreateTestStream;
  VarStream := FDataSnapTestData.CreateTestStream;
  Result := FDataSnapTestData.CreateTestStream;

end;

function TParametersServerModule1.StringMethod(InString: String; out OutString: OleVariant; var VarString: OleVariant): String;
begin
  FDataSnapTestData.ValidateString(InString);
  FDataSnapTestData.ValidateString(VarString);

  FDataSnapTestData.PopulateString(Result);
  OutString := Result;
  VarString := Result;

end;

end.
