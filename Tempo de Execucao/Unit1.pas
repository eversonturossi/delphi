unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm1 = class(TForm)
    ButtonVariaveis: TButton;
    ButtonStopWatch: TButton;
    ButtonTimeSpan: TButton;
    ListBoxLog: TListBox;
    procedure ButtonStopWatchClick(Sender: TObject);
    procedure ButtonTimeSpanClick(Sender: TObject);
    procedure ButtonVariaveisClick(Sender: TObject);
  private
    procedure Aguardar;
  public
    procedure UsaStopWatch;
    procedure UsaTimeSpan;
    procedure UsaVariaveis;
  end;

var
  Form1: TForm1;

implementation

uses
  System.Math,
  System.Diagnostics,
  System.TimeSpan;

{$R *.dfm}
{ TForm1 }

{
  https://medium.com/@viniciuss.sanchez/diagnostico-de-performance-usando-tstopwatch-e-ttimespan-ed13c21311af
}

procedure TForm1.Aguardar;
begin
  Sleep(RandomRange(50, 500));
end;

procedure TForm1.ButtonVariaveisClick(Sender: TObject);
begin
  UsaVariaveis;
end;

procedure TForm1.ButtonStopWatchClick(Sender: TObject);
begin
  UsaStopWatch;
end;

procedure TForm1.ButtonTimeSpanClick(Sender: TObject);
begin
  UsaTimeSpan;
end;

procedure TForm1.UsaStopWatch;
var
  LStopWatch: TStopWatch;
begin
  LStopWatch := TStopWatch.StartNew;

  Aguardar;

  LStopWatch.Stop;
  ListBoxLog.Items.Add('StopWatch: ' + LStopWatch.ElapsedMilliseconds.ToString);
end;

procedure TForm1.UsaTimeSpan;
var
  LStopWatch: TStopWatch;
  LTempoGasto: TTimeSpan;
begin
  LStopWatch := TStopWatch.StartNew;

  Aguardar;

  LStopWatch.Stop;
  LTempoGasto := LStopWatch.Elapsed;
  ListBoxLog.Items.Add('TimeSpan: ' + LTempoGasto.Milliseconds.ToString);
end;

procedure TForm1.UsaVariaveis;
var
  LInicio, LTermino, LDiferenca: TDateTime;
begin
  LInicio := Now;

  Aguardar;

  LTermino := Now;
  ListBoxLog.Items.Add('Variaveis: ' + TimeToStr(LTermino - LInicio));
end;

end.
