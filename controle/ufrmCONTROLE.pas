unit ufrmCONTROLE;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Menus,
  ufrmCliente,
  ufrmLOGIN,
  ComCtrls, ToolWin, ImgList, ExtCtrls, jpeg;

type
  TfrPrincipal = class(TForm)
    StatusBar1: TStatusBar;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ImageList1: TImageList;
    Image1: TImage;
    MainMenu1: TMainMenu;
    a1: TMenuItem;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
  private
    procedure CreateChildForm(const childName: string);
    procedure FecharTodos;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frPrincipal: TfrPrincipal;
  // ----------------------

  frCliente: TfrCliente;

  frLOGIN: TfrLOGIN;

  // ----------------------
implementation

{$R *.DFM}

procedure TfrPrincipal.CreateChildForm(const childName: string);
var
  ExistenteForm: Boolean;
begin
  ExistenteForm := false;

  if childName = 'frCliente' then
  begin
    frCliente := TfrCliente.Create(Application);
    frCliente.Caption := childName;
    frCliente.Width := 630;
    frCliente.Height := 400;
  end;

  if childName = 'frLogin' then
  begin
    frLOGIN := TfrLOGIN.Create(Application);
    frLOGIN.Caption := childName;
    frLOGIN.Width := 480;
    frLOGIN.Height := 215;
  end;
end;

procedure TfrPrincipal.FecharTodos;
var
  i: integer;
begin
  for i := 0 to MdiChildCount - 1 do
    MDIChildren[i].Close;

end;

procedure TfrPrincipal.ToolButton1Click(Sender: TObject);
begin
  CreateChildForm('frCliente');
end;

procedure TfrPrincipal.ToolButton7Click(Sender: TObject);
begin
  if ToolButton1.Visible then
  begin
    ToolButton1.Visible := false;
    ToolButton2.Visible := false;
    ToolButton3.Visible := false;
    ToolButton4.Visible := false;
    ToolButton5.Visible := false;
    ToolButton6.Visible := false;
  end
  else
  begin
    ToolButton1.Visible := true;
    ToolButton2.Visible := true;
    ToolButton3.Visible := true;
    ToolButton4.Visible := true;
    ToolButton5.Visible := true;
    ToolButton6.Visible := true;
    CreateChildForm('frLogin');
  end;
end;

end.
