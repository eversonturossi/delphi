unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls;

type
  TForm7 = class(TForm)
    Button1: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
  private
  public
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
var
  files: array of AnsiString;
  i, totalarquivos: Integer;
begin
  Button1.Enabled := False;
  try
    if OpenDialog1.Execute then
    begin
      totalarquivos := OpenDialog1.files.Count;
      SetLength(files, totalarquivos);
      for i := 0 to Pred(totalarquivos) do
      begin
        files[i] := AnsiString(OpenDialog1.files[i]);
      end;

      // JuntaPdfs('C:\Users\Top System\Desktop\Juntar PDF\test.pdf', files);
    end;
  finally
    Button1.Enabled := true;
  end;
end;

end.
