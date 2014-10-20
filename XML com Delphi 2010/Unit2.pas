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
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
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
      Localizacao.Text := 'CHAPECO';

      Application.ProcessMessages;
    end;

    XMLDocument1.SaveToFile('myxmldoc2.xml');
    XMLDocument1.Active := False;
  finally
    TButton(Sender).Enabled := True;
  end;
end;

procedure TForm2.Button3Click(Sender: TObject);
var { http://www.devmedia.com.br/carregar-treeview-xml-parte-2/17882 }
  INivel1, INivel2, INivel3, INivel4: integer;
  XMLNodeN1, XMLNodeN2, XMLNodeN3, XMLNodeN4: IXMLNode;
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

    ListBox1.Clear;
    // for INodes := 0 to XMLDocument1.DocumentElement.ChildNodes.Count - 1 do
    // begin
    // ListBox1.Items.Add(XMLDocument1.DocumentElement.ChildNodes[INodes].ChildNodes['NOME'].Text);
    // end;

    // for INodes := 0 to XMLDocument1.ChildNodes.Count do
    // begin
    // ListBox1.Items.Add(XMLDocument1.ChildNodes[INodes].Text);
    // end;

    for INivel1 := 0 to pred(XMLDocument1.ChildNodes.Count) do
    begin
      XMLNodeN1 := XMLDocument1.ChildNodes[INivel1];
      if XMLNodeN1.NodeType = ntElement then
      begin
        if XMLNodeN1.HasChildNodes then
        begin
          for INivel2 := 0 to pred(XMLNodeN1.ChildNodes.Count) do
          begin
            XMLNodeN2 := XMLNodeN1.ChildNodes[INivel2];
            if XMLNodeN2.HasChildNodes then
            begin
              for INivel3 := 0 to pred(XMLNodeN2.ChildNodes.Count) do
              begin
                XMLNodeN3 := XMLNodeN2.ChildNodes[INivel3];
                if XMLNodeN3.IsTextElement then
                begin
                  ListBox1.Items.Add(XMLNodeN3.Text);
                end;
              end;
            end;
          end;
        end;
      end;
    end;

    XMLDocument1.Active := False;
  finally
    TButton(Sender).Enabled := True;
  end;
end;

procedure TForm2.Button4Click(Sender: TObject);
var { http://www.devmedia.com.br/carregar-treeview-xml-parte-2/17882 }
  INivel1, INivel2: integer;
  XMLNodeN1, XMLNodeN2: IXMLNode;
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
    ListBox1.Clear;
    for INivel1 := 0 to pred(XMLDocument1.ChildNodes.Count) do
    begin
      XMLNodeN1 := XMLDocument1.ChildNodes[INivel1];
      if XMLNodeN1.NodeType = ntElement then
      begin
        if XMLNodeN1.HasChildNodes then
        begin
          for INivel2 := 0 to pred(XMLNodeN1.ChildNodes.Count) do
          begin
            XMLNodeN2 := XMLNodeN1.ChildNodes[INivel2];
            if XMLNodeN2.HasChildNodes then
            begin
              ListBox1.Items.Add( //
                XMLNodeN2.ChildNodes['NOME'].Text + ', ' + //
                  XMLNodeN2.ChildNodes['IDADE'].Text + ', ' + //
                  XMLNodeN2.ChildNodes['LOCALIZACAO'].Text //
                );
            end;
          end;
        end;
      end;
    end;

    XMLDocument1.Active := False;
  finally
    TButton(Sender).Enabled := True;
  end;
end;

end.

{ http://www.devmedia.com.br/importando-xml-com-o-xmldocument-delphi/24288 }
