unit UDSServerModuleConfiguracao;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer,

  FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt,
  Datasnap.Provider, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDSServerModuleConfiguracao = class(TDSServerModule)
    FDQueryTabelas: TFDQuery;
    dspTabelas: TDataSetProvider;
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
