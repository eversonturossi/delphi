unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    EncodingComboBox: TComboBox;
    Memo1: TMemo;
    ListBox1: TListBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  sl: TStringList;
begin
  sl := TStringList.Create;
  try
    sl.Text := Memo1.Text;
    ListBox1.Items.Clear;
    ListBox1.Items.AddStrings(sl);
    if EncodingComboBox.Items[EncodingComboBox.ItemIndex] = 'ASCII' then
      sl.SaveToFile('temp.txt', TEncoding.ASCII)
    else
      if EncodingComboBox.Items[EncodingComboBox.ItemIndex] = 'UTF-8' then
        sl.SaveToFile('temp.txt', TEncoding.UTF8)
      else
        if EncodingComboBox.Items[EncodingComboBox.ItemIndex] = 'UTF-16 LE (Little-endian)' then
          sl.SaveToFile('temp.txt', TEncoding.Unicode)
        else
          if EncodingComboBox.Items[EncodingComboBox.ItemIndex] = 'UTF-16 BE (Big-endian)' then
            sl.SaveToFile('temp.txt', TEncoding.BigEndianUnicode);
  finally
    sl.Free;
  end;
end;

end.
