program Cliente;

uses
  Forms,
  UFormCliente in 'UFormCliente.pas' {FormCliente},
  UDataModuleConexao in 'UDataModuleConexao.pas' {DataModuleConexao: TDataModule},
  UDataModuleCadastro in 'UDataModuleCadastro.pas' {DataModuleCadastro: TDataModule},
  ClientClasses in 'ClientClasses.pas',
  UDataModuleMovimento in 'UDataModuleMovimento.pas' {DataModuleMovimento: TDataModule},
  UDataModuleRelatorio in 'UDataModuleRelatorio.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCliente, FormCliente);
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.CreateForm(TDataModuleCadastro, DataModuleCadastro);
  Application.CreateForm(TDataModuleMovimento, DataModuleMovimento);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
