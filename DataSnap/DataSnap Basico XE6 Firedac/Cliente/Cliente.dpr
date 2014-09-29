program Cliente;

uses
  Vcl.Forms,
  UFormCliente in 'UFormCliente.pas' {Form1},
  UDataModuleConfiguracao in 'UDataModuleConfiguracao.pas' {DataModuleConfiguracao: TDataModule},
  UDataModuleConexaoDataSnap in 'UDataModuleConexaoDataSnap.pas' {DataModuleConexaoDataSap: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModuleConfiguracao, DataModuleConfiguracao);
  Application.CreateForm(TDataModuleConexaoDataSap, DataModuleConexaoDataSap);
  Application.Run;
end.
