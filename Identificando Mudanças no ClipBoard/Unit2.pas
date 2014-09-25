unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Clipbrd;

type
  TForm2 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
    procedure ClipBoardChanged(var Message: TMessage); Message WM_DRAWCLIPBOARD;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

{ Fonte: http://www.devmedia.com.br/identificando-mudancas-no-clipboard-delphi/24036 }
procedure TForm2.ClipBoardChanged(var Message: TMessage);
begin { uses Clipbrd }
  Memo1.Lines.Clear;
  Memo1.Lines.Add(Clipboard.AsText);
  Self.Caption := FormatDateTime('hh:nn:ss', Now);
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  SetClipboardViewer(Handle);
end;

end.
