unit Unit1;

interface

uses Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, Dialogs, StdCtrls, UDynamicMessagedlg, xpman,
  ExtCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  public
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

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
  Mensagem: TDynamicMessageDlg;
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

  Mensagem := TDynamicMessageDlg.Create;
  ShowMessage(Mensagem.MensagemEscolha(Self, 'titulo',
      'mensagem teste mensagem teste mensagem teste mensagem teste mensagem teste mensagem teste mensagem teste ' +
        'mensagem teste mensagem teste mensagem teste mensagem teste mensagem teste ', ['botao1', 'botao2'], ['1', 2]));
  FreeAndNil(Mensagem);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  Opcao: String;
begin
  Opcao := DynamicMessageDlg(Self, 'titulo',
    'mensagem teste mensagem teste mensagem teste mensagem teste mensagem teste mensagem teste mensagem teste ' +
      'mensagem teste mensagem teste mensagem teste mensagem teste mensagem teste ', ['botao1', 'botao2'], ['1', 2]);
  ShowMessage(Opcao);
end;

end.
