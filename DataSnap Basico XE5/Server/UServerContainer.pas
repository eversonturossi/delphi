unit UServerContainer;

interface

uses System.SysUtils, System.Classes,
  Datasnap.DSTCPServerTransport,
  Datasnap.DSServer, Datasnap.DSCommonServer,
  Datasnap.DSAuth, IPPeerServer, DbxSocketChannelNative, DbxCompressionFilter;

type
  TServerContainer = class(TDataModule)
    DataSnapServer: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSAuthenticationManager1: TDSAuthenticationManager;
    DSServerClass1: TDSServerClass;
    DSServerClassConfiguracao: TDSServerClass;
    DSServerClassRelatorio: TDSServerClass;
    DSServerClassLancamento: TDSServerClass;
    DSServerClassCadastro: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSAuthenticationManager1UserAuthorize(Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
    procedure DSAuthenticationManager1UserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean;
      UserRoles: TStrings);
    procedure DSServerClassCadastroGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSServerClassLancamentoGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSServerClassRelatorioGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DSServerClassConfiguracaoGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

  public

  end;

var
  ServerContainer: TServerContainer;

implementation

uses Winapi.Windows, uServerMethods, UDSServerModuleCadastro,
  UDSServerModuleConfiguracao, UDSServerModuleMovimento,
  UDSServerModuleRelatorio;

{$R *.dfm}

procedure TServerContainer.DSServerClass1GetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := uServerMethods.TServerMethods;
end;

procedure TServerContainer.DSServerClassLancamentoGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDSServerModuleMovimento;
end;

procedure TServerContainer.DSServerClassRelatorioGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDSServerModuleRelatorio;
end;

procedure TServerContainer.DSServerClassCadastroGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDSServerModuleCadastro;
end;

procedure TServerContainer.DSServerClassConfiguracaoGetClass(DSServerClass: TDSServerClass; var PersistentClass: TPersistentClass);
begin
  PersistentClass := TDSServerModuleConfiguracao;
end;

procedure TServerContainer.DataModuleCreate(Sender: TObject);
begin
  DataSnapServer.Start;
end;

procedure TServerContainer.DataModuleDestroy(Sender: TObject);
begin
  DataSnapServer.Stop;
end;

procedure TServerContainer.DSAuthenticationManager1UserAuthenticate(Sender: TObject; const Protocol, Context, User, Password: string; var valid: Boolean;
  UserRoles: TStrings);
begin
  { TODO : Validate the client user and password.
    If role-based authorization is needed, add role names to the UserRoles parameter }
  valid := True;
end;

procedure TServerContainer.DSAuthenticationManager1UserAuthorize(Sender: TObject; EventObject: TDSAuthorizeEventObject; var valid: Boolean);
begin
  { TODO : Authorize a user to execute a method.
    Use values from EventObject such as UserName, UserRoles, AuthorizedRoles and DeniedRoles.
    Use DSAuthenticationManager1.Roles to define Authorized and Denied roles
    for particular server methods. }
  valid := True;
end;

end.
