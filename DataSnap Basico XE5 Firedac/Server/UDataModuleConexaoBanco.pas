unit UDataModuleConexaoBanco;

interface

uses
  System.SysUtils, System.Classes,

  FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Comp.UI, FireDAC.Phys.IBBase, FireDAC.Phys.FB, Data.DB,
  FireDAC.Comp.Client;

type
  TDataModuleConexaoBanco = class(TDataModule)
    FDConexaoBanco: TFDConnection;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    destructor Destroy; override;
  end;

var
  DataModuleConexaoBanco: TDataModuleConexaoBanco;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses
  Vcl.Dialogs;
{$R *.dfm}

procedure TDataModuleConexaoBanco.DataModuleCreate(Sender: TObject);
begin
  FDConexaoBanco.Connected := True;
end;

procedure TDataModuleConexaoBanco.DataModuleDestroy(Sender: TObject);
begin
  FDConexaoBanco.Connected := False;
end;

destructor TDataModuleConexaoBanco.Destroy;
begin
  ShowMessage('Destruindo TDataModuleConexaoBanco');
  inherited;
end;

end.
