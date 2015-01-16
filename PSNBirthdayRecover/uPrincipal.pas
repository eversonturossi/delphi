unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls, ComCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    WebBrowser1: TWebBrowser;
    StatusBar1: TStatusBar;
    ButtonParar: TButton;
    ButtonIniciar: TButton;
    dtDataInicio: TDateTimePicker;
    dtDataFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelDataTeste: TLabel;
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
