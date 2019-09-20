unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.WinXCalendars;

type
  TForm7 = class(TForm)
    CalendarView1: TCalendarView;
    procedure CalendarView1DrawDayItem(Sender: TObject; DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
    procedure FormCreate(Sender: TObject);
    procedure CalendarView1Click(Sender: TObject);
  private
    FData: TDate;
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  DateUtils;

{$R *.dfm}

procedure TForm7.CalendarView1Click(Sender: TObject);
begin
  FData := CalendarView1.Date;
end;

procedure TForm7.CalendarView1DrawDayItem(Sender: TObject; DrawParams: TDrawViewInfoParams; CalendarViewViewInfo: TCellItemViewInfo);
begin
  if (DayOfWeek(CalendarViewViewInfo.Date) = 1) then
  begin
    DrawParams.BkColor := clRed;
    DrawParams.ForegroundColor := clWhite;
  end;

  if (DayOfWeek(CalendarViewViewInfo.Date) = 7) then
  begin
    DrawParams.BkColor := clRed;
    DrawParams.ForegroundColor := clWhite;
  end;

  if (MonthOf(CalendarViewViewInfo.Date) <> MonthOf(FData)) then
  begin
    DrawParams.BkColor := clSilver;
    DrawParams.ForegroundColor := clWhite;
  end;

end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  FData := Date;
end;

end.
