unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
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

uses
  ObjectClone;

{$R *.dfm}
{ Fonte:  https://delphihaven.wordpress.com/2011/06/09/object-cloning-using-rtti/ }

procedure TForm7.Button1Click(Sender: TObject);
var
  NewButton: TButton;
begin
  NewButton := TObjectClone.From(TButton(Sender));
  NewButton.Left := TButton(Sender).Left + 75;
end;

end.
