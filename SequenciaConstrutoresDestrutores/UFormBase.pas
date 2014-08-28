unit UFormBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs;

type
  TFormBase = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
  protected
    procedure DoCreate; override;
    procedure DoDestroy; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}
{ TForm2 }

constructor TFormBase.Create(AOwner: TComponent);
begin
  inherited;
  ShowMessage('constructor Create');
end;

destructor TFormBase.Destroy;
begin
  ShowMessage('destructor Destroy');
  inherited;
end;

procedure TFormBase.DoCreate;
begin
  inherited;
  ShowMessage('procedure DoCreate');
end;

procedure TFormBase.DoDestroy;
begin
  inherited;
  ShowMessage('procedure DoDestroy');
end;

procedure TFormBase.FormCreate(Sender: TObject);
begin
  ShowMessage('procedure FormCreate');
end;

procedure TFormBase.FormDestroy(Sender: TObject);
begin
  ShowMessage('procedure FormDestroy');
end;

end.
