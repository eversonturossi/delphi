unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Clipbrd, ComCtrls, ExtCtrls;

type
  TForm2 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Memo1: TMemo;
    Image1: TImage;
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

{ Fontes
  http://www.devmedia.com.br/identificando-mudancas-no-clipboard-delphi/24036
  http://delphi.about.com/od/vclusing/a/tclipboard.htm
  }
procedure TForm2.ClipBoardChanged(var Message: TMessage);
begin { uses Clipbrd }
  // CF_TEXT - Text with each line ending with a CR-LF combination.
  // CF_BITMAP - A Windows bitmap graphic.
  // CF_METAFILEPICT - A Windows metafile graphic.
  // CF_PICTURE - An object of type TPicture.
  // CF_OBJECT - Any persistent object.
  if Clipboard.HasFormat(CF_TEXT) then
  begin
    Memo1.Lines.Clear;
    Memo1.Lines.Add(Clipboard.AsText);
    Self.Caption := FormatDateTime('hh:nn:ss', Now);
  end;
  if Clipboard.HasFormat(CF_BITMAP) then
  begin
    Image1.Picture.Bitmap.Assign(Clipboard);
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  Memo1.Lines.Clear;
  SetClipboardViewer(Handle);
end;

end.
