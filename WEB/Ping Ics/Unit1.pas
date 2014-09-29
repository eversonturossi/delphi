unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OverbyteIcsWndControl, OverbyteIcsPing;

type
  TForm1 = class(TForm)
    Ping1: TPing;
    Button1: TButton;
    Edit1: TEdit;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
    procedure Ping1Display(Sender, Icmp: TObject; Msg: string);
    procedure Ping1EchoReply(Sender, Icmp: TObject; Status: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  ping: Integer;
begin
  Ping1.Address := Edit1.Text;
  ping := Ping1.ping;
  if ping > 0 then
    ShowMessageFmt('pingado %d', [ping])
  else
    ShowMessage('erro');
end;

procedure TForm1.Ping1Display(Sender, Icmp: TObject; Msg: string);
begin
  ListBox1.Items.Add('1 - ' + Msg);
end;

procedure TForm1.Ping1EchoReply(Sender, Icmp: TObject; Status: Integer);
begin
  ListBox1.Items.Add('2 - ' + IntToStr(Status));
end;

end.
