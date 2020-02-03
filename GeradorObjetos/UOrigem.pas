unit UOrigem;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  System.StrUtils,
  UCampo, UCampoList;

const
  cNada = '';
  cEspaco = #32;
  cTab = #9;
  cEspacoDuplo = #32 + #32;
  cEnter = #13;
  cQuebra = #10;
  cNull = #0;
  cPontoEVirgula = ';';
  cDoisPontos = ':';

type
  TOrigem = class(TObject)
  private
    FOrigem: TStringList;
    FCampoList: TCampoList;
    procedure TratarPadrao;
    procedure RemoverEspacoInicioFim;
    procedure RemoverLinhaEmBranco;
    procedure RemoverEspacoDuplos;
    procedure RemoverOutros;

    procedure RemoverTab;

    procedure RemoverProperty;
    procedure RemoverReadWrite;

    procedure RemoverF;
    procedure RemovePontoEVirgula;
    procedure RemoveDuplicado;

    procedure RemoverProcedureFunction;
    procedure RemoverGetSet;
    procedure RemoverArgumentos;

    function ExisteEspacoDuplo: Boolean;

    function isProcedure(AValue: String): Boolean;
    function isFunction(AValue: String): Boolean;
    procedure LerCampos;
  public
    constructor Create(AOrigem: TStrings; ACampoList: TCampoList);
    procedure Processar;
  end;

implementation

{ TOrigem }

constructor TOrigem.Create(AOrigem: TStrings; ACampoList: TCampoList);
begin
  FCampoList := ACampoList;
  FOrigem := TStringList.Create;
  FOrigem.AddStrings(AOrigem);
end;

procedure TOrigem.RemoverEspacoInicioFim;
var
  I: Integer;
begin
  for I := 0 to Pred(FOrigem.Count) do
    FOrigem[I] := Trim(FOrigem[I]);
end;

procedure TOrigem.RemoverLinhaEmBranco;
var
  I: Integer;
begin
  for I := Pred(FOrigem.Count) downto 0 do
    if (FOrigem[I] = EmptyStr) then
      FOrigem.Delete(I);
end;

procedure TOrigem.RemoverOutros;
var
  I: Integer;
begin
  for I := 0 to Pred(FOrigem.Count) do
  begin
    FOrigem[I] := StringReplace(FOrigem[I], cEnter, cNada, [rfReplaceAll, rfIgnoreCase]);
    FOrigem[I] := StringReplace(FOrigem[I], cQuebra, cNada, [rfReplaceAll, rfIgnoreCase]);
    FOrigem[I] := StringReplace(FOrigem[I], cNull, cNada, [rfReplaceAll, rfIgnoreCase]);
  end;
end;

function TOrigem.ExisteEspacoDuplo: Boolean;
begin
  Result := (Pos(cEspacoDuplo, FOrigem.Text) > 0);
end;

function TOrigem.isFunction(AValue: String): Boolean;
begin
  Result := False;
  if (Pos('function', AValue) > 0) then
    Result := True;
  if (Pos(')', AValue) = 0) then
    if (Pos(':', AValue) > 0) then
      Result := True;
  if (Pos(')', AValue) > 0) then
    if (PosEx(':', AValue, Pos(')', AValue)) > 0) then
      Result := True;
end;

function TOrigem.isProcedure(AValue: String): Boolean;
begin
  Result := False;
  if (Pos('procedure', AValue) > 0) then
    Result := True;
  if (Pos(')', AValue) = 0) then
    if (Pos(':', AValue) = 0) then
      Result := True;
  if (Pos(')', AValue) > 0) then
    if (PosEx(':', AValue, Pos(')', AValue)) = 0) then
      Result := True;
end;

procedure TOrigem.RemoveDuplicado;
var
  I, IDuplicado: Integer;
  LDuplicado: Boolean;
begin
  for I := Pred(FOrigem.Count) downto 0 do
  begin
    LDuplicado := False;
    for IDuplicado := 0 to Pred(FOrigem.Count) do
    begin
      if (FOrigem[I] = FOrigem[IDuplicado]) then
        if (I <> IDuplicado) then
          LDuplicado := True;
    end;
    if (LDuplicado) then
      FOrigem.Delete(I);
  end;
end;

procedure TOrigem.RemovePontoEVirgula;
var
  I: Integer;
begin
  for I := 0 to Pred(FOrigem.Count) do
    FOrigem[I] := StringReplace(FOrigem[I], cPontoEVirgula, cNada, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TOrigem.RemoverEspacoDuplos;
var
  I: Integer;
begin
  for I := 0 to Pred(FOrigem.Count) do
    FOrigem[I] := StringReplace(FOrigem[I], cEspacoDuplo, cEspaco, [rfReplaceAll, rfIgnoreCase]);
end;

procedure TOrigem.RemoverF;
var
  I: Integer;
  LTexto: String;
begin
  for I := 0 to Pred(FOrigem.Count) do
  begin
    LTexto := FOrigem[I];
    if (LTexto.Length > 2) then
      if (LTexto[1] = 'F') then
        if (LTexto[2] in ['A' .. 'Z']) then
          Delete(LTexto, 1, 1);
    FOrigem[I] := LTexto;
  end;
end;

procedure TOrigem.RemoverProcedureFunction;
var
  I: Integer;
begin
  for I := 0 to Pred(FOrigem.Count) do
  begin
    FOrigem[I] := StringReplace(FOrigem[I], 'procedure', cNada, [rfReplaceAll, rfIgnoreCase]);
    FOrigem[I] := StringReplace(FOrigem[I], 'function', cNada, [rfReplaceAll, rfIgnoreCase]);
  end;
  TratarPadrao;
end;

procedure TOrigem.RemoverProperty;
var
  I: Integer;
begin
  for I := 0 to Pred(FOrigem.Count) do
    FOrigem[I] := StringReplace(FOrigem[I], 'property', cNada, [rfReplaceAll, rfIgnoreCase]);

  TratarPadrao;
end;

procedure TOrigem.RemoverReadWrite;
var
  I: Integer;
  LPosReadWrite: Integer;
  LTexto: String;
begin
  for I := 0 to Pred(FOrigem.Count) do
  begin
    LTexto := FOrigem[I];

    LPosReadWrite := Pos('read', LTexto);
    if (LPosReadWrite = 0) then
      LPosReadWrite := Pos('write', LTexto);
    if (LPosReadWrite > 0) then
      LTexto := Copy(LTexto, 0, LPosReadWrite - 1);

    FOrigem[I] := LTexto;
  end;
  TratarPadrao;
end;

procedure TOrigem.RemoverGetSet;
var
  I: Integer;
  LTexto: String;
begin
  for I := 0 to Pred(FOrigem.Count) do
  begin
    LTexto := FOrigem[I];
    if (LowerCase(Copy(LTexto, 1, 3)) = 'set') then
      Delete(LTexto, 1, 3);
    if (LowerCase(Copy(LTexto, 1, 3)) = 'get') then
      Delete(LTexto, 1, 3);
    FOrigem[I] := LTexto;
  end;
  TratarPadrao;
end;

procedure TOrigem.RemoverArgumentos;
var
  I, LPosRemoveInicio, LPosRemoveFim: Integer;
  LTexto: String;
begin
  for I := 0 to Pred(FOrigem.Count) do
  begin
    LTexto := FOrigem[I];
    LTexto := StringReplace(LTexto, '()', cNada, [rfReplaceAll, rfIgnoreCase]);
    if (Pos('(', LTexto) > 0) then
    begin
      LPosRemoveInicio := Pos('(', LTexto);
      LPosRemoveFim := PosEx(':', LTexto, LPosRemoveInicio);
      Delete(LTexto, LPosRemoveInicio, LPosRemoveFim - LPosRemoveInicio);

      if (Pos(')', LTexto) > 0) then
        Delete(LTexto, Pos(')', LTexto), 1);

      FOrigem[I] := LTexto;

    end;
  end;
end;

procedure TOrigem.RemoverTab;
var
  I: Integer;
begin
  for I := 0 to Pred(FOrigem.Count) do
    FOrigem[I] := Trim(StringReplace(FOrigem[I], cTab, cEspaco, [rfReplaceAll, rfIgnoreCase]));
  TratarPadrao;
end;

procedure TOrigem.TratarPadrao;
begin
  RemoverEspacoInicioFim;
  RemoverLinhaEmBranco;
  RemoverOutros;
  while (ExisteEspacoDuplo) do
    RemoverEspacoDuplos;
end;

procedure TOrigem.LerCampos;
var
  I, ISeparador: Integer;
  LCampo: TCampo;
begin
  for I := 0 to Pred(FOrigem.Count) do
  begin
    ISeparador := Pos(':', FOrigem[I]);
    LCampo := TCampo.Create;

    LCampo.Nome := Copy(FOrigem[I], 1, ISeparador - 1);
    LCampo.Tipo := Copy(FOrigem[I], ISeparador + 1, FOrigem[I].Length);

    FCampoList.Add(LCampo);
  end;
end;

procedure TOrigem.Processar;
begin
  TratarPadrao;
  RemoverTab;

  { somente propertys }
  RemoverProperty;
  RemoverReadWrite;
  RemoverF;

  { somente para interfaces }
  RemoverProcedureFunction;
  RemoverGetSet;
  RemoverArgumentos;
  RemovePontoEVirgula;

  TratarPadrao;
  RemoveDuplicado;
  LerCampos;
end;

end.
