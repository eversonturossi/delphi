unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    ListBoxResultado: TListBox;
    Label1: TLabel;
    lblArquivo: TLabel;
    edtTexto2: TEdit;
    edtTexto1: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    Button2: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
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
begin
  lblArquivo.Caption := '';
  if (OpenDialog1.Execute) then
    lblArquivo.Caption := OpenDialog1.FileName;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  StrListOrigem, StrListDestino: TStringList;
  I: Integer;
  Texto1, Texto2: AnsiString;
begin
  ListBoxResultado.Clear;

  if not(FileExists(lblArquivo.Caption)) then
    raise Exception.Create('arquivo nao encontrado');

  Texto1 := edtTexto1.Text;
  Texto2 := edtTexto2.Text;

  StrListOrigem := TStringList.Create;
  StrListDestino := TStringList.Create;
  try
    StrListOrigem.LoadFromFile(lblArquivo.Caption);

    for I := 0 to StrListOrigem.Count - 1 do
    begin
      if (Pos(Texto1, StrListOrigem[I]) > 0) then
        if (Pos(Texto2, StrListOrigem[I]) > 0) then
          StrListDestino.Add(StrListOrigem[I]);
    end;

    ListBoxResultado.Items.Assign(StrListDestino);
  finally
    FreeAndNil(StrListOrigem);
    FreeAndNil(StrListDestino);
  end;
end;

end.
