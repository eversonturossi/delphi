unit UTestePermissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, uPermissoes;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    ImageList1: TImageList;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var
  I: integer;
  Permissoes: TPermissoes;
begin
  try
    Permissoes := TPermissoes.Create;
    Permissoes.TreeView := TreeView1;
    Permissoes.Images := ImageList1;
    Permissoes.AdicionarNodoPai('nodo pai 1', 0);
    Permissoes.AdicionarNodoPai('nodo pai 2', 0);
    Permissoes.AdicionarNodoPai('nodo pai 3', 0);
    Permissoes.AdicionarNodoFilho('nodo filho 4.2', 1);
    Permissoes.AdicionarNodoPai('nodo pai 4', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.1', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.2', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.3', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.4', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.5', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.6', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.7', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.8', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.9', 1);
    Permissoes.AdicionarNodoFilho('nodo filho 4.10', 1);

    Permissoes.AdicionarNodoPai('nodo pai 5', 0);
    Permissoes.Expandir();
  finally
    FreeAndNil(Permissoes);
  end;
end;

// procedure TForm1.TreeView1DblClick(Sender: TObject);
// var
// NodeSelectionado: TTreeNode;
// P: TPoint;
// begin
// GetCursorPos(P);
// P := TreeView1.ScreenToClient(P);
// if (htOnItem in TreeView1.GetHitTestInfoAt(P.X, P.Y)) then
// begin
// NodeSelectionado := TreeView1.Selected;
// if (NodeSelectionado.StateIndex = 0) then
// begin
// NodeSelectionado.StateIndex := 1;
// NodeSelectionado.SelectedIndex := 1;
// NodeSelectionado.ImageIndex := 1;
// end
// else
// begin
// NodeSelectionado.StateIndex := 0;
// NodeSelectionado.SelectedIndex := 0;
// NodeSelectionado.ImageIndex := 0;
// end;
// end;
// end;
end.
