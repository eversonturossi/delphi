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
    FNumeros: TNumeros;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    property Numeros: TNumeros read FNumeros write FNumeros;
  end;

  TApostas = class(TObjectList<TAposta>)
  end;

implementation

{ TAposta }

procedure TAposta.Clear;
begin

end;

constructor TAposta.Create;
begin
  FNumeros := TNumeros.Create;
end;

destructor TAposta.Destroy;
begin
  FreeAndNil(FNumeros);
  inherited;
end;

end.
