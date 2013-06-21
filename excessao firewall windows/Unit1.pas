unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    EditNomeRegra: TEdit;
    Label1: TLabel;
    EditPorta: TEdit;
    Label2: TLabel;
    EditAplicacao: TEdit;
    Label3: TLabel;
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses Comobj;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
    EditAplicacao.Text := OpenDialog1.FileName;
end;

end.
