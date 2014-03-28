unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ACBrBarCode, AJBarcode, Spin, ComCtrls;

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
    ComboBoxTipo: TComboBox;
    Label2: TLabel;
    CheckBoxLegenda: TCheckBox;
    StatusBar1: TStatusBar;
    procedure ButtonGerarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    procedure ChangeCodBar(Sender: TObject);
    procedure Gerar;
    function getTipo(Index: Integer): TBarcodeType;
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
    ACBrBarCode1.Typ := getTipo(ComboBoxTipo.ItemIndex); // bcCodeEAN128A;
    try
      ACBrBarCode1.Ratio := SpinEditRatio.Value;
      ACBrBarCode1.Modul := SpinEditModul.Value;
      ACBrBarCode1.Text := Edit1.Text;
      ACBrBarCode1.ShowText := bcoNone;
      if (CheckBoxLegenda.Checked) then
      begin
        ACBrBarCode1.ShowText := bcoCode;
        ACBrBarCode1.ShowTextPosition := stpBottomCenter;
      end;
      ACBrBarCode1.BarCode.Height := SpinEditAltura.Value;
      bmp := Graphics.TBitmap.Create();
      bmp.Width := ACBrBarCode1.BarCode.Width;
      bmp.Height := ACBrBarCode1.BarCode.Height;
      ACBrBarCode1.DrawBarcode(bmp.Canvas);
      Image1.Width := bmp.Width;
      Image1.Height := bmp.Height;
      Image1.Picture.Bitmap := bmp;
      StatusBar1.Panels[0].Text := '';
    except
      on E: Exception do
        StatusBar1.Panels[0].Text := E.Message;
    end;
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
  ComboBoxTipo.OnChange := ChangeCodBar;
  SpinEditAltura.OnChange := ChangeCodBar;
  SpinEditRatio.OnChange := ChangeCodBar;
  SpinEditModul.OnChange := ChangeCodBar;
  ComboBoxTipo.ItemIndex := 20;
end;

function TForm1.getTipo(Index: Integer): TBarcodeType;
begin
  case Index of
    00: Result := bcCode_2_5_interleaved;
    01: Result := bcCode_2_5_industrial;
    02: Result := bcCode_2_5_matrix;
    03: Result := bcCode39;
    04: Result := bcCode39Extended;
    05: Result := bcCode128A;
    06: Result := bcCode128B;
    07: Result := bcCode128C;
    08: Result := bcCode93;
    09: Result := bcCode93Extended;
    10: Result := bcCodeMSI;
    11: Result := bcCodePostNet;
    12: Result := bcCodeCodabar;
    13: Result := bcCodeEAN8;
    14: Result := bcCodeEAN13;
    15: Result := bcCodeUPC_A;
    16: Result := bcCodeUPC_E0;
    17: Result := bcCodeUPC_E1;
    18: Result := bcCodeUPC_Supp2;
    19: Result := bcCodeUPC_Supp5;
    20: Result := bcCodeEAN128A;
    21: Result := bcCodeEAN128B;
    22: Result := bcCodeEAN128C;
  end;
end;

end.
