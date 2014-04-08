unit UDatasnapContainer;

interface

uses
  SysUtils, Classes,
  DSTCPServerTransport,
  DSServer, DSCommonServer, UrdmCadastro;

type
  TDatasnapContainer = class(TDataModule)
    DatasapServer: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSServerClass1: TDSServerClass;
    DSServerClassCadastro: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSServerClassCadastroGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
  end;

var
  DatasnapContainer: TDatasnapContainer;

implementation

uses Windows, ServerMethodsUnit1;
{$R *.dfm}

procedure TDatasnapContainer.DataModuleCreate(Sender: TObject);
begin
  DatasapServer.Start;
end;

procedure TDatasnapContainer.DataModuleDestroy(Sender: TObject);
begin
  DatasapServer.Stop;
end;

procedure TDatasnapContainer.DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := ServerMethodsUnit1.TServerMethods1;
end;

procedure TDatasnapContainer.DSServerClassCadastroGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TrdmCadastro;
end;

end.
