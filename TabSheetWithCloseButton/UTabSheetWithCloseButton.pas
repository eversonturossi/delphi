unit UTabSheetWithCloseButton;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, UxTheme, Themes, Math, XPMan, UFrmArquivo, UFrmAjuda,
  UFrmEditar, UFrmLocalizar, UManagerPageControl;

type
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Editar1: TMenuItem;
    Localizar1: TMenuItem;
    Ajuda1: TMenuItem;
    PageControlCloseButton: TPageControl;
    StatusBar1: TStatusBar;
    TabSheet7: TTabSheet;
    TabSheet8: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure Arquivo1Click(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure Localizar1Click(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
  private
    procedure CriarAba(clsForm: TFormClass; Index: Integer);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.CriarAba(clsForm: TFormClass; Index: Integer);
begin
  ManagerPageControlCloseButton.CriarAba(clsForm, PageControlCloseButton, Index);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  ManagerPageControlCloseButton.AssignEvents(PageControlCloseButton);
  ManagerPageControlCloseButton.CreateCloseButtonInNewTab(PageControlCloseButton);
end;

procedure TForm1.Ajuda1Click(Sender: TObject);
begin
  CriarAba(TFrmAjuda, 0);
end;

procedure TForm1.Arquivo1Click(Sender: TObject);
begin
  CriarAba(TFrmArquivo, 0);
end;

procedure TForm1.Localizar1Click(Sender: TObject);
begin
  CriarAba(TFrmLocalizar, 0);
end;

procedure TForm1.Editar1Click(Sender: TObject);
begin
  CriarAba(TFrmEditar, 0);
end;

end.
