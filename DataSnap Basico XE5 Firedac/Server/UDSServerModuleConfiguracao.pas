unit UDSServerModuleConfiguracao;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth,
  Data.FMTBcd, Datasnap.DBClient, Datasnap.Provider, Data.DB, Data.SqlExpr,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  IPPeerClient, FireDAC.Phys, FireDAC.Phys.TDBXBase, FireDAC.Phys.DataSnap;

type
  TDSServerModuleConfiguracao = class(TDSServerModule)
    FDQuery1: TFDQuery;
    FDPhysDataSnapDriverLink1: TFDPhysDataSnapDriverLink;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses UDataModuleConexaoBanco;

{$R *.dfm}

end.
