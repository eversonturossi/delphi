unit UFormServer;

interface

uses Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB,
  Vcl.Grids, Vcl.DBGrids,

  UServerMethods,
  UDSServerModuleCadastro,
  UDSServerModuleConfiguracao,
  UDSServerModuleMovimento,
  UDSServerModuleRelatorio,
  UServerContainer;

type
  TFormServer = class(TForm)
    procedure FormCreate(Sender: TObject);
  private
    ServerMethods: TServerMethods;

    DSServerModuleCadastro: TDSServerModuleCadastro;
    DSServerModuleConfiguracao: TDSServerModuleConfiguracao;
    DSServerModuleMovimento: TDSServerModuleMovimento;
    DSServerModuleRelatorio: TDSServerModuleRelatorio;

    ServerContainer: TServerContainer;

  public
    destructor Destroy; override;
  end;

var
  FormServer: TFormServer;

implementation

{$R *.dfm}

destructor TFormServer.Destroy;
begin
  FreeAndNil(ServerMethods);
  FreeAndNil(DSServerModuleCadastro);
  FreeAndNil(DSServerModuleConfiguracao);
  FreeAndNil(DSServerModuleMovimento);
  FreeAndNil(DSServerModuleRelatorio);
  FreeAndNil(ServerContainer);
  ShowMessage('Destruindo TFormServer');
  inherited;
end;

procedure TFormServer.FormCreate(Sender: TObject);
begin
  try
    ServerMethods := TServerMethods.Create(nil);

    DSServerModuleCadastro := TDSServerModuleCadastro.Create(nil);
    DSServerModuleConfiguracao := TDSServerModuleConfiguracao.Create(nil);
    DSServerModuleMovimento := TDSServerModuleMovimento.Create(nil);
    DSServerModuleRelatorio := TDSServerModuleRelatorio.Create(nil);

    ServerContainer := TServerContainer.Create(nil);
  finally

  end;
end;

end.
