program FileRecv;

uses
  Forms,
  recv_u in 'recv_u.pas' { Form1 } ;
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
