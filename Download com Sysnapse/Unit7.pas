unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Label2: TLabel;
    edURL: TComboBox;
    Label11: TLabel;
    edArq: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

uses
  uhttpdownloader,
  ssl_openssl, httpsend;

procedure TForm7.Button1Click(Sender: TObject);
var
  HttpDownloader: THttpDownloader;
begin
  try
    HttpDownloader := THttpDownloader.Create;

    HttpDownloader.DownloadHTTP(edURL.Text, edArq.Text, nil);
  finally
    FreeAndNil(HttpDownloader);
  end;
end;

procedure DownloadFromDropbox(AURL: String; Directory: String);
var
  LHTTP: THTTPSend;
  LRedirected: boolean;
  LFilename: String;
  LLine: string;
  I, IFileNameP1, IFileNameP22: integer;
begin
  LFilename := 'unknown.htm';
  LHTTP := THTTPSend.Create;
  try
    repeat
      LRedirected := False;
      LHTTP.HTTPMethod('GET', AURL);
      case LHTTP.Resultcode of
        301, 302, 307:
          begin
            for I := 0 to Pred(LHTTP.Headers.Count) do
              if (Pos('location: ', LowerCase(LHTTP.Headers.Strings[I])) = 1) then
              begin
                AURL := StringReplace(LHTTP.Headers.Strings[I], 'location: ', '', [rfReplaceAll, rfIgnoreCase]);
                LHTTP.Clear;
                LRedirected := True;
                Break;
              end;
          end;
      end;
    until not LRedirected;

    // extract filename from headers
    // content-disposition: attachment; filename="zzzzzzz.zzz"; filename*=UTF-8''zzzzzz.zzz
    for I := 0 to Pred(LHTTP.Headers.Count) do
      if (Pos('content-disposition: attachment;', LowerCase(LHTTP.Headers.Strings[I])) = 1) then
      begin
        LLine := LHTTP.Headers.Strings[I];
        IFileNameP1 := Pos('filename="', LLine);
        if IFileNameP1 > 0 then
        begin
          IFileNameP1 := IFileNameP1 + Length('filename="');
          IFileNameP22 := IFileNameP1;
          while (IFileNameP22 < Length(LLine)) and (LLine[IFileNameP22] <> '"') do
            Inc(IFileNameP22);
          if IFileNameP22 <= Length(LLine) then
            LFilename := Copy(LLine, IFileNameP1, IFileNameP22 - IFileNameP1);
        end;
      end;

    LHTTP.Document.SaveToFile(Directory + LFilename);
  finally
    LHTTP.Free;
  end;
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
  { https://forum.lazarus.freepascal.org/index.php?topic=30344.0 }
  DownloadFromDropbox(edURL.Text, 'c:\temp\');
end;

end.
