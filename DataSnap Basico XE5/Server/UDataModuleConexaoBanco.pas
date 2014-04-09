unit UDataModuleConexaoBanco;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.SqlExpr, Data.DBXFirebird;

type
  TDataModuleConexaoBanco = class(TDataModule)
    ConexaoBanco: TSQLConnection;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleConexaoBanco: TDataModuleConexaoBanco;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

{$R *.dfm}

procedure TDataModuleConexaoBanco.DataModuleCreate(Sender: TObject);
begin
  ConexaoBanco.Connected := True;
end;

procedure TDataModuleConexaoBanco.DataModuleDestroy(Sender: TObject);
begin
  ConexaoBanco.Connected := False;
end;

end.
