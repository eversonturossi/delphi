unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ACBrBarCode, AJBarcode, Spin;

type
  TForm1 = class(TForm)
    ButtonGerar: TButton;
    Image1: TImage;
    Edit1: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    SpinEditRatio: TSpinEdit;
    SpinEditModul: TSpinEdit;
    Label1: TLabel;
    SpinEditAltura: TSpinEdit;
    procedure ButtonGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ChangeCodBar(Sender: TObject);
    procedure Gerar;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Gerar();
var
  ACBrBarCode1: TACBrBarCode;
  bmp: Graphics.TBitmap;
begin
  try
    ACBrBarCode1 := TACBrBarCode.Create(nil);
    ACBrBarCode1.Typ := bcCodeEAN128A;
    ACBrBarCode1.Ratio := SpinEditRatio.Value;
    ACBrBarCode1.Modul := SpinEditModul.Value;
    ACBrBarCode1.Text := Edit1.Text;
    ACBrBarCode1.ShowText := bcoCode;
    ACBrBarCode1.ShowTextPosition := stpBottomCenter;
    // ACBrBarCode1.BarCode.Height := Trunc(ACBrBarCode1.BarCode.Width / 3);
    ACBrBarCode1.BarCode.Height := SpinEditAltura.Value;
    bmp := Graphics.TBitmap.Create();
    bmp.Width := ACBrBarCode1.BarCode.Width;
    bmp.Height := ACBrBarCode1.BarCode.Height;
    ACBrBarCode1.DrawBarcode(bmp.Canvas);
    Image1.Width := bmp.Width;
    Image1.Height := bmp.Height;
    Image1.Picture.Bitmap := bmp;
  finally
    FreeAndNil(ACBrBarCode1);
    FreeAndNil(bmp);
  end;
end;

procedure TForm1.ButtonGerarClick(Sender: TObject);
begin
  Gerar();
end;

procedure TForm1.ChangeCodBar(Sender: TObject);
begin
  Gerar();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  Edit1.OnChange := ChangeCodBar;
  SpinEditAltura.OnChange := ChangeCodBar;
  SpinEditRatio.OnChange := ChangeCodBar;
  SpinEditModul.OnChange := ChangeCodBar;
end;

end.
