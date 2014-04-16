unit UDataModuleConfiguracao;

interface

uses
  System.SysUtils, System.Classes, Data.DBXDataSnap, IPPeerClient,
  Data.DBXCommon, Data.DB, Data.SqlExpr, Datasnap.DBClient, Datasnap.DSConnect,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDataModuleConfiguracao = class(TDataModule)
    FDQuery1: TFDQuery;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModuleConfiguracao: TDataModuleConfiguracao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses UDataModuleConexaoDataSnap;

{$R *.dfm}

end.
