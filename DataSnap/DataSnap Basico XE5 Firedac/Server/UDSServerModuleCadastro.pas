unit UDSServerModuleCadastro;

interface

uses
  System.SysUtils, System.Classes, Datasnap.DSServer

    ;

type
  TDSServerModuleCadastro = class(TDSServerModule)
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
{ TDSServerModuleCadastro }

destructor TDSServerModuleCadastro.Destroy;
begin
  ShowMessage('Destruindo TDSServerModuleCadastro');
  inherited;
end;

end.
