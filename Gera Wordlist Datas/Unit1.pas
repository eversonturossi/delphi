unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, DBCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    edtAnoInicial: TLabeledEdit;
    edtAnoFinal: TLabeledEdit;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses DateUtils;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  DataInicial, DataFinal: TDate;
  StrList: TStringList;
  I: Double;
begin
  DataInicial := StrToDate('01/01/0001'); // EncodeDate(StrToInt(edtAnoInicial.Text), 01, 01);
  DataFinal := StrToDate('31/12/2300'); // EncodeDate(StrToInt(edtAnoFinal.Text), 12, 31);
  StrList := TStringList.Create;
  I := DataInicial;
  while (I <= DataFinal) do
  begin
    StrList.Add(FormatDateTime('ddmmyyyy', I));
    StrList.Add(FormatDateTime('dd/mm/yyyy', I));
    StrList.Add(FormatDateTime('dd-mm-yyyy', I));
    StrList.Add(FormatDateTime('dd/mm/yy', I));
    StrList.Add(FormatDateTime('dd-mm-yy', I));
    StrList.Add(FormatDateTime('yyyymmdd', I));
    // StrList.Add(FormatDateTime('yyyy/mm/dd', I));
    // StrList.Add(FormatDateTime('yyyy-mm-dd', I));
    // StrList.Add(FormatDateTime('yy/mm/dd', I));
    // StrList.Add(FormatDateTime('yy-mm-dd', I));
    I := I + 1;
  end;
  StrList.SaveToFile('datas-ano01ate2300.txt');
  FreeAndNil(StrList);
end;

end.
