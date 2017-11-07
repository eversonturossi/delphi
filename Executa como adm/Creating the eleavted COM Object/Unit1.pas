unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TForm1 = class(TForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function CoGetObject(pszName: PWideChar; pBindOptions: PBindOpts3; const iid: TIID; ppv: PPointer): HResult; stdcall; external 'ole32.dll';

var
  Form1: TForm1;

implementation

{$R *.dfm}

function CoCreateInstanceAsAdmin(const Handle: HWND; const ClassID, iid: TGuid; PInterface: PPointer);
var
  BindOpts: TBindOpts3;
  MonikerName: WideString;
begin
  MonikerName := 'Elevation:Administrator!new:' + GUIDToString(ClassID);
  ZeroMemory(@BindOpts, Sizeof(TBindOpts3));
  BindOpts.HWND := Handle;
  BindOpts.cbStruct := Sizeof(TBindOpts3);
  BindOpts.dwClassContext := CLSCTX_LOCAL_SERVER;
  Result := CoGetObject(PWideChar(MonikerName), @BindOpts, iid, PInterface);
end;

end.
