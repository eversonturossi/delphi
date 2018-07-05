unit UNumerosOcorrencias;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Generics.Collections, Generics.Defaults,
  UNumeros;

type
  TNumerosOcorrencias = class(TObject)
  private
    FNumero01: Integer;
    FNumero02: Integer;
    FNumero03: Integer;
    FNumero04: Integer;
    FNumero05: Integer;
    FNumero06: Integer;
    FNumero07: Integer;
    FNumero08: Integer;
    FNumero09: Integer;
    FNumero10: Integer;
    FNumero11: Integer;
    FNumero12: Integer;
    FNumero13: Integer;
    FNumero14: Integer;
    FNumero15: Integer;
    FNumero16: Integer;
    FNumero17: Integer;
    FNumero18: Integer;
    FNumero19: Integer;
    FNumero20: Integer;
    FNumero21: Integer;
    FNumero22: Integer;
    FNumero23: Integer;
    FNumero24: Integer;
    FNumero25: Integer;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function Ocorrencias(ACompara: TNumeros): Integer;

    property Numero01: Integer read FNumero01 write FNumero01;
    property Numero02: Integer read FNumero02 write FNumero02;
    property Numero03: Integer read FNumero03 write FNumero03;
    property Numero04: Integer read FNumero04 write FNumero04;
    property Numero05: Integer read FNumero05 write FNumero05;
    property Numero06: Integer read FNumero06 write FNumero06;
    property Numero07: Integer read FNumero07 write FNumero07;
    property Numero08: Integer read FNumero08 write FNumero08;
    property Numero09: Integer read FNumero09 write FNumero09;
    property Numero10: Integer read FNumero10 write FNumero10;
    property Numero11: Integer read FNumero11 write FNumero11;
    property Numero12: Integer read FNumero12 write FNumero12;
    property Numero13: Integer read FNumero13 write FNumero13;
    property Numero14: Integer read FNumero14 write FNumero14;
    property Numero15: Integer read FNumero15 write FNumero15;
    property Numero16: Integer read FNumero16 write FNumero16;
    property Numero17: Integer read FNumero17 write FNumero17;
    property Numero18: Integer read FNumero18 write FNumero18;
    property Numero19: Integer read FNumero19 write FNumero19;
    property Numero20: Integer read FNumero20 write FNumero20;
    property Numero21: Integer read FNumero21 write FNumero21;
    property Numero22: Integer read FNumero22 write FNumero22;
    property Numero23: Integer read FNumero23 write FNumero23;
    property Numero24: Integer read FNumero24 write FNumero24;
    property Numero25: Integer read FNumero25 write FNumero25;
  end;

  TNumeroOcorrencia = class(TObject)
  private
    FOcorrencia: Integer;
    FNumero: String;
  public
    constructor Create; overload;
    constructor Create(ANumero: String; AOcorrencia: Integer); overload;
    property Numero: String read FNumero write FNumero;
    property Ocorrencia: Integer read FOcorrencia write FOcorrencia;
  end;

  TNumerosOrdenar = class(TObjectList<TNumeroOcorrencia>)
  private
  public
    procedure Carregar(ANumeros: TNumerosOcorrencias);
    procedure Ordenar;
    function ToStr: String;
  end;

  TNumeroOcorrenciaComparer = class(TComparer<TNumeroOcorrencia>)
  public
    function Compare(const Item1, Item2: TNumeroOcorrencia): Integer; override;
  end;

implementation

{ TNumerosOcorrencias }

procedure TNumerosOcorrencias.Clear;
begin
  FNumero01 := 0;
  FNumero02 := 0;
  FNumero03 := 0;
  FNumero04 := 0;
  FNumero05 := 0;
  FNumero06 := 0;
  FNumero07 := 0;
  FNumero08 := 0;
  FNumero09 := 0;
  FNumero10 := 0;
  FNumero11 := 0;
  FNumero12 := 0;
  FNumero13 := 0;
  FNumero14 := 0;
  FNumero15 := 0;
  FNumero16 := 0;
  FNumero17 := 0;
  FNumero18 := 0;
  FNumero19 := 0;
  FNumero20 := 0;
  FNumero21 := 0;
  FNumero22 := 0;
  FNumero23 := 0;
  FNumero24 := 0;
  FNumero25 := 0;
end;

constructor TNumerosOcorrencias.Create;
begin
  Clear;
end;

destructor TNumerosOcorrencias.Destroy;
begin
  inherited;
end;

function TNumerosOcorrencias.Ocorrencias(ACompara: TNumeros): Integer;
begin
  if (ACompara.Numero01) then
    Inc(FNumero01);
  if (ACompara.Numero02) then
    Inc(FNumero02);
  if (ACompara.Numero03) then
    Inc(FNumero03);
  if (ACompara.Numero04) then
    Inc(FNumero04);
  if (ACompara.Numero05) then
    Inc(FNumero05);
  if (ACompara.Numero06) then
    Inc(FNumero06);
  if (ACompara.Numero07) then
    Inc(FNumero07);
  if (ACompara.Numero08) then
    Inc(FNumero08);
  if (ACompara.Numero09) then
    Inc(FNumero09);
  if (ACompara.Numero10) then
    Inc(FNumero10);
  if (ACompara.Numero11) then
    Inc(FNumero11);
  if (ACompara.Numero12) then
    Inc(FNumero12);
  if (ACompara.Numero13) then
    Inc(FNumero13);
  if (ACompara.Numero14) then
    Inc(FNumero14);
  if (ACompara.Numero15) then
    Inc(FNumero15);
  if (ACompara.Numero16) then
    Inc(FNumero16);
  if (ACompara.Numero17) then
    Inc(FNumero17);
  if (ACompara.Numero18) then
    Inc(FNumero18);
  if (ACompara.Numero19) then
    Inc(FNumero19);
  if (ACompara.Numero20) then
    Inc(FNumero20);
  if (ACompara.Numero21) then
    Inc(FNumero21);
  if (ACompara.Numero22) then
    Inc(FNumero22);
  if (ACompara.Numero23) then
    Inc(FNumero23);
  if (ACompara.Numero24) then
    Inc(FNumero24);
  if (ACompara.Numero25) then
    Inc(FNumero25);
end;

{ TNumeroOcorrencia }

constructor TNumeroOcorrencia.Create;
begin
  FNumero := '';
  FOcorrencia := 0;
end;

constructor TNumeroOcorrencia.Create(ANumero: String; AOcorrencia: Integer);
begin
  FNumero := ANumero;
  FOcorrencia := AOcorrencia;
end;

{ TNumeroOcorrenciaComparer }

function TNumeroOcorrenciaComparer.Compare(const Item1, Item2: TNumeroOcorrencia): Integer;
begin
  if (Item1.Ocorrencia < Item2.Ocorrencia) then
    Result := -1
  else
    if (Item1.Ocorrencia > Item2.Ocorrencia) then
      Result := 1
    else
      Result := 0;
end;

{ TNumerosOrdenar }

procedure TNumerosOrdenar.Carregar(ANumeros: TNumerosOcorrencias);
begin
  Self.Add(TNumeroOcorrencia.Create('01', ANumeros.Numero01));
  Self.Add(TNumeroOcorrencia.Create('02', ANumeros.Numero02));
  Self.Add(TNumeroOcorrencia.Create('03', ANumeros.Numero03));
  Self.Add(TNumeroOcorrencia.Create('04', ANumeros.Numero04));
  Self.Add(TNumeroOcorrencia.Create('05', ANumeros.Numero05));
  Self.Add(TNumeroOcorrencia.Create('06', ANumeros.Numero06));
  Self.Add(TNumeroOcorrencia.Create('07', ANumeros.Numero07));
  Self.Add(TNumeroOcorrencia.Create('08', ANumeros.Numero08));
  Self.Add(TNumeroOcorrencia.Create('09', ANumeros.Numero09));
  Self.Add(TNumeroOcorrencia.Create('10', ANumeros.Numero10));
  Self.Add(TNumeroOcorrencia.Create('11', ANumeros.Numero11));
  Self.Add(TNumeroOcorrencia.Create('12', ANumeros.Numero12));
  Self.Add(TNumeroOcorrencia.Create('13', ANumeros.Numero13));
  Self.Add(TNumeroOcorrencia.Create('14', ANumeros.Numero14));
  Self.Add(TNumeroOcorrencia.Create('15', ANumeros.Numero15));
  Self.Add(TNumeroOcorrencia.Create('16', ANumeros.Numero16));
  Self.Add(TNumeroOcorrencia.Create('17', ANumeros.Numero17));
  Self.Add(TNumeroOcorrencia.Create('18', ANumeros.Numero18));
  Self.Add(TNumeroOcorrencia.Create('19', ANumeros.Numero19));
  Self.Add(TNumeroOcorrencia.Create('20', ANumeros.Numero20));
  Self.Add(TNumeroOcorrencia.Create('21', ANumeros.Numero21));
  Self.Add(TNumeroOcorrencia.Create('22', ANumeros.Numero22));
  Self.Add(TNumeroOcorrencia.Create('23', ANumeros.Numero23));
  Self.Add(TNumeroOcorrencia.Create('24', ANumeros.Numero24));
  Self.Add(TNumeroOcorrencia.Create('25', ANumeros.Numero25));
end;

procedure TNumerosOrdenar.Ordenar;
begin
  Self.Sort(TNumeroOcorrenciaComparer.Create);
end;

function TNumerosOrdenar.ToStr: String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Pred(Self.Count) do
  begin
    Result := Result + ';';
    Result := Result + Format('%S = %D', [Self.Items[I].Numero, Self.Items[I].Ocorrencia]);
  end;
end;

end.
