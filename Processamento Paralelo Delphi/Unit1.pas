unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    ButtonSemThread: TButton;
    ButtonComThread: TButton;
    ButtonMuitasThreads: TButton;
    procedure ButtonSemThreadClick(Sender: TObject);
    procedure ButtonComThreadClick(Sender: TObject);
    procedure ButtonMuitasThreadsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses
  System.Threading;

{$R *.dfm}
{ http://www.andrecelestino.com/delphi-utilizando-o-mecanismo-de-processamento-paralelo/ }

procedure ConsultarDadosCliente;
begin
  Sleep(5000);
end;

procedure ConsultarDadosPedido;
begin
  Sleep(5000);
end;

procedure ConsultarDadosItensPedido;
begin
  Sleep(5000);
end;

procedure EmitirRelatorioSemThread;
var
  Inicio: TDateTime;
  Fim: TDateTime;
begin
  Inicio := Now;

  ConsultarDadosCliente;
  ConsultarDadosItensPedido;
  ConsultarDadosPedido;

  Fim := Now;

  ShowMessage(Format('Consultas realizadas em %s segundos.', [FormatDateTime('ss', Fim - Inicio)]));
end;

procedure EmitirRelatorioComThread;
var
  Tasks: array [0 .. 2] of ITask;

  Inicio: TDateTime;
  Fim: TDateTime;
begin
  Inicio := Now;

  Tasks[0] := TTask.Create(ConsultarDadosCliente);
  Tasks[0].Start;

  Tasks[1] := TTask.Create(ConsultarDadosPedido);
  Tasks[1].Start;

  Tasks[2] := TTask.Create(ConsultarDadosItensPedido);
  Tasks[2].Start;

  TTask.WaitForAll(Tasks);

  Fim := Now;

  ShowMessage(Format('Consultas realizadas em %s segundos.', [FormatDateTime('ss', Fim - Inicio)]));
end;

procedure EmitirRelatorioMuitasThread;
var
  Tasks: array [0 .. 29] of ITask;

  Inicio: TDateTime;
  Fim: TDateTime;
  I: Integer;
begin
  Inicio := Now;

  I := 0;
  while (I < length(Tasks)) do
  begin
    Tasks[I] := TTask.Create(ConsultarDadosCliente);
    Inc(I);

    Tasks[I] := TTask.Create(ConsultarDadosPedido);
    Inc(I);

    Tasks[I] := TTask.Create(ConsultarDadosItensPedido);
    Inc(I);
  end;

  for I := Low(Tasks) to High(Tasks) do
    Tasks[I].Start;

  TTask.WaitForAll(Tasks);

  Fim := Now;

  ShowMessage(Format('Consultas realizadas em %s segundos.', [FormatDateTime('ss', Fim - Inicio)]));
end;

procedure TForm1.ButtonSemThreadClick(Sender: TObject);
begin
  EmitirRelatorioSemThread;
end;

procedure TForm1.ButtonComThreadClick(Sender: TObject);
begin
  EmitirRelatorioComThread;
end;

procedure TForm1.ButtonMuitasThreadsClick(Sender: TObject);
begin
  EmitirRelatorioMuitasThread;
end;

end.
