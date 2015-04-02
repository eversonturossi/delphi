unit Unit2;

interface

uses
  SysUtils, Classes, Forms;

type
  TForm2 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses SockApp;

{$R *.dfm}

initialization
  TWebAppSockObjectFactory.Create('coServico')

end.

