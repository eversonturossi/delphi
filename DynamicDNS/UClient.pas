unit UClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    IdHTTP1: TIdHTTP;
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

uses Hashes;

procedure TForm1.Button1Click(Sender: TObject);
var
  sha1: String;
  conteudo: String;
begin
  sha1 := CalcHash2(Edit1.Text, haSHA1);
  Edit3.Text := 'Processando...';
  Edit2.Clear;
  Edit2.Text := CalcHash2(Edit1.Text, haSHA1);
  conteudo := IdHTTP1.Get(format('http://www.turossi.com.br/public/read.php?hash=%s', [sha1]));
  Edit3.Text := conteudo;
end;

end.
