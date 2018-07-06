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
    FConcurso: Integer;
    FDataSorteio: TDate;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    property Concurso: Integer read FConcurso write FConcurso;
    property DataSorteio: TDate read FDataSorteio write FDataSorteio;
    property NumerosSorteio: TNumeros read FNumerosSorteados write FNumerosSorteados;
  end;

  TSorteios = class(TObjectList<TSorteio>)
  end;

implementation

{ TSorteio }

procedure TSorteio.Clear;
begin
  FConcurso := 0;
  FDataSorteio := 0;
  FNumerosSorteados.Clear;
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
