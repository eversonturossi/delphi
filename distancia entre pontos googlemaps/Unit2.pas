unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    EditLatInicial: TEdit;
    EditLongInicial: TEdit;
    EditDistancia: TEdit;
    Button1: TButton;
    EditLatFinal: TEdit;
    EditLongFinal: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  Form2: TForm2;

implementation

uses math;
{$R *.dfm}

function CalcularDistancia(LatIni, LonIni, LatFim, LonFim: Extended): Extended;
var
  arcoA, arcoB, arcoC: Extended;
  auxPI: Extended;
begin
  auxPI := Pi / 180;

  arcoA := (LonFim - LonIni) * auxPI;
  arcoB := (90 - LatFim) * auxPI;
  arcoC := (90 - LatIni) * auxPI;

  // cos (a) = cos (b) . cos (c)  + sen (b) . sen (c) . cos (A)
  Result := Cos(arcoB) * Cos(arcoC) + Sin(arcoB) * Sin(arcoC) * Cos(arcoA);
  Result := (40030 * ((180 / Pi) * ArcCos(Result))) / 360;
end;

function CoordenadaToExtended(ACoordenada: String): Extended;
var
  Str: String;
begin
  Str := Trim(ACoordenada);
  Str := StringReplace(Str, '.', ',', [rfReplaceAll, rfIgnoreCase]);

  if (Length(Str) < 8) then
    raise Exception.Create('Coordenada Inválida!');

  if (Str[1] = '-') then
  begin

  end
  else
  begin

  end;

  Result := StrToFloat(Str);
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  LatitudeInicial, LatitudeFinal, LongitudeInicial, LongitudeFinal: Extended;
  Distancia: Extended;
begin
  LatitudeInicial := CoordenadaToExtended(EditLatInicial.Text);
  LongitudeInicial := CoordenadaToExtended(EditLongInicial.Text);

  LatitudeFinal := CoordenadaToExtended(EditLatFinal.Text);
  LongitudeFinal := CoordenadaToExtended(EditLongFinal.Text);

  Distancia := CalcularDistancia(LatitudeInicial, LongitudeInicial, LatitudeFinal, LongitudeFinal);

  EditDistancia.Text := FloatToStr(Distancia);
end;

end.
