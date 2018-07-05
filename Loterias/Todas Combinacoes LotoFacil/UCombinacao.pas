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
    FNumeros: TNumeros;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    property Numeros: TNumeros read FNumeros write FNumeros;
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
  FNumeros := TNumeros.Create;
end;

destructor TCombinacao.Destroy;
begin
  FreeAndNil(FNumeros);
  inherited;
end;

end.
