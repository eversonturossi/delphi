unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm2 = class(TForm)
    EditLatitudeInicio: TEdit;
    EditLongitudeInicio: TEdit;
    EditDistanciaKM: TEdit;
    Button1: TButton;
    EditLatitudeFim: TEdit;
    EditLongitudeFim: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    EditDistanciaMetros: TEdit;
    Label6: TLabel;
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  Form2: TForm2;

implementation

uses math;
{$R *.dfm}

function CalcularDistanciaCoordenadas(ALatitudeInicio, ALongitudeInicio, ALatitudeFim, ALongitudeFim: Extended): Extended;
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
end;

function CoordenadaToExtended(ACoordenada: String): Extended;
var
  Str: String;
begin
  Str := Trim(ACoordenada);
  Str := StringReplace(Str, '.', ',', [rfReplaceAll, rfIgnoreCase]);
  if (Length(Str) < 8) then
    raise Exception.Create('Coordenada Inválida!');
  Result := StrToFloat(Str);
end;

function CalcularDistanciaCoordenadasStr(ALatitudeInicioStr, ALongitudeInicioStr, ALatitudeFimStr, ALongitudeFimStr: String): Extended;
var
  ALatitudeInicio, ALatitudeFim, ALongitudeInicio, ALongitudeFim: Extended;
begin
  ALatitudeInicio := CoordenadaToExtended(ALatitudeInicioStr);
  ALongitudeInicio := CoordenadaToExtended(ALongitudeInicioStr);
  ALatitudeFim := CoordenadaToExtended(ALatitudeFimStr);
  ALongitudeFim := CoordenadaToExtended(ALongitudeFimStr);
  Result := CalcularDistanciaCoordenadas(ALatitudeInicio, ALongitudeInicio, ALatitudeFim, ALongitudeFim);
end;

procedure TForm2.Button1Click(Sender: TObject);
var
  Distancia: Extended;
begin
  Distancia := CalcularDistanciaCoordenadasStr(EditLatitudeInicio.Text, EditLongitudeInicio.Text, EditLatitudeFim.Text, EditLongitudeFim.Text);
  EditDistanciaKM.Text := FloatToStr(Distancia);
  EditDistanciaMetros.Text := FloatToStr(Distancia * 1000);
end;

end.
