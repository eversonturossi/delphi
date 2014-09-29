unit UDataModuleRelatorio;

interface

uses
  SysUtils, Classes, UDataModuleConexao, DB, DBClient;

type
  TDataModule1 = class(TDataModule)
    ClientDataSet1: TClientDataSet;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{$R *.dfm}

end.
