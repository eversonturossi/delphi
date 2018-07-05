unit UNumeros;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes;

const
  cSeparador = ';';

type
  TNumeros = class(TObject)
  private
    FNumero02: Boolean;
    FNumero12: Boolean;
    FNumero03: Boolean;
    FNumero13: Boolean;
    FNumero10: Boolean;
    FNumero01: Boolean;
    FNumero11: Boolean;
    FNumero06: Boolean;
    FNumero07: Boolean;
    FNumero04: Boolean;
    FNumero14: Boolean;
    FNumero05: Boolean;
    FNumero15: Boolean;
    FNumero08: Boolean;
    FNumero09: Boolean;
    FNumero20: Boolean;
    FNumero21: Boolean;
    FNumero24: Boolean;
    FNumero25: Boolean;
    FNumero16: Boolean;
    FNumero17: Boolean;
    FNumero18: Boolean;
    FNumero19: Boolean;
    FNumero22: Boolean;
    FNumero23: Boolean;
  public
    constructor Create;
    destructor Destroy; override;
    procedure Clear;
    function ToStr: String;
    procedure Carregar(ANumeros: String);
    function Acertos(ACompara: TNumeros): Integer;

    property Numero01: Boolean read FNumero01 write FNumero01;
    property Numero02: Boolean read FNumero02 write FNumero02;
    property Numero03: Boolean read FNumero03 write FNumero03;
    property Numero04: Boolean read FNumero04 write FNumero04;
    property Numero05: Boolean read FNumero05 write FNumero05;
    property Numero06: Boolean read FNumero06 write FNumero06;
    property Numero07: Boolean read FNumero07 write FNumero07;
    property Numero08: Boolean read FNumero08 write FNumero08;
    property Numero09: Boolean read FNumero09 write FNumero09;
    property Numero10: Boolean read FNumero10 write FNumero10;
    property Numero11: Boolean read FNumero11 write FNumero11;
    property Numero12: Boolean read FNumero12 write FNumero12;
    property Numero13: Boolean read FNumero13 write FNumero13;
    property Numero14: Boolean read FNumero14 write FNumero14;
    property Numero15: Boolean read FNumero15 write FNumero15;
    property Numero16: Boolean read FNumero16 write FNumero16;
    property Numero17: Boolean read FNumero17 write FNumero17;
    property Numero18: Boolean read FNumero18 write FNumero18;
    property Numero19: Boolean read FNumero19 write FNumero19;
    property Numero20: Boolean read FNumero20 write FNumero20;
    property Numero21: Boolean read FNumero21 write FNumero21;
    property Numero22: Boolean read FNumero22 write FNumero22;
    property Numero23: Boolean read FNumero23 write FNumero23;
    property Numero24: Boolean read FNumero24 write FNumero24;
    property Numero25: Boolean read FNumero25 write FNumero25;
  end;

implementation

{ TNumeros }

procedure TNumeros.Clear;
begin
  FNumero01 := False;
  FNumero02 := False;
  FNumero03 := False;
  FNumero04 := False;
  FNumero05 := False;
  FNumero06 := False;
  FNumero07 := False;
  FNumero08 := False;
  FNumero09 := False;
  FNumero10 := False;
  FNumero11 := False;
  FNumero12 := False;
  FNumero13 := False;
  FNumero14 := False;
  FNumero15 := False;
  FNumero16 := False;
  FNumero17 := False;
  FNumero18 := False;
  FNumero19 := False;
  FNumero20 := False;
  FNumero21 := False;
  FNumero22 := False;
  FNumero23 := False;
  FNumero24 := False;
  FNumero25 := False;
end;

constructor TNumeros.Create;
begin
  Clear;
end;

destructor TNumeros.Destroy;
begin

  inherited;
end;

procedure TNumeros.Carregar(ANumeros: String);
begin
  if (Pos('01', ANumeros) > 0) then
    FNumero01 := True;
  if (Pos('02', ANumeros) > 0) then
    FNumero02 := True;
  if (Pos('03', ANumeros) > 0) then
    FNumero03 := True;
  if (Pos('04', ANumeros) > 0) then
    FNumero04 := True;
  if (Pos('05', ANumeros) > 0) then
    FNumero05 := True;
  if (Pos('06', ANumeros) > 0) then
    FNumero06 := True;
  if (Pos('07', ANumeros) > 0) then
    FNumero07 := True;
  if (Pos('08', ANumeros) > 0) then
    FNumero08 := True;
  if (Pos('09', ANumeros) > 0) then
    FNumero09 := True;
  if (Pos('10', ANumeros) > 0) then
    FNumero10 := True;
  if (Pos('11', ANumeros) > 0) then
    FNumero11 := True;
  if (Pos('12', ANumeros) > 0) then
    FNumero12 := True;
  if (Pos('13', ANumeros) > 0) then
    FNumero13 := True;
  if (Pos('14', ANumeros) > 0) then
    FNumero14 := True;
  if (Pos('15', ANumeros) > 0) then
    FNumero15 := True;
  if (Pos('16', ANumeros) > 0) then
    FNumero16 := True;
  if (Pos('17', ANumeros) > 0) then
    FNumero17 := True;
  if (Pos('18', ANumeros) > 0) then
    FNumero18 := True;
  if (Pos('19', ANumeros) > 0) then
    FNumero19 := True;
  if (Pos('20', ANumeros) > 0) then
    FNumero20 := True;
  if (Pos('21', ANumeros) > 0) then
    FNumero21 := True;
  if (Pos('22', ANumeros) > 0) then
    FNumero22 := True;
  if (Pos('23', ANumeros) > 0) then
    FNumero23 := True;
  if (Pos('24', ANumeros) > 0) then
    FNumero24 := True;
  if (Pos('25', ANumeros) > 0) then
    FNumero25 := True;
end;

function TNumeros.ToStr: String;
begin
  Result := '';
  if (FNumero01 = True) then
    Result := Result + cSeparador + '01';
  if (FNumero02 = True) then
    Result := Result + cSeparador + '02';
  if (FNumero03 = True) then
    Result := Result + cSeparador + '03';
  if (FNumero04 = True) then
    Result := Result + cSeparador + '04';
  if (FNumero05 = True) then
    Result := Result + cSeparador + '05';
  if (FNumero06 = True) then
    Result := Result + cSeparador + '06';
  if (FNumero07 = True) then
    Result := Result + cSeparador + '07';
  if (FNumero08 = True) then
    Result := Result + cSeparador + '08';
  if (FNumero09 = True) then
    Result := Result + cSeparador + '09';
  if (FNumero10 = True) then
    Result := Result + cSeparador + '10';
  if (FNumero11 = True) then
    Result := Result + cSeparador + '11';
  if (FNumero12 = True) then
    Result := Result + cSeparador + '12';
  if (FNumero13 = True) then
    Result := Result + cSeparador + '13';
  if (FNumero14 = True) then
    Result := Result + cSeparador + '14';
  if (FNumero15 = True) then
    Result := Result + cSeparador + '15';
  if (FNumero16 = True) then
    Result := Result + cSeparador + '16';
  if (FNumero17 = True) then
    Result := Result + cSeparador + '17';
  if (FNumero18 = True) then
    Result := Result + cSeparador + '18';
  if (FNumero19 = True) then
    Result := Result + cSeparador + '19';
  if (FNumero20 = True) then
    Result := Result + cSeparador + '20';
  if (FNumero21 = True) then
    Result := Result + cSeparador + '21';
  if (FNumero22 = True) then
    Result := Result + cSeparador + '22';
  if (FNumero23 = True) then
    Result := Result + cSeparador + '23';
  if (FNumero24 = True) then
    Result := Result + cSeparador + '24';
  if (FNumero25 = True) then
    Result := Result + cSeparador + '25';

  if (Result.Length > 0) then
    Delete(Result, 1, 1);
end;

function TNumeros.Acertos(ACompara: TNumeros): Integer;
var
  LAcertos: Integer;
begin
  LAcertos := 0;
  if (ACompara.Numero01 = FNumero01) then
    Inc(LAcertos);
  if (ACompara.Numero02 = FNumero02) then
    Inc(LAcertos);
  if (ACompara.Numero03 = FNumero03) then
    Inc(LAcertos);
  if (ACompara.Numero04 = FNumero04) then
    Inc(LAcertos);
  if (ACompara.Numero05 = FNumero05) then
    Inc(LAcertos);
  if (ACompara.Numero06 = FNumero06) then
    Inc(LAcertos);
  if (ACompara.Numero07 = FNumero07) then
    Inc(LAcertos);
  if (ACompara.Numero08 = FNumero08) then
    Inc(LAcertos);
  if (ACompara.Numero09 = FNumero09) then
    Inc(LAcertos);
  if (ACompara.Numero10 = FNumero10) then
    Inc(LAcertos);
  if (ACompara.Numero11 = FNumero11) then
    Inc(LAcertos);
  if (ACompara.Numero12 = FNumero12) then
    Inc(LAcertos);
  if (ACompara.Numero13 = FNumero13) then
    Inc(LAcertos);
  if (ACompara.Numero14 = FNumero14) then
    Inc(LAcertos);
  if (ACompara.Numero15 = FNumero15) then
    Inc(LAcertos);
  if (ACompara.Numero16 = FNumero16) then
    Inc(LAcertos);
  if (ACompara.Numero17 = FNumero17) then
    Inc(LAcertos);
  if (ACompara.Numero18 = FNumero18) then
    Inc(LAcertos);
  if (ACompara.Numero19 = FNumero19) then
    Inc(LAcertos);
  if (ACompara.Numero20 = FNumero20) then
    Inc(LAcertos);
  if (ACompara.Numero21 = FNumero21) then
    Inc(LAcertos);
  if (ACompara.Numero22 = FNumero22) then
    Inc(LAcertos);
  if (ACompara.Numero23 = FNumero23) then
    Inc(LAcertos);
  if (ACompara.Numero24 = FNumero24) then
    Inc(LAcertos);
  if (ACompara.Numero25 = FNumero25) then
    Inc(LAcertos);
  Result := LAcertos;
end;

end.
