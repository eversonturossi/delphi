unit Unit7;

interface

{
  https://www.alberton.info/firebird_sql_meta_info.html
  https://gist.github.com/martinusso/1278962
  https://edn.embarcadero.com/article/25259

  "c:\Program Files\Firebird\Firebird_3_0\isql.exe" -extract -a -output c:\bancos\sql.txt -u SYSDBA -p masterkey c:\bancos\banco.FDB
}

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.VCLUI.Wait,
  FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Data.DB,
  Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, Vcl.ComCtrls, Vcl.StdCtrls, FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase, FireDAC.Phys.FB, Vcl.Mask, Vcl.DBCtrls;

type
  TFormPrincipal = class(TForm)
    FDQuery1: TFDQuery;
    Panel1: TPanel;
    StatusBar1: TStatusBar;
    DataSource1: TDataSource;
    FDConnection: TFDConnection;
    ButtonSelecionaDB: TButton;
    LabeledEditDB: TLabeledEdit;
    OpenDialogDB: TOpenDialog;
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    ButtonListarTabela: TButton;
    ButtonListarTrigger: TButton;
    ButtonListarView: TButton;
    ButtonListarProcedure: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    procedure ButtonSelecionaDBClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FDQuery1AfterOpen(DataSet: TDataSet);
    procedure ButtonListarTabelaClick(Sender: TObject);
    procedure FDQuery1AfterScroll(DataSet: TDataSet);
    procedure ButtonListarTriggerClick(Sender: TObject);
    procedure ButtonListarViewClick(Sender: TObject);
    procedure ButtonListarProcedureClick(Sender: TObject);
  private
    FDB: String;
    FSQL: TStringList;
    procedure ConfigurarFDConnection;
    procedure ConectarFDConnection;
    procedure DesconectarFDConnection;
    procedure Executar;
    procedure TotalizarItens(DataSet: TDataSet);

    property DB: String read FDB write FDB;
    property SQL: TStringList read FSQL write FSQL;
  public
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

{$R *.dfm}

procedure TFormPrincipal.ConfigurarFDConnection;
begin
  FDB := LabeledEditDB.Text;

  FDConnection.Params.Clear;
  FDConnection.Params.Add('DriverID=FB');
  FDConnection.Params.Add(Format('Database=%s', [FDB]));
  FDConnection.Params.Add('User_Name=SYSDBA');
  FDConnection.Params.Add('Password=masterkey');
end;

procedure TFormPrincipal.ConectarFDConnection;
begin
  try
    FDConnection.TxOptions.AutoCommit := True;
    FDConnection.UpdateOptions.AutoCommitUpdates := True;
    FDConnection.Connected := True;
  except
    on E: Exception do
      ShowMessageFmt('ERRO: %S', [E.Message]);
  end;
end;

procedure TFormPrincipal.DesconectarFDConnection;
begin
  FDConnection.Connected := False;
end;

procedure TFormPrincipal.TotalizarItens(DataSet: TDataSet);
begin
  StatusBar1.Panels[0].Text := Format('%D itens', [DataSet.RecordCount]);
end;

procedure TFormPrincipal.FDQuery1AfterOpen(DataSet: TDataSet);
begin
  TotalizarItens(DataSet);
end;

procedure TFormPrincipal.FDQuery1AfterScroll(DataSet: TDataSet);
begin
  TotalizarItens(DataSet);
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  FDB := '';
  FSQL := TStringList.Create;
end;

procedure TFormPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FSQL);
end;

procedure TFormPrincipal.Executar;
begin
  try
    FDQuery1.Close;
    FDQuery1.SQL.Clear;
    FDQuery1.SQL.AddStrings(FSQL);
    FDQuery1.Active := True;
    FDQuery1.Last;
    FDQuery1.First;
  except
    on E: Exception do
      ShowMessageFmt('ERRO: %S', [E.Message]);
  end;
end;

procedure TFormPrincipal.ButtonListarProcedureClick(Sender: TObject);
begin
  FSQL.Clear;
  FSQL.Add('SELECT RDB$PROCEDURE_NAME AS NAME,');
  FSQL.Add('       RDB$PROCEDURE_SOURCE AS SOURCE');
  FSQL.Add('  FROM RDB$PROCEDURES');
  FSQL.Add('ORDER BY 1');
  Executar;
end;

procedure TFormPrincipal.ButtonListarTabelaClick(Sender: TObject);
begin
  FSQL.Clear;
  FSQL.ADD('SELECT RDB$RELATION_NAME AS NAME,');
  FSQL.ADD('       NULL AS SOURCE');
  FSQL.ADD('  FROM RDB$RELATIONS');
  FSQL.ADD(' WHERE RDB$SYSTEM_FLAG = 0');
  FSQL.ADD('   AND RDB$VIEW_BLR IS NULL');
  FSQL.ADD('ORDER BY 1');
  Executar;
end;

procedure TFormPrincipal.ButtonListarTriggerClick(Sender: TObject);
begin
  FSQL.Clear;
  FSQL.Add('SELECT  RDB$TRIGGER_NAME   AS NAME,');
  FSQL.Add('        RDB$TRIGGER_SOURCE AS SOURCE');
  FSQL.Add('   FROM RDB$TRIGGERS');
  FSQL.Add('  WHERE RDB$SYSTEM_FLAG = 0');
  FSQL.Add('ORDER BY 1');
  Executar;
end;

procedure TFormPrincipal.ButtonListarViewClick(Sender: TObject);
begin
  FSQL.Clear;
  FSQL.Add('SELECT RDB$RELATION_NAME AS NAME,');
  FSQL.Add('       RDB$VIEW_SOURCE   AS SOURCE');
  FSQL.Add('  FROM RDB$RELATIONS');
  FSQL.Add(' WHERE RDB$VIEW_SOURCE IS NOT NULL ');
  FSQL.Add('ORDER BY 1');
  Executar;
end;

procedure TFormPrincipal.ButtonSelecionaDBClick(Sender: TObject);
begin
  OpenDialogDB.InitialDir := ExtractFileDir(LabeledEditDB.Text);
  if (OpenDialogDB.Execute) then
  begin
    LabeledEditDB.Text := OpenDialogDB.FileName;
    DesconectarFDConnection;
    ConfigurarFDConnection;
    ConectarFDConnection;
  end;
end;

end.
