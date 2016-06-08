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

uses UGeoLocalizacao;
{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  Distancia: Extended;
begin
  Distancia := TGeoLocalizacao.CalcularDistanciaCoordenadas(EditLatitudeInicio.Text, EditLongitudeInicio.Text, EditLatitudeFim.Text, EditLongitudeFim.Text);
  EditDistanciaKM.Text := FloatToStr(Distancia / 1000);
  EditDistanciaMetros.Text := FloatToStr(Distancia);
end;

end.
