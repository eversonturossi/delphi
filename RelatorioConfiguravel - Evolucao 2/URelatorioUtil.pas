unit URelatorioUtil;

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  QuickRpt,
  QRPrntr,
  QRCtrls,
  DB,
  DBClient,
  QRPDFFilt,
  Provider,
  DBXFirebird, SqlExpr { sqlconnection }
  ;

type
  TParametrosMasterDetail =   Array of String;

function ConcatenaParametros(Itens: array of String): String;

function CriarDataSetDinamico(AOwner: TComponent; SQL: String; ParametrosDetail, ParametroMaster: array of String; MasterSource: TDataSource): TClientDataSet;
function CriarDatasetDinamicoAntigo(AOwner: TComponent; SQL, NomeCampo, NomeParametro: String; Con: TSQLConnection; MasterSource: TDataSource): TClientDataSet;
function CriarDataSourceDinamico(AOwner: TComponent; ADataSet: TDataSet): TDataSource;

implementation

function ConcatenaParametros(Itens: array of String): String;
var
  I: Integer;
begin
  Result := '';
  for I := Low(Itens) to High(Itens) do
  begin
    if (I > 0) then
      Result := Result + ';';
    Result := Result + Itens[I];
  end;
end;

function CriarDataSetDinamico(AOwner: TComponent; SQL: String; ParametrosDetail, ParametroMaster: array of String; MasterSource: TDataSource): TClientDataSet;
var
  ADataSet: TClientDataSet;
  AParam: TParam;
  IParametros: Integer;
begin
  ADataSet := TClientDataSet.Create(AOwner);
  ADataSet.IndexFieldNames := ConcatenaParametros(ParametrosDetail);
  ADataSet.MasterFields := ConcatenaParametros(ParametroMaster);
  // ADataSet.FetchOnDemand := False;   <----    nao usar

  if (MasterSource <> nil) then
  begin
    ADataSet.MasterSource := MasterSource;
    ADataSet.PacketRecords := 0;
  end;

  for IParametros := Low(ParametroMaster) to High(ParametroMaster) do
  begin
    AParam := TParam.Create(nil);
    AParam.DataType := ftInteger;
    AParam.Name := ParametroMaster[IParametros];
    ADataSet.Params.AddParam(AParam);
  end;
  Result := ADataSet;
end;

function CriarDatasetDinamicoAntigo(AOwner: TComponent; SQL, NomeCampo, NomeParametro: String; Con: TSQLConnection; MasterSource: TDataSource): TClientDataSet;
var
  AQuery: TSQLQuery;
  AProvider: TDataSetProvider;
  ADataSet: TClientDataSet;
  AParam: TParam;
begin
  AQuery := TSQLQuery.Create(AOwner);
  AProvider := TDataSetProvider.Create(AOwner);
  ADataSet := TClientDataSet.Create(AOwner);

  AQuery.SQLConnection := Con;
  AQuery.SQL.Add(SQL);
  AProvider.DataSet := AQuery;
  ADataSet.SetProvider(AProvider);
  ADataSet.IndexFieldNames := NomeCampo;
  ADataSet.MasterFields := NomeParametro;
  // ADataSet.FetchOnDemand := False;       nao usar

  if (MasterSource <> nil) then
  begin
    ADataSet.MasterSource := MasterSource;
    ADataSet.PacketRecords := 0;
  end;

  if (NomeParametro <> '') then
  begin
    AParam := TParam.Create(nil);
    AParam.DataType := ftInteger;
    AParam.Name := NomeParametro;
    AQuery.Params.AddParam(AParam);
    ADataSet.Params.AddParam(AParam);
  end;

  Result := ADataSet;
end;

function CriarDataSourceDinamico(AOwner: TComponent; ADataSet: TDataSet): TDataSource;
var
  ADataSource: TDataSource;
begin
  ADataSource := TDataSource.Create(AOwner);
  ADataSource.DataSet := ADataSet;
  Result := ADataSource;
end;

end.
