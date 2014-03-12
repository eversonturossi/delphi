unit UInverteLink;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm3 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  I: integer;
  S: String;
begin
  try
    S := EmptyStr;
    for I := 1 to Length(Edit1.Text) do
    begin
      S := Edit1.Text[I] + S;
    end;
  finally
    Edit1.Text := Trim(S);
  end;

end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  Edit1.Clear;
end;

end.
