unit TFlatPanelUnit;

interface

{$I DFS.inc}

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, FlatUtilitys;

type
  TFlatPanel = class(TCustomPanel)
  private
    FTransparent: Boolean;
    FColorHighlight: TColor;
    FColorShadow: TColor;
    procedure SetColors(Index: Integer; Value: TColor);
    procedure CMEnabledChanged(var Message: TMessage); message CM_ENABLEDCHANGED;
    procedure CMTextChanged(var Message: TWmNoParams); message CM_TEXTCHANGED;
    procedure SetTransparent(const Value: Boolean);
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  published
    property Transparent: Boolean read FTransparent write SetTransparent default false;
    property Caption;
    property Font;
    property Color;
    property ParentColor;
    property Enabled;
    property Visible;
    property ColorHighLight: TColor index 0 read FColorHighlight write SetColors default $008396A0;
    property ColorShadow: TColor index 1 read FColorShadow write SetColors default $008396A0;
    property Align;
    property Alignment;
    property Cursor;
    property Hint;
    property ParentShowHint;
    property ShowHint;
    property PopupMenu;
    property TabOrder;
    property TabStop;
{$IFDEF DFS_DELPHI_4_UP}
    property AutoSize;
    property UseDockManager;
    property Anchors;
    property BiDiMode;
    property Constraints;
    property DragKind;
    property DragMode;
    property DragCursor;
    property ParentBiDiMode;
    property DockSite;
    property OnEndDock;
    property OnStartDock;
    property OnCanResize;
    property OnConstrainedResize;
    property OnDockDrop;
    property OnDockOver;
    property OnGetSiteInfo;
    property OnUnDock;
{$ENDIF}
{$IFDEF DFS_DELPHI_5_UP}
    property OnContextPopup;
{$ENDIF}
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnResize;
    property OnStartDrag;
  end;

implementation

constructor TFlatPanel.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  ParentFont := True;
  FColorHighlight := $008396A0;
  FColorShadow := $008396A0;
  ParentColor := True;
  ControlStyle := ControlStyle + [csAcceptsControls, csOpaque];
  SetBounds(0, 0, 185, 41);
end;

procedure TFlatPanel.SetColors(Index: Integer; Value: TColor);
begin
  case Index of
    0:
      FColorHighlight := Value;
    1:
      FColorShadow := Value;
  end;
  Invalidate;
end;

procedure TFlatPanel.Paint;
var
  memoryBitmap: TBitmap;
  textBounds: TRect;
  Format: UINT;
begin
  textBounds := ClientRect;
  Format := DT_SINGLELINE or DT_VCENTER;
  case Alignment of
    taLeftJustify:
      Format := Format or DT_LEFT;
    taCenter:
      Format := Format or DT_CENTER;
    taRightJustify:
      Format := Format or DT_RIGHT;
  end;

  memoryBitmap := TBitmap.Create; // create memory-bitmap to draw flicker-free
  try
    memoryBitmap.Height := ClientRect.Bottom;
    memoryBitmap.Width := ClientRect.Right;

    // Draw Background
    if FTransparent then
      DrawParentImage(Self, memoryBitmap.Canvas)
    else
    begin
      memoryBitmap.Canvas.Brush.Color := Self.Color;
      memoryBitmap.Canvas.FillRect(ClientRect);
    end;

    // Draw Border
    Frame3DBorder(memoryBitmap.Canvas, ClientRect, FColorHighlight, FColorShadow, 1);

    // Draw Text
    memoryBitmap.Canvas.Font := Self.Font;
    memoryBitmap.Canvas.Brush.Style := bsClear;
    if not Enabled then
    begin
      OffsetRect(textBounds, 1, 1);
      memoryBitmap.Canvas.Font.Color := clBtnHighlight;
      DrawText(memoryBitmap.Canvas.Handle, PChar(Caption), Length(Caption), textBounds, Format);
      OffsetRect(textBounds, -1, -1);
      memoryBitmap.Canvas.Font.Color := clBtnShadow;
      DrawText(memoryBitmap.Canvas.Handle, PChar(Caption), Length(Caption), textBounds, Format);
    end
    else
      DrawText(memoryBitmap.Canvas.Handle, PChar(Caption), Length(Caption), textBounds, Format);

    // Copy memoryBitmap to screen
    Canvas.CopyRect(ClientRect, memoryBitmap.Canvas, ClientRect);
  finally
    memoryBitmap.free; // delete the bitmap
  end;
end;

procedure TFlatPanel.CMEnabledChanged(var Message: TMessage);
begin
  inherited;
  Invalidate;
end;

procedure TFlatPanel.CMTextChanged(var Message: TWmNoParams);
begin
  inherited;
  Invalidate;
end;

procedure TFlatPanel.SetTransparent(const Value: Boolean);
begin
  FTransparent := Value;
  Invalidate;
end;

end.
