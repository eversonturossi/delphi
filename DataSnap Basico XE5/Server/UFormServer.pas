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
    procedure FormDestroy(Sender: TObject);
  private
    ServerMethods: TServerMethods;

    DSServerModuleCadastro: TDSServerModuleCadastro;
    DSServerModuleConfiguracao: TDSServerModuleConfiguracao;
    DSServerModuleMovimento: TDSServerModuleMovimento;
    DSServerModuleRelatorio: TDSServerModuleRelatorio;

    ServerContainer: TServerContainer;

  public
    { Public declarations }
  end;

var
  FormServer: TFormServer;

implementation

{$R *.dfm}

procedure TFormServer.FormCreate(Sender: TObject);
begin
  try
    ServerMethods := TServerMethods.Create(Self);

    DSServerModuleCadastro := TDSServerModuleCadastro.Create(Self);
    DSServerModuleConfiguracao := TDSServerModuleConfiguracao.Create(Self);
    DSServerModuleMovimento := TDSServerModuleMovimento.Create(Self);
    DSServerModuleRelatorio := TDSServerModuleRelatorio.Create(Self);

    ServerContainer := TServerContainer.Create(Self);
  finally

  end;
end;

procedure TFormServer.FormDestroy(Sender: TObject);
begin
  FreeAndNil(ServerMethods);
  FreeAndNil(DSServerModuleCadastro);
  FreeAndNil(DSServerModuleConfiguracao);
  FreeAndNil(DSServerModuleMovimento);
  FreeAndNil(DSServerModuleRelatorio);
  FreeAndNil(ServerContainer);
end;

end.
