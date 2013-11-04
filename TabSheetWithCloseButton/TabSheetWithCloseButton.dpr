program TabSheetWithCloseButton;

uses
  Forms,
  UTabSheetWithCloseButton in 'UTabSheetWithCloseButton.pas' { FrmPrincipal } ,
  UFrmArquivo in 'UFrmArquivo.pas' { FrmArquivo } ,
  UFrmEditar in 'UFrmEditar.pas' { FrmEditar } ,
  UFrmLocalizar in 'UFrmLocalizar.pas' { FrmLocalizar } ,
  UFrmAjuda in 'UFrmAjuda.pas' { FrmAjuda } ,
  UManagerPageControl in 'UManagerPageControl.pas',
  UFrmBase in 'UFrmBase.pas' { FrmBase } ;
{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;

end.
