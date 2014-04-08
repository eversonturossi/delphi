unit UDataModuleMovimento;

interface

uses
  SysUtils, Classes, DB, DBClient, UDataModuleConexao, DSConnect;

type
  TDataModuleMovimento = class(TDataModule)
    cdFinanceiro: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleMovimento: TDataModuleMovimento;

implementation

{$R *.dfm}

end.
