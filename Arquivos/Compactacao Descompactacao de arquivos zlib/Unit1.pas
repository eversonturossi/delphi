unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ZLib;

type
  TForm1 = class(TForm)
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    procedure CompressionProgress(Sender: TObject);
    procedure CompressFiles(Arquivos: TStrings; const Compactado: AnsiString);
    procedure DecompressFiles(FileName, Destination: AnsiString);
    procedure DecompressionProgress(Sender: TObject);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  nMax: Integer;

implementation

{$R *.dfm}

procedure TForm1.CompressionProgress(Sender: TObject);
begin
  Label2.Caption := 'Leitura Atual: ' + IntToStr((Sender as TCompressionStream).Position) + ' / Taxa de Compressão: ' + CurrToStrF(100 - (Sender as TCompressionStream).CompressionRate, ffNumber, 2);
  // Processa as mensagens do Windows na aplicação para evitar o estado "Não respondendo"
  Application.ProcessMessages;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  S: TStringList;
begin
  try
    S := TStringList.Create;
    S.Add('C:\teste1.exe');
    S.Add('C:\teste2.exe');
    S.Add('C:\teste3.exe');
    S.Add('C:\teste4.exe');
    S.Add('C:\teste5.exe');
    S.Add('C:\teste6.exe');
    CompressFiles(S, 'C:\Compactado.zlib');
  finally
    FreeAndNil(S);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  MkDir('C:\Descompactado');
  DecompressFiles('C:\Compactado.zlib', 'C:\Descompactado');
  DeleteFile('C:\Compactado.zlib');
end;

procedure TForm1.CompressFiles(Arquivos: TStrings; const Compactado: AnsiString);
var
  InFile, OutFile, TmpFile: TFileStream;
  Compr: TCompressionStream;
  I, L: Integer;
  S: AnsiString;
  ATempPath: array [0 .. 255] of Char;
begin
  if Arquivos.Count > 0 then
  begin
    // Cria o arquivo de saída, será nosso compactado
    OutFile := TFileStream.Create(Compactado, fmCreate);
    try
      { Grava o número de arquivos }
      L := Arquivos.Count;
      OutFile.Write(L, SizeOf(L));
      for I := 0 to Arquivos.Count - 1 do
      begin
        Label1.Caption := 'Comprimindo: ' + IntToStr(I + 1) + ' de ' + IntToStr(Arquivos.Count);
        InFile := TFileStream.Create(Arquivos[I], fmOpenRead);
        try
          { Grava o nome do arquivo a compactar }
          S := ExtractFileName(Arquivos[I]);
          L := Length(S);
          OutFile.Write(L, SizeOf(L));
          OutFile.Write(S[1], L);
          { Pega o caminho da pasta temporária do Windows }
          ATempPath := #0;
          GetTempPath(256, ATempPath);
          { Grava o tamanho do arquivo a compactar }
          L := InFile.Size;
          OutFile.Write(L, SizeOf(L));
          { Comprime o arquivo em um outro temporário }
          TmpFile := TFileStream.Create(Trim(ATempPath) + 'tmpZLib', fmCreate);
          Compr := TCompressionStream.Create(clDefault, TmpFile); // clMax é compressão Máxima
          Compr.OnProgress := CompressionProgress; // Atribui o evento para sabermos se a compressão está em andamento
          try
            Compr.CopyFrom(InFile, L); // Efetua a compressão do arquivo
          finally
            Compr.Free;
            TmpFile.Free;
          end;
          { Copia o arquivo comprimido temporário para o nosso arquivo de saída }
          TmpFile := TFileStream.Create(Trim(ATempPath) + 'tmpZLib', fmOpenRead);
          try
            OutFile.CopyFrom(TmpFile, 0);
          finally
            TmpFile.Free;
          end;
        finally
          InFile.Free;
        end;
      end;
      Label1.Caption := '';
      Label2.Caption := '';
    finally
      OutFile.Free;
    end;
    DeleteFile(Trim(ATempPath) + 'tmpZLib'); // Remove o arquivo temporário
  end;
end;

// Progresso da Descompactação
procedure TForm1.DecompressionProgress(Sender: TObject);
begin
  Label2.Caption := CurrToStrF(((Sender as TDecompressionStream).Position * 100) / nMax, ffNumber, 0);
  Application.ProcessMessages;
end;

procedure TForm1.DecompressFiles(FileName, Destination: AnsiString);
var
  InFile, OutFile: TFileStream;
  Decompr: TDecompressionStream;
  S: AnsiString;
  I, L, C: Integer;
begin
  Destination := IncludeTrailingPathDelimiter(Destination);
  InFile := TFileStream.Create(FileName, fmOpenRead);
  try
    { Pega o número de arquivos }
    InFile.Read(C, SizeOf(C));
    for I := 1 to C do
    begin
      Label1.Caption := 'Descompactando: ' + IntToStr(I) + ' de ' + IntToStr(C);
      { Pega o nome do arquivo }
      InFile.Read(L, SizeOf(L));
      SetLength(S, L);
      InFile.Read(S[1], L);
      { Lê o tamanho do arquivo }
      InFile.Read(L, SizeOf(L));
      { Progresso do arquivo atual. Não se pode ler Decompr.Size, dá erro, por isso utilizamos L }
      nMax := L;
      { Descompacta e grava o arquivo no disco }
      S := Destination + S; // Adiciona o caminho do arquivo
      OutFile := TFileStream.Create(S, fmCreate or fmShareExclusive);
      Decompr := TDecompressionStream.Create(InFile);
      Decompr.OnProgress := DecompressionProgress;
      try
        OutFile.CopyFrom(Decompr, L);
      finally
        OutFile.Free;
        Decompr.Free;
      end;
    end;
    Label1.Caption := '';
    Label2.Caption := '';
  finally
    InFile.Free;
  end;
end;

end.
