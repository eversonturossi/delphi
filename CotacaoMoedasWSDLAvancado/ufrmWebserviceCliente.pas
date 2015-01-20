unit ufrmWebserviceCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, InvokeRegistry, Rio, SOAPHTTPClient;

type

  TUtilHTTPRIO = class(TObject)
  private
    fMemoResponse: TMemo;
    fStrRequest: TStringList;
    fStrResponse: TStringList;
    fHttpRio: THTTPRIO;
    fMemoRequest: TMemo;
    property StrRequest: TStringList read fStrRequest write fStrRequest;
    property StrResponse: TStringList read fStrResponse write fStrResponse;
    property HTTPRIO: THTTPRIO read fHttpRio;
  public
    property MemoRequest: TMemo read fMemoRequest write fMemoRequest;
    property MemoResponse: TMemo read fMemoResponse write fMemoResponse;
    function getHTTPRIO: THTTPRIO;
    constructor Create;
    destructor Destroy; override;
  published
    procedure httpRioBeforeExecute(const MethodName: String; SOAPRequest: TStream);
    procedure httpRioAfterExecute(const MethodName: String; SOAPResponse: TStream);
  end;

  TfrmWebserviceCliente = class(TForm)
    Panel1: TPanel;
    ButtonConverter: TButton;
    ComboBoxFrom: TComboBox;
    ComboBoxTo: TComboBox;
    lblResultado: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    MemoRequest: TMemo;
    Splitter1: TSplitter;
    MemoResponse: TMemo;
    procedure FormCreate(Sender: TObject);
    procedure ButtonConverterClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    fUtilHTTPRIO: TUtilHTTPRIO;
    procedure CarregarCombos;
  public
    property UtilHTTPRIO: TUtilHTTPRIO read fUtilHTTPRIO write fUtilHTTPRIO;
  end;

var
  frmWebserviceCliente: TfrmWebserviceCliente;

implementation

uses CurrencyConvertor, typInfo;
{$R *.dfm}

procedure TfrmWebserviceCliente.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown := true;
  Self.CarregarCombos();
  fUtilHTTPRIO := TUtilHTTPRIO.Create;
  UtilHTTPRIO.MemoRequest := MemoRequest;
  UtilHTTPRIO.MemoResponse := MemoResponse;
end;

procedure TfrmWebserviceCliente.FormDestroy(Sender: TObject);
begin
  FreeAndNil(fUtilHTTPRIO);
end;

procedure TfrmWebserviceCliente.ButtonConverterClick(Sender: TObject);
var
  _ccSoap: CurrencyConvertorSoap;
begin
  MemoRequest.Lines.Clear;
  MemoResponse.Lines.Clear;
  Application.ProcessMessages;

  _ccSoap := GetCurrencyConvertorSoap(true, EmptyStr, UtilHTTPRIO.getHTTPRIO());
  try
    lblResultado.Caption := Format('$%f', [_ccSoap.ConversionRate(Currency(ComboBoxFrom.ItemIndex), Currency(ComboBoxTo.ItemIndex))]);
  finally
    _ccSoap := nil;
  end;
end;

procedure TfrmWebserviceCliente.CarregarCombos;
var
  moeda: Currency;
begin
  ComboBoxFrom.Clear;
  ComboBoxTo.Clear;

  for moeda := low(Currency) to high(Currency) do
  begin
    ComboBoxFrom.Items.Add(GetEnumName(TypeInfo(Currency), ord(moeda)));
  end;
  ComboBoxTo.Items.AddStrings(ComboBoxFrom.Items);

  ComboBoxFrom.ItemIndex := ComboBoxFrom.Items.IndexOf('USD');
  ComboBoxTo.ItemIndex := ComboBoxTo.Items.IndexOf('BRL');
end;

{ TUtilHTTPRIO }

constructor TUtilHTTPRIO.Create;
begin
  fStrRequest := TStringList.Create;
  fStrResponse := TStringList.Create;
end;

destructor TUtilHTTPRIO.Destroy;
begin
  MemoResponse := nil;
  MemoRequest := nil;
  FreeAndNil(fStrRequest);
  FreeAndNil(fStrResponse);
  inherited;
end;

function TUtilHTTPRIO.getHTTPRIO: THTTPRIO;
begin
  fHttpRio := THTTPRIO.Create(nil);
  fHttpRio.OnBeforeExecute := httpRioBeforeExecute;
  fHttpRio.OnAfterExecute := httpRioAfterExecute;
  Result := fHttpRio;
end;

procedure TUtilHTTPRIO.httpRioAfterExecute(const MethodName: String; SOAPResponse: TStream);
begin
  SOAPResponse.Position := 0;
  StrResponse.LoadFromStream(SOAPResponse);
  if Assigned(MemoResponse) then
    MemoResponse.Lines.Assign(StrResponse);
  SOAPResponse.Position := 0;
end;

procedure TUtilHTTPRIO.httpRioBeforeExecute(const MethodName: String; SOAPRequest: TStream);
begin
  SOAPRequest.Position := 0;
  StrRequest.LoadFromStream(SOAPRequest);
  if Assigned(MemoRequest) then
    MemoRequest.Lines.Assign(StrRequest);
  SOAPRequest.Position := 0;
end;

end.
