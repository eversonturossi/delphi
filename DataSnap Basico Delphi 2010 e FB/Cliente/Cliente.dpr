program Cliente;

uses
  Forms,
  UFormPrincipal in 'UFormPrincipal.pas' {Form1},
  UDataModuleConexao in 'UDataModuleConexao.pas' {DataModuleConexao: TDataModule},
  UDataModuleCadastro in 'UDataModuleCadastro.pas' {DataModule2: TDataModule},
  ClientClasses in 'ClientClasses.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.Run;
end.
