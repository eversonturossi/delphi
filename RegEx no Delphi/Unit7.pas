unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  System.RegularExpressions;

{$R *.dfm}
// https://pt.stackoverflow.com/questions/260306/regex-no-delphi

// Uma ajuda com expressões regulares no Delphi 10 por favor. Preciso verificar o seguinte numa string:
// 1 Tamanho variando no mínimo de 6 caracteres ao máximo de 20 caracteres;
// 2 Tipo de caracteres: a-z ou A-Z ou 0-9 ou _ (caracter "underline");
// 3 Os carateres permitidos podem estar em qualquer posição e em qualquer quantidade (até o limite da string, claro);

procedure TForm7.Button1Click(Sender: TObject);
var
  LTexto: String;
begin
  LTexto := Edit1.Text;

  // \w casa a-z, A-Z, 0-9 ou _.
  // Só precisa repetir 6 a 20 vezes, isso é \w{6,20}
  // Desde o início da string ^ até o final da string $.

  if TRegEx.IsMatch(LTexto, '^\w{6,20}$') then
  begin
    Showmessage(LTexto + ' é válido');
  end
  else
  begin
    Showmessage(LTexto + ' não é válido');
  end;
end;

end.
