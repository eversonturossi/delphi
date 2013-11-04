program TabSheetWithCloseButton;

uses
  Forms,
  UTabSheetWithCloseButton in 'UTabSheetWithCloseButton.pas' {Form1},
  UFrmArquivo in 'UFrmArquivo.pas' {FrmArquivo},
  UFrmEditar in 'UFrmEditar.pas' {FrmEditar},
  UFrmLocalizar in 'UFrmLocalizar.pas' {FrmLocalizar},
  UFrmAjuda in 'UFrmAjuda.pas' {FrmAjuda};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
