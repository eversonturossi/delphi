program CotacaoMoedasWSDL;

uses
  Forms,
  Unit2 in 'Unit2.pas' {frmWebserviceCliente},
  CurrencyConvertor in 'CurrencyConvertor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWebserviceCliente, frmWebserviceCliente);
  Application.Run;
end.
