unit FlatUtilitys;

interface

{$I DFS.inc}

uses Windows, Classes, Graphics, Buttons, Messages, Controls, HSLUtils;
{$IFNDEF DFS_COMPILER_4_UP}

const
  MSH_MOUSEWHEEL = 'MSWHEEL_ROLLMSG';
  WM_MOUSEWHEEL = $020A;
  WHEEL_DELTA = 120;
  WHEEL_PAGESCROLL = MAXDWORD;

  SM_MOUSEWHEELPRESENT = 75;
  SPI_GETWHEELSCROLLLINES = 104;
  SPI_SETWHEELSCROLLLINES = 105;

type
  TWMMouseWheel = record
    Msg: Cardinal;
    Keys: Word;
    Delta: Word;
    case Integer of
      0:
        (XPos: Smallint;
          YPos: Smallint);
      1:
        (Pos: TSmallPoint;
          Result: Longint);
  end;
{$ENDIF}

type
  TScrollType = (up, down);
  TColorCalcType = (lighten, darken);
  TCheckBoxLayout = (checkboxLeft, checkboxRight);
  TRadioButtonLayout = (radioLeft, radioRight);
{$IFNDEF DFS_DELPHI_4_UP}
  TProgressBarOrientation = (pbHorizontal, pbVertical);
{$ENDIF}
  TFlatTabPosition = (tpTop, tpBottom);
  TArrowPos = (NE, NW, SE, SW);
  TNumGlyphs = 1 .. 4;
  TAdvColors = 0 .. 100;
  TGroupBoxBorder = (brFull, brOnlyTopLine);
  TTransparentMode = (tmAlways, tmNotFocused, tmNone);

procedure Frame3DBorder(Canvas: TCanvas; Rect: TRect; TopColor, BottomColor: TColor; Width: Integer);
procedure DrawTransparentBmp(Cnv: TCanvas; x, y: Integer; Bmp: TBitmap; clTransparent: TColor);

procedure DrawParentImage(Control: TControl; Dest: TCanvas);

function CreateDisabledBitmap(FOriginal: TBitmap; OutlineColor, BackColor, HighlightColor, ShadowColor: TColor;
  DrawHighlight: Boolean): TBitmap;
function CalcAdvancedColor(ParentColor, OriginalColor: TColor; Percent: Byte; ColorType: TColorCalcType): TColor;
procedure CalcButtonLayout(Canvas: TCanvas; const Client: TRect; const Offset: TPoint; Layout: TButtonLayout;
  Spacing, Margin: Integer; FGlyph: TBitmap; FNumGlyphs: Integer; const Caption: string; var TextBounds: TRect;
  var GlyphPos: TPoint);
function Min(val1, val2: Word): Word;
function GetFontMetrics(Font: TFont): TTextMetric;
function GetFontHeight(Font: TFont): Integer;
function RectInRect(R1, R2: TRect): Boolean;

implementation

procedure Frame3DBorder(Canvas: TCanvas; Rect: TRect; TopColor, BottomColor: TColor; Width: Integer);

  procedure DoRect;
  var
    TopRight, BottomLeft: TPoint;
  begin
    with Canvas, Rect do
    begin
      TopRight.x := Right;
      TopRight.y := Top;
      BottomLeft.x := Left;
      BottomLeft.y := Bottom;
      Pen.Color := TopColor;
      PolyLine([BottomLeft, TopLeft, TopRight]);
      Pen.Color := BottomColor;
      Dec(BottomLeft.x);
      PolyLine([TopRight, BottomRight, BottomLeft]);
    end;
  end;

begin
  Canvas.Pen.Width := 1;
  Dec(Rect.Bottom);
  Dec(Rect.Right);
  while Width > 0 do
  begin
    Dec(Width);
    DoRect;
    InflateRect(Rect, -1, -1);
  end;
  Inc(Rect.Bottom);
  Inc(Rect.Right);
end;

procedure DrawTransparentBmp(Cnv: TCanvas; x, y: Integer; Bmp: TBitmap; clTransparent: TColor);
var
  bmpXOR, bmpAND, bmpINVAND, bmpTarget: TBitmap;
  oldcol: Longint;
begin
  bmpAND := TBitmap.Create;
  bmpINVAND := TBitmap.Create;
  bmpXOR := TBitmap.Create;
  bmpTarget := TBitmap.Create;
  try
    bmpAND.Width := Bmp.Width;
    bmpAND.Height := Bmp.Height;
    bmpAND.Monochrome := True;
    oldcol := SetBkColor(Bmp.Canvas.Handle, ColorToRGB(clTransparent));
    BitBlt(bmpAND.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    SetBkColor(Bmp.Canvas.Handle, oldcol);

    bmpINVAND.Width := Bmp.Width;
    bmpINVAND.Height := Bmp.Height;
    bmpINVAND.Monochrome := True;
    BitBlt(bmpINVAND.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, bmpAND.Canvas.Handle, 0, 0, NOTSRCCOPY);

    bmpXOR.Width := Bmp.Width;
    bmpXOR.Height := Bmp.Height;
    BitBlt(bmpXOR.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, Bmp.Canvas.Handle, 0, 0, SRCCOPY);
    BitBlt(bmpXOR.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, bmpINVAND.Canvas.Handle, 0, 0, SRCAND);

    bmpTarget.Width := Bmp.Width;
    bmpTarget.Height := Bmp.Height;
    BitBlt(bmpTarget.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, Cnv.Handle, x, y, SRCCOPY);
    BitBlt(bmpTarget.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, bmpAND.Canvas.Handle, 0, 0, SRCAND);
    BitBlt(bmpTarget.Canvas.Handle, 0, 0, Bmp.Width, Bmp.Height, bmpXOR.Canvas.Handle, 0, 0, SRCINVERT);

    BitBlt(Cnv.Handle, x, y, Bmp.Width, Bmp.Height, bmpTarget.Canvas.Handle, 0, 0, SRCCOPY);
  finally
    bmpXOR.Free;
    bmpAND.Free;
    bmpINVAND.Free;
    bmpTarget.Free;
  end;
end;

procedure DrawParentImage(Control: TControl; Dest: TCanvas);
var
  SaveIndex: Integer;
  DC: HDC;
  Position: TPoint;
begin
  with Control do
  begin
    if Parent = nil then
      Exit;
    DC := Dest.Handle;
    SaveIndex := SaveDC(DC);
{$IFDEF DFS_COMPILER_2}
    GetViewportOrgEx(DC, @Position);
{$ELSE}
    GetViewportOrgEx(DC, Position);
{$ENDIF}
    SetViewportOrgEx(DC, Position.x - Left, Position.y - Top, nil);
    IntersectClipRect(DC, 0, 0, Parent.ClientWidth, Parent.ClientHeight);
    Parent.Perform(WM_ERASEBKGND, DC, 0);
    Parent.Perform(WM_PAINT, DC, 0);
    RestoreDC(DC, SaveIndex);
  end;
end;

function CreateDisabledBitmap(FOriginal: TBitmap; OutlineColor, BackColor, HighlightColor, ShadowColor: TColor;
  DrawHighlight: Boolean): TBitmap;
const
  ROP_DSPDxax = $00E20746;
var
  MonoBmp: TBitmap;
  IRect: TRect;
begin
  IRect := Rect(0, 0, FOriginal.Width, FOriginal.Height);
  Result := TBitmap.Create;
  try
    Result.Width := FOriginal.Width;
    Result.Height := FOriginal.Height;
    MonoBmp := TBitmap.Create;
    try
      with MonoBmp do
      begin
        Width := FOriginal.Width;
        Height := FOriginal.Height;
        Canvas.CopyRect(IRect, FOriginal.Canvas, IRect);
{$IFDEF DFS_DELPHI_3_UP}
        HandleType := bmDDB;
{$ENDIF}
        Canvas.Brush.Color := OutlineColor;
        if Monochrome then
        begin
          Canvas.Font.Color := clWhite;
          Monochrome := False;
          Canvas.Brush.Color := clWhite;
        end;
        Monochrome := True;
      end;
      with Result.Canvas do
      begin
        Brush.Color := BackColor;
        FillRect(IRect);
        if DrawHighlight then
        begin
          Brush.Color := HighlightColor;
          SetTextColor(Handle, clBlack);
          SetBkColor(Handle, clWhite);
          BitBlt(Handle, 1, 1, IRect.Right - IRect.Left, IRect.Bottom - IRect.Top, MonoBmp.Canvas.Handle, 0, 0,
            ROP_DSPDxax);
        end;
        Brush.Color := ShadowColor;
        SetTextColor(Handle, clBlack);
        SetBkColor(Handle, clWhite);
        BitBlt(Handle, 0, 0, IRect.Right - IRect.Left, IRect.Bottom - IRect.Top, MonoBmp.Canvas.Handle, 0, 0,
          ROP_DSPDxax);
      end;
    finally
      MonoBmp.Free;
    end;
  except
    Result.Free;
    raise ;
  end;
end;

function CalcAdvancedColor(ParentColor, OriginalColor: TColor; Percent: Byte; ColorType: TColorCalcType): TColor;
var
  H, S, L: Integer;
begin
  if Percent <> 0 then
  begin
    RGBtoHSLRange(ColorToRGB(ParentColor), H, S, L);
    Inc(L, 10);
    if ColorType = lighten then
      if L + Percent > 100 then
        L := 100
      else
        Inc(L, Percent)
      else if L - Percent < 0 then
        L := 0
      else
        Dec(L, Percent);

    Result := HSLRangeToRGB(H, S, L);
  end
  else
    Result := OriginalColor;
end;

procedure CalcButtonLayout(Canvas: TCanvas; const Client: TRect; const Offset: TPoint; Layout: TButtonLayout;
  Spacing, Margin: Integer; FGlyph: TBitmap; FNumGlyphs: Integer; const Caption: string; var TextBounds: TRect;
  var GlyphPos: TPoint);
var
  TextPos: TPoint;
  ClientSize, GlyphSize, TextSize: TPoint;
  TotalSize: TPoint;
begin
  // calculate the item sizes
  ClientSize := Point(Client.Right - Client.Left, Client.Bottom - Client.Top);

  if FGlyph <> nil then
    GlyphSize := Point(FGlyph.Width div FNumGlyphs, FGlyph.Height)
  else
    GlyphSize := Point(0, 0);

  if Length(Caption) > 0 then
  begin
    TextBounds := Rect(0, 0, Client.Right - Client.Left, 0);
    DrawText(Canvas.Handle, PChar(Caption), Length(Caption), TextBounds, DT_CALCRECT or DT_SINGLELINE);
    TextSize := Point(TextBounds.Right - TextBounds.Left, TextBounds.Bottom - TextBounds.Top);
  end
  else
  begin
    TextBounds := Rect(0, 0, 0, 0);
    TextSize := Point(0, 0);
  end;

  // If the layout has the glyph on the right or the left, then both the
  // text and the glyph are centered vertically.  If the glyph is on the top
  // or the bottom, then both the text and the glyph are centered horizontally.
  if Layout in [blGlyphLeft, blGlyphRight] then
  begin
    GlyphPos.y := (ClientSize.y - GlyphSize.y + 1) div 2;
    TextPos.y := (ClientSize.y - TextSize.y + 1) div 2;
  end
  else
  begin
    GlyphPos.x := (ClientSize.x - GlyphSize.x + 1) div 2;
    TextPos.x := (ClientSize.x - TextSize.x + 1) div 2;
  end;

  // if there is no text or no bitmap, then Spacing is irrelevant
  if (TextSize.x = 0) or (GlyphSize.x = 0) then
    Spacing := 0;

  // adjust Margin and Spacing
  if Margin = -1 then
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(GlyphSize.x + TextSize.x, GlyphSize.y + TextSize.y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.x - TotalSize.x) div 3
      else
        Margin := (ClientSize.y - TotalSize.y) div 3;
      Spacing := Margin;
    end
    else
    begin
      TotalSize := Point(GlyphSize.x + Spacing + TextSize.x, GlyphSize.y + Spacing + TextSize.y);
      if Layout in [blGlyphLeft, blGlyphRight] then
        Margin := (ClientSize.x - TotalSize.x + 1) div 2
      else
        Margin := (ClientSize.y - TotalSize.y + 1) div 2;
    end;
  end
  else
  begin
    if Spacing = -1 then
    begin
      TotalSize := Point(ClientSize.x - (Margin + GlyphSize.x), ClientSize.y - (Margin + GlyphSize.y));
      if Layout in [blGlyphLeft, blGlyphRight] then
        Spacing := (TotalSize.x - TextSize.x) div 2
      else
        Spacing := (TotalSize.y - TextSize.y) div 2;
    end;
  end;

  case Layout of
    blGlyphLeft:
      begin
        GlyphPos.x := Margin;
        TextPos.x := GlyphPos.x + GlyphSize.x + Spacing;
      end;
    blGlyphRight:
      begin
        GlyphPos.x := ClientSize.x - Margin - GlyphSize.x;
        TextPos.x := GlyphPos.x - Spacing - TextSize.x;
      end;
    blGlyphTop:
      begin
        GlyphPos.y := Margin;
        TextPos.y := GlyphPos.y + GlyphSize.y + Spacing;
      end;
    blGlyphBottom:
      begin
        GlyphPos.y := ClientSize.y - Margin - GlyphSize.y;
        TextPos.y := GlyphPos.y - Spacing - TextSize.y;
      end;
  end;

  // fixup the result variables
  with GlyphPos do
  begin  {d2010: Client.Left é Integer;Offset.x é Integer  }
  {d2010: Offset - Types.TPoint (PPoint = ^TPoint;TPoint = record X: Longint;Y: Longint;end;)}
{$IF CompilerVersion <= 21}
    Inc(x, Client.Left + Offset.x);
    Inc(y, Client.Top + Offset.y);
{$IFEND}
{$IFDEF VER260}
    Inc(x, Client.Left + Offset.Dx);
    Inc(y, Client.Top + Offset.Dy);
{$ENDIF}
  end;
  OffsetRect(TextBounds, TextPos.x + Client.Left + Offset.x, TextPos.y + Client.Top + Offset.x);
end;

function Min(val1, val2: Word): Word;
begin
  Result := val1;
  if val1 > val2 then
    Result := val2;
end;

function GetFontMetrics(Font: TFont): TTextMetric;
var
  DC: HDC;
  SaveFont: HFont;
begin
  DC := GetDC(0);
  SaveFont := SelectObject(DC, Font.Handle);
  GetTextMetrics(DC, Result);
  SelectObject(DC, SaveFont);
  ReleaseDC(0, DC);
end;

function GetFontHeight(Font: TFont): Integer;
begin
  with GetFontMetrics(Font) do
    Result := Round(tmHeight + tmHeight / 8);
end;

function RectInRect(R1, R2: TRect): Boolean;
begin
  Result := IntersectRect(R1, R1, R2);
end;

end.
