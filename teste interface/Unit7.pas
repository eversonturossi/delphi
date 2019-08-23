unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, MyClasses, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
  {  foo: IFoo;
    foo2: TFoo;  }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
var
    foo: IFoo;
    foo2: TFoo;
begin
  foo := TFoo.Create(TBar.Create);
  //foo2 := tFoo(foo);
  foo.Execute;

      ShowMessage('ok');
end;

procedure TForm7.Button2Click(Sender: TObject);
begin
//  if Assigned(foo2) then
    ShowMessage('ok');
end;

end.
