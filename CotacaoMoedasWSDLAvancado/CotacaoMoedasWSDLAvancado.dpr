program CotacaoMoedasWSDLAvancado;

uses
  Forms,
  ufrmWebserviceCliente in 'ufrmWebserviceCliente.pas' {frmWebserviceCliente},
  CurrencyConvertor in 'CurrencyConvertor.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmWebserviceCliente, frmWebserviceCliente);
  Application.Run;
end.
