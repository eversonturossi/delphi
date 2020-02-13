unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm9 = class(TForm)
    ButtonAlteraTemp: TButton;
    ButtonAlteraPath: TButton;
    MemoPathOriginal: TMemo;
    MemoPathAlterado: TMemo;
    procedure ButtonAlteraTempClick(Sender: TObject);
    procedure ButtonAlteraPathClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

procedure TForm9.ButtonAlteraTempClick(Sender: TObject);
var
  LTempOriginal, LTempAlterado: string;
begin
  LTempOriginal := GetEnvironmentVariable(PCHar('Temp'));
  Showmessage(LTempOriginal);

  SetEnvironmentVariable(PCHar('Temp'), PCHar('C:\Better put back the old one'));
  LTempAlterado := GetEnvironmentVariable(PCHar('Temp'));
  Showmessage(LTempAlterado);

  // SetEnvironmentVariable(PCHar('Temp'), PCHar(LTempOriginal)) // reset old value
end;

procedure TForm9.ButtonAlteraPathClick(Sender: TObject);
var
  LPathOriginal, LPathAlterado: string;
begin
  MemoPathOriginal.Lines.Clear;
  MemoPathAlterado.Lines.Clear;

  LPathOriginal := GetEnvironmentVariable(PCHar('Path'));
  MemoPathOriginal.Lines.Add(LPathOriginal);

  SetEnvironmentVariable(PCHar('Path'), PCHar(LPathOriginal + ';C:\Better put back the old one'));
  LPathAlterado := GetEnvironmentVariable(PCHar('Path'));
  MemoPathAlterado.Lines.Add(LPathAlterado);
end;

end.
