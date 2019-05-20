unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
const
  CamposNomes: array of string = ['Numero da Nota', 'Numero do Lote', 'Envio Síncrono(1=Sim, 0=Não)'];

var
  vAux, vNumLote, vSincrono, idDFESTR: String;
  idDFe: Integer;
  Sincrono: boolean;
  ImputValue: array of string;
  I: Integer;
begin
  SetLength(ImputValue, Length(CamposNomes));
  if InputQuery('WebServices Enviar', CamposNomes, ImputValue) then
  begin
    for I := Low(ImputValue) to High(ImputValue) do
    begin
      if ImputValue[I] = '' then
      Begin
        ShowMessage('É obrigatório informar o campo: ' + CamposNomes[I]);
        Abort;
      end;
    end;
  end;
end;

end.
