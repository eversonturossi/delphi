unit Unit1;
interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, UTopMessageBox;

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

  Mensagem: TTopMessageBox;
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

  // ShowMessage(MensagemEscolha(Self, '', '', [aInteger, aBoolean, aChar, aExtended, aString, aPointer, aPChar, aObject, aClass, aWideChar, aPWideChar,
  // aAnsiString, aCurrency, aVariant, aWideString, aInt64, aUnicodeString]));
  Mensagem := TTopMessageBox.Create;
  Mensagem.Opcao := 100000;
  ShowMessage(Mensagem.MensagemEscolha(Self, '', '', ['1', '2', '3', '4']));
  FreeAndNil(Mensagem);
end;

end.
