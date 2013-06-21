unit uPermissoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList;

const
  ImageIndexNaoPermitido = 0;
  ImageIndexPermitido = 1;
  ImageIndexGrupo = 2;

type
  TTreeNodeExpandido = class(TTreeNode)
  private
    fCodigo: Integer;
  public
    property Codigo: Integer read fCodigo write fCodigo;
  end;

  TPermissoesEventos = class
    class procedure TreeViewDoubleClick(Sender: TObject);
    class procedure TreeViewCreateNodeClass(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
  end;

  TPermissoes = class(TObject)
  private
    fImages: TImageList;
    fNodoPaiAtual: TTreeNode;
    fTreeView: TTreeView;

    procedure setImages(const Value: TImageList);
    procedure setTreeView(const Value: TTreeView);

    property NodoPaiAtual: TTreeNode read fNodoPaiAtual write fNodoPaiAtual;
  public
    procedure AdicionarNodoPai(Nome: String; Codigo: Integer);
    procedure AdicionarNodoFilho(Nome: String; Codigo: Integer);
    procedure Expandir();
    function Localizar(Nome: String): TTreeNode;

    Constructor Create();
    Destructor Destroy; override;

    property TreeView: TTreeView read fTreeView write setTreeView;
    property Images: TImageList read fImages write setImages;
  end;

implementation

uses CommCtrl;

{ TPermissoes }

class procedure TPermissoesEventos.TreeViewCreateNodeClass(Sender: TCustomTreeView; var NodeClass: TTreeNodeClass);
begin
  NodeClass := TTreeNodeExpandido;
end;

class procedure TPermissoesEventos.TreeViewDoubleClick(Sender: TObject);
var
  NodeSelectionado: TTreeNode;
  P: TPoint;
begin
  GetCursorPos(P);
  P := TTreeView(Sender).ScreenToClient(P);
  if (htOnItem in TTreeView(Sender).GetHitTestInfoAt(P.X, P.Y)) then
  begin
    NodeSelectionado := TTreeView(Sender).Selected;
    if (NodeSelectionado.StateIndex <> ImageIndexGrupo) then
      if (NodeSelectionado.StateIndex = ImageIndexNaoPermitido) then
      begin
        NodeSelectionado.StateIndex := ImageIndexPermitido;
        NodeSelectionado.SelectedIndex := ImageIndexPermitido;
        NodeSelectionado.ImageIndex := ImageIndexPermitido;
      end
      else
      begin
        NodeSelectionado.StateIndex := ImageIndexNaoPermitido;
        NodeSelectionado.SelectedIndex := ImageIndexNaoPermitido;
        NodeSelectionado.ImageIndex := ImageIndexNaoPermitido;
      end;
  end;
end;

procedure TPermissoes.AdicionarNodoFilho(Nome: String; Codigo: Integer);
var
  NovoNode: TTreeNode;
begin
  NovoNode := TreeView.Items.AddChild(NodoPaiAtual, Nome);
  NovoNode.StateIndex := ImageIndexNaoPermitido;
  NovoNode.SelectedIndex := ImageIndexNaoPermitido;
  NovoNode.ImageIndex := ImageIndexNaoPermitido;
  TTreeNodeExpandido(NovoNode).Codigo := Codigo;
end;

procedure TPermissoes.AdicionarNodoPai(Nome: String; Codigo: Integer);
var
  NovoNode: TTreeNode;
  treeItem: TTVItem;
begin
  NovoNode := TreeView.Items.AddChild(nil, Nome);
  NovoNode.StateIndex := ImageIndexGrupo;
  NovoNode.SelectedIndex := ImageIndexGrupo;
  NovoNode.ImageIndex := ImageIndexGrupo;

  treeItem.hItem := NovoNode.ItemId;
  treeItem.stateMask := TVIS_BOLD;
  treeItem.mask := TVIF_HANDLE or TVIF_STATE;
  treeItem.state := TVIS_BOLD;
  TreeView_SetItem(NovoNode.Handle, treeItem);

  NodoPaiAtual := NovoNode;
end;

constructor TPermissoes.Create;
begin

end;

destructor TPermissoes.Destroy;
begin
  TreeView := nil;
  Images := nil;
  NodoPaiAtual := nil;
  inherited;
end;

procedure TPermissoes.Expandir();
begin
  TreeView.FullExpand;
end;

function TPermissoes.Localizar(Nome: String): TTreeNode;
var
  Node: TTreeNode;
begin
  Result := nil;
  if (TreeView.Items.Count = 0) then
    Exit;
  Node := TreeView.Items[0];
  while (Node <> nil) do
  begin
    if (AnsiUpperCase(Node.Text) = AnsiUpperCase(Nome)) then
    begin
      Result := Node;
      // if AVisible then
      // Result.MakeVisible;
      Break;
    end;
    Node := Node.GetNext;
  end;
end;

procedure TPermissoes.setImages(const Value: TImageList);
begin
  fImages := Value;
  if (TreeView <> nil) and (fImages <> nil) then
  begin
    TreeView.Images := fImages;
  end;
end;

procedure TPermissoes.setTreeView(const Value: TTreeView);
begin
  fTreeView := Value;
  if (fImages <> nil) and (fTreeView <> nil) then
    TreeView.Images := fImages;
  if (fTreeView <> nil) then
  begin
    TreeView.OnDblClick := TPermissoesEventos.TreeViewDoubleClick;
    TreeView.OnCreateNodeClass := TPermissoesEventos.TreeViewCreateNodeClass;
  end;
end;

end.
