{ ******************************************************* }
{ }
{ CodeGear Delphi Visual Component Library }
{ }
{ Copyright (c) 1995-2008 CodeGear }
{ }
{ ******************************************************* }

program DataSnapTestClient;

uses
{$IF DEFINED(DEBUG)}
  // FastMM4,
{$IFEND}
  SysUtils,
  Forms,
  ClientForm in 'ClientForm.pas' { Form13 } ,
  ClientClasses in 'ClientClasses.pas',
  DataSnapTestData in '..\examples\DataSnapTestData.pas';
{$R *.res}

begin
  try
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TForm13, Form13);
    Application.Run;
  except
    on Ex: Exception do
      Application.ShowException(Ex);
  end;

end.
