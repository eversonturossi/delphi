// ************************************************************************ //
// The types declared in this file were generated from data read from the
// WSDL File described below:
// WSDL     : http://www.webservicex.net/CurrencyConvertor.asmx?WSDL
// >Import : http://www.webservicex.net/CurrencyConvertor.asmx?WSDL>0
// Encoding : utf-8
// Version  : 1.0
// (20/01/2015 10:07:47 - - $Rev: 25127 $)
// ************************************************************************ //

unit CurrencyConvertor;

interface

uses InvokeRegistry, SOAPHTTPClient, Types, XSBuiltIns;

const
  IS_REF = $0080;

type

  // ************************************************************************ //
  // The following types, referred to in the WSDL document are not being represented
  // in this file. They are either aliases[@] of other types represented or were referred
  // to but never[!] declared in the document. The types from the latter category
  // typically map to predefined/known XML or Embarcadero types; however, they could also
  // indicate incorrect WSDL documents that failed to declare or import a schema type.
  // ************************************************************************ //
  // !:double          - "http://www.w3.org/2001/XMLSchema"[Gbl]
  // !:string          - "http://www.w3.org/2001/XMLSchema"[]
{$SCOPEDENUMS ON}
  { "http://www.webserviceX.NET/"[GblSmpl] }
  Currency = (AFA, ALL, DZD, ARS, AWG, AUD, BSD, BHD, BDT, BBD, BZD, BMD, BTN, BOB, BWP, BRL, GBP, BND, BIF, XOF, XAF, KHR, CAD, CVE, KYD, CLP, CNY, COP, KMF, CRC, HRK, CUP, CYP, CZK, DKK, DJF, DOP, XCD, EGP, SVC, EEK, ETB, EUR, FKP, GMD, GHC, GIP,
    XAU, GTQ, GNF, GYD, HTG, HNL, HKD, HUF, ISK, INR, IDR, IQD, ILS, JMD, JPY, JOD, KZT, KES, KRW, KWD, LAK, LVL, LBP, LSL, LRD, LYD, LTL, MOP, MKD, MGF, MWK, MYR, MVR, MTL, MRO, MUR, MXN, MDL, MNT, MAD, MZM, MMK, NAD, NPR, ANG, NZD, NIO, NGN, KPW,
    NOK, OMR, XPF, PKR, XPD, PAB, PGK, PYG, PEN, PHP, XPT, PLN, QAR, ROL, RUB, WST, STD, SAR, SCR, SLL, XAG, SGD, SKK, SIT, SBD, SOS, ZAR, LKR, SHP, SDD, SRG, SZL, SEK, CHF, SYP, TWD, TZS, THB, TOP, TTD, TND, TRL, USD, AED, UGX, UAH, UYU, VUV, VEB,
    VND, YER, YUM, ZMK, ZWD, TRY_);
{$SCOPEDENUMS OFF}
  double_ = type Double; { "http://www.webserviceX.NET/"[GblElm] }

  // ************************************************************************ //
  // Namespace : http://www.webserviceX.NET/
  // soapAction: http://www.webserviceX.NET/ConversionRate
  // transport : http://schemas.xmlsoap.org/soap/http
  // style     : document
  // binding   : CurrencyConvertorSoap12
  // service   : CurrencyConvertor
  // port      : CurrencyConvertorSoap12
  // URL       : http://www.webservicex.net/CurrencyConvertor.asmx
  // ************************************************************************ //
  CurrencyConvertorSoap = interface(IInvokable)
    ['{7A5B2A2E-A240-0304-FA58-F86D9AFAA52F}']
    function ConversionRate(const FromCurrency: Currency; const ToCurrency: Currency): Double; stdcall;
  end;

  // ************************************************************************ //
  // Namespace : http://www.webserviceX.NET/
  // binding   : CurrencyConvertorHttpGet
  // service   : CurrencyConvertor
  // port      : CurrencyConvertorHttpGet
  // ************************************************************************ //
  CurrencyConvertorHttpGet = interface(IInvokable)
    ['{44834808-BF25-E8E7-B6F8-2713C082359C}']
    function ConversionRate(const FromCurrency: string; const ToCurrency: string): double_; stdcall;
  end;

  // ************************************************************************ //
  // Namespace : http://www.webserviceX.NET/
  // binding   : CurrencyConvertorHttpPost
  // service   : CurrencyConvertor
  // port      : CurrencyConvertorHttpPost
  // ************************************************************************ //
  CurrencyConvertorHttpPost = interface(IInvokable)
    ['{A7CCBD67-8708-2EFA-72E9-D461EF46582A}']
    function ConversionRate(const FromCurrency: string; const ToCurrency: string): double_; stdcall;
  end;

function GetCurrencyConvertorSoap(UseWSDL: Boolean = System.False; Addr: string = ''; HTTPRIO: THTTPRIO = nil): CurrencyConvertorSoap;
function GetCurrencyConvertorHttpGet(UseWSDL: Boolean = System.False; Addr: string = ''; HTTPRIO: THTTPRIO = nil): CurrencyConvertorHttpGet;
function GetCurrencyConvertorHttpPost(UseWSDL: Boolean = System.False; Addr: string = ''; HTTPRIO: THTTPRIO = nil): CurrencyConvertorHttpPost;

implementation

uses SysUtils;

function GetCurrencyConvertorSoap(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CurrencyConvertorSoap;
const
  defWSDL = 'http://www.webservicex.net/CurrencyConvertor.asmx?WSDL';
  defURL = 'http://www.webservicex.net/CurrencyConvertor.asmx';
  defSvc = 'CurrencyConvertor';
  defPrt = 'CurrencyConvertorSoap12';
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
    Result := (RIO as CurrencyConvertorSoap);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end
    else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

function GetCurrencyConvertorHttpGet(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CurrencyConvertorHttpGet;
const
  defWSDL = 'http://www.webservicex.net/CurrencyConvertor.asmx?WSDL';
  defURL = '';
  defSvc = 'CurrencyConvertor';
  defPrt = 'CurrencyConvertorHttpGet';
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
    Result := (RIO as CurrencyConvertorHttpGet);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end
    else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

function GetCurrencyConvertorHttpPost(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): CurrencyConvertorHttpPost;
const
  defWSDL = 'http://www.webservicex.net/CurrencyConvertor.asmx?WSDL';
  defURL = '';
  defSvc = 'CurrencyConvertor';
  defPrt = 'CurrencyConvertorHttpPost';
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
    Result := (RIO as CurrencyConvertorHttpPost);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end
    else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

initialization

InvRegistry.RegisterInterface(TypeInfo(CurrencyConvertorSoap), 'http://www.webserviceX.NET/', 'utf-8');
InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CurrencyConvertorSoap), 'http://www.webserviceX.NET/ConversionRate');
InvRegistry.RegisterInvokeOptions(TypeInfo(CurrencyConvertorSoap), ioDocument);
InvRegistry.RegisterInvokeOptions(TypeInfo(CurrencyConvertorSoap), ioSOAP12);
InvRegistry.RegisterInterface(TypeInfo(CurrencyConvertorHttpGet), 'http://www.webserviceX.NET/', 'utf-8');
InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CurrencyConvertorHttpGet), '');
InvRegistry.RegisterInterface(TypeInfo(CurrencyConvertorHttpPost), 'http://www.webserviceX.NET/', 'utf-8');
InvRegistry.RegisterDefaultSOAPAction(TypeInfo(CurrencyConvertorHttpPost), '');
RemClassRegistry.RegisterXSInfo(TypeInfo(Currency), 'http://www.webserviceX.NET/', 'Currency');
RemClassRegistry.RegisterExternalPropName(TypeInfo(Currency), 'TRY_', 'TRY');
RemClassRegistry.RegisterXSInfo(TypeInfo(double_), 'http://www.webserviceX.NET/', 'double_', 'double');

end.
