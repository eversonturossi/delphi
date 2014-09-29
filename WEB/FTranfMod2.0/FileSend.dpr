program FileSend;

uses
  Forms,
  fsend_u in 'fsend_u.pas' { MainSend } ;
{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TMainSend, MainSend);
  Application.Run;

end.
