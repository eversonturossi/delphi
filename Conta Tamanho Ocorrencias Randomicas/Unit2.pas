unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, math, StdCtrls, StrUtils;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    function MeuRandom(const NumeroDigitos: Integer): Integer;

  public

  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

function TForm2.MeuRandom(const NumeroDigitos: Integer): Integer;
var
  ArrayRange: array of Integer;
  I, Posicao, Range: Integer;
  RangeStr: String;
begin
  SetLength(ArrayRange, NumeroDigitos);
  for I := 0 to (NumeroDigitos - 1) do
    ArrayRange[I] := I + 1;
  Posicao := RandomFrom(ArrayRange);
  RangeStr := StringOfChar('9', Posicao);
  Range := StrToInt(RangeStr);
  Result := Random(Range);
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  I: Integer;
  Tamanho01, Tamanho02, Tamanho03, Tamanho04, Tamanho05, Tamanho06, Tamanho07, Tamanho08, Tamanho09: Integer;
  CodigoRandomico: String;
begin
  Tamanho01 := 0;
  Tamanho02 := 0;
  Tamanho03 := 0;
  Tamanho04 := 0;
  Tamanho05 := 0;
  Tamanho06 := 0;
  Tamanho07 := 0;
  Tamanho08 := 0;
  Tamanho09 := 0;
  for I := 0 to 2000000 { 000 } do
  begin
    Randomize;
    // CodigoRandomico := IntToStr(RandomRange(1, 999999999));
    // CodigoRandomico := IntToStr(Random(99999999));
    // CodigoRandomico := IntToStr(RandomFrom([1, 12, 123, 1234, 12345, 123456, 1234567, 12345678, 123456789]));
    CodigoRandomico := IntToStr(MeuRandom(9));
    if (Length(CodigoRandomico) = 01) then
      inc(Tamanho01);
    if (Length(CodigoRandomico) = 02) then
      inc(Tamanho02);
    if (Length(CodigoRandomico) = 03) then
      inc(Tamanho03);
    if (Length(CodigoRandomico) = 04) then
      inc(Tamanho04);
    if (Length(CodigoRandomico) = 05) then
      inc(Tamanho05);
    if (Length(CodigoRandomico) = 06) then
      inc(Tamanho06);
    if (Length(CodigoRandomico) = 07) then
      inc(Tamanho07);
    if (Length(CodigoRandomico) = 08) then
      inc(Tamanho08);
    if (Length(CodigoRandomico) = 09) then
      inc(Tamanho09);
  end;
  ShowMessage('' + //
      Format('Tamanho01 = %d', [Tamanho01]) + #13 + //
      Format('Tamanho02 = %d', [Tamanho02]) + #13 + //
      Format('Tamanho03 = %d', [Tamanho03]) + #13 + //
      Format('Tamanho04 = %d', [Tamanho04]) + #13 + //
      Format('Tamanho05 = %d', [Tamanho05]) + #13 + //
      Format('Tamanho06 = %d', [Tamanho06]) + #13 + //
      Format('Tamanho07 = %d', [Tamanho07]) + #13 + //
      Format('Tamanho08 = %d', [Tamanho08]) + #13 + //
      Format('Tamanho09 = %d', [Tamanho09]) + #13 + //
      '');
end;

end.
