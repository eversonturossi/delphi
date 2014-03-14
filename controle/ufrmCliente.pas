unit ufrmCliente;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Menus, ExtDlgs, Grids,
  uObjCliente;

type
  TfrCliente = class(TForm)
    Panel1: TPanel;
    Label3: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    edtTelefone: TEdit;
    edtEndereco: TEdit;
    edtNome: TEdit;
    Button1: TButton;
    btnCadastro: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    StringGrid1: TStringGrid;
    GroupBox1: TGroupBox;
    edtCpf: TEdit;
    Label4: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCadastroClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure StringGrid1Click(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
    procedure Button3Click(Sender: TObject);
  private

    REGISTRO_EM_USO: TObjCliente;
    procedure Abrir(id: Integer);
    procedure Carregar;
    procedure Add(cliente: TObjCliente);
    procedure LimparGrid;
    procedure LimparForm;
    procedure Replace(cliente: TObjCliente);
    { Private declarations }
  public

  end;

var
  frCliente: TfrCliente;

implementation

{$R *.DFM}
// GridDeleteRow(3, stringGrid1);

procedure GridDeleteRow(RowNumber: Integer; Grid: TStringGrid);
var
  i: Integer;
begin
  Grid.Row := RowNumber;
  if (Grid.Row = Grid.RowCount - 1) then
    { On the last row }
    Grid.RowCount := Grid.RowCount - 1
  else
  begin
    { Not the last row }
    for i := RowNumber to Grid.RowCount - 1 do
      Grid.Rows[i] := Grid.Rows[i + 1];
    Grid.RowCount := Grid.RowCount - 1;
  end;
end;

procedure TfrCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TfrCliente.LimparGrid;
var
  i: Integer;
begin
  StringGrid1.RowCount := 2;
  for i := 0 to StringGrid1.ColCount - 1 do
  begin
    StringGrid1.Cells[i, 1] := '';
  end;
end;

procedure TfrCliente.Add(cliente: TObjCliente);
var
  i: Integer;
begin
  if Trim(StringGrid1.Cells[0, 1]) = '' then
    i := 1
  else
  begin
    StringGrid1.RowCount := StringGrid1.RowCount + 1;
    i := StringGrid1.RowCount - 1;
  end;
  StringGrid1.Cells[0, i] := IntToStr(cliente.id);
  StringGrid1.Cells[1, i] := cliente.NOME;
  StringGrid1.Cells[2, i] := cliente.ENDERECO;
  StringGrid1.Cells[3, i] := cliente.TELEFONE;
  StringGrid1.Cells[4, i] := cliente.CPF;
end;

procedure TfrCliente.Replace(cliente: TObjCliente);
var
  i: Integer;
begin
  i := StringGrid1.Row;
  StringGrid1.Cells[1, i] := cliente.NOME;
  StringGrid1.Cells[2, i] := cliente.ENDERECO;
  StringGrid1.Cells[3, i] := cliente.TELEFONE;
  StringGrid1.Cells[4, i] := cliente.CPF;
end;

procedure TfrCliente.Carregar;
var
  i: Integer;
  CLIENTES: TClientes;
begin
  CLIENTES := TClientes.Create;
  CLIENTES.LoadFromFile;
  for i := 0 to CLIENTES.Count - 1 do
    Add(CLIENTES.GetPosicao(i));
end;

procedure TfrCliente.Abrir(id: Integer);
var
  cliente: TObjCliente;
  CLIENTES: TClientes;
begin
  CLIENTES := TClientes.Create;
  CLIENTES.LoadFromFile;
  cliente := CLIENTES.Get(id);
  edtNome.Text := cliente.NOME;
  edtEndereco.Text := cliente.ENDERECO;
  edtTelefone.Text := cliente.TELEFONE;
  edtCpf.Text := cliente.CPF;
  REGISTRO_EM_USO := cliente;
end;

procedure TfrCliente.LimparForm;
var
  i: Integer;
begin
  for i := 0 to Self.ComponentCount - 1 do
    if (Self.Components[i] is TEdit) then
      (Self.Components[i] as TEdit).Text := '';
  REGISTRO_EM_USO.id := 0;
  btnCadastro.Caption := 'Cadastrar';
end;

procedure TfrCliente.btnCadastroClick(Sender: TObject);
var
  cliente: TObjCliente;
  CLIENTES: TClientes;
begin
  CLIENTES := TClientes.Create;
  CLIENTES.LoadFromFile;

  cliente.NOME := edtNome.Text;
  cliente.ENDERECO := edtEndereco.Text;
  cliente.TELEFONE := edtTelefone.Text;
  cliente.CPF := edtCpf.Text;
  cliente.ID_USUARIO := 1555;

  if REGISTRO_EM_USO.id = 0 then
  begin
    cliente.id := CLIENTES.ProxID;
    CLIENTES.Add(cliente);
    Add(cliente);
  end
  else
  begin
    cliente.id := REGISTRO_EM_USO.id;
    CLIENTES.Modify(cliente);
    Replace(cliente);
  end;

  CLIENTES.SaveToFile;
end;

procedure TfrCliente.Button4Click(Sender: TObject);
var
  CLIENTES: TClientes;
  _CLIENTES: TClientes;
  i: Integer;
begin
  CLIENTES := TClientes.Create;
  CLIENTES.LoadFromFile;
  _CLIENTES := CLIENTES.FindByName(edtNome.Text);
  LimparGrid;
  for i := 0 to _CLIENTES.Count - 1 do
    Add(_CLIENTES.GetPosicao(i));
end;

procedure TfrCliente.FormCreate(Sender: TObject);
begin
  StringGrid1.Cells[0, 0] := 'ID';
  StringGrid1.Cells[1, 0] := 'Nome';
  StringGrid1.Cells[2, 0] := 'Endereço';
  StringGrid1.Cells[3, 0] := 'Telefone';
  StringGrid1.Cells[4, 0] := 'CPF';
  Carregar;
  StringGrid1.Row := 0;
  StringGrid1.Col := 0;
end;

procedure TfrCliente.StringGrid1Click(Sender: TObject);
begin
  if StringGrid1.Row > 0 then
    if Trim(StringGrid1.Cells[0, StringGrid1.Row]) <> '' then
    begin
      Abrir(StrToInt(StringGrid1.Cells[0, StringGrid1.Row]));
      btnCadastro.Caption := 'Alterar';
    end;
end;

procedure TfrCliente.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer; Rect: TRect; State: TGridDrawState);
const
  clPaleGreen = TColor($CCFFCC);
begin
  { with (Sender as TStringGrid) do
    begin
    if (ARow = 0) then
    Canvas.Brush.Color := clBtnFace
    else
    begin
    if ARow mod 2 = 0 then
    Canvas.Brush.Color := $00E4E4E4
    else
    Canvas.Brush.Color := clPaleGreen;
    Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, cells[acol, arow]);
    Canvas.FrameRect(Rect);
    end;
    end; }

end;

procedure TfrCliente.Button3Click(Sender: TObject);
begin
  LimparForm;
end;

end.
