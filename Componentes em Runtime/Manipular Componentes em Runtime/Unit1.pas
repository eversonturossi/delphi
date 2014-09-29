unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LinhaTop: TPanel;
    LinhaBotton: TPanel;
    LinhaLeft: TPanel;
    LinhaRigth: TPanel;
    Panel1: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    EditNome: TEdit;
    EditTop: TEdit;
    EditLeft: TEdit;
    EditHeight: TEdit;
    EditWidth: TEdit;
    Label8: TLabel;
    Button1: TButton;

    procedure FormCreate(Sender: TObject);
    procedure ClickDefault(Sender: TObject);
    procedure MouseDownDefault(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure MouseMoveDefault(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure MouseUpDefault(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
  private
    MouseDownSpot: TPoint;
    Capturing: BOOL;

    procedure AlinhamentoDefault(Sender: TObject);
    procedure CriarLinhaTop(ALeft, ATop, AWidth: Integer);
    procedure GetComponent(Sender: TObject);
    procedure SetComponent;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.GetComponent(Sender: TObject);
begin
  EditNome.Text := TGraphicControl(Sender).Name;
  EditTop.Text := IntToStr(TGraphicControl(Sender).top);
  EditLeft.Text := IntToStr(TGraphicControl(Sender).Left);
  EditHeight.Text := IntToStr(TGraphicControl(Sender).Height);
  EditWidth.Text := IntToStr(TGraphicControl(Sender).Width);
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  CriarLinhaTop(-1, -1, -1);
  for I := 0 to ComponentCount - 1 do
    if (Components[I].ClassType = TLabel) then
    begin
      TLabel(Components[I]).onMouseDown := MouseDownDefault;
      TLabel(Components[I]).OnMouseMove := MouseMoveDefault;
      TLabel(Components[I]).OnMouseUp := MouseUpDefault;
      TLabel(Components[I]).OnClick := ClickDefault;
    end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  SetComponent();
end;

procedure TForm1.SetComponent();
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if (AnsiUpperCase(Components[I].Name) = AnsiUpperCase(EditNome.Text)) then
    begin
      TGraphicControl(Components[I]).top := StrToIntDef(EditTop.Text, 0);
      TGraphicControl(Components[I]).Left := StrToIntDef(EditLeft.Text, 0);
      TGraphicControl(Components[I]).Height := StrToIntDef(EditHeight.Text, 0);
      TGraphicControl(Components[I]).Width := StrToIntDef(EditWidth.Text, 0);
      AlinhamentoDefault(Components[I]);
    end;
end;

procedure TForm1.ClickDefault(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to ComponentCount - 1 do
    if (Components[I].ClassType = TLabel) then
      TLabel(Components[I]).Font.Color := clBlack;
  TLabel(Sender).Font.Color := clRed;
  AlinhamentoDefault(Sender);
  GetComponent(Sender);
end;

procedure TForm1.MouseDownDefault(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  Capturing := True;
  MouseDownSpot.X := X;
  MouseDownSpot.Y := Y;
end;

procedure TForm1.MouseMoveDefault(Sender: TObject; Shift: TShiftState; X, Y: Integer);
begin
  if (Capturing) then
  begin
    TGraphicControl(Sender).Left := TGraphicControl(Sender).Left - (MouseDownSpot.X - X);
    TGraphicControl(Sender).top := TGraphicControl(Sender).top - (MouseDownSpot.Y - Y);
    AlinhamentoDefault(Sender);
  end;
end;

procedure TForm1.MouseUpDefault(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if (Capturing) then
  begin
    Capturing := False;
    TGraphicControl(Sender).Left := TGraphicControl(Sender).Left - (MouseDownSpot.X - X);
    TGraphicControl(Sender).top := TGraphicControl(Sender).top - (MouseDownSpot.Y - Y);
  end;
end;

procedure TForm1.CriarLinhaTop(ALeft, ATop, AWidth: Integer);
begin
  TGraphicControl(LinhaTop).Visible := False;
  TGraphicControl(LinhaBotton).Visible := False;
  TGraphicControl(LinhaLeft).Visible := False;
  TGraphicControl(LinhaRigth).Visible := False;
  if (ATop > 0) then
  begin
    TGraphicControl(LinhaTop).Visible := True;
    TGraphicControl(LinhaTop).Left := ALeft;
    TGraphicControl(LinhaTop).top := ATop;
    TGraphicControl(LinhaTop).Width := AWidth;
  end;
end;

procedure TForm1.AlinhamentoDefault(Sender: TObject);
var
  I: Integer;
begin
  CriarLinhaTop(-1, -1, -1);
  for I := 0 to ComponentCount - 1 do
  begin
    if (TGraphicControl(Sender).Name <> TGraphicControl(Components[I]).Name) then
      if (TGraphicControl(Sender).top = TGraphicControl(Components[I]).top) then
        CriarLinhaTop(TGraphicControl(Sender).Left, TGraphicControl(Sender).top, 100);
  end;
end;

end.
