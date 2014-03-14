unit ufrmLOGIN;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, ExtDlgs, Buttons;

type
  TfrLOGIN = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private

  public

  end;

var
  frLOGIN: TfrLOGIN;

implementation

{$R *.DFM}

procedure TfrLOGIN.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
