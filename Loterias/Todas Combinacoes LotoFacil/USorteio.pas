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
    FNumerosSorteados: TNumeros;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    property NumerosSorteio: TNumeros read FNumerosSorteados write FNumerosSorteados;
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
  FNumerosSorteados := TNumeros.Create;
end;

destructor TSorteio.Destroy;
begin
  FreeAndNil(FNumerosSorteados);
  inherited;
end;

end.
