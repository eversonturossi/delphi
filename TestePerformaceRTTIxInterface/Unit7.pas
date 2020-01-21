unit Unit7;

{ Fonte: http://edgarpavao.com/2017/09/07/como-e-a-performance-da-rtti/ }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  ITeste = interface
    ['{489180E6-C8AD-4248-9CCD-86B96FCA4CB9}']
    procedure Setup;
  end;

type
  TTeste = class(TInterfacedObject, ITeste)
  private
    FValor: Integer;
  public
    procedure Setup;
  end;

type
  TForm7 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
    procedure ExecutarPelaInterface(AClass: TClass);
    procedure ExecutarPelaRTTI(AClass: TClass);
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  System.Diagnostics, System.TimeSpan, System.Rtti;

{$R *.dfm}
{ TTeste }

procedure TTeste.Setup;
begin
  FValor := 1;
end;

procedure TForm7.Button1Click(Sender: TObject);
var
  StopWatch: TStopWatch;
  Resultado: TTimeSpan;
  I: Integer;
begin
  StopWatch := TStopWatch.Create;
  StopWatch.Start;
  try
    for I := 0 to StrToInt(Edit1.Text) do
    begin
      ExecutarPelaInterface(TTeste);
    end;
  finally
    StopWatch.Stop
  end;

  Resultado := StopWatch.Elapsed;

  ShowMessage(FloatToStr(Resultado.Seconds) + ' segundos');
end;

procedure TForm7.Button2Click(Sender: TObject);
var
  StopWatch: TStopWatch;
  Resultado: TTimeSpan;
  I: Integer;
begin
  StopWatch := TStopWatch.Create;
  StopWatch.Start;
  try
    for I := 0 to StrToInt(Edit1.Text) do
    begin
      ExecutarPelaRTTI(TTeste);
    end;
  finally
    StopWatch.Stop
  end;

  Resultado := StopWatch.Elapsed;

  ShowMessage(FloatToStr(Resultado.Seconds) + ' segundos');
end;

procedure TForm7.ExecutarPelaInterface(AClass: TClass);
var
  Aux: TObject;
begin
  Aux := AClass.Create;
  (Aux as TInterfacedObject as ITeste).Setup;
end;

procedure TForm7.ExecutarPelaRTTI(AClass: TClass);
var
  Contexto: TRttiContext;
  Tipo: TRttiType;
  Metodo: TRttiMethod;
  Aux: TObject;
begin
  Contexto := TRttiContext.Create;
  Tipo := Contexto.GetType(AClass);
  for Metodo in Tipo.GetDeclaredMethods do
  begin
    if LowerCase(Metodo.Name) = 'setup' then
    begin
      Aux := AClass.Create;
      Metodo.Invoke(Aux, []);
    end;
  end;
end;

end.
