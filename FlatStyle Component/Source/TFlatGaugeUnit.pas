unit TFlatGaugeUnit;

{ *************************************************************** }
{ TFlatGauge }
{ Copyright ©1999 Lloyd Kinsella. }
{ }
{ FlatStyle is Copyright ©1998-99 Maik Porkert. }
{ *************************************************************** }

interface

{$I DFS.inc}

uses
  WinProcs, WinTypes, SysUtils, Messages, Classes, Graphics, Controls,
  Forms, StdCtrls, ExtCtrls, Consts, FlatUtilitys;

type
  TFlatGauge = class(TGraphicControl)
  private
    FTransparent: Boolean;
    FUseAdvColors: Boolean;
    FAdvColorBorder: TAdvColors;
    FBarColor, FBorderColor: TColor;
    FMinValue, FMaxValue, FProgress: LongInt;
    FShowText: Boolean;
    procedure SetShowText(Value: Boolean);
    procedure SetMinValue(Value: LongInt);
    procedure SetMaxValue(Value: LongInt);
    procedure SetProgress(Value: LongInt);
    procedure SetColors(Index: Integer; Value: TColor);
    procedure SetAdvColors(Index: Integer; Value: TAdvColors);
    procedure SetUseAdvColors(Value: Boolean);
    procedure CMSysColorChange(var Message: TMessage); message CM_SYSCOLORCHANGE;
    procedure CMParentColorChanged(var Message: TWMNoParams); message CM_PARENTCOLORCHANGED;
    procedure SetTransparent(const Value: Boolean);
  protected
    procedure CalcAdvColors;
    procedure Paint; override;
{$IFDEF DFS_COMPILER_4_UP}
    procedure SetBiDiMode(Value: TBiDiMode); override;
{$ENDIF}
  public
    constructor Create(AOwner: TComponent); override;
  published
    property AdvColorBorder: TAdvColors index 0 read FAdvColorBorder write SetAdvColors default 50;
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property UseAdvColors: Boolean read FUseAdvColors write SetUseAdvColors default false;
    property Color default $00E0E9EF;
    property ColorBorder: TColor index 0 read FBorderColor write SetColors default $00555E66;
    property BarColor: TColor index 1 read FBarColor write SetColors default $00996633;
    property MinValue: LongInt read FMinValue write SetMinValue default 0;
    property MaxValue: LongInt read FMaxValue write SetMaxValue default 100;
    property Progress: LongInt read FProgress write SetProgress;
    property ShowText: Boolean read FShowText write SetShowText default True;
    property Align;
    property Enabled;
    property Font;
    property ParentColor;
    property ParentFont;
    property ParentShowHint;
    property ShowHint;
    property Visible;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
{$IFDEF DFS_COMPILER_4_UP}
    property Anchors;
    property BiDiMode write SetBiDiMode;
    property Constraints;
    property DragKind;
    property ParentBiDiMode;
    property OnEndDock;
    property OnStartDock;
{$ENDIF}
  end;

implementation

constructor TFlatGauge.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  Width := 145;
  Height := 25;
  MinValue := 0;
  MaxValue := 100;
  Progress := 25;
  ShowText := True;
  BarColor := $00996633;
  ColorBorder := $008396A0;
  ParentColor := True;
end;

procedure TFlatGauge.Paint;
var
  barRect, solvedRect: TRect;
  PercentText: String;
begin
  barRect := ClientRect;

  // Clear Background
  if not FTransparent then
  begin
    Canvas.Brush.Color := Color;
    Canvas.FillRect(barRect);
  end;

  // Draw Border
  Frame3DBorder(Canvas, ClientRect, FBorderColor, FBorderColor, 1);

  // Calculate the Rect
  InflateRect(barRect, -2, -2);
{$IFDEF DFS_COMPILER_4_UP}
  if BiDiMode = bdRightToLeft then
    solvedRect := Rect(barRect.right - Trunc((barRect.right - barRect.left) / (FMaxValue - FMinValue) * FProgress),
      barRect.top, barRect.right, barRect.bottom)
  else
    solvedRect := Rect(barRect.left, barRect.top,
      barRect.left + Trunc((barRect.right - barRect.left) / (FMaxValue - FMinValue) * FProgress), barRect.bottom);
{$ELSE}
  solvedRect := Rect(barRect.left, barRect.top,
    barRect.left + Trunc((barRect.right - barRect.left) / (FMaxValue - FMinValue) * FProgress), barRect.bottom);
{$ENDIF}
  // Fill the Rect
  Canvas.Brush.Color := FBarColor;
  Canvas.FillRect(solvedRect);

  // Draw Text
  if FShowText then
  begin
    PercentText := IntToStr(Trunc(((FProgress - FMinValue) / (FMaxValue - FMinValue)) * 100)) + ' %';
    Canvas.Font.Assign(Self.Font);
    Canvas.Brush.Style := bsClear;
    DrawText(Canvas.Handle, PChar(PercentText), Length(PercentText), barRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
    // bar is under caption
    IntersectClipRect(Canvas.Handle, solvedRect.left, solvedRect.top, solvedRect.right, solvedRect.bottom);
    Canvas.Font.Color := Color;
    DrawText(Canvas.Handle, PChar(PercentText), Length(PercentText), barRect, DT_CENTER or DT_VCENTER or DT_SINGLELINE);
  end;
end;

procedure TFlatGauge.SetShowText(Value: Boolean);
begin
  if FShowText <> Value then
  begin
    FShowText := Value;
    Repaint;
  end;
end;

procedure TFlatGauge.SetMinValue(Value: LongInt);
begin
  if Value <> FMinValue then
  begin
    if Value > FMaxValue then
      FMinValue := FMaxValue
    else
      FMinValue := Value;
    if FProgress < Value then
      FProgress := Value;
    Repaint;
  end;
end;

procedure TFlatGauge.SetMaxValue(Value: LongInt);
begin
  if Value <> FMaxValue then
  begin
    if Value < FMinValue then
      FMaxValue := FMinValue
    else
      FMaxValue := Value;
    if FProgress > Value then
      FProgress := Value;
    Repaint;
  end;
end;

procedure TFlatGauge.SetProgress(Value: LongInt);
begin
  if Value < FMinValue then
    Value := FMinValue
  else if Value > FMaxValue then
    Value := FMaxValue;
  if FProgress <> Value then
  begin
    FProgress := Value;
    Repaint;
  end;
end;

procedure TFlatGauge.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FBorderColor := Value;
    1:
      FBarColor := Value;
  end;
  Invalidate;
end;

procedure TFlatGauge.CalcAdvColors;
begin
  if FUseAdvColors then
  begin
    FBorderColor := CalcAdvancedColor(Color, FBorderColor, FAdvColorBorder, darken);
  end;
end;

procedure TFlatGauge.SetAdvColors(Index: Integer; Value: TAdvColors);
begin
  case Index of
    0:
      FAdvColorBorder := Value;
  end;
  CalcAdvColors;
  Invalidate;
end;

procedure TFlatGauge.SetUseAdvColors(Value: Boolean);
begin
  if Value <> FUseAdvColors then
  begin
    FUseAdvColors := Value;
    ParentColor := Value;
    CalcAdvColors;
    Invalidate;
  end;
end;

procedure TFlatGauge.CMSysColorChange(var Message: TMessage);
begin
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatGauge.CMParentColorChanged(var Message: TWMNoParams);
begin
  inherited;
  if FUseAdvColors then
  begin
    ParentColor := True;
    CalcAdvColors;
  end;
  Invalidate;
end;

procedure TFlatGauge.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;
  Invalidate;
end;
{$IFDEF DFS_COMPILER_4_UP}

procedure TFlatGauge.SetBiDiMode(Value: TBiDiMode);
begin
  inherited;
  Invalidate;
end;
{$ENDIF}

end.
