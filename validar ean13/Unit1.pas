unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    edtCodigoBarras: TEdit;
    Button1: TButton;
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

function ValidaEAN(CodBar: string): Boolean;
var
  sl_CodIni: String;
  il_SeqSom, il_Soma, il_TodNum: Integer;
begin
  // se codigo eh invalido
  IF (Length(Trim(CodBar)) = 0) THEN
    Result := TRUE

  ELSE
    IF ((Length(Trim(CodBar)) <> 13) AND (Length(Trim(CodBar)) <> 8)) THEN
      Result := FALSE

      // se codigo eh certo, entao continua
    ELSE
    BEGIN
      sl_CodIni := Copy(Trim(CodBar), 1, Length(CodBar) - 1);
      il_Soma := 0;
      il_SeqSom := 1;

      // se for ean8 entao completa numeros
      IF Length(Trim(CodBar)) = 8 THEN
        sl_CodIni := '00000' + sl_CodIni;

      // continua

      FOR il_TodNum := 1 TO Length(sl_CodIni) DO
      BEGIN
        IF il_SeqSom = 1 THEN
        BEGIN
          il_Soma := il_Soma + (StrToInt(Copy(sl_CodIni, il_TodNum, 1)) * il_SeqSom);
          il_SeqSom := 3;
        END
        ELSE
        BEGIN
          il_Soma := il_Soma + (StrToInt(Copy(sl_CodIni, il_TodNum, 1)) * il_SeqSom);
          il_SeqSom := 1;
        END

      END;

      // calcula o restante

      // para numeros que nao sao zero no final
      IF Copy(IntToStr(il_Soma), Length(IntToStr(il_Soma)), 1) <> '0' THEN
      BEGIN
        IF Copy(Trim(CodBar), Length(CodBar), 1) = IntToStr(10 - StrToInt(Copy(IntToStr(il_Soma), Length(IntToStr(il_Soma)), 1))) THEN
          Result := TRUE
        ELSE
          Result := FALSE
      END
      ELSE
        IF StrToInt(Copy(Trim(CodBar), Length(CodBar), 1)) = 0 THEN
          Result := TRUE
        ELSE
          Result := FALSE;
    END;
end;

// Veja mais: http: // www.cheatsbrasil.org/local/delphi/18840-validando-codigo-de-barras-ean13-e-ean8.html#ixzz26FsFMtQp

procedure TForm1.Button1Click(Sender: TObject);
begin
  if ValidaEAN(edtCodigoBarras.Text) then
    ShowMessage('Válido')
  else
  begin
    ShowMessage('Código de Barras Inválido!');
    edtCodigoBarras.SetFocus;
    abort;
  end;
end;

end.
