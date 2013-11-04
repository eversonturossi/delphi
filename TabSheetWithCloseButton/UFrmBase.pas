unit UFrmBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmBase = class(TForm)
  private
    { Private declarations }
  public
    Destructor Destroy; override;
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}
{ TFrmBase }

Destructor TFrmBase.Destroy;
begin
  // ShowMessage(Caption);
  inherited;
end;

end.
