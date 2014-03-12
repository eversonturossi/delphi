unit TFlatDesignRegister;

interface

{$I DFS.inc}

uses
  Classes, Controls, Graphics, Forms;

function RxIdentToColor(const Ident: string; var Color: Longint): Boolean;
function RxColorToString(Color: TColor): string;
function RxStringToColor(S: string): TColor;
procedure RxGetColorValues(Proc: TGetStrProc);

procedure Register;

implementation

uses
  {$IFDEF DFS_COMPILER_5_UP} Windows, {$ENDIF}
  FlatGraphics, SysUtils, DsgnIntf, Dialogs;

type
  TColorEntry = record
    Value: TColor;
    Name: PChar;
  end;

const
  clInfoBk16 = TColor($02E1FFFF);
  clNone16 = TColor($02FFFFFF);
  ColorCount = 18;
  Colors: array[0..ColorCount - 1] of TColorEntry = (
    (Value: ecDarkBlue;     Name: 'ecDarkBlue'),
    (Value: ecBlue;         Name: 'ecBlue'),
    (Value: ecLightBlue;    Name: 'ecLightBlue'),
    (Value: ecDarkRed;      Name: 'ecDarkRed'),
    (Value: ecRed;          Name: 'ecRed'),
    (Value: ecLightRed;     Name: 'ecLightRed'),
    (Value: ecDarkGreen;    Name: 'ecDarkGreen'),
    (Value: ecGreen;        Name: 'ecGreen'),
    (Value: ecLightGreen;   Name: 'ecLightGreen'),
    (Value: ecDarkYellow;   Name: 'ecDarkYellow'),
    (Value: ecYellow;       Name: 'ecYellow'),
    (Value: ecLightYellow;  Name: 'ecLightYellow'),
    (Value: ecDarkBrown;    Name: 'ecDarkBrown'),
    (Value: ecBrown;        Name: 'ecBrown'),
    (Value: ecLightBrown;   Name: 'ecLightBrown'),
    (Value: ecDarkKaki;     Name: 'ecDarkKaki'),
    (Value: ecKaki;         Name: 'ecKaki'),
    (Value: ecLightKaki;    Name: 'ecLightKaki')
  );

function RxColorToString(Color: TColor): string;
var
  I: Integer;
begin
  if not ColorToIdent(Color, Result) then begin
    for I := Low(Colors) to High(Colors) do
      if Colors[I].Value = Color then
      begin
        Result := StrPas(Colors[I].Name);
        Exit;
      end;
    FmtStr(Result, '$%.8x', [Color]);
  end;
end;

function RxIdentToColor(const Ident: string; var Color: Longint): Boolean;
var
  I: Integer;
  Text: array[0..63] of Char;
begin
  StrPLCopy(Text, Ident, SizeOf(Text) - 1);
  for I := Low(Colors) to High(Colors) do
    if StrIComp(Colors[I].Name, Text) = 0 then begin
      Color := Colors[I].Value;
      Result := True;
      Exit;
    end;
  Result := IdentToColor(Ident, Color);
end;

function RxStringToColor(S: string): TColor;
var
  I: Integer;
  Text: array[0..63] of Char;
begin
  StrPLCopy(Text, S, SizeOf(Text) - 1);
  for I := Low(Colors) to High(Colors) do
    if StrIComp(Colors[I].Name, Text) = 0 then
    begin
      Result := Colors[I].Value;
      Exit;
    end;
  Result := StringToColor(S);
end;

procedure RxGetColorValues(Proc: TGetStrProc);
var
  I: Integer;
begin
  GetColorValues(Proc);
  for I := Low(Colors) to High(Colors) do Proc(StrPas(Colors[I].Name));
end;

{ TRxColorProperty }

type
  TRxColorProperty = class(TColorProperty)
  public
    function GetValue: string; override;
    procedure GetValues (Proc: TGetStrProc); override;
    procedure SetValue (const Value: string); override;
{$IFDEF DFS_COMPILER_5_UP}
    procedure ListDrawValue(const Value: string; ACanvas: TCanvas;
      const ARect: TRect; ASelected: Boolean); override;
{$ENDIF}
  end;

function TRxColorProperty.GetValue: string;
var
  Color: TColor;
begin
  Color := TColor(GetOrdValue);
  if Color = clNone16 then Color := clNone
  else if Color = clInfoBk16 then Color := clInfoBk;
  Result := RxColorToString(Color);
end;

procedure TRxColorProperty.GetValues(Proc: TGetStrProc);
begin
  RxGetColorValues(Proc);
end;

procedure TRxColorProperty.SetValue(const Value: string);
begin
  SetOrdValue(RxStringToColor(Value));
end;

{$IFDEF DFS_COMPILER_5_UP}
procedure TRxColorProperty.ListDrawValue(const Value: string; ACanvas: TCanvas;
  const ARect: TRect; ASelected: Boolean);

  function ColorToBorderColor(AColor: TColor): TColor;
  type
    TColorQuad = record
      Red, Green, Blue, Alpha: Byte;
    end;
  begin
    if (TColorQuad(AColor).Red > 192) or (TColorQuad(AColor).Green > 192) or
       (TColorQuad(AColor).Blue > 192) then
      Result := clBlack
    else if ASelected then
      Result := clWhite
    else
      Result := AColor;
  end;

var
  vRight: Integer;
  vOldPenColor, vOldBrushColor: TColor;
begin
  vRight := (ARect.Bottom - ARect.Top) + ARect.Left;
  with ACanvas do
  try
    vOldPenColor := Pen.Color;
    vOldBrushColor := Brush.Color;
    Pen.Color := Brush.Color;
    Rectangle(ARect.Left, ARect.Top, vRight, ARect.Bottom);
    Brush.Color := RxStringToColor(Value);
    Pen.Color := ColorToBorderColor(ColorToRGB(Brush.Color));
    Rectangle(ARect.Left + 1, ARect.Top + 1, vRight - 1, ARect.Bottom - 1);
    Brush.Color := vOldBrushColor;
    Pen.Color := vOldPenColor;
  finally
    ACanvas.TextRect(Rect(vRight, ARect.Top, ARect.Right, ARect.Bottom),
      vRight + 1, ARect.Top + 1, Value);
  end;
end;
{$ENDIF}

procedure Register;
begin
  RegisterPropertyEditor(TypeInfo(TColor), TPersistent, '', TRxColorProperty);
end;

end.
