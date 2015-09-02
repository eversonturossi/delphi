unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, math, StdCtrls;

type
  TForm2 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
var
  I: integer;
  Tamanho01, Tamanho02, Tamanho03, Tamanho04, Tamanho05, Tamanho06, Tamanho07, Tamanho08, Tamanho09: integer;
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
    CodigoRandomico := IntToStr(RandomRange(1, 999999999));
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
