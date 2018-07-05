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
  public
    constructor Create; overload;
    constructor Create(ANumeros: String); overload;
    destructor Destroy; override;
    procedure Clear;

    property NumerosCombinacao: TNumeros read FNumerosCombinacao write FNumerosCombinacao;
  end;

  TCombinacoes = class(TObjectList<TCombinacao>)
  end;

implementation

{ TCombinacao }

procedure TCombinacao.Clear;
begin

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

end.
