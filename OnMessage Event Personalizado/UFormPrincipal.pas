unit UFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uMyEvent, Menus, StdCtrls, uFormTeste1, uFormTeste2, uFormTeste3;

type
  TFormPrincipal = class(TForm)
    Memo1: TMemo;
    MainMenu1: TMainMenu;
    FormulariosAbertos1: TMenuItem;
    este11: TMenuItem;
    este21: TMenuItem;
    este31: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormulariosAbertos1Click(Sender: TObject);
    procedure este11Click(Sender: TObject);
    procedure este21Click(Sender: TObject);
    procedure este31Click(Sender: TObject);
  private
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.este11Click(Sender: TObject);
begin
  Application.CreateForm(TFormTeste1, FormTeste1);
  FormTeste1.Show;
end;

procedure TFormPrincipal.este21Click(Sender: TObject);
begin
  Application.CreateForm(TFormTeste2, FormTeste2);
  FormTeste2.Show;
end;

procedure TFormPrincipal.este31Click(Sender: TObject);
begin
  Application.CreateForm(TFormTeste3, FormTeste3);
  FormTeste3.Show;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  Application.OnMessage := AppMessage;
end;

procedure TFormPrincipal.FormulariosAbertos1Click(Sender: TObject);
var
  I: integer;
begin
  for I := 0 to (Screen.FormCount - 1) do
    if not(Screen.Forms[I] is TFormPrincipal) then
    begin
      Memo1.Lines.Add(Format('Formulario %D: %S', [I, TForm(Screen.Forms[I]).Name]));
    end;
end;

procedure TFormPrincipal.AppMessage(var Msg: TMsg; var Handled: Boolean);
var
  msgStr: String;
begin
  if Msg.hwnd = Application.Handle then
  begin
    if (Msg.message = WM_ABRINDO) or (Msg.message = WM_FECHANDO) or (Msg.message = WM_DESTRUINDO) then
    begin
      msgStr := PChar(Msg.lParam);
      case Msg.message of
        WM_ABRINDO: Memo1.Lines.Add('Abrindo: ' + msgStr);
        WM_FECHANDO: Memo1.Lines.Add('Fechando: ' + msgStr);
        WM_DESTRUINDO: Memo1.Lines.Add('Destruindo: ' + msgStr);
      end;
      Handled := True;
    end;
  end;
  { for all other messages, Handled remains False }
  { so that other message handlers can respond }

  { http://docs.embarcadero.com/products/rad_studio/delphiAndcpp2009/HelpUpdate2/EN/html/delphivclwin32/Forms_TApplication_OnMessage.html }
end;

end.
