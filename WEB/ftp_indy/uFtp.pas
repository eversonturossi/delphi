unit uFtp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdExplicitTLSClientServerBase, IdFTP, StdCtrls, ComCtrls, Gauges;

type
  TForm1 = class(TForm)
    btnConectar: TButton;
    btnPut: TButton;
    btnDesconectar: TButton;
    IdFTP1: TIdFTP;
    Gauge1: TGauge;
    Memo_Relatorio_FTP: TMemo;
    OpenDialog1: TOpenDialog;
    btnCriaDir: TButton;
    btnDeleteDir: TButton;
    btnGet: TButton;
    TreeView1: TTreeView;
    btnListarArquivos: TButton;
    btnChanceDir: TButton;
    procedure btnConectarClick(Sender: TObject);
    procedure btnDesconectarClick(Sender: TObject);
    procedure IdFTP1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
    procedure IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
    procedure btnPutClick(Sender: TObject);
    procedure btnCriaDirClick(Sender: TObject);
    procedure btnDeleteDirClick(Sender: TObject);
    procedure btnGetClick(Sender: TObject);
    procedure btnChanceDirClick(Sender: TObject);
    procedure btnListarArquivosClick(Sender: TObject);
  private
    bytesToTransfer: integer;
    Diretorio_Leitura: string;
  public
    constructor Create(AOwner: tcomponent); override;
  end;

var
  Form1: TForm1;

implementation

uses IdFTPList;
{$R *.dfm}

procedure TForm1.btnConectarClick(Sender: TObject);
begin
  Memo_Relatorio_FTP.Clear;
  try
    IdFTP1.Host := 'host.com.br';
    IdFTP1.Port := 21;
    IdFTP1.Username := 'usuario';
    IdFTP1.Password := 'senha';
    IdFTP1.Passive := true;
    IdFTP1.Connect;
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
end;

procedure TForm1.btnDesconectarClick(Sender: TObject);
begin
  try
    // if IdFTP1.Status = ftpTransfer  then

    IdFTP1.Disconnect;
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
end;

procedure TForm1.btnPutClick(Sender: TObject);
var
  m: TStream;
  f: TStream;
  t: Cardinal;
  Nome_Arquivo, Auxiliar: string;
  contador: integer;
begin
  Auxiliar := ' ';
  f := nil;
  m := nil;

  Memo_Relatorio_FTP.Lines.Add('Diretório original: ' + Diretorio_Leitura);
  OpenDialog1.Filter := 'Arquivos(*.*)|*.*';

  if OpenDialog1.Execute then
  begin

    Nome_Arquivo := OpenDialog1.FileName;

    Memo_Relatorio_FTP.Lines.Add('Operação: troca de diretório local');
    Memo_Relatorio_FTP.Lines.Add('Diretório do arquivo: ' + GetCurrentDir);
    Memo_Relatorio_FTP.Lines.Add('');

    Nome_Arquivo := AnsiStrRScan(PCHar(Nome_Arquivo), '\');
    for contador := 2 To StrLen(PCHar(Nome_Arquivo)) do
      Auxiliar := Auxiliar + Nome_Arquivo[contador];
    Nome_Arquivo := Auxiliar;

    try
      Memo_Relatorio_FTP.Lines.Add('Operação: Upload');
      Memo_Relatorio_FTP.Lines.Add('Arquivo local: ' + OpenDialog1.FileName);
      Memo_Relatorio_FTP.Lines.Add('Gravado como: ' + Nome_Arquivo);

      f := TFileStream.Create(OpenDialog1.FileName, fmOpenRead);
      m := TMemoryStream.Create;
      m.CopyFrom(f, f.Size);
      m.Seek(0, 0);
      t := GetTickCount;
      IdFTP1.Put(m, Nome_Arquivo);

      Memo_Relatorio_FTP.Lines.Add(Format('tempo %d milesegundos', [GetTickCount - t]));
      Memo_Relatorio_FTP.Lines.Add(Format('Tamanho %d bytes', [m.Size]));
      Memo_Relatorio_FTP.Lines.Add('');

    finally
      m.Free;
      f.Free;
    end;
  end;
  SetCurrentDir(Diretorio_Leitura);
  Memo_Relatorio_FTP.Lines.Add('Operação: troca de diretorio local');
  Memo_Relatorio_FTP.Lines.Add('Diretório após a operação: ' + GetCurrentDir);
  Memo_Relatorio_FTP.Lines.Add('');

end;

procedure TForm1.btnGetClick(Sender: TObject);
var
  WebCheats: TFileStream;
begin
  try
    { como o IdFTP nao aceita substituir nenhum arquivo, temos que checar primeiro se o arquivo existe }
    if not FileExists('C:\temp\arduino.exe') then
    begin
      WebCheats := TFileStream.Create('C:\webcheats.exe', fmCreate);
      IdFTP1.Get('arduino.exe', WebCheats);
    end
    else
      DeleteFile('C:\temp\arduino.exe');
    WebCheats := TFileStream.Create('C:\webcheats.exe', fmCreate);
    IdFTP1.Get('arduino.exe', WebCheats);
  finally
    WebCheats.Free;
  end;
end;

procedure TForm1.btnListarArquivosClick(Sender: TObject);
var
  i: integer;
  AFile: string;
begin
  IdFTP1.List(nil);
  for i := 0 To IdFTP1.ListResult.Count - 1 do
  begin
{$IFDEF VER000}   // exemplo original provavelmente em delphi7
    AFile := IdFTP1.ListResult.Items[i].FileName;
    if (AFile = '.') or (AFile = '..') then
      Continue;
    if IdFTP1.ListResult.Items[i].ItemType = ditDirectory then
      Memo_Relatorio_FTP.Lines.Add('dir: ' + AFile)
    else
      if IdFTP1.ListResult.Items[i].ItemType = ditFile then
      begin
        Memo_Relatorio_FTP.Lines.Add('file: ' + AFile)
      end;
{$ENDIF}
{$IFDEF VER210}   // 2010
    AFile := IdFTP1.DirectoryListing.Items[i].FileName;
    if (AFile = '.') or (AFile = '..') then
      Continue;
    if IdFTP1.DirectoryListing.Items[i].ItemType = ditDirectory then
      Memo_Relatorio_FTP.Lines.Add('dir: ' + AFile)
    else
      if IdFTP1.DirectoryListing.Items[i].ItemType = ditFile then
      begin
        Memo_Relatorio_FTP.Lines.Add('file: ' + AFile)
      end;
{$ENDIF}
{$IFDEF VER260}       // XE5
    AFile := IdFTP1.ListResult.Items[i].FileName;
    if (AFile = '.') or (AFile = '..') then
      Continue;
    if IdFTP1.ListResult.Items[i].ItemType = ditDirectory then
      Memo_Relatorio_FTP.Lines.Add('dir: ' + AFile)
    else
      if IdFTP1.ListResult.Items[i].ItemType = ditFile then
      begin
        Memo_Relatorio_FTP.Lines.Add('file: ' + AFile)
      end;
{$ENDIF}
  end;
end;

procedure TForm1.btnChanceDirClick(Sender: TObject);
begin
  try
    IdFTP1.ChangeDir('teste2');
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
end;

procedure TForm1.btnCriaDirClick(Sender: TObject);
begin
  try
    IdFTP1.MakeDir('teste2');
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
end;

procedure TForm1.btnDeleteDirClick(Sender: TObject);
begin
  try
    IdFTP1.RemoveDir('teste2');
  except
    on E: Exception do
      ShowMessage('Erro: ' + E.Message);
  end;
end;

constructor TForm1.Create(AOwner: tcomponent);
begin
  inherited;

  btnDesconectar.Enabled := False;
  btnCriaDir.Enabled := False;
  btnDeleteDir.Enabled := False;
  btnChanceDir.Enabled := False;
  btnListarArquivos.Enabled := False;
  btnPut.Enabled := False;
  btnGet.Enabled := False;

end;

procedure TForm1.IdFTP1Status(ASender: TObject; const AStatus: TIdStatus; const AStatusText: string);
begin
  case AStatus of
    hsConnected:
      begin

      end;
    hsDisconnected:
      begin

      end;
  end;
  btnConectar.Enabled := not(TIdFTP(ASender).Connected);
  btnDesconectar.Enabled := TIdFTP(ASender).Connected;
  btnCriaDir.Enabled := TIdFTP(ASender).Connected;
  btnDeleteDir.Enabled := TIdFTP(ASender).Connected;
  btnChanceDir.Enabled := TIdFTP(ASender).Connected;
  btnListarArquivos.Enabled := TIdFTP(ASender).Connected;
  btnPut.Enabled := TIdFTP(ASender).Connected;
  btnGet.Enabled := TIdFTP(ASender).Connected;

  Self.Caption := AStatusText;
end;

procedure TForm1.IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode; AWorkCount: Int64);
begin
  Gauge1.Progress := AWorkCount;
  Application.ProcessMessages;
end;

procedure TForm1.IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode; AWorkCountMax: Int64);
begin
  Gauge1.Progress := 0;
  if AWorkCountMax > 0 then
    Gauge1.MaxValue := AWorkCountMax;
  // else
  // Gauge1.MaxValue := bytesToTransfer;
end;

end.

{
  function TFrmPrincipal.CaminhoCompleto: String;
  var
  NoRaiz: TTreeNode;
  S: String;
  begin
  if TreeView1.Selected = nil then
  Exit;
  S := '';
  NoRaiz := TreeView1.Selected;
  if not(NoRaiz = TreeView1.Selected.GetLastChild) then
  While NoRaiz.Parent <> nil do
  begin
  NoRaiz := NoRaiz.Parent;
  S := S + NoRaiz.Text + '/';
  end;
  Result := S + TreeView1.Selected.Text;
  end;

  procedure TFrmPrincipal.ListarArquivos(NodePai: TTreeNode; Diretorio: String);
  var
  i, J: integer;
  Node: TTreeNode;
  begin
  Try
  IdFTP1.Connect;
  IdFTP1.ChangeDir(Diretorio);
  IdFTP1.List(nil);
  if NodePai <> Nil then
  if NodePai.HasChildren then
  NodePai.DeleteChildren;
  for i := 0 to IdFTP1.DirectoryListing.Count - 1 do
  begin
  Node := TTreeNode.Create(TreeView1.Items);
  Node.Text := IdFTP1.DirectoryListing.Items[i].FileName;
  if (Node.Text = '.') or (Node.Text = '..') then
  Continue;
  if NodePai = Nil then
  Node := TreeView1.Items.Add(Nil, Node.Text)
  else
  Node := TreeView1.Items.AddChild(NodePai, Node.Text);
  if IdFTP1.DirectoryListing.Items[i].ItemType = ditDirectory then
  Node.ImageIndex := 0
  else if IdFTP1.DirectoryListing.Items[i].ItemType = ditFile then
  begin
  Node.ImageIndex := 1;
  Node.SelectedIndex := 2;
  end;
  end;
  finally
  IdFTP1.Disconnect;
  end;
  end; }
