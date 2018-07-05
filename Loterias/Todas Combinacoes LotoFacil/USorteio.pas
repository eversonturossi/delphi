unit USorteio;

{ soretios ate agora }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Generics.Collections, Generics.Defaults,
  UNumeros;

type
  TSorteio = class(TObject)
  private
    FNumeros: TNumeros;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    property Numeros: TNumeros read FNumeros write FNumeros;
  end;

  TSorteios = class(TObjectList<TSorteio>)
  end;

implementation

{ TSorteio }

procedure TSorteio.Clear;
begin

end;

constructor TSorteio.Create;
begin
  FNumeros := TNumeros.Create;
end;

destructor TSorteio.Destroy;
begin
  FreeAndNil(FNumeros);
  inherited;
end;

end.
