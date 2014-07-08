program RelatorioConfiguravel;

uses
  Forms,
  Unit1 in 'Unit1.pas' { Form1 } ,
  Relatorio_NovaImpressao in 'Relatorio_NovaImpressao.pas' { RelatorioNovaImpressao: TQuickRep } ;
{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.CreateForm(TForm1, Form1);
  Application.Run;

end.
