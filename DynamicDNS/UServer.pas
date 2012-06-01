unit UServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  StdCtrls;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    Edit2: TEdit;
    Edit1: TEdit;
    Button1: TButton;
    Memo1: TMemo;
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

uses Hashes, IdMultipartFormData;

procedure TForm1.Button1Click(Sender: TObject);
var
  sha1: String;
  conteudo: String;
  FormData: TIdMultiPartFormDataStream;
begin
  try
    Memo1.Clear;
    Edit2.Clear;
    FormData := TIdMultiPartFormDataStream.Create;
    Memo1.Lines.Add('processando...');

    sha1 := CalcHash2(Edit1.Text, haSHA1);
    Edit2.Text := CalcHash2(Edit1.Text, haSHA1);
    Application.ProcessMessages;
    FormData.AddFormField('hash', sha1);
    conteudo := IdHTTP1.Post('http://www.turossi.com.br/public/write.php', FormData);

    Memo1.Clear;
    Memo1.Lines.Add(conteudo);
  finally
    FreeAndNil(FormData);
  end;
end;

end.
