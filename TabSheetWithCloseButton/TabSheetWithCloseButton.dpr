program TabSheetWithCloseButton;

uses
  Forms,
  UTabSheetWithCloseButton in 'UTabSheetWithCloseButton.pas' {FrmPrincipal},
  UFrmBase in 'UFrmBase.pas' {FrmBase},
  UManagerPageControl in 'UManagerPageControl.pas',
  UFrmArquivo in 'UFrmArquivo.pas' {FrmArquivo},
  UFrmEditar in 'UFrmEditar.pas' {FrmEditar},
  UFrmLocalizar in 'UFrmLocalizar.pas' {FrmLocalizar},
  UFrmAjuda in 'UFrmAjuda.pas' {FrmAjuda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.Run;
end.
