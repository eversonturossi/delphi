unit UTabSheetWithCloseButton;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, ComCtrls, UxTheme, Themes, Math, XPMan, UManagerPageControl;

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Arquivo1: TMenuItem;
    Editar1: TMenuItem;
    Localizar1: TMenuItem;
    Ajuda1: TMenuItem;
    PageControlCloseButton: TPageControl;
    StatusBar1: TStatusBar;
    TabSheetPrincipal: TTabSheet;
    procedure FormCreate(Sender: TObject);
    procedure Arquivo1Click(Sender: TObject);
    procedure Editar1Click(Sender: TObject);
    procedure Localizar1Click(Sender: TObject);
    procedure Ajuda1Click(Sender: TObject);
  private
    procedure CriarAba(ClasseForm: TFormClass; Index: Integer);
  public
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation

uses
  UFrmAjuda, UFrmArquivo, UFrmBase, UFrmEditar, UFrmLocalizar;
{$R *.dfm}

procedure TFrmPrincipal.CriarAba(ClasseForm: TFormClass; Index: Integer);
begin
  if not(TManagerPageControlCloseButton.ExisteAba(PageControlCloseButton, ClasseForm)) then
    TManagerPageControlCloseButton.CriarAba(ClasseForm, PageControlCloseButton, Index);
end;

procedure TFrmPrincipal.FormCreate(Sender: TObject);
begin
  TManagerPageControlCloseButton.AssignEvents(PageControlCloseButton);
  TManagerPageControlCloseButton.CreateCloseButtonInNewTab(PageControlCloseButton);
end;

procedure TFrmPrincipal.Ajuda1Click(Sender: TObject);
begin
  CriarAba(TFrmAjuda, 0);
end;

procedure TFrmPrincipal.Arquivo1Click(Sender: TObject);
begin
  CriarAba(TFrmArquivo, 0);
end;

procedure TFrmPrincipal.Localizar1Click(Sender: TObject);
begin
  CriarAba(TFrmLocalizar, 0);
end;

procedure TFrmPrincipal.Editar1Click(Sender: TObject);
begin
  CriarAba(TFrmEditar, 0);
end;

end.
