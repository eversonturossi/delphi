unit UManagerPageControl;

interface

uses
  Windows,
  Messages,
  SysUtils,
  Variants,
  Classes,
  Graphics,
  Controls,
  Forms,
  Dialogs,
  Menus,
  ComCtrls,
  UxTheme,
  Themes,
  Math;

type
  ManagerPageControlCloseButton = class(TObject)
  private

  published
    class procedure AssignEvents(var PageControl: TPageControl);
    class procedure CreateCloseButtonInNewTab(var PageControl: TPageControl);

    class procedure EventDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
    class procedure EventMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    class procedure EventMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    class procedure EventMouseLeave(Sender: TObject);
    class procedure EventMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);

    class procedure CriarAba(clsForm: TFormClass; var PageControl: TPageControl; Index: Integer);
    class function ExisteAba(PageControl: TPageControl; NomeAba: String): Boolean;
    class procedure FecharAba(PageControl: TPageControl; NomeAba: String);
  end;

var
  FCloseButtonsRect: array of TRect;
  FCloseButtonMouseDownIndex: Integer;
  FCloseButtonShowPushed: Boolean;

implementation

{ http://stackoverflow.com/questions/2201850/how-to-implement-a-close-button-for-a-ttabsheet-of-a-tpagecontrol }
class procedure ManagerPageControlCloseButton.AssignEvents(var PageControl: TPageControl);
begin
  PageControl.OnDrawTab := ManagerPageControlCloseButton.EventDrawTab;
  PageControl.OnMouseDown := ManagerPageControlCloseButton.EventMouseDown;
  PageControl.OnMouseMove := ManagerPageControlCloseButton.EventMouseMove;
  PageControl.OnMouseLeave := ManagerPageControlCloseButton.EventMouseLeave;
  PageControl.OnMouseUp := ManagerPageControlCloseButton.EventMouseUp;

  PageControl.TabWidth := 150;
  PageControl.TabHeight := 20;
  PageControl.OwnerDraw := True;
end;

class procedure ManagerPageControlCloseButton.CreateCloseButtonInNewTab(var PageControl: TPageControl);
var
  I: Integer;
begin
  // should be done on every change of the page count
  SetLength(FCloseButtonsRect, PageControl.PageCount);
  FCloseButtonMouseDownIndex := -1;
  for I := 0 to Length(FCloseButtonsRect) - 1 do
    FCloseButtonsRect[I] := Rect(0, 0, 0, 0);
end;

class procedure ManagerPageControlCloseButton.EventDrawTab(Control: TCustomTabControl; TabIndex: Integer; const Rect: TRect; Active: Boolean);
var
  CloseBtnSize: Integer;
  PageControl: TPageControl;
  TabCaption: TPoint;
  CloseBtnRect: TRect;
  CloseBtnDrawState: Cardinal;
  CloseBtnDrawDetails: TThemedElementDetails;
begin
  PageControl := TPageControl(Control);

  if InRange(TabIndex, 0, Length(FCloseButtonsRect) - 1) then
  begin
    CloseBtnSize := 14;
    TabCaption.Y := Rect.Top + 3;

    if Active then
    begin
      CloseBtnRect.Top := Rect.Top + 4;
      CloseBtnRect.Right := Rect.Right - 5;
      TabCaption.X := Rect.Left + 6;
    end
    else
    begin
      CloseBtnRect.Top := Rect.Top + 3;
      CloseBtnRect.Right := Rect.Right - 5;
      TabCaption.X := Rect.Left + 3;
    end;

    CloseBtnRect.Bottom := CloseBtnRect.Top + CloseBtnSize;
    CloseBtnRect.Left := CloseBtnRect.Right - CloseBtnSize;
    FCloseButtonsRect[TabIndex] := CloseBtnRect;

    PageControl.Canvas.FillRect(Rect);
    PageControl.Canvas.TextOut(TabCaption.X, TabCaption.Y, PageControl.Pages[TabIndex].Caption);

    if not(UseThemes) then
    begin
      if (FCloseButtonMouseDownIndex = TabIndex) and FCloseButtonShowPushed then
        CloseBtnDrawState := DFCS_CAPTIONCLOSE + DFCS_PUSHED
      else
        CloseBtnDrawState := DFCS_CAPTIONCLOSE;

      Windows.DrawFrameControl(PageControl.Canvas.Handle, FCloseButtonsRect[TabIndex], DFC_CAPTION, CloseBtnDrawState);
    end
    else
    begin
      Dec(FCloseButtonsRect[TabIndex].Left);

      if (FCloseButtonMouseDownIndex = TabIndex) and FCloseButtonShowPushed then
        CloseBtnDrawDetails := ThemeServices.GetElementDetails(twCloseButtonPushed)
      else
        CloseBtnDrawDetails := ThemeServices.GetElementDetails(twCloseButtonNormal);

      ThemeServices.DrawElement(PageControl.Canvas.Handle, CloseBtnDrawDetails, FCloseButtonsRect[TabIndex]);
    end;
  end;
end;

class procedure ManagerPageControlCloseButton.EventMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  I: Integer;
  PageControl: TPageControl;
begin
  PageControl := TPageControl(Sender);

  if (Button = mbLeft) then
  begin
    for I := 0 to Length(FCloseButtonsRect) - 1 do
    begin
      if (PtInRect(FCloseButtonsRect[I], Point(X, Y))) then
      begin
        FCloseButtonMouseDownIndex := I;
        FCloseButtonShowPushed := True;
        PageControl.Repaint;
      end;
    end;
  end;
end;

class procedure ManagerPageControlCloseButton.EventMouseLeave(Sender: TObject);
var
  PageControl: TPageControl;
begin
  PageControl := TPageControl(Sender);
  FCloseButtonShowPushed := False;
  PageControl.Repaint;
end;

class procedure ManagerPageControlCloseButton.EventMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var
  PageControl: TPageControl;
  Inside: Boolean;
begin
  PageControl := TPageControl(Sender);

  if (ssLeft in Shift) and (FCloseButtonMouseDownIndex >= 0) then
  begin
    Inside := PtInRect(FCloseButtonsRect[FCloseButtonMouseDownIndex], Point(X, Y));

    if FCloseButtonShowPushed <> Inside then
    begin
      FCloseButtonShowPushed := Inside;
      PageControl.Repaint;
    end;
  end;
end;

class procedure ManagerPageControlCloseButton.EventMouseUp(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  PageControl: TPageControl;
  TabSheet: TTabSheet;
  I: Integer;
  Componente: TComponent;
begin
  PageControl := TPageControl(Sender);
  if (Button = mbLeft) and (FCloseButtonMouseDownIndex >= 0) then
  begin
    if (PtInRect(FCloseButtonsRect[FCloseButtonMouseDownIndex], Point(X, Y))) then
    begin
      // ShowMessage('Button ' + IntToStr(FCloseButtonMouseDownIndex + 1) + ' pressed!');
      // PageControl.Pages[PageControl.ActivePageIndex].Free;

      TabSheet := PageControl.Pages[PageControl.ActivePageIndex];
      for I := (TabSheet.ComponentCount - 1) downto 0 do
      begin
        Componente := TComponent(TabSheet.Components[I]);
        FreeAndNil(Componente);
      end;
      FreeAndNil(TabSheet);

      FCloseButtonMouseDownIndex := -1;
      PageControl.Repaint;
    end;
  end;
end;

class procedure ManagerPageControlCloseButton.CriarAba(clsForm: TFormClass; var PageControl: TPageControl; Index: Integer);
var
  { http: // www.lucianopimenta.com/post.aspx?id=171 }
  TabSheet: TTabSheet;
  Form: TForm;
begin

  TabSheet := TTabSheet.Create(PageControl);
  Form := clsForm.Create(TabSheet);

  TabSheet.PageControl := PageControl;
  TabSheet.Caption := Form.Caption;
  TabSheet.ImageIndex := Index;

  // Form.Align := alClient;
  Form.Position := poMainFormCenter;
  Form.BorderStyle := bsNone;
  Form.Parent := TabSheet;
  Form.Show;

  PageControl.ActivePage := TabSheet;

  ManagerPageControlCloseButton.CreateCloseButtonInNewTab(PageControl);
end;

class function ManagerPageControlCloseButton.ExisteAba(PageControl: TPageControl; NomeAba: String): Boolean;
var
  I: Integer;
  Aba: TTabSheet;
begin
  Result := False;
  for I := 0 to PageControl.PageCount - 1 do
  begin
    if PageControl.Pages[I].Caption = NomeAba then
    begin
      Aba := PageControl.Pages[I];
      PageControl.ActivePage := Aba;
      Result := True;
      Break;
    end;
  end;
end;

class procedure ManagerPageControlCloseButton.FecharAba(PageControl: TPageControl; NomeAba: String);
var
  I: Integer;
  Aba: TTabSheet;
begin
  for I := 0 to PageControl.PageCount - 1 do
  begin
    if (PageControl.Pages[I].Caption = NomeAba) then
    begin
      Aba := PageControl.Pages[I];
      Aba.Destroy;
      PageControl.ActivePageIndex := 0;
      Break;
    end;
  end;
end;

end.
