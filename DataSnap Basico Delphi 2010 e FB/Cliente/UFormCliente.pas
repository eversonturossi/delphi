unit UFormCliente;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDataModuleCadastro, DB, Grids, DBGrids, StdCtrls;

type
  TFormCliente = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormCliente: TFormCliente;

implementation

{$R *.dfm}

procedure TFormCliente.Button1Click(Sender: TObject);
begin
  DataModuleCadastro.cdClifor.Close;
  ShowMessage('a');
  DataModuleCadastro.cdClifor.Open;
end;

end.
