program Cliente;

uses
  Forms,
  UFormCliente in 'UFormCliente.pas' {FormCliente},
  UDataModuleConexao in 'UDataModuleConexao.pas' {DataModuleConexao: TDataModule},
  UDataModuleCadastro in 'UDataModuleCadastro.pas' {DataModuleCadastro: TDataModule},
  ClientClasses in 'ClientClasses.pas',
  UDataModuleMovimento in 'UDataModuleMovimento.pas' {DataModuleMovimento: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormCliente, FormCliente);
  Application.CreateForm(TDataModuleConexao, DataModuleConexao);
  Application.CreateForm(TDataModuleCadastro, DataModuleCadastro);
  Application.CreateForm(TDataModuleMovimento, DataModuleMovimento);
  Application.Run;
end.
