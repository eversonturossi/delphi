unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, math, ExtCtrls;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    Button1: TButton;
    Edit2: TEdit;
    Button2: TButton;
    Timer1: TTimer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
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
  DataHora, DataHoraCalculada: Double;
begin
  DataHora := Now;
  Edit1.Text := FloatToStr(DataHora);

  DataHoraCalculada := SimpleRoundTo(DataHora, -5) * 100000;
  Edit2.Text := FloatToStr(DataHoraCalculada);
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  DataHora, datahoraatt: Double;
begin
  DataHora := StrToFloat(Edit1.Text);
  datahoraatt := StrToFloat(Edit2.Text) / 100000;
  ShowMessage(DateTimeToStr(DataHora) + #13 + DateTimeToStr(datahoraatt));
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  DataHora, DataHoraAproximada: Double;
begin
  DataHora := Now;
  DataHoraAproximada := SimpleRoundTo(DataHora, -5);

  Label3.Caption := DateTimeToStr(DataHora);
  Label4.Caption := DateTimeToStr(DataHoraAproximada);
end;

end.
