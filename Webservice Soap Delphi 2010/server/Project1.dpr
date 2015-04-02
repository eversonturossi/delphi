program Project1;

{$APPTYPE GUI}

uses
  Forms,
  SockApp,
  Unit2 in 'Unit2.pas' {Form2},
  Unit3 in 'Unit3.pas' {WebModule3: TWebModule},
  OperacoesImpl in 'OperacoesImpl.pas',
  OperacoesIntf in 'OperacoesIntf.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TWebModule3, WebModule3);
  Application.Run;
end.

