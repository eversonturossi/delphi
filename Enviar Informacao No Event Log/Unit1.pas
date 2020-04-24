unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
  public
    class procedure LogDebug(AMensagem: String);
  end;

function IsDebuggerPresent: LongBool; external kernel32 name 'IsDebuggerPresent';

var
  Form1: TForm1;

implementation

{$R *.dfm}
{ TForm1 }

{
  http://www.andreanolanusse.com/pt/enviando-informacoes-de-depuracao-para-o-event-log-do-delphi/
}

procedure TForm1.Button1Click(Sender: TObject);
begin
  LogDebug('teste teste teste');
end;

class procedure TForm1.LogDebug(AMensagem: String);
var
  LHora: String;
begin
  LHora := FormatDateTime('hh:mm:ss.zzz', now);
  if IsDebuggerPresent then
    OutputDebugString(PWideChar(LHora + '->' + AMensagem));
end;

end.
