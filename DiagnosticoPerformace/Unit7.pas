unit Unit7;

{ http://edgarpavao.com/2017/08/07/diagnostico-de-performance-com-tstopwatch-e-ttimespan/ }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    MedicaoTempoPorData: TButton;
    MedicaoStopWatch: TButton;
    MedicaoTickCount: TButton;
    procedure MedicaoTempoPorDataClick(Sender: TObject);
    procedure MedicaoTickCountClick(Sender: TObject);
    procedure MedicaoStopWatchClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  System.Diagnostics, System.TimeSpan;

{$R *.dfm}

procedure TForm7.MedicaoTempoPorDataClick(Sender: TObject);
var
  I: Integer;
  Aux: Integer;
  DataIni: TDateTime;
  DataFim: TDateTime;
begin
  DataIni := Now;
  try
    for I := 0 to 999999999 do
    begin
      Aux := Trunc(I / 2);
    end;
  finally
    DataFim := Now;
  end;

  ShowMessage(FloatToStr((DataFim - DataIni) * 24 * 60 * 60));
end;

procedure TForm7.MedicaoTickCountClick(Sender: TObject);
var
  I: Integer;
  Aux: Integer;
  TickIni: LongWord;
  TickFim: LongWord;
begin
  TickIni := GetTickCount;
  try
    for I := 0 to 999999999 do
    begin
      Aux := Trunc(I / 2);
    end;
  finally
    TickFim := GetTickCount;
  end;

  ShowMessage(FloatToStr((TickFim - TickIni) / 1000) + ' segundos');
end;

procedure TForm7.MedicaoStopWatchClick(Sender: TObject);
var
  StopWatch: TStopWatch;
  I: Integer;
  Aux: Integer;
  Resultado: TTimeSpan;
begin
  StopWatch := TStopWatch.Create;
  StopWatch.Start;
  try
    for I := 0 to 999999999 do
    begin
      Aux := Trunc(I / 2);
    end;
  finally
    StopWatch.Stop
  end;

  Resultado := StopWatch.Elapsed;

  ShowMessage(FloatToStr(Resultado.Seconds) + ' segundos');
  // ShowMessage(FloatToStr(StopWatch.Elapsed.Seconds) + ' segundos');
end;

end.
