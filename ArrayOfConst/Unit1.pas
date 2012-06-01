unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
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

function Converte(Arg: TVarRec): String;
var
  PonteiroWideString: ^widestring;
  PonteiroWideChar: ^WideChar;
  PonteiroExtended: ^Extended;
  PonteiroVariant: ^Variant;
begin
  Result := 'nulo';
  case Arg.VType of
    vtInteger:
      Result := IntToStr(Arg.VInteger); // ok
    vtBoolean:
      Result := BoolToStr(Arg.VBoolean); // ok
    vtChar:
      Result := Arg.VChar; // nao usado
    vtExtended:
      begin
        PonteiroExtended := @Arg.vExtended;
        // vExtended := PonteiroExtended^;
        // Result := FloatToStr(PonteiroExtended^);
      end;
    vtString:
      Result := String(Arg.VString);
    vtPointer:
      Result := 'ponteiro';
    vtPChar:
      Result := Arg.VPChar;
    vtObject:
      Result := String(Arg.VObject);
    vtClass:
      Result := Arg.VClass.ClassName;
    vtWideChar:
      Result := Arg.VWideChar; // ok e tambem usado pelo ansichar
    vtPWideChar:
      begin
        PonteiroWideChar := @Arg.VPWideChar;
        // Result := Arg.VPWideChar^;
        // Result := WideCharToString(Arg.VPWideChar);
      end;
    vtAnsiString:
      Result := String(Arg.VAnsiString);
    vtCurrency:
      Result := String(Arg.VCurrency);
    vtVariant:
      begin
        PonteiroVariant := @Arg.VVariant;
        Result := VarToStr(PonteiroVariant^);
        // Result := String(Arg.VVariant);
      end;
    vtInterface:
      Result := 'interface';
    vtWideString:
      begin
        PonteiroWideString := @Arg.VWideString;
        Result := PonteiroWideString^;
      end;
    vtInt64:
      Result := String(Arg.VInt64);
    vtUnicodeString:
      Result := string(Arg.VUnicodeString);
  else
    ShowMessage(IntToStr(Arg.VType));
  end;
end;

function MensagemEscolha(AOwner: TComponent; Titulo, Mensagem: String; Args: array of const ): String;
var
  Form: TForm;
  I: Integer;
  TypeStr: String;
begin
  Result := 'null';
  try
    Form := TForm.Create(AOwner);
    Form.BorderStyle := bsDialog;
    Form.Position := poDesktopCenter;
    Form.Caption := Titulo;
    Form.ShowModal;

    I := Low(Args);
    while (I < High(Args)) do
    begin
      ShowMessage(Converte(Args[I]));
      inc(I, 1);
    end;

  finally
    FreeAndNil(Form);
  end;
end;

{ TForm1 }

procedure TForm1.Button1Click(Sender: TObject);
var
  aInteger: Integer;
  aBoolean: Boolean;
  aChar: Char;
  aExtended: Extended;
  aString: String;
  aPointer: Pointer;
  aPChar: PChar;
  aObject: TObject;
  aClass: TClass;
  aWideChar: WideChar;
  aPWideChar: PWideChar;
  aAnsiString: AnsiString;
  aCurrency: Currency;
  aVariant: Variant;
  aWideString: widestring;
  aInt64: Int64;
  aUnicodeString: UnicodeString;
begin

  aInteger := 10;
  aBoolean := false;
  aChar := AnsiChar('A');
  aExtended := 123456;
  aString := 'String';
  aPointer := 0;
  aPChar := PChar('A');
  aObject := nil;
  aClass := TStringList;
  aWideChar := WideChar('w');
  aPWideChar := PWideChar('pwidechar usando ponteiro');
  aAnsiString := AnsiString('ansistring');
  aCurrency := StrToCurr('123,45');
  aVariant := 9999;
  aWideString := widestring('widestring que esta sendo acessada via ponteiro');
  aInt64 := StrToInt64(' 1234');
  aUnicodeString := UnicodeString('unicodestring');

  ShowMessage(MensagemEscolha(Self, '', '', [aInteger, aBoolean, aChar, aExtended, aString, aPointer, aPChar, aObject, aClass, aWideChar, aPWideChar,
      aAnsiString, aCurrency, aVariant, aWideString, aInt64, aUnicodeString]));
end;

end.
//teste 23
