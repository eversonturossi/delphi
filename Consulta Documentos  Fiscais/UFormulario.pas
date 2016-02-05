unit UFormulario;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, OleCtrls, SHDocVw, ACBrMDFe, ACBrCTe,
  ACBrBase, ACBrDFe, ACBrNFe;

type
  TForm2 = class(TForm)
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    Button1: TButton;
    RadioGroup1: TRadioGroup;
    RadioGroup2: TRadioGroup;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    WebBrowser1: TWebBrowser;
    ACBrNFe1: TACBrNFe;
    ACBrCTe1: TACBrCTe;
    ACBrMDFe1: TACBrMDFe;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

end.
