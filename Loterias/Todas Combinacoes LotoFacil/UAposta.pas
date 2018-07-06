unit UAposta;

{ as apostas a serem feitas }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Generics.Collections, Generics.Defaults,
  UNumeros;

type
  TAposta = class(TObject)
  private
    FNumerosAposta: TNumeros;
    FAcertos: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    procedure VerificaAcertos(ANumerosSorteados: TNumeros);

    property Acertos: Integer read FAcertos write FAcertos;
    property NumerosAposta: TNumeros read FNumerosAposta write FNumerosAposta;
  end;

  TApostas = class(TObjectList<TAposta>)
  end;

  TApostaComparer = class(TComparer<TAposta>)
  public
    function Compare(const Item1, Item2: TAposta): Integer; override;
  end;

implementation

{ TAposta }

procedure TAposta.Clear;
begin
  FAcertos := 0;
end;

constructor TAposta.Create;
begin
  FNumerosAposta := TNumeros.Create;
end;

destructor TAposta.Destroy;
begin
  FreeAndNil(FNumerosAposta);
  inherited;
end;

procedure TAposta.VerificaAcertos(ANumerosSorteados: TNumeros);
begin
  FAcertos := FNumerosAposta.Acertos(ANumerosSorteados);
end;

{ TTApostaComparer }

function TApostaComparer.Compare(const Item1, Item2: TAposta): Integer;
begin
  if (Item1.Acertos < Item2.Acertos) then
    Result := -1
  else
    if (Item1.Acertos > Item2.Acertos) then
      Result := 1
    else
      Result := 0;
end;

end.
