program SequenciaConstrutoresDestrutores;

uses
  Forms,
  UFormBase in 'UFormBase.pas' {FormBase},
  UFormInicial in 'UFormInicial.pas' {FormInicial};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFormInicial, FormInicial);
  Application.Run;
end.
