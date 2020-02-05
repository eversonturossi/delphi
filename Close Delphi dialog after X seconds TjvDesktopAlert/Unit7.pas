unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  JvBaseDlg, JvDesktopAlert;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    procedure AddAlert(title, text: String; stack: TjvDesktopAlertStack);
    { Private declarations }
  public
    Function MSG(Título, Mensagem: string; Tempo_Mensagem: integer): string;
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
  MSG('P2', 'Esta mensagem vai destruir-se automaticamente', 10000);
end;

{ Fonte:  https://www.devmedia.com.br/forum/mensagem-em-dll-delphi/562302 }

function TForm7.MSG(Título, Mensagem: string; Tempo_Mensagem: integer): string;
var
  Comp: TjvDesktopAlert;
begin
  Comp := TjvDesktopAlert.Create(nil);
  Comp.HeaderText := Título;
  Comp.MessageText := Mensagem;
  Comp.StyleOptions.DisplayDuration := Tempo_Mensagem;
  Comp.AutoFree := True;
  Comp.Execute();
end;

procedure TForm7.AddAlert(title, text: String; stack: TjvDesktopAlertStack);
Begin
  with TjvDesktopAlert.Create(self) do
  Begin
    AutoFree := True;
    AlertStack := stack;
    HeaderText := title;
    MessageText := text;
    Execute(self.Handle);
  End;
End;

procedure TForm7.Button2Click(Sender: TObject);
var
  stack: TjvDesktopAlertStack;
begin
  stack := TjvDesktopAlertStack.Create(self);
  try
    AddAlert('title1', 'message1', stack);
    AddAlert('title2', 'message2', stack);
    AddAlert('title3', 'message3', stack);
    AddAlert('title4', 'message4', stack);
    AddAlert('title5', 'message5', stack);
  finally
    stack.Free;
  end;
end;

end.
