unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  {treaths}
  System.Threading, System.Diagnostics, System.SyncObjs;

const
  // Max = 5000000;
  Max = 50000000;

type
  TForm7 = class(TForm)
    Panel1: TPanel;
    Memo1: TMemo;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;
  Pool: TThreadPool;

implementation

{$R *.dfm}

function IsPrime(N: Integer): Boolean;
var
  Test, k: Integer;
begin
  if N <= 3 then
    IsPrime := N > 1
  else
    if ((N mod 2) = 0) or ((N mod 3) = 0) then
      IsPrime := False
    else
    begin
      IsPrime := True;
      k := Trunc(Sqrt(N));
      Test := 5;
      while Test <= k do
      begin
        if ((N mod Test) = 0) or ((N mod (Test + 2)) = 0) then
        begin
          IsPrime := False;
          break; { jump out of the for loop }
        end;
        Test := Test + 6;
      end;
    end;
end;

procedure TForm7.Button1Click(Sender: TObject);
var { Fonte: http://docwiki.embarcadero.com/RADStudio/Tokyo/en/Tutorial:_Using_the_For_Loop_from_the_Parallel_Programming_Library }
  Tot: Integer;
  SW: TStopwatch;
begin
  try
    // counts the prime numbers below a given value
    Tot := 0;
    SW := TStopwatch.Create;
    SW.Start;
    TParallel.For(2, 1, Max,
      procedure(I: Int64)
      begin
        if IsPrime(I) then
          TInterlocked.Increment(Tot);
      end);
    SW.Stop;
    Memo1.Lines.Add(Format('Parallel For loop. Time (in milliseconds): %d - Primes found: %d', [SW.ElapsedMilliseconds, Tot]));
  except
    on E: EAggregateException do
      ShowMessage(E.ToString);
  end;
end;

procedure TForm7.Button2Click(Sender: TObject);
var
  I, Tot: Integer;
  SW: TStopwatch;
begin
  // counts the prime numbers below a given value
  Tot := 0;
  SW := TStopwatch.Create;
  SW.Start;
  for I := 1 to Max do
  begin
    if IsPrime(I) then
      Inc(Tot);
  end;
  SW.Stop;
  Memo1.Lines.Add(Format('Sequential For loop. Time (in milliseconds): %d - Primes found: %d', [SW.ElapsedMilliseconds, Tot]));
end;

procedure TForm7.Button3Click(Sender: TObject);
var { https://delphiaball.co.uk/2014/09/23/parallel-programming-thread-pool/ }
  Tot, I: Integer;
  SW: TStopwatch;
begin

  I := TThreadPool.Default.MaxWorkerThreads;
  ShowMessage('Pool size = ' + I.ToString());

  // counts the prime numbers below a given value
  Tot := 0;
  SW := TStopwatch.Create;
  SW.Start;

  if Pool = nil then
  begin
    Pool := TThreadPool.Create;
    Pool.SetMaxWorkerThreads(10);
  end;

  TParallel.For(1, Max,
    procedure(I: Integer)
    begin
      if IsPrime(I) then
        TInterlocked.Increment(Tot);
    end, Pool);
  SW.Stop;
  Memo1.Lines.Add(Format('Parallel (Custom Pool) for loop: %d - %d', [SW.ElapsedMilliseconds, Tot]));
end;

end.
