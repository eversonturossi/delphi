unit UDSServerModuleRelatorio;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer, Datasnap.DSAuth;

type
  TDSServerModuleRelatorio = class(TDSServerModule)
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
{ TDSServerModuleRelatorio }

destructor TDSServerModuleRelatorio.Destroy;
begin
  ShowMessage('Destruido TDSServerModuleRelatorio');
  inherited;
end;

end.
