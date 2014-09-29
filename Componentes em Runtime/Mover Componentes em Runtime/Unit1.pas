unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ListBox1: TListBox;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    procedure AppMessage(var Msg: TMsg; var Handled: Boolean);
  public
    { Public declarations }
  end;

const
  SC_SIZE = $F012;

var
  Form1: TForm1;

implementation

uses WinProcs, Registry;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  iTemp: Integer;
  r: TRegIniFile;
begin
  (* Open the key in the registry where we store
    all the positions *)
  r := TRegIniFile.Create('Resize Test');

  (* Loop through all the components on a form *)
  for iTemp := 0 to ComponentCount - 1 do
    (* Get the position of all controls *)
    if Components[iTemp] is TControl then
      with Components[iTemp] as TControl do
      begin
        left := r.readinteger(Name, 'Left', left);
        top := r.readinteger(Name, 'Top', top);
        (* Make there cursors crosses *)
        cursor := crCross;
      end;
  (* Release the registry object *)
  r.free;

  (* Use our own message handler for all message
    sent  to the application *)
  Application.OnMessage := AppMessage;
end;

procedure TForm1.FormDestroy(Sender: TObject);
var
  iTemp: Integer;
  r: TRegIniFile;
begin
  (* As in the form create loop through all the
    components But this time write the left and
    top properties to the registry *)

  r := TRegIniFile.Create('Resize Test');
  for iTemp := 0 to ComponentCount - 1 do
    if Components[iTemp] is TControl then
      with Components[iTemp] as TControl do
      begin
        r.writeinteger(Name, 'Left', left);
        r.writeinteger(Name, 'Top', top);
      end;
  r.free;
end;

procedure TForm1.AppMessage(var Msg: TMsg; var Handled: Boolean);
begin
  (* Only do anything if the left mouse button is
    pressed *)
  if Msg.message = wm_LBUTTONDOWN then
  begin
    (* Release the mouse capture *)
    WinProcs.ReleaseCapture;
    (* Send a message to the control under the
      mouse to go into move mode *)
    postmessage(Msg.hwnd, WM_SysCommand, SC_SIZE, 0);
    (* Say we have handled this message *)
    Handled := true;
  end;
end;

end.

{ Fone : http://www.delphi-central.com/movecontrun.aspx }
