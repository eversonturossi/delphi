unit uPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, ExtCtrls, ComCtrls, StdCtrls;

const
  StatusPanelProgreso = 0;
  StatusPanelLink = 1;

type
  THackControl = class(TControl);

  TForm2 = class(TForm)
    Panel1: TPanel;
    Browser: TWebBrowser;
    BarraStatusNavegador: TStatusBar;
    ButtonParar: TButton;
    ButtonIniciar: TButton;
    dtDataInicio: TDateTimePicker;
    dtDataFim: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    LabelDataTeste: TLabel;
    Label4: TLabel;
    EditUrl: TEdit;
    ProgressoNavegador: TProgressBar;
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure ButtonIniciarClick(Sender: TObject);
    procedure ButtonPararClick(Sender: TObject);
    procedure BrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
    procedure EditUrlClick(Sender: TObject);
    procedure EditUrlKeyPress(Sender: TObject; var Key: Char);
    procedure BrowserStatusTextChange(ASender: TObject; const Text: WideString);
    procedure BrowserProgressChange(ASender: TObject; Progress, ProgressMax: Integer);
  private
    fExecutando: Boolean;
    fHTML: TStringList;
    fDataAtual: TDate;
    procedure setExecutando(const Value: Boolean);

    procedure Navegar();
    procedure FixarBarraProgresso();
    procedure SetURL(URL: String);
    procedure ProcessarHTML(Navegador: TWebBrowser);
    procedure setDataAtual(const Value: TDate);
    procedure PreencherSubmeterFormulario(Navegador: TWebBrowser);
    property Executando: Boolean read fExecutando write setExecutando;
    property DataAtual: TDate read fDataAtual write setDataAtual;
  public

  end;

var
  Form2: TForm2;

implementation

uses
  CommCtrl,
  TLhelp32,
  MSHTML,
  StrUtils;

{$R *.dfm}

function FillForm(WebBrowser: TWebBrowser; FieldName: String; Value: String; Submit: Boolean = False): Boolean;
var
  iForm, iField: Integer;
  FormItem: Variant;
begin
  Result := False;
  if WebBrowser.OleObject.Document.all.tags('FORM').Length > 0 then
  begin
    for iForm := 0 to WebBrowser.OleObject.Document.Forms.Length - 1 do
    begin
      FormItem := WebBrowser.OleObject.Document.Forms.Item(iForm);
      for iField := 0 to FormItem.Length - 1 do
      begin
        try
          if FormItem.Item(iField).id = FieldName then
          begin
            FormItem.Item(iField).Value := Value;
            if (Submit) then
              FormItem.Submit;
            Result := True;
          end;
        except
          Exit;
        end;
      end;
    end;
  end;
end;

// procedure SubmitForm(WebBrowser: TWebBrowser; FieldName: String);
// var
// i: Word;
// Document: IHtmlDocument2;
// str: String;
// begin
// // Schleife über alle Bilder im Webbrowser
// for i := 0 to WebBrowser.OleObject.Document.Images.Length - 1 do
// begin
// Document := WebBrowser.Document as IHtmlDocument2;
// // URL auslesen
// str := (Document.Images.Item(i, 0) as IHTMLImgElement).ID;
// // Dateiname des Bildes überprüfen
// if Pos(FieldName, str) > 0 then
// begin
// ((Document.Images.Item(i, 0) as IHTMLImgElement) as IHTMLElement).Click;
// end;
// end;
// end;

procedure TForm2.BrowserProgressChange(ASender: TObject; Progress, ProgressMax: Integer);
begin
  if (Progress > 0) then
  begin
    ProgressoNavegador.Max := ProgressMax;
    ProgressoNavegador.Position := Progress;
  end
  else
    ProgressoNavegador.Position := 0;
end;

procedure TForm2.BrowserStatusTextChange(ASender: TObject; const Text: WideString);
begin
  if (LowerCase(Copy(Text, 1, 7)) = 'http://') or (LowerCase(Copy(Text, 1, 10)) = 'javascript') or (Trim(Text) = '') then
    BarraStatusNavegador.Panels[StatusPanelLink].Text := Text;
end;

procedure TForm2.ButtonIniciarClick(Sender: TObject);
begin
  Executando := True;
  DataAtual := dtDataInicio.Date;
  Navegar();
end;

procedure TForm2.ButtonPararClick(Sender: TObject);
begin
  Executando := False;
end;

procedure TForm2.EditUrlClick(Sender: TObject);
begin
  EditUrl.SelectAll;
end;

procedure TForm2.EditUrlKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key = #13) then
    Navegar();
end;

procedure TForm2.FixarBarraProgresso;
var
  PanelRect: TRect;
begin
  try
    THackControl(ProgressoNavegador).SetParent(BarraStatusNavegador); // Place progressbar on the statusbar
    SendMessage(BarraStatusNavegador.Handle, SB_GETRECT, StatusPanelProgreso, Integer(@PanelRect)); // Retreive the rectancle of the statuspanel (in my case the second)
    with PanelRect do // Position the progressbar over the panel on the statusbar
      ProgressoNavegador.SetBounds(Left, Top, Right - Left, Bottom - Top);
    ProgressoNavegador.Brush.Color := clBtnFace;
    SendMessage(ProgressoNavegador.Handle, PBM_SETBARCOLOR, 0, $00996633);
  except
  end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  fHTML := TStringList.Create;
  dtDataInicio.DateTime := StrToDate('01/01/1980');
  dtDataFim.DateTime := Now;
  Executando := False;

  // EditUrl.Text := 'http://www.google.com.br';
  Browser.Silent := True;
  FixarBarraProgresso();
end;

procedure TForm2.Navegar;
begin
  Browser.Navigate(EditUrl.Text);
end;

procedure TForm2.ProcessarHTML(Navegador: TWebBrowser);
const
  URL = 'forgot-password-verify-identity';
var
  Texto: String;
begin
  try
    // HTML := Browser.OleObject.Document.DocumentElement.InnerHTML;
    // Texto := Browser.OleObject.Document.DocumentElement.InnerHTML;

    if (Pos(URL, TWebBrowser(Navegador).OleObject.Document.URL) > 0) then
    begin
      PreencherSubmeterFormulario(Navegador);
    end;
  except
  end;
end;

procedure TForm2.setDataAtual(const Value: TDate);
begin
  fDataAtual := Value;
  LabelDataTeste.Caption := FormatDateTime('dd/mm/yyyy', fDataAtual);
end;

procedure TForm2.setExecutando(const Value: Boolean);
begin
  fExecutando := Value;
  dtDataInicio.Enabled := not(Value);
  dtDataFim.Enabled := not(Value);
  ButtonParar.Enabled := Value;
  ButtonIniciar.Enabled := not(Value);
end;

procedure TForm2.SetURL(URL: String);
begin
  if (URL <> 'about:blank') then
    EditUrl.Text := URL;
end;

procedure TForm2.BrowserDocumentComplete(ASender: TObject; const pDisp: IDispatch; const URL: OleVariant);
begin
  SetURL(TWebBrowser(ASender).OleObject.Document.URL);
  ProcessarHTML(TWebBrowser(ASender));
end;

procedure TForm2.PreencherSubmeterFormulario(Navegador: TWebBrowser);
var
  Dia, Mes, Ano: Word;
begin
  if (Executando) then
  begin
    DataAtual := DataAtual + 1;
    if (DataAtual < dtDataFim.Date) then
    begin
      DecodeDate(DataAtual, Ano, Mes, Dia);
      FillForm(Browser, 'monthDropDown', IntToStr(Mes));
      FillForm(Browser, 'dayDropDown', IntToStr(Dia));
      FillForm(Browser, 'yearDropDown', IntToStr(Ano), True);
      // SubmitForm(Browser, 'forgotPasswordContinueButton');
    end;
  end;
end;

end.
