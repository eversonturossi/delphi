unit Unit7;

{
  Fonte:https://stackoverflow.com/questions/4472215/close-delphi-dialog-after-x-seconds
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    AMsgDialog: TForm;
    lbl: TLabel;
    counter: integer;
    procedure MyOnTimer(Sender: TObject);
  public
    { Public declarations }
  end;

function MessageBoxTimeOut(hWnd: hWnd; lpText: PChar; lpCaption: PChar; uType: UINT; wLanguageId: WORD; dwMilliseconds: DWORD): integer; stdcall; external user32 name 'MessageBoxTimeoutA';

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure CloseMessageBox(AWnd: hWnd; AMsg: UINT; AIDEvent: UINT_PTR; ATicks: DWORD); stdcall;
var
  Wnd: hWnd;
begin
  KillTimer(AWnd, AIDEvent);
  // active window of the calling thread should be the message box
  Wnd := GetActiveWindow;
  if IsWindow(Wnd) then
    PostMessage(Wnd, WM_CLOSE, 0, 0);
end;

procedure TForm7.Button1Click(Sender: TObject);
var
  TimerId: UINT_PTR;
begin
  TimerId := SetTimer(0, 0, 10 * 1000, @CloseMessageBox);
  Application.MessageBox('Will auto-close after 10 seconds...', nil);
  // prevent timer callback if user already closed the message box
  KillTimer(0, TimerId);
end;

{ --------------------------------------------------------------------------------------------------------------------------------------- }

procedure TForm7.Button2Click(Sender: TObject);
var
  iFlags: integer;
begin
  iFlags := MB_OK or MB_SETFOREGROUND or MB_SYSTEMMODAL or MB_ICONINFORMATION;
  MessageBoxTimeOut(Handle, 'Esta mensagem será fechada em 5 segundos!', 'Fechando', iFlags, 0, 5000);
end;

{ --------------------------------------------------------------------------------------------------------------------------------------- }

procedure DialogBoxAutoClose(const ACaption, APrompt: string; DuracaoEmSegundos: integer);
var
  Form: TForm;
  Prompt: TLabel;
  DialogUnits: TPoint;
  ButtonTop, ButtonWidth, ButtonHeight: integer;
  nX, Lines: integer;

  function GetAveCharSize(Canvas: TCanvas): TPoint;
  var
    I: integer;
    Buffer: array [0 .. 51] of Char;
  begin
    for I := 0 to 25 do
      Buffer[I] := Chr(I + Ord('A'));
    for I := 0 to 25 do
      Buffer[I + 26] := Chr(I + Ord('a'));
    GetTextExtentPoint(Canvas.Handle, Buffer, 52, TSize(Result));
    Result.X := Result.X div 52;
  end;

begin
  Form := TForm.Create(Application);
  Lines := 0;

  For nX := 1 to Length(APrompt) do
    if APrompt[nX] = #13 then
      Inc(Lines);

  with Form do
    try
      Font.Name := 'Arial'; // mcg
      Font.Size := 10; // mcg
      Font.Style := [fsBold];
      Canvas.Font := Font;
      DialogUnits := GetAveCharSize(Canvas);
      // BorderStyle    := bsDialog;
      BorderStyle := bsToolWindow;
      FormStyle := fsStayOnTop;
      BorderIcons := [];
      Caption := ACaption;
      ClientWidth := MulDiv(Screen.Width div 4, DialogUnits.X, 4);
      ClientHeight := MulDiv(23 + (Lines * 10), DialogUnits.Y, 8);
      Position := poScreenCenter;

      Prompt := TLabel.Create(Form);
      with Prompt do
      begin
        Parent := Form;
        AutoSize := True;
        Left := MulDiv(8, DialogUnits.X, 4);
        Top := MulDiv(8, DialogUnits.Y, 8);
        Caption := APrompt;
      end;

      Form.Width := Prompt.Width + Prompt.Left + 50; // mcg fix

      Show;
      Application.ProcessMessages;
    finally
      Sleep(DuracaoEmSegundos * 1000);
      Form.Free;
    end;
end;

procedure TForm7.Button3Click(Sender: TObject);
begin
  DialogBoxAutoClose('teste de mensagem', 'durar 10 segundos', 10);
end;

{ --------------------------------------------------------------------------------------------------------------------------------------- }

procedure TForm7.MyOnTimer(Sender: TObject);
begin
  Inc(counter);
  lbl.Caption := 'Counting: ' + IntToStr(counter);
  if (counter >= 5) then
  begin
    AMsgDialog.Close;
  end;
end;

procedure TForm7.Button4Click(Sender: TObject);
var
  tim: TTimer;
begin
  // create the message
  AMsgDialog := CreateMessageDialog('This is a test message.', mtWarning, [mbYes, mbNo]);
  lbl := TLabel.Create(AMsgDialog);
  tim := TTimer.Create(AMsgDialog);
  counter := 0;

  // Define and adding components
  with AMsgDialog do
    try
      Caption := 'Dialog Title';
      Height := 169;

      // Label
      lbl.Parent := AMsgDialog;
      lbl.Caption := 'Counting...';
      lbl.Top := 121;
      lbl.Left := 8;

      // Timer
      tim.Interval := 1000;
      tim.OnTimer := MyOnTimer;
      tim.Enabled := True;

      // result of Dialog
      if (ShowModal = ID_YES) then
      begin
        Button1.Caption := 'Press YES';
      end
      else
      begin
        Button1.Caption := 'Press NO';
      end;
    finally
      Free;
    end;
end;

end.
