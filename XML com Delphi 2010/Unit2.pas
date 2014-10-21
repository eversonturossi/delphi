unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc, StdCtrls;

type
  TForm2 = class(TForm)
    XMLDocument1: TXMLDocument;
    Button1: TButton;
    ButtonGerar: TButton;
    ButtonLeitura1: TButton;
    ListBox1: TListBox;
    ButtonLeitura2: TButton;
    ButtonLeitura3: TButton;
    ButtonGerar2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure ButtonGerarClick(Sender: TObject);
    procedure ButtonLeitura1Click(Sender: TObject);
    procedure ButtonLeitura2Click(Sender: TObject);
    procedure ButtonLeitura3Click(Sender: TObject);
    procedure ButtonGerar2Click(Sender: TObject);
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

procedure TForm2.ButtonGerarClick(Sender: TObject);
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

    for INome := 0 to 10 do
    begin
      Pessoa := XMLDocument1.CreateNode('PESSOA', ntElement);
      Raiz.ChildNodes.Add(Pessoa);

      ID := XMLDocument1.CreateNode('ID', ntAttribute);
      ID.Text := IntToStr(INome);
      Pessoa.AttributeNodes.Add(ID);

      Nome := XMLDocument1.CreateNode('NOME', ntElement);
      Pessoa.ChildNodes.Add(Nome);
      Nome.Text := 'TESTE ' + IntToStr(INome);

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

procedure TForm2.ButtonLeitura1Click(Sender: TObject);
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

procedure TForm2.ButtonLeitura2Click(Sender: TObject);
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
      if (XMLNodeN1.NodeType = ntElement) then
      begin
        if (UpperCase(XMLNodeN1.NodeName) = 'RAIZ') then
          if (XMLNodeN1.HasChildNodes) then
          begin
            for INivel2 := 0 to pred(XMLNodeN1.ChildNodes.Count) do
            begin
              XMLNodeN2 := XMLNodeN1.ChildNodes[INivel2];
              if (UpperCase(XMLNodeN2.NodeName) = 'PESSOA') then
                if (XMLNodeN2.HasChildNodes) then
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

procedure TForm2.ButtonGerar2Click(Sender: TObject);
var { http://www.activedelphi.com.br/forum/viewtopic.php?t=48264&highlight=xml }
  Raiz, Pessoa, ID, Nome, Idade, Localizacao: IXMLNode;
  INome: integer;
  AXML: IXMLDocument;
begin
  try
    TButton(Sender).Enabled := False;
    AXML := TXMLDocument.Create(nil);
    // AXML.FileName := '';
    // AXML.XML.Text := '';
    // AXML.Active := False;
    // AXML.Active := True;
    // AXML.Version := '1.0';
    // AXML.Encoding := 'UTF-8';

    Raiz := AXML.AddChild('RAIZ');

    for INome := 0 to 10 do
    begin
      Pessoa := AXML.CreateNode('PESSOA', ntElement);
      Raiz.ChildNodes.Add(Pessoa);

      ID := AXML.CreateNode('ID', ntAttribute);
      ID.Text := IntToStr(INome);
      Pessoa.AttributeNodes.Add(ID);

      Nome := AXML.CreateNode('NOME', ntElement);
      Pessoa.ChildNodes.Add(Nome);
      Nome.Text := 'TESTE ' + IntToStr(INome);

      Idade := AXML.CreateNode('IDADE', ntElement);
      Pessoa.ChildNodes.Add(Idade);
      Idade.Text := '10';

      Localizacao := AXML.CreateNode('LOCALIZACAO', ntElement);
      Pessoa.ChildNodes.Add(Localizacao);
      Localizacao.Text := 'CHAPECO';

      Application.ProcessMessages;
    end;

    AXML.SaveToFile('myxmldoc2.xml');
    AXML.Active := False;
  finally
    TButton(Sender).Enabled := True;
  end;
end;

procedure TForm2.ButtonLeitura3Click(Sender: TObject);
var
  { http://www.devmedia.com.br/carregar-treeview-xml-parte-2/17882
    http://marc.durdin.net/2011/10/ixmldocument-savetostream-does-not-always-use-utf-16-encoding-2/
    }
  INivel1, INivel2: integer;
  XMLNodeN1, XMLNodeN2: IXMLNode;
  AXML: IXMLDocument;
begin
  try
    TButton(Sender).Enabled := False;
    AXML := TXMLDocument.Create(nil);
    // AXML.FileName := '';
    // AXML.XML.Text := '';
    // AXML.Active := False;
    // AXML.Active := True;
    // AXML.Version := '1.0';
    // AXML.Encoding := 'UTF-8';
    AXML.LoadFromFile('myxmldoc2.xml');
    ListBox1.Clear;
    for INivel1 := 0 to pred(AXML.ChildNodes.Count) do
    begin
      XMLNodeN1 := AXML.ChildNodes[INivel1];
      if (XMLNodeN1.NodeType = ntElement) then
      begin
        if (UpperCase(XMLNodeN1.NodeName) = 'RAIZ') then
          if (XMLNodeN1.HasChildNodes) then
          begin
            for INivel2 := 0 to pred(XMLNodeN1.ChildNodes.Count) do
            begin
              XMLNodeN2 := XMLNodeN1.ChildNodes[INivel2];
              if (UpperCase(XMLNodeN2.NodeName) = 'PESSOA') then
                if (XMLNodeN2.HasChildNodes) then
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
    AXML.Active := False;
  finally
    TButton(Sender).Enabled := True;
  end;
end;

end.

{ http://www.devmedia.com.br/importando-xml-com-o-xmldocument-delphi/24288 }

{
  Outro ótimo exemplo: http://www.caiooliveira.com.br/?p=73
  procedure TForm1.Button32Click(Sender: TObject);
  var vXMLDoc: TXMLDocument;
  NodePai,NodeSec,NodeTmp: IXMLNode;
  nome, codigo: WideString;
  begin
  // Cria a variável baseada no TXMLDocument
  vXMLDoc := TXMLDocument.Create(self);

  // Le conteúdo do arquivo XML informado
  vXMLDoc.LoadFromFile('EnviNFe.xml');
  // Poderia ser uma URL como abaixo:
  //vXMLDoc.FileName := 'http://www.caiooliveira.com.br/?feed=rss2';
  //vXMLDoc.Active := True;

  // Vou colocar os dados no memo apenas como exemplo
  Memo.lines.Add( '-------------------------------------------------');
  Memo.lines.Add( 'Vamos inserir num campo memo (apenas para ver o resultado do teste');
  Memo.lines.Add( VXMLDoc.XML.Text +#13+#13 );

  // Aqui eu peço para encontrar a primeira ocorrencia da Tag <det>>
  NodePai := vXMLDoc.DocumentElement.childNodes.First.ChildNodes.FindNode('det');
  // Esse nó vai ser usado no LOOP
  NodeSec := NodePai;
  // Posiciona o primeiro elemento encontrado
  NodeSec.ChildNodes.First;
  repeat
  // referencia a tag <prod> dentro de <det>
  NodeTmp  := NodeSec.ChildNodes['prod'];
  // da pra ver que é um XML resumido da NFe (so temos uma tag <prod> para cada <det> então não precisaria da linha abaixo
  // agora se tivéssemos mais de uma seria o caso de posicionar também na primeira ocorrencia.
  NodeTmp.ChildNodes.First;
  repeat
  // pega os dados que vc quiser dentro da tag <prod>
  nome := NodeTmp.ChildNodes['cProd'].text;     // posso ler assim
  codigo := NodeTmp.ChildValues['cEan'];        // ou assim

  // vamos inserir no Memo os dados
  Memo4.Lines.Add('-----------------------------------------------');
  Memo4.Lines.Add( nome+' ---- '+codigo );

  // vai para a proxima ocorrência <prod> (se houvesse)
  NodeTmp := NodeTmp.NextSibling;
  until NodeTmp = nil;
  // vai para a proxima ocorrência <det>
  NodeSec := NodeSec.NextSibling;
  until NodeSec = nil;
  end;
}
