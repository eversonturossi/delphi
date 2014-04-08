{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2008 CodeGear            }
{                                                       }
{*******************************************************}

program DataSnapExamples;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  Forms,
  TextTestRunner,
  ClientTest in 'ClientTest.pas',
  DataSnapTestData in 'DataSnapTestData.pas',
  ClientTestClasses in 'ClientTestClasses.pas',
  TestServerContainer in 'TestServerContainer.pas' {DSServerContainer: TDataModule},
  TestServerModule in 'TestServerModule.pas' {SimpleServerModule: TDataModule};

begin
  Application.Initialize;
  Application.CreateForm(TDSServerContainer, DSServerContainer);
  Application.CreateForm(TSimpleServerModule, SimpleServerModule);
  TextTestRunner.RunRegisteredTests;
  DSServerContainer.DSServer1.Stop;
  Application.Terminate;
end.
