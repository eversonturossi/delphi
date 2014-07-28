unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, OverbyteIcsWndControl, OverbyteIcsHttpProt;

type
  TForm1 = class(TForm)
    Button1: TButton;
    HttpCli1: THttpCli;
    ListBox1: TListBox;
    Edit1: TEdit;
    Edit2: TEdit;
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

procedure TForm1.Button1Click(Sender: TObject);
const
  UsuarioAutenticacaoHttp = 'usuario';
  SenhaAutenticacaoHttp = 'senha';
var
  TempoInicial, TempoFinal: TDateTime;
begin
  try
    try
      Button1.Enabled := false;
      HttpCli1.URL := Edit1.Text;
      HttpCli1.NoCache := True;
      HttpCli1.ServerAuth := httpAuthBasic;
      HttpCli1.Username := UsuarioAutenticacaoHttp;
      HttpCli1.Password := Edit2.Text;
      self.Caption := IntToStr(HttpCli1.Timeout);
      TempoInicial := Now;
      HttpCli1.Get;
      ListBox1.Items.Add('GET OK !');
      ListBox1.Items.Add('StatusCode   = ' + IntToStr(HttpCli1.StatusCode));

      if (HttpCli1.StatusCode < 100) or (HttpCli1.StatusCode > 399) then
        raise Exception.Create('tem coisa errada');
    except
      on E: Exception do
      begin
        ListBox1.Items.Add('GET Failed !');
        ListBox1.Items.Add('StatusCode   = ' + IntToStr(HttpCli1.StatusCode));
        ListBox1.Items.Add('detalhe: ' + E.Message);
      end;
    end;
  finally
    Button1.Enabled := True;
    TempoFinal := Now;
    ListBox1.Items.Add(FormatDateTime('hh:nn:ss', TempoFinal - TempoInicial));
    ListBox1.Items.Add('');
    ListBox1.ItemIndex := ListBox1.Count - 1;
  end;

end;

end.
