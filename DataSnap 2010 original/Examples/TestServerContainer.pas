{*******************************************************}
{                                                       }
{       CodeGear Delphi Visual Component Library        }
{                                                       }
{           Copyright (c) 1995-2008 CodeGear            }
{                                                       }
{*******************************************************}

unit TestServerContainer;

interface

uses
  SysUtils, Classes, DSCommonServer, DSServer, DSTransport, DSTCPServerTransport,
  TestServerModule;

type
  TDSServerContainer = class(TDataModule)
    DSServer1: TDSServer;
    DSTCPServerTransport1: TDSTCPServerTransport;
    DSServerClass1: TDSServerClass;
    procedure DSServerClass1GetClass(DSServerClass: TDSServerClass;
      var PersistentClass: TPersistentClass);
  private
    { Private declarations }
  public
    { Public declarations }
    destructor Destroy; override;
  end;

var
  DSServerContainer: TDSServerContainer;

implementation

{$R *.dfm}


destructor TDSServerContainer.Destroy;
begin
  DSServer1.Stop;
  inherited;
end;

procedure TDSServerContainer.DSServerClass1GetClass(DSServerClass: TDSServerClass;
  var PersistentClass: TPersistentClass);
begin
  PersistentClass := TSimpleServerModule;
end;

end.
