unit UGeoLocalizacao;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Math;

type
  TGeoLocalizacao = class(TObject)
  private
  public
    class function CalcularDistanciaCoordenadas(ALatitudeInicio, ALongitudeInicio, ALatitudeFim, ALongitudeFim: Extended): Extended; overload; static;
    class function CalcularDistanciaCoordenadas(ALatitudeInicioStr, ALongitudeInicioStr, ALatitudeFimStr, ALongitudeFimStr: String): Extended; overload; static;
  end;

implementation

function CoordenadaToExtended(ACoordenada: String): Extended;
var
  Str: String;
begin
  Str := Trim(ACoordenada);
  Str := StringReplace(Str, '.', ',', [rfReplaceAll, rfIgnoreCase]);
  if (Length(Str) < 8) or (Pos(',', Str) = -1) then
    raise Exception.Create('Coordenada Inválida!');
  Result := StrToFloat(Str);
end;

class function TGeoLocalizacao.CalcularDistanciaCoordenadas(ALatitudeInicio, ALongitudeInicio, ALatitudeFim, ALongitudeFim: Extended): Extended;
var
  arcoA, arcoB, arcoC: Extended;
  auxPI: Extended;
begin
  auxPI := Pi / 180;

  arcoA := (ALongitudeFim - ALongitudeInicio) * auxPI;
  arcoB := (90 - ALatitudeFim) * auxPI;
  arcoC := (90 - ALatitudeInicio) * auxPI;

  // cos (a) = cos (b) . cos (c)  + sen (b) . sen (c) . cos (A)
  Result := Cos(arcoB) * Cos(arcoC) + Sin(arcoB) * Sin(arcoC) * Cos(arcoA);
  Result := (40030 * ((180 / Pi) * ArcCos(Result))) / 360;
  Result := Result * 1000; { converter para metros }
end;

class function TGeoLocalizacao.CalcularDistanciaCoordenadas(ALatitudeInicioStr, ALongitudeInicioStr, ALatitudeFimStr, ALongitudeFimStr: String): Extended;
var
  ALatitudeInicio, ALatitudeFim, ALongitudeInicio, ALongitudeFim: Extended;
begin
  ALatitudeInicio := CoordenadaToExtended(ALatitudeInicioStr);
  ALongitudeInicio := CoordenadaToExtended(ALongitudeInicioStr);
  ALatitudeFim := CoordenadaToExtended(ALatitudeFimStr);
  ALongitudeFim := CoordenadaToExtended(ALongitudeFimStr);
  Result := TGeoLocalizacao.CalcularDistanciaCoordenadas(ALatitudeInicio, ALongitudeInicio, ALatitudeFim, ALongitudeFim);
end;

end.
