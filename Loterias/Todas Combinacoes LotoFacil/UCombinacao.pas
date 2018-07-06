unit UCombinacao;

{ combinacoes pra teste de 8 a 15 digitos }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Generics.Collections, Generics.Defaults,
  UNumeros;

type
  TCombinacao = class(TObject)
  private
    FNumerosCombinacao: TNumeros;
    FOcorrencias: Integer;
  public
    constructor Create; overload;
    constructor Create(ANumeros: String); overload;
    destructor Destroy; override;
    procedure Clear;
    procedure VerificaOcorrencias(AQuantidadeNumeros: Integer; ANumerosSorteados: TNumeros);

    property Ocorrencias: Integer read FOcorrencias write FOcorrencias;
    property NumerosCombinacao: TNumeros read FNumerosCombinacao write FNumerosCombinacao;
  end;

  TCombinacoes = class(TObjectList<TCombinacao>)
  end;

  TCombinacaoComparer = class(TComparer<TCombinacao>)
  public
    function Compare(const Item1, Item2: TCombinacao): Integer; override;
  end;

implementation

{ TCombinacao }

procedure TCombinacao.Clear;
begin
  FOcorrencias := 0;
end;

constructor TCombinacao.Create;
begin
  FNumerosCombinacao := TNumeros.Create;
end;

constructor TCombinacao.Create(ANumeros: String);
begin
  Create;
  Self.NumerosCombinacao.Carregar(ANumeros);
end;

destructor TCombinacao.Destroy;
begin
  FreeAndNil(FNumerosCombinacao);
  inherited;
end;

procedure TCombinacao.VerificaOcorrencias(AQuantidadeNumeros: Integer; ANumerosSorteados: TNumeros);
var
  LAcertos: Integer;
begin
  LAcertos := FNumerosCombinacao.Acertos(ANumerosSorteados);
  if ( LAcertos >= AQuantidadeNumeros) then
    FOcorrencias := FOcorrencias + 1;
end;

{ TCombinacaoComparer }

function TCombinacaoComparer.Compare(const Item1, Item2: TCombinacao): Integer;
begin
  if (Item1.Ocorrencias < Item2.Ocorrencias) then
    Result := -1
  else
    if (Item1.Ocorrencias > Item2.Ocorrencias) then
      Result := 1
    else
      Result := 0;
end;

end.
