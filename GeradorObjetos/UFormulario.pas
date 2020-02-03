unit UFormulario;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls,
  UCampo,
  UCampoList;

type
  TFormulario = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    MemoOrigem: TMemo;
    MemoFonte: TMemo;
    ButtonGerar: TButton;
    LabeledEditNomeClasse: TLabeledEdit;
    procedure FormCreate(Sender: TObject);
    procedure ButtonGerarClick(Sender: TObject);
    procedure MemoFonteDblClick(Sender: TObject);
  private
  public
    procedure Gerar;
  end;

var
  Formulario: TFormulario;

implementation

{$R *.dfm}

uses UFonte, UOrigem;

procedure TFormulario.ButtonGerarClick(Sender: TObject);
begin
  Gerar;
end;

procedure TFormulario.FormCreate(Sender: TObject);
begin
  // MemoOrigem.Lines.Clear;
  // MemoFonte.Lines.Clear;
end;

procedure TFormulario.Gerar;
var
  LCampoList: TCampoList;
  LOrigem: TOrigem;
  LFonte: TFonte;
begin
  LCampoList := TCampoList.Create;
  LOrigem := TOrigem.Create(MemoOrigem.Lines, LCampoList);
  LFonte := TFonte.Create(LCampoList, LabeledEditNomeClasse.Text);
  try
    LOrigem.Processar;
    LFonte.Gerar;

    MemoOrigem.Lines.Clear;
    MemoOrigem.Lines.Add(LCampoList.Text);

    MemoFonte.Lines.Clear;
    MemoFonte.Lines.AddStrings(LFonte.GetFonte)
  finally
    FreeAndNil(LCampoList);
    FreeAndNil(LFonte);
    FreeAndNil(LOrigem);
  end;
end;

procedure TFormulario.MemoFonteDblClick(Sender: TObject);
begin
  MemoFonte.SelectAll;
  MemoFonte.CopyToClipboard;
end;

end.
