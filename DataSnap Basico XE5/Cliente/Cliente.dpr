program Cliente;

uses
  Vcl.Forms,
  UFormCliente in 'UFormCliente.pas' {Form1},
  UDataModuleConfiguracao in 'UDataModuleConfiguracao.pas' {DataModule1: TDataModule},
  UDataModuleConexaoDataSnap in 'UDataModuleConexaoDataSnap.pas' {DataModule2: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TDataModule2, DataModule2);
  Application.Run;
end.
