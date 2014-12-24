unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, StrUtils, xmldom, XMLIntf, msxmldom, XMLDoc;

const
  SenhaPadrao = 'top2015';

type
  TForm2 = class(TForm)
    OpenDialog1: TOpenDialog;
    ButtonLerUsuarios: TButton;
    ListBox1: TListBox;
    LabelNomeArquivo: TLabel;
    XMLDocument1: TXMLDocument;
    procedure ButtonLerUsuariosClick(Sender: TObject);
  private
    ArquivoShadow, ArquivoPasswd, ScriptCria, ScriptApaga: TStringList;
    UsuariosFilezilla: TStringList;

    Usuario, Senha, Descricao, Comando: String;

    procedure LerNodos(XMLNode: IXMLNode);
    procedure LerNodoServer(XMLNode: IXMLNode);
    function TratarCaracteres(aTexto: String): String;
  public
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

function TForm2.TratarCaracteres(aTexto: String): String;
var
  I: Integer;
  Str: String;
const
  COM_ACENTO = 'àâêôûãõáéíóúçüîäëïöèìòùÀÂÊÔÛÃÕÁÉÍÓÚÇÜÎÄËÏÖÈÌÒÙ';
  SEM_ACENTO = 'aaeouaoaeioucuiaeioeiouAAEOUAOAEIOUCUIAEIOEIOU';
  COM_ESPECIAIS = '¹²³ªº°';
  SEM_ESPECIAIS = '123aoo';
begin
  Result := '';
  Str := aTexto;
  for I := 1 to Length(Str) do
  begin
    if (Pos(Str[I], COM_ACENTO) > 0) then
      Str[I] := SEM_ACENTO[Pos(Str[I], COM_ACENTO)];
    if (Pos(Str[I], COM_ESPECIAIS) > 0) then
      Str[I] := SEM_ESPECIAIS[Pos(Str[I], COM_ESPECIAIS)];
  end;

  for I := 1 to Length(Str) do
    if (Str[I] in [' ' .. '~']) then
      Result := Result + Str[I];

  Result := Trim(Result);
end;

procedure TForm2.LerNodoServer(XMLNode: IXMLNode);
begin
  if (UpperCase(XMLNode.NodeName) = UpperCase('Server')) then
  begin
    if (XMLNode.HasChildNodes) then
    begin
      Usuario := XMLNode.ChildNodes['User'].Text;
      Senha := XMLNode.ChildNodes['Pass'].Text;
      Descricao := XMLNode.ChildNodes['Name'].Text;
      Descricao := TratarCaracteres(Descricao);

      if (Senha = '') then
        Senha := SenhaPadrao;
      if (Descricao = '') then
        Descricao := Usuario;

      Comando := Format('echo "criando usuario %S"', [Usuario]);
      ScriptCria.Add(Comando);
      Comando := Format('adduser %s -g 100 -s /sbin/nologin -p $(openssl passwd -1 %s) -c "%s"', [Usuario, Senha, Descricao]);
      ScriptCria.Add(Comando);
      ListBox1.Items.Add(Usuario + ' -> ' + Senha);
      UsuariosFilezilla.Add(Usuario);

      Comando := Format('echo "apagando usuario %S"', [Usuario]);
      ScriptApaga.Add(Comando);
      Comando := Format('userdel -r %s ', [Usuario]);
      ScriptApaga.Add(Comando);

    end;
  end;
end;

procedure TForm2.LerNodos(XMLNode: IXMLNode);
var
  INivel2: Integer;
  XMLNodeN2: IXMLNode;
begin
  if (UpperCase(XMLNode.NodeName) = 'SERVER') then
  begin
    LerNodoServer(XMLNode);
  end;

  if (UpperCase(XMLNode.NodeName) <> 'SERVER') then
  begin
    if (XMLNode.HasChildNodes) then
    begin
      for INivel2 := 0 to pred(XMLNode.ChildNodes.Count) do
      begin
        XMLNodeN2 := XMLNode.ChildNodes[INivel2];
        if (XMLNodeN2.HasChildNodes) then
          LerNodos(XMLNodeN2);
      end;
    end;
  end;
end;

procedure TForm2.ButtonLerUsuariosClick(Sender: TObject);
var
  IShadow, IPasswd: Integer;
  PosicaoDelimitador1, PosicaoDelimitador2, PosicaoDelimitador3, PosicaoDelimitador4, PosicaoDelimitador5: Integer;

  INivel1: Integer;

  XMLNodeN1: IXMLNode;
begin
  try
    ListBox1.Clear;
    UsuariosFilezilla := TStringList.Create;
    ArquivoShadow := TStringList.Create;
    ArquivoPasswd := TStringList.Create;
    ScriptCria := TStringList.Create;
    ScriptCria.Add('#!/bin/bash');
    ScriptApaga := TStringList.Create;
    ScriptApaga.Add('#!/bin/bash');

    TButton(Sender).Enabled := False;

    if (OpenDialog1.Execute) then
    begin
      if (UpperCase(ExtractFileName(OpenDialog1.FileName)) <> UpperCase('Shadow')) then
        raise Exception.Create('selecionar o arquivo Shadow');
      ArquivoShadow.LoadFromFile(OpenDialog1.FileName);
    end;
    if OpenDialog1.Execute then
    begin
      if (UpperCase(ExtractFileName(OpenDialog1.FileName)) <> UpperCase('Passwd')) then
        raise Exception.Create('selecionar o arquivo Passwd');
      ArquivoPasswd.LoadFromFile(OpenDialog1.FileName);
    end;

    if OpenDialog1.Execute then
      if (UpperCase(ExtractFileExt(OpenDialog1.FileName)) <> UpperCase('.xml')) then
        raise Exception.Create('selecionar o arquivo Passwd');

    { *********************************************************** }
    XMLDocument1.FileName := '';
    XMLDocument1.XML.Text := '';
    XMLDocument1.Active := False;
    XMLDocument1.Active := True;
    XMLDocument1.Version := '1.0';
    XMLDocument1.Encoding := 'UTF-8';
    XMLDocument1.LoadFromFile(OpenDialog1.FileName);
    ListBox1.Clear;
    for INivel1 := 0 to pred(XMLDocument1.ChildNodes.Count) do
    begin
      XMLNodeN1 := XMLDocument1.ChildNodes[INivel1];
      if (XMLNodeN1.NodeType = ntElement) then
      begin
        LerNodos(XMLNodeN1);
      end;
    end;

    { *********************************************************** }

    Comando := 'echo "usuarios nao existentes no xml"';
    ScriptCria.Add(Comando);

    for IShadow := 0 to (ArquivoShadow.Count - 1) do
    begin
      PosicaoDelimitador1 := Pos(':', ArquivoShadow[IShadow]);
      PosicaoDelimitador2 := PosEx(':', ArquivoShadow[IShadow], PosicaoDelimitador1 + 1);
      Usuario := Copy(ArquivoShadow[IShadow], 1, PosicaoDelimitador1 - 1);
      Senha := Copy(ArquivoShadow[IShadow], PosicaoDelimitador1 + 1, (PosicaoDelimitador2) - (PosicaoDelimitador1 + 1));
      for IPasswd := 0 to (ArquivoPasswd.Count - 1) do
      begin
        PosicaoDelimitador1 := Pos(':', ArquivoPasswd[IPasswd]);
        PosicaoDelimitador2 := PosEx(':', ArquivoPasswd[IPasswd], PosicaoDelimitador1 + 1);
        PosicaoDelimitador3 := PosEx(':', ArquivoPasswd[IPasswd], PosicaoDelimitador2 + 1);
        PosicaoDelimitador4 := PosEx(':', ArquivoPasswd[IPasswd], PosicaoDelimitador3 + 1);
        PosicaoDelimitador5 := PosEx(':', ArquivoPasswd[IPasswd], PosicaoDelimitador4 + 1);
        if (UpperCase(Copy(ArquivoPasswd[IPasswd], 1, PosicaoDelimitador1 - 1)) = UpperCase(Usuario)) then
          Descricao := Copy(ArquivoPasswd[IPasswd], PosicaoDelimitador4 + 1, (PosicaoDelimitador5) - (PosicaoDelimitador4 + 1));
      end;

      if (UpperCase(Usuario) <> UpperCase('root')) then
        if (UsuariosFilezilla.IndexOf(Usuario) = -1) then
        begin
          if (Trim(Usuario) = '') then
            raise Exception.Create('erro ao ler usuario');
          if (Trim(Senha) = '') then
            Senha := SenhaPadrao;
          if (Trim(Descricao) = '') then
            Descricao := Usuario;
          Descricao := TratarCaracteres(Descricao);

          Comando := Format('echo "criando usuario %S"', [Usuario]);
          ScriptCria.Add(Comando);
          Comando := Format('adduser %s -g 100 -s /sbin/nologin -p $(openssl passwd -1 %s) -c "%s"', [Usuario, Usuario, Descricao]);
          ScriptCria.Add(Comando);
          ListBox1.Items.Add(Comando);

          Comando := Format('echo "apagando usuario %S"', [Usuario]);
          ScriptApaga.Add(Comando);
          Comando := Format('userdel -r %s ', [Usuario]);
          ScriptApaga.Add(Comando);
        end;
    end;

    if (FileExists('criar.sh')) then
      DeleteFile('criar.sh');
    ScriptCria.SaveToFile('criar.sh');

    if (FileExists('apagar.sh')) then
      DeleteFile('apagar.sh');
    ScriptApaga.SaveToFile('apagar.sh');
  finally
    FreeAndNil(UsuariosFilezilla);
    FreeAndNil(ArquivoShadow);
    FreeAndNil(ArquivoPasswd);
    FreeAndNil(ScriptCria);
    FreeAndNil(ScriptApaga);
    TButton(Sender).Enabled := True;
  end;
end;

end.
