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
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    property NumerosAposta: TNumeros read FNumerosAposta write FNumerosAposta;
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
  FNumerosAposta := TNumeros.Create;
end;

destructor TAposta.Destroy;
begin
  FreeAndNil(FNumerosAposta);
  inherited;
end;

end.
