unit UDataModuleCadastro;

interface

uses
  SysUtils, Classes, DB, DBClient, DSConnect, UDataModuleConexao;

type
  TDataModule2 = class(TDataModule)
    DSProviderCadastro: TDSProviderConnection;
    ClientDataSet1: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule2: TDataModule2;

implementation

{$R *.dfm}

end.
