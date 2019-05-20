unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls;

type
  TForm7 = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    PanelProdutos: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
  private
    FCont: Integer;
    procedure pintarheader;
    procedure pintarproduto;
  public
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.FormCreate(Sender: TObject);
begin
  FCont := 0;
end;

procedure TForm7.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if FCont = 0 then
    pintarheader;
  pintarproduto;
end;

procedure TForm7.pintarheader;
begin
  with TControlCanvas.Create do
  begin
    Control := PanelProdutos; // Componente irá ser pintado
    Font.Color := RGB(80, 80, 80); // Cor da fonte
    Font.Size := 11; // Tamanho da fonte
    Font.Name := 'Segoe UI Light'; // Tipo da fonte
    Font.Style := [fsBold]; // Estilo da fonte
    TextOut(10, FCont, 'Código'); // posição x e y, e valor a ser pintado.
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(80, 80, 80);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    TextOut(140, FCont, 'Descrição');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(80, 80, 80);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    TextOut(PanelProdutos.Width - 230, FCont, 'Qnt');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(80, 80, 80);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    TextOut(PanelProdutos.Width - 170, FCont, 'Vr.Unit');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(24, 127, 222);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    Font.Style := [fsBold];
    TextOut(PanelProdutos.Width - 100, FCont, 'Total');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Rectangle(10, FCont + 30, PanelProdutos.Width - 10, FCont + 31);
    Free;
  end;

  FCont := FCont + 40;
end;

procedure TForm7.pintarproduto;
begin

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(24, 127, 222);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    Font.Style := [fsBold];
    TextOut(10, FCont, '1234567890123');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(80, 80, 80);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    TextOut(140, FCont, 'Arroz Branco');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(80, 80, 80);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    TextOut(PanelProdutos.Width - 230, FCont, '1,000x');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(80, 80, 80);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    TextOut(PanelProdutos.Width - 170, FCont, 'R$ 13,00');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Font.Color := RGB(24, 127, 222);
    Font.Size := 11;
    Font.Name := 'Segoe UI Light';
    Font.Style := [fsBold];
    TextOut(PanelProdutos.Width - 100, FCont, 'R$ 13,00');
    Free;
  end;

  with TControlCanvas.Create do
  begin
    Control := PanelProdutos;
    Rectangle(10, FCont + 30, PanelProdutos.Width - 10, FCont + 31);
    Free;
  end;

  FCont := FCont + 40;
end;

end.
