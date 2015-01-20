{
  Exemplo baseado no artigo:
  https://drgarcia1986.wordpress.com/2014/03/18/recuperando-o-xml-de-uma-requisicao-soap-em-delphi/
}

unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CurrencyConvertor, InvokeRegistry, Rio, SOAPHTTPClient,
  ExtCtrls;

type
  TfrmWebserviceCliente = class(TForm)
    HTTPRIO: THTTPRIO;
    Panel1: TPanel;
    MemoRequest: TMemo;
    Splitter1: TSplitter;
    MemoResponse: TMemo;
    ButtonRealToDolar: TButton;
    Button1: TButton;
    procedure ButtonRealToDolarClick(Sender: TObject);
    procedure HTTPRIOBeforeExecute(const MethodName: string; SOAPRequest: TStream);
    procedure HTTPRIOAfterExecute(const MethodName: string; SOAPResponse: TStream);
    procedure Button1Click(Sender: TObject);
  private
    procedure Converter;
    procedure Converter2(Botao: TButton; const FromCurrency: Currency; const ToCurrency: Currency);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmWebserviceCliente: TfrmWebserviceCliente;

implementation

{$R *.dfm}

procedure TfrmWebserviceCliente.Button1Click(Sender: TObject);
begin
  Converter2(TButton(Sender), Currency.EUR, Currency.BRL);
end;

procedure TfrmWebserviceCliente.ButtonRealToDolarClick(Sender: TObject);
begin
  Converter2(TButton(Sender), Currency.USD, Currency.BRL);
end;

procedure TfrmWebserviceCliente.Converter();
var
  oCCSoap: CurrencyConvertorSoap;
begin
  oCCSoap := GetCurrencyConvertorSoap();
  try
    ShowMessageFmt('USD -> BRL = $%f', [oCCSoap.ConversionRate(Currency.USD, Currency.BRL)]);
  finally
    oCCSoap := nil;
  end;
end;

procedure TfrmWebserviceCliente.Converter2(Botao: TButton; const FromCurrency: Currency; const ToCurrency: Currency);
var
  oCCSoap: CurrencyConvertorSoap;
begin
  MemoRequest.Lines.Clear;
  MemoResponse.Lines.Clear;
  Botao.Enabled := False;
  Application.ProcessMessages;
  oCCSoap := GetCurrencyConvertorSoap(False, EmptyStr, HTTPRIO);
  try
    ShowMessageFmt('%S = %f', [Botao.Caption, oCCSoap.ConversionRate(FromCurrency, ToCurrency)]);
  finally
    oCCSoap := nil;
    Botao.Enabled := true;
  end;
end;

procedure TfrmWebserviceCliente.HTTPRIOAfterExecute(const MethodName: string; SOAPResponse: TStream);
begin
  SOAPResponse.Position := 0;
  MemoResponse.Lines.LoadFromStream(SOAPResponse);
  SOAPResponse.Position := 0;
end;

procedure TfrmWebserviceCliente.HTTPRIOBeforeExecute(const MethodName: string; SOAPRequest: TStream);
begin
  SOAPRequest.Position := 0;
  MemoRequest.Lines.LoadFromStream(SOAPRequest);
  SOAPRequest.Position := 0;
end;

end.
