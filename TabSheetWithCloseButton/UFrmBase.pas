unit UFrmBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TFrmBase = class(TForm)
    LabelTitulo: TLabel;
    Button1: TButton;
  private
    { Private declarations }
  public
    Destructor Destroy; override;
    Constructor Create(AOwner: TComponent); override;
  end;

var
  FrmBase: TFrmBase;

implementation

{$R *.dfm}
{ TFrmBase }

Constructor TFrmBase.Create(AOwner: TComponent);
begin
  inherited;
  LabelTitulo.Caption := Self.Caption;
end;

Destructor TFrmBase.Destroy;
begin
  // ShowMessage(Caption);
  inherited;
end;

end.
