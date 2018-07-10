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
    FValor_Rateio_12_Numeros: Double;
    FValor_Rateio_13_Numeros: Double;
    FValor_Rateio_11_Numeros: Double;
    FValor_Rateio_14_Numeros: Double;
    FValor_Rateio_15_Numeros: Double;
    FGanhadores_12_Numeros: Integer;
    FGanhadores_13_Numeros: Integer;
    FGanhadores_11_Numeros: Integer;
    FGanhadores_14_Numeros: Integer;
    FGanhadores_15_Numeros: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;

    property Concurso: Integer read FConcurso write FConcurso;
    property DataSorteio: TDate read FDataSorteio write FDataSorteio;
    property NumerosSorteio: TNumeros read FNumerosSorteados write FNumerosSorteados;

    property Ganhadores_15_Numeros: Integer read FGanhadores_15_Numeros write FGanhadores_15_Numeros;
    property Ganhadores_14_Numeros: Integer read FGanhadores_14_Numeros write FGanhadores_14_Numeros;
    property Ganhadores_13_Numeros: Integer read FGanhadores_13_Numeros write FGanhadores_13_Numeros;
    property Ganhadores_12_Numeros: Integer read FGanhadores_12_Numeros write FGanhadores_12_Numeros;
    property Ganhadores_11_Numeros: Integer read FGanhadores_11_Numeros write FGanhadores_11_Numeros;
    property Valor_Rateio_15_Numeros: Double read FValor_Rateio_15_Numeros write FValor_Rateio_15_Numeros;
    property Valor_Rateio_14_Numeros: Double read FValor_Rateio_14_Numeros write FValor_Rateio_14_Numeros;
    property Valor_Rateio_13_Numeros: Double read FValor_Rateio_13_Numeros write FValor_Rateio_13_Numeros;
    property Valor_Rateio_12_Numeros: Double read FValor_Rateio_12_Numeros write FValor_Rateio_12_Numeros;
    property Valor_Rateio_11_Numeros: Double read FValor_Rateio_11_Numeros write FValor_Rateio_11_Numeros;
  end;

  TSorteios = class(TObjectList<TSorteio>)
  end;

implementation

{ TSorteio }

procedure TSorteio.Clear;
begin
  FConcurso := 0;
  FDataSorteio := 0;

  FGanhadores_15_Numeros := 0;
  FGanhadores_14_Numeros := 0;
  FGanhadores_13_Numeros := 0;
  FGanhadores_12_Numeros := 0;
  FGanhadores_11_Numeros := 0;
  FValor_Rateio_15_Numeros := 0;
  FValor_Rateio_14_Numeros := 0;
  FValor_Rateio_13_Numeros := 0;
  FValor_Rateio_12_Numeros := 0;
  FValor_Rateio_11_Numeros := 0;

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
