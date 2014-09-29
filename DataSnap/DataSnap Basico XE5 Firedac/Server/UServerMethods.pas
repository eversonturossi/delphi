unit UServerMethods;

interface

uses System.SysUtils, System.Classes, Datasnap.DSServer;

type
  TServerMethods = class(TDSServerModule)
  private
    { Private declarations }
  public
    { Public declarations }
    function EchoString(Value: string): string;
    function ReverseString(Value: string): string;
    destructor Destroy; override;
  end;

implementation

{$R *.dfm}

uses System.StrUtils,
  Vcl.Dialogs;

destructor TServerMethods.Destroy;
begin
  ShowMessage('Destruindo TServerMethods');
  inherited;
end;

function TServerMethods.EchoString(Value: string): string;
begin
  Result := Value;
end;

function TServerMethods.ReverseString(Value: string): string;
begin
  Result := System.StrUtils.ReverseString(Value);
end;

end.
