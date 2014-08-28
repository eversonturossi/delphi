unit Unit1;

{

  TreeView with check boxes and radio buttons.

  http://delphi.about.com/library/weekly/aa092104a.htm

  Here's how to add check boxes and radio buttons to a
  TTreeView Delphi component. Give your applications a
  more professional and smoother look.

  ..............................................
  Zarko Gajic, BSCS
  About Guide to Delphi Programming
  http://delphi.about.com
  how to advertise: http://delphi.about.com/library/bladvertise.htm
  free newsletter: http://delphi.about.com/library/blnewsletter.htm
  forum: http://forums.about.com/ab-delphi/start/
  ..............................................

}

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ImgList, StdCtrls;

type
  TForm1 = class(TForm)
    TreeView1: TTreeView;
    ImageList1: TImageList;
    Button1: TButton;
    Memo1: TMemo;
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Collapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  // ImageList.StateIndex=0 has some bugs, so we add one dummy image to position 0
  cFlatUnCheck = 1;
  cFlatChecked = 2;
  cFlatRadioUnCheck = 3;
  cFlatRadioChecked = 4;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure ToggleTreeViewCheckBoxes(Node: TTreeNode; cUnChecked, cChecked, cRadioUnchecked, cRadioChecked: integer);
var
  tmp: TTreeNode;
begin
  if Assigned(Node) then
  begin
    if Node.StateIndex = cUnChecked then
      Node.StateIndex := cChecked
    else
      if Node.StateIndex = cChecked then
        Node.StateIndex := cUnChecked
      else
        if Node.StateIndex = cRadioUnchecked then
        begin
          tmp := Node.Parent;
          if not Assigned(tmp) then
            tmp := TTreeView(Node.TreeView).Items.getFirstNode
          else
            tmp := tmp.getFirstChild;
          while Assigned(tmp) do
          begin
            if (tmp.StateIndex in [cRadioUnchecked, cRadioChecked]) then
              tmp.StateIndex := cRadioUnchecked;
            tmp := tmp.getNextSibling;
          end;
          Node.StateIndex := cRadioChecked;
        end; // if StateIndex = cRadioUnChecked
  end; // if Assigned(Node)
end; (* ToggleTreeViewCheckBoxes *)

procedure TForm1.TreeView1Click(Sender: TObject);
var
  P: TPoint;
begin
  GetCursorPos(P);
  P := TreeView1.ScreenToClient(P);
  if (htOnStateIcon in TreeView1.GetHitTestInfoAt(P.X, P.Y)) then
    ToggleTreeViewCheckBoxes(TreeView1.Selected, cFlatUnCheck, cFlatChecked, cFlatRadioUnCheck, cFlatRadioChecked);
end;

procedure TForm1.TreeView1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (Key = VK_SPACE) and Assigned(TreeView1.Selected) then
    ToggleTreeViewCheckBoxes(TreeView1.Selected, cFlatUnCheck, cFlatChecked, cFlatRadioUnCheck, cFlatRadioChecked);
end; (* TreeView1KeyDown *)

procedure TForm1.FormCreate(Sender: TObject);
var
  i: integer;
begin
  TreeView1.FullExpand;
end; (* FormCreate *)

procedure TForm1.TreeView1Collapsing(Sender: TObject; Node: TTreeNode; var AllowCollapse: Boolean);
begin
  AllowCollapse := false;
end; (* TreeView1Collapsing *)

procedure TForm1.Button1Click(Sender: TObject);
var
  BoolResult: Boolean;
  tn: TTreeNode;
begin
  if Assigned(TreeView1.Selected) then
  begin
    tn := TreeView1.Selected;
    BoolResult := tn.StateIndex in [cFlatChecked, cFlatRadioChecked];
    Memo1.Text := tn.Text + #13#10 + 'Selected: ' + BoolToStr(BoolResult, True);
  end;
end; (* Button1Click *)

end.
