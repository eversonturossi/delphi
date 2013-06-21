unit UModulo11;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function Modulo11(Valor: String; Base: Integer = 9; Resto: boolean = false; X: boolean = false): String;
{
  Rotina muito usada para calcular dígitos verificadores
  Pega-se cada um dos dígitos contidos no parâmetro VALOR,
  da direita para a esquerda e multiplica-se pela seqüência
  de pesos 2, 3, 4 ... até BASE.
  Por exemplo: se a base for 9, os pesos serão 2,3,4,5,6,7,8,9,2,3,4,5...
  Se a base for 7, os pesos serão 2,3,4,5,6,7,2,3,4...
  Soma-se cada um dos subprodutos.
  Divide-se a soma por 11.
  Faz-se a operação 11-Resto da divisão e devolve-se o resultado dessa operação
  como resultado da função Modulo11.
  Obs.: Caso o resultado seja maior que 9, deverá ser substituído por 0 (ZERO).
}
var
  Soma: Integer;
  Contador, Peso, Digito: Integer;
  Ret: String;
begin
  Soma := 0;
  Peso := 2;
  for Contador := Length(Valor) downto 1 do
  begin
    Soma := Soma + (StrToInt(Valor[Contador]) * Peso);
    if Peso < Base then
      Peso := Peso + 1
    else
      Peso := 2;
  end;
  if Resto then
    Result := IntToStr(Soma mod 11)
  else
  begin
    Digito := 11 - (Soma mod 11);
    if X then
    begin
      if (Digito > 9) then
        Ret := 'X'
      else
        Ret := IntToStr(Digito);
    end
    else
    begin
      if (Digito > 9) then
        Ret := '0'
      else
        Ret := IntToStr(Digito);
    end;
    Result := Ret;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  Edit2.Text := Modulo11(Edit1.Text);
end;

end.
