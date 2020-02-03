unit UFonte;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  UCampo, UCampoList;

type
  TFonte = class(TObject)
  private
    FCampoList: TCampoList;
    FNomeBase: String;
    FNomeClasse: String;
    FNomeUnit: String;

    FFonte: TStringList;

    function GetNomeClasse: String;
    function GetNomeUnit: String;

    procedure GerarUnitCabecalho;
    procedure GerarUses;
    procedure GerarClasseCabecalho;
    procedure GerarClasseCampos;
    procedure GerarClasseMetodosPadrao;
    procedure GerarClasseSets;
    procedure GerarClasseGets;
    procedure GerarClassePropertys;
    procedure GerarConstructorDestructor;
    procedure GerarClear;
    procedure GerarSets;
    procedure GerarGets;
    procedure GerarUnitRodape;

    procedure Add(AValue: String); overload;
    procedure Add(AValue: String; const Args: array of const); overload;

    function GetValorPadrao(ATipo: String): String;
  public
    constructor Create(ACampoList: TCampoList; ANomeBase: String);
    destructor Destroy; override;
    procedure Gerar;
    function GetFonte: TStringList;
  end;

implementation

{ TFonte }

procedure TFonte.Add(AValue: String);
begin
  FFonte.Add(AValue);
end;

procedure TFonte.Add(AValue: String; const Args: array of const);
begin
  FFonte.Add(Format(AValue, Args));
end;

constructor TFonte.Create(ACampoList: TCampoList; ANomeBase: String);
begin
  FFonte := TStringList.Create;
  FCampoList := ACampoList;
  FNomeBase := ANomeBase;
  FNomeClasse := GetNomeClasse;
  FNomeUnit := GetNomeUnit;
end;

destructor TFonte.Destroy;
begin
  FreeAndNil(FFonte);
  inherited;
end;

function TFonte.GetFonte: TStringList;
begin
  Result := FFonte;
end;

function TFonte.GetNomeClasse: String;
begin
  Result := FNomeBase;
  Result := 'T' + FNomeBase;
  if (Copy(Result, 1, 3) = 'TTT') then
    Delete(Result, 1, 1);
end;

function TFonte.GetNomeUnit: String;
begin
  Result := FNomeBase;
  Result := 'U' + FNomeBase;
  if (Copy(Result, 1, 3) = 'UUU') then
    Delete(Result, 1, 1);
end;

procedure TFonte.Gerar;
begin
  FFonte.Clear;
  GerarUnitCabecalho;
  GerarUses;
  GerarClasseCabecalho;
  GerarClasseCampos;
  GerarClasseMetodosPadrao;
  GerarClasseSets;
  GerarClasseGets;
  GerarClassePropertys;
  GerarConstructorDestructor;
  GerarClear;
  GerarSets;
  GerarGets;
  GerarUnitRodape;
end;

procedure TFonte.GerarUnitCabecalho;
begin
  Add('unit %S;', [FNomeUnit]);
  Add('');
  Add('interface');
  Add('');
end;

procedure TFonte.GerarUses;
begin
  Add('uses');
  Add('  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, System.StrUtils;');
  Add('');
end;

function TFonte.GetValorPadrao(ATipo: String): String;
var
  LTipo: String;
begin
  LTipo := UpperCase(ATipo);
  if (LTipo = 'STRING') then
    Result := ''''''
  else
    if (LTipo = 'INTEGER') then
      Result := '-1'
    else
      if (LTipo = 'DOUBLE') then
        Result := '0'
      else
        if (LTipo = 'TDATE') then
          Result := '0'
        else
          if (LTipo = 'TDATETIME') then
            Result := '0'
          else
            Result := '''''';
end;

procedure TFonte.GerarClasseCabecalho;
begin
  Add('type');
  Add('  %S = class(TObject)', [FNomeClasse]);
  Add('  private');
end;

procedure TFonte.GerarClasseCampos;
var
  I: Integer;
begin
  for I := 0 to Pred(FCampoList.Count) do
    Add('    F%S: %S;', [FCampoList[I].Nome, FCampoList[I].Tipo]);
end;

procedure TFonte.GerarClasseMetodosPadrao;
begin
  Add('  public');
  Add('    constructor Create;');
  Add('    destructor  Destroy;override;');
  Add('    procedure Clear;');
end;

procedure TFonte.GerarClasseSets;
var
  I: Integer;
begin
  for I := 0 to Pred(FCampoList.Count) do
    Add('    procedure Set%S(AValue: %S);', [FCampoList[I].Nome, FCampoList[I].Tipo]);
end;

procedure TFonte.GerarClasseGets;
var
  I: Integer;
begin
  for I := 0 to Pred(FCampoList.Count) do
    Add('    function Get%S: %S);', [FCampoList[I].Nome, FCampoList[I].Tipo]);
end;

procedure TFonte.GerarClassePropertys;
var
  I: Integer;
begin
  for I := 0 to Pred(FCampoList.Count) do
    Add('    propcerty %S: %S read F%0:S write F%0:S);', [FCampoList[I].Nome, FCampoList[I].Tipo]);
  Add('  end;');
end;

procedure TFonte.GerarConstructorDestructor;
begin
  Add('');
  Add('  implementation');
  Add('');
  Add('{ %S }', [FNomeClasse]);
  Add('');
  Add('constructor %S.Create();', [FNomeClasse]);
  Add('begin');
  Add('  Self.Clear;');
  Add('end;');
  Add('');
  Add('destrucotor %S.Destructor;', [FNomeClasse]);
  Add('begin');
  Add('  inherited');
  Add('end;');
  Add('');
end;

procedure TFonte.GerarClear;
var
  I: Integer;
begin
  Add('procedure %S.Clear;', [FNomeClasse]);
  Add('begin');
  for I := 0 to Pred(FCampoList.Count) do
    Add('  Self.F%S := %S;', [FCampoList[I].Nome, GetValorPadrao(FCampoList[I].Tipo)]);
  Add('end;');
  Add('');
end;

procedure TFonte.GerarSets;
var
  I: Integer;
begin
  for I := 0 to Pred(FCampoList.Count) do
  begin
    Add('procedure %S.Set%S(AValue: %S);', [FNomeClasse, FCampoList[I].Nome, FCampoList[I].Tipo]);
    Add('begin');
    Add('  Self.F%S := AValue;', [FCampoList[I].Nome]);
    Add('end;');
    Add('');
  end;
end;

procedure TFonte.GerarGets;
var
  I: Integer;
begin
  for I := 0 to Pred(FCampoList.Count) do
  begin
    Add('function %S.Get%S: %S;', [FNomeClasse, FCampoList[I].Nome, FCampoList[I].Tipo]);
    Add('begin');
    Add('  Result := Self.F%S;', [FCampoList[I].Nome]);
    Add('end;');
    Add('');
  end;
end;

procedure TFonte.GerarUnitRodape;
begin
  Add('end.');
end;

end.
