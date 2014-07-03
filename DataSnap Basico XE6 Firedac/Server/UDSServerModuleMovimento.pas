unit UDSServerModuleMovimento;

interface

uses
  System.SysUtils, System.Classes,
  Datasnap.DSServer,
  Datasnap.DSProviderDataModuleAdapter,
  Datasnap.DSAuth;

type
  TDSServerModuleMovimento = class(TDSServerModule)
  private
    { Private declarations }
  public
    destructor Destroy; override;
  end;

implementation

{ %CLASSGROUP 'Vcl.Controls.TControl' }

uses
  Vcl.Dialogs;
{$R *.dfm}
{ TDSServerModuleMovimento }

destructor TDSServerModuleMovimento.Destroy;
begin
  ShowMessage('Destruindo TDSServerModuleMovimento');
  inherited;
end;

end.
