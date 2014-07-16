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
  I, IInicial, IFinal: Integer;
begin
  DataInicial := EncodeDate(StrToInt(edtAnoInicial.Text), 01, 01);
  DataFinal := EncodeDate(StrToInt(edtAnoFinal.Text), 12, 31);
  StrList := TStringList.Create;

  for I := IInicial to IFinal do
  begin

  end;

  FreeAndNil(StrList);
end;

end.
