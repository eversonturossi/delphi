unit UDataModuleCadastro;

interface

uses
  SysUtils, Classes, DB, DBClient, DSConnect, UDataModuleConexao;

type
  TDataModuleCadastro = class(TDataModule)
    cdClifor: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleCadastro: TDataModuleCadastro;

implementation

{$R *.dfm}

end.
