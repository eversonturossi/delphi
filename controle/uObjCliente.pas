unit uObjCliente;

interface

const
  arquivoDados = 'CLIENTES.DATA';
  nrCampos = 6;

type
  TObjCliente = record
    ID: integer;
    NOME: string;
    ENDERECO: string;
    TELEFONE: string;
    CPF: string;
    ID_USUARIO: integer;
  end;

  TClientes = class(TObject)
  private
    Itens: array of TObjCliente;
    Len: integer;
    function Find(NOME: string): TClientes;
    procedure AddTemp(Cliente: TObjCliente);
    function TotalRegistros: integer;
  public
    constructor Create;
    destructor Destroy;
    procedure LoadFromFile;
    procedure SaveToFile;
    procedure Add(Cliente: TObjCliente);
    procedure Modify(Cliente: TObjCliente);
    procedure Delete(ID: integer);
    procedure Clear;
    function Count: integer;
    function Get(ID: integer): TObjCliente;
    function GetPosicao(posicao: integer): TObjCliente;
    function LastID: integer;
    function ProxID: integer;
    function FindByName(NOME: string): TClientes;
  end;

implementation

uses SysUtils, Classes;

constructor TClientes.Create;
begin
  Len := 0;
  SetLength(Itens, TotalRegistros);
  // ------------------------------------------------------
  // LoadFromFile;
end;

destructor TClientes.Destroy;
begin
  SetLength(Itens, 0);
  Len := 0;
end;

function TClientes.TotalRegistros: integer;
var
  F: TextFile;
  T: string;
  I: integer;
begin
  I := 0;
  if FileExists(arquivoDados) then
  begin
    AssignFile(F, arquivoDados);
    Reset(F);
    I := 0;
    while not Eof(F) do
    begin
      Readln(F, T);
      I := I + 1;
    end;
    CloseFile(F);
  end;
  Result := Trunc(I / nrCampos);
end;

procedure TClientes.LoadFromFile;
var
  F: TextFile;
  T: string;
  DEFINE: integer;
begin
  if not FileExists(arquivoDados) then
    exit;
  AssignFile(F, arquivoDados);
  Reset(F);
  DEFINE := 0;
  while not Eof(F) do
  begin
    Readln(F, T);
    if DEFINE = 0 then
    begin
      Inc(Len);
      Itens[Len - 1].ID := StrToInt(T);
    end
    else if DEFINE = 1 then
      Itens[Len - 1].NOME := T
    else if DEFINE = 2 then
      Itens[Len - 1].ENDERECO := T
    else if DEFINE = 3 then
      Itens[Len - 1].TELEFONE := T
    else if DEFINE = 4 then
      Itens[Len - 1].CPF := T
    else if DEFINE = 5 then
    begin
      Itens[Len - 1].ID_USUARIO := StrToInt(T);
      DEFINE := -1;
    end;
    Inc(DEFINE);
  end;
  CloseFile(F);
end;

procedure TClientes.SaveToFile;
var
  F: TextFile;
  I: integer;
begin
  AssignFile(F, arquivoDados);
  ReWrite(F);
  for I := 0 to Len - 1 do
  begin
    WriteLn(F, IntToStr(Itens[I].ID));
    WriteLn(F, Itens[I].NOME);
    WriteLn(F, Itens[I].ENDERECO);
    WriteLn(F, Itens[I].TELEFONE);
    WriteLn(F, Itens[I].CPF);
    WriteLn(F, IntToStr(Itens[I].ID_USUARIO));
  end;
  CloseFile(F);
end;

procedure TClientes.Add(Cliente: TObjCliente);
begin
  SetLength(Itens, Len + 1);
  Itens[Len] := Cliente;
  Inc(Len);
  // ------------------------------------------------------
  // SaveToFile;
end;

procedure TClientes.AddTemp(Cliente: TObjCliente);
begin
  SetLength(Itens, Len + 1);
  Itens[Len] := Cliente;
  Inc(Len);
end;

procedure TClientes.Modify(Cliente: TObjCliente);
var
  I: integer;
begin
  for I := 0 to Len do
    if Itens[I].ID = Cliente.ID then
    begin
      Itens[I] := Cliente;
      Break;
    end;
  // ------------------------------------------------------
  // SaveToFile;
end;

procedure TClientes.Delete(ID: integer);
var
  TempArray: array of TObjCliente;
  I, ix: integer;
begin
  if (Len = 0) then
    exit;
  Dec(Len);
  SetLength(TempArray, Len);
  ix := 0;
  for I := 0 to Len do
    if Itens[I].ID <> ID then
    begin
      TempArray[ix] := Itens[I];
      Inc(ix);
    end;
  SetLength(Itens, Len);
  for I := 0 to Len - 1 do
    Itens[I] := TempArray[I];
  TempArray := nil;
  // ------------------------------------------------------
  // SaveToFile;
end;

procedure TClientes.Clear;
begin
  SetLength(Itens, 0);
  Len := 0;
end;

function TClientes.Count: integer;
begin
  Result := Len;
end;

function TClientes.Get(ID: integer): TObjCliente;
var
  I: integer;
begin
  for I := 0 to Len do
    if Itens[I].ID = ID then
    begin
      Result := Itens[I];
      Break;
    end;
end;

function TClientes.GetPosicao(posicao: integer): TObjCliente;
begin
  Result := Itens[posicao];
end;

function TClientes.LastID: integer;
begin
  if Len > 0 then
    Result := Itens[Len - 1].ID
  else
    Result := 0;
end;

function TClientes.ProxID: integer;
begin
  Result := LastID + 1;
end;

function TClientes.Find(NOME: string): TClientes;
var
  I: integer;
  ResBusca: TClientes;
begin
  ResBusca := TClientes.Create;
  for I := 0 to Len - 1 do
    if Pos(LowerCase(NOME), LowerCase(Itens[I].NOME)) > 0 then
      ResBusca.AddTemp(Itens[I]);
  Result := ResBusca;
end;

function TClientes.FindByName(NOME: string): TClientes;
begin
  Result := Find(NOME);
end;

end.
