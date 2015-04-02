// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://localhost:8081/Project1.coServico/wsdl/IOperacoes
//  >Import : http://localhost:8081/Project1.coServico/wsdl/IOperacoes>0
// Version  : 1.0
// (02/04/2015 09:54:44 - - $Rev: 25127 $)
// ************************************************************************ //

unit IOperacoes1;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also 
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[Gbl]

  TMyEmployee          = class;                 { "urn:OperacoesIntf"[GblCplx] }

  {$SCOPEDENUMS ON}
  { "urn:OperacoesIntf"[GblSmpl] }
  TEnumTest = (etNone, etAFew, etSome, etAlot);

  {$SCOPEDENUMS OFF}

  TDoubleArray = array of Double;               { "urn:OperacoesIntf"[GblCplx] }


  // ************************************************************************ //
  // XML       : TMyEmployee, global, <complexType>
  // Namespace : urn:OperacoesIntf
  // ************************************************************************ //
  TMyEmployee = class(TRemotable)
  private
    FLastName: string;
    FFirstName: string;
    FSalary: Double;
  published
    property LastName:  string  read FLastName write FLastName;
    property FirstName: string  read FFirstName write FFirstName;
    property Salary:    Double  read FSalary write FSalary;
  end;


  // ************************************************************************ //
  // Namespace : urn:OperacoesIntf-IOperacoes
  // soapAction: urn:OperacoesIntf-IOperacoes#%operationName%
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : rpc
  // binding   : IOperacoesbinding
  // service   : IOperacoesservice
  // port      : IOperacoesPort
  // URL       : http://localhost:8081/Project1.coServico/soap/IOperacoes
  // ************************************************************************ //
  IOperacoes = interface(IInvokable)
  ['{CC60E911-02EC-E7B1-52F5-0BE69C35D74A}']
    function  echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function  echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function  echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function  echoDouble(const Value: Double): Double; stdcall;
  end;

function GetIOperacoes(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): IOperacoes;


implementation
  uses SysUtils;

function GetIOperacoes(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): IOperacoes;
const
  defWSDL = 'http://localhost:8081/Project1.coServico/wsdl/IOperacoes';
  defURL  = 'http://localhost:8081/Project1.coServico/soap/IOperacoes';
  defSvc  = 'IOperacoesservice';
  defPrt  = 'IOperacoesPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;
  try
    Result := (RIO as IOperacoes);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;


initialization
  InvRegistry.RegisterInterface(TypeInfo(IOperacoes), 'urn:OperacoesIntf-IOperacoes', '');
  InvRegistry.RegisterDefaultSOAPAction(TypeInfo(IOperacoes), 'urn:OperacoesIntf-IOperacoes#%operationName%');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TDoubleArray), 'urn:OperacoesIntf', 'TDoubleArray');
  RemClassRegistry.RegisterXSClass(TMyEmployee, 'urn:OperacoesIntf', 'TMyEmployee');
  RemClassRegistry.RegisterXSInfo(TypeInfo(TEnumTest), 'urn:OperacoesIntf', 'TEnumTest');

end.