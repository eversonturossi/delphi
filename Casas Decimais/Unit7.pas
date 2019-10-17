unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
var
  LPonto1, LPonto2, Lponto: Extended;
begin
  Edit1.Text := StringReplace(Edit1.Text, '.', ',', []);
  Edit2.Text := StringReplace(Edit2.Text, '.', ',', []);

  LPonto1 := Strtofloatdef(Edit1.Text, 0);
  LPonto2 := Strtofloatdef(Edit2.Text, 0);
  Lponto := (LPonto1 + LPonto2) / 2;
  Edit3.Text := FloatToStrF(Lponto, ffFixed, 15, 15);

  { LPonto1 := Strtofloatdef(Edit1.Text, 0);
    LPonto2 := Strtofloatdef(Edit2.Text, 0);
    Edit3.Text := ((LPonto1 + LPonto2) / 2).ToString;
    Edit3.Text := StringReplace(Edit3.Text, ',', '.', []); }

end;

end.
