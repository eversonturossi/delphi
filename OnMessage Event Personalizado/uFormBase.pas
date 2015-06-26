unit uFormBase;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, uMyEvent;

type
  TFormBase = class(TForm)
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    function GetFormularoAcao: Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormBase: TFormBase;

implementation

{$R *.dfm}

function TFormBase.GetFormularoAcao(): Integer;
var
  Acao: PChar;
begin
  Acao := PChar(Self.Name);
  Result := Integer(Acao);
end;

procedure TFormBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  PostMessage(Application.Handle, WM_FECHANDO, 0, GetFormularoAcao());
end;

procedure TFormBase.FormCreate(Sender: TObject);
begin
  PostMessage(Application.Handle, WM_ABRINDO, 0, GetFormularoAcao());
end;

procedure TFormBase.FormDestroy(Sender: TObject);
begin
  PostMessage(Application.Handle, WM_DESTRUINDO, 0, GetFormularoAcao());
end;

end.
