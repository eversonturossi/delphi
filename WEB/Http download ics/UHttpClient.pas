unit UHttpClient;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OverbyteIcsWndControl, OverbyteIcsHttpProt, StdCtrls,
  ComCtrls, Math, OverbyteIcsMD5;

type
  TForm1 = class(TForm)
    Client: THttpCli;
    btnDownload: TButton;
    FileNameEdit: TEdit;
    URLEdit: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    BandwidthLimitEdit: TEdit;
    Label3: TLabel;
    lblInfo: TLabel;
    btnAbort: TButton;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    edtMd5: TEdit;
    ProgressBar1: TProgressBar;
    procedure btnDownloadClick(Sender: TObject);
    procedure ClientDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
    procedure btnAbortClick(Sender: TObject);
    procedure ClientHeaderData(Sender: TObject);
    procedure BandwidthLimitEditChange(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses OverByteIcsFtpSrvT;
{$R *.dfm}

procedure TForm1.BandwidthLimitEditChange(Sender: TObject);
begin
  // Client.BandwidthLimit := StrToIntDef(BandwidthLimitEdit.Text, 1000000);
  // if Client.BandwidthLimit > 0 then
  // Client.Options := Client.Options + [httpoBandwidthControl];
end;

procedure TForm1.btnAbortClick(Sender: TObject);
begin
  Client.Abort;
end;

procedure TForm1.btnDownloadClick(Sender: TObject);
var
  StartTime: Longword;
  Duration, BytesSec, ByteCount: Integer;
  Temp: string;
begin
  Client.URL := URLEdit.Text;
  // Client.Proxy := ProxyHostEdit.Text;
  // Client.ProxyPort := ProxyPortEdit.Text;
  Client.RcvdStream := TFileStream.Create(FileNameEdit.Text, fmCreate);
  // {$IFDEF BUILTIN_THROTTLE}
  Client.BandwidthLimit := StrToIntDef(BandwidthLimitEdit.Text, 1000000);
  if Client.BandwidthLimit > 0 then
    Client.Options := Client.Options + [httpoBandwidthControl];
  // {$ENDIF}
  btnDownload.Enabled := FALSE;
  btnAbort.Enabled := TRUE;
  lblInfo.Caption := 'Loading';
  try
    try
      StartTime := GetTickCount;
      Client.Get;
      Duration := GetTickCount - StartTime;
      ByteCount := Client.RcvdStream.Size;
      Temp := 'Received ' + IntToStr(ByteCount) + ' bytes, ';
      if Duration < 5000 then
        Temp := Temp + IntToStr(Duration) + ' milliseconds'
      else
        Temp := Temp + IntToStr(Duration div 1000) + ' seconds';
      if ByteCount > 32767 then
        BytesSec := 1000 * (ByteCount div Duration)
      else
        BytesSec := (1000 * ByteCount) div Duration;
      Temp := Temp + ' (' + IntToKByte(BytesSec) + 'bytes/sec)';
      lblInfo.Caption := Temp;
    except
      on E: EHttpException do
      begin
        lblInfo.Caption := 'Failed : ' + IntToStr(Client.StatusCode) + ' ' + Client.ReasonPhrase; ;
      end
      else
        raise ;
    end;
  finally
    btnDownload.Enabled := TRUE;
    btnAbort.Enabled := FALSE;
    Client.RcvdStream.Destroy;
    Client.RcvdStream := nil;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);

  function MD5Ics(FileName: string): string;
  begin
    Result := LowerCase(FileMD5(FileName));
  end;

begin
  if OpenDialog1.Execute then
  begin
    edtMd5.Text := MD5Ics(OpenDialog1.FileName);
  end;
end;

procedure TForm1.ClientDocData(Sender: TObject; Buffer: Pointer; Len: Integer);
begin
  lblInfo.Caption := IntToStr(Client.RcvdCount);

  // ProgressBar1.Position := trunc((Client.RcvdCount * 100) / Client.RcvdStream.);
end;

procedure TForm1.ClientHeaderData(Sender: TObject);
begin
  lblInfo.Caption := lblInfo.Caption + '.';
end;

end.
