unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls;

type
  TForm2 = class(TForm)
    XMLDocument1: TXMLDocument;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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
  XMLDoc: TXMLDocument;
  iNode: IXMLNode;
  sl: TStringList;
begin
  XMLDoc := TXMLDocument.Create(nil);
  try
    XMLDoc.Active := True;
    iNode := XMLDoc.AddChild('leaf');
    iNode.Attributes['attrib1'] := 'value1';
    iNode.Text := 'Node Text';
    XMLDoc.Active := False;
  finally
    XMLDoc := nil;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var { http://www.activedelphi.com.br/forum/viewtopic.php?t=48264&highlight=xml }
  Raiz, Pessoa, ID, Nome, Idade, Localizacao: IXMLNode;
  INome: integer;
begin
  try
    TButton(Sender).Enabled := False;
    XMLDocument1.FileName := '';
    XMLDocument1.XML.Text := '';
    XMLDocument1.Active := False;
    XMLDocument1.Active := True;
    XMLDocument1.Version := '1.0';
    XMLDocument1.Encoding := 'UTF-8';

    Raiz := XMLDocument1.AddChild('RAIZ');

    for INome := 0 to 1000 do
    begin
      Pessoa := XMLDocument1.CreateNode('pessoa', ntElement);
      Raiz.ChildNodes.Add(Pessoa);

      ID := XMLDocument1.CreateNode('ID', ntAttribute);
      ID.Text := IntToStr(INome);
      Pessoa.AttributeNodes.Add(ID);

      Nome := XMLDocument1.CreateNode('NOME', ntElement);
      Pessoa.ChildNodes.Add(Nome);
      Nome.Text := 'teste ';

      Idade := XMLDocument1.CreateNode('IDADE', ntElement);
      Pessoa.ChildNodes.Add(Idade);
      Idade.Text := '10';

      Localizacao := XMLDocument1.CreateNode('LOCALIZACAO', ntElement);
      Pessoa.ChildNodes.Add(Localizacao);
      Localizacao.Text := 'CHAPECDO';

      Application.ProcessMessages;
    end;

    XMLDocument1.SaveToFile('myxmldoc2.xml');
    XMLDocument1.Active := False;
  finally
    TButton(Sender).Enabled := True;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
begin
  try
    TButton(Sender).Enabled := False;

    XMLDocument1.FileName := '';
    XMLDocument1.XML.Text := '';
    XMLDocument1.Active := False;
    XMLDocument1.Active := True;
    XMLDocument1.Version := '1.0';
    XMLDocument1.Encoding := 'UTF-8';
    XMLDocument1.LoadFromFile('myxmldoc2.xml');

  finally
    TButton(Sender).Enabled := True;
  end;
end;

end.

{ http://www.devmedia.com.br/importando-xml-com-o-xmldocument-delphi/24288 }
