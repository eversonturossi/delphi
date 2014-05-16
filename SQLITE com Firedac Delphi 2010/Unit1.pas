unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uADStanIntf, uADStanOption, uADStanError, uADGUIxIntf,
  uADPhysIntf, uADStanDef, uADStanPool, uADStanAsync, uADPhysManager,
  uADStanParam, uADDatSManager, uADDAptIntf, uADDAptManager, Grids, DBGrids, DB,
  uADCompDataSet, uADCompClient, uADStanExprFuncs, uADGUIxFormsWait,
  uADCompGUIx, uADPhysSQLite, ComCtrls, XPMan;

type
  TForm1 = class(TForm)
    ButtonOpen: TButton;
    ButtonInsert: TButton;
    ADConnection1: TADConnection;
    ADQueryLista: TADQuery;
    ADQueryInsert: TADQuery;
    DBGrid1: TDBGrid;
    ADPhysSQLiteDriverLink1: TADPhysSQLiteDriverLink;
    ADGUIxWaitCursor1: TADGUIxWaitCursor;
    DataSourceLista: TDataSource;
    ProgressBar1: TProgressBar;
    EditMax: TEdit;
    CheckBoxInserirViaSQL: TCheckBox;
    CheckBoxResetarDados: TCheckBox;
    XPManifest1: TXPManifest;
    procedure ButtonOpenClick(Sender: TObject);
    procedure ButtonInsertClick(Sender: TObject);
  private
    procedure OpenDB;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.ButtonOpenClick(Sender: TObject);
begin
  OpenDB;
end;

procedure TForm1.OpenDB;
begin
  ADConnection1.Close;
  ADQueryLista.Close;

  ADConnection1.Open();
  ADQueryLista.SQL.Text := 'select * from versao';
  ADQueryLista.Open();
  ButtonInsert.Enabled := True;
end;

procedure TForm1.ButtonInsertClick(Sender: TObject);
var
  I, MaxRegistros, ID: Integer;
  ViaSQL, Resetar: Boolean;
begin
  ADQueryLista.DisableControls;
  ButtonOpen.Enabled := False;
  ButtonInsert.Enabled := False;
  Application.ProcessMessages;
  try
    ID := 0;
    ViaSQL := CheckBoxInserirViaSQL.Checked;
    Resetar := CheckBoxResetarDados.Checked;
    if (Resetar) then
    begin
      ADQueryInsert.SQL.Text := 'delete from versao';
      ADQueryInsert.ExecSQL;
    end;

    ADQueryInsert.SQL.Text := 'select max(codigo) max_codigo from versao';
    ADQueryInsert.Open();
    if (ADQueryInsert.FieldByName('max_codigo').AsString <> '') then
      ID := ADQueryInsert.FieldByName('max_codigo').AsInteger;

    ProgressBar1.Position := 0;
    MaxRegistros := StrToInt(EditMax.Text);
    ProgressBar1.Max := MaxRegistros;
    for I := 1 to MaxRegistros do
    begin
      Inc(ID);

      if (ViaSQL) then
      begin
        ADQueryInsert.SQL.Text := 'insert into versao(CODIGO,VERSAOCONTROLELOCAL,VERSAOCONTROLEREMOTA,NOMESISTEMA,VERSAOSISTEMA,DATAALTERACAO,USARCOMPACTACAO,ATUALIZACAOAUTOMATICA,DIRETORIOREMOTO)' +
          ' values (:CODIGO,:VERSAOCONTROLELOCAL,:VERSAOCONTROLEREMOTA,:NOMESISTEMA,:VERSAOSISTEMA,:DATAALTERACAO,:USARCOMPACTACAO,:ATUALIZACAOAUTOMATICA,:DIRETORIOREMOTO)';
        ADQueryInsert.ParamByName('CODIGO').AsInteger := ID;
        ADQueryInsert.ParamByName('VERSAOCONTROLELOCAL').AsInteger := I;
        ADQueryInsert.ParamByName('VERSAOCONTROLEREMOTA').AsInteger := I * 2;
        ADQueryInsert.ParamByName('NOMESISTEMA').AsString := self.Caption;
        ADQueryInsert.ParamByName('VERSAOSISTEMA').AsString := 'X.XX.X';
        ADQueryInsert.ParamByName('DATAALTERACAO').AsDate := now;
        ADQueryInsert.ParamByName('USARCOMPACTACAO').AsString := 'S';
        ADQueryInsert.ParamByName('ATUALIZACAOAUTOMATICA').AsString := 'S';
        ADQueryInsert.ParamByName('DIRETORIOREMOTO').AsString := ExtractFilePath(ParamStr(0));
        ADQueryInsert.ExecSQL;
      end
      else
      begin
        ADQueryLista.Append;
        ADQueryLista.FieldByName('CODIGO').AsInteger := ID;
        ADQueryLista.FieldByName('VERSAOCONTROLELOCAL').AsInteger := I;
        ADQueryLista.FieldByName('VERSAOCONTROLEREMOTA').AsInteger := I * 2;
        ADQueryLista.FieldByName('NOMESISTEMA').AsString := self.Caption;
        ADQueryLista.FieldByName('VERSAOSISTEMA').AsString := 'X.XX.X';
        ADQueryLista.FieldByName('DATAALTERACAO').AsDateTime := now;
        ADQueryLista.FieldByName('USARCOMPACTACAO').AsString := 'S';
        ADQueryLista.FieldByName('ATUALIZACAOAUTOMATICA').AsString := 'S';
        ADQueryLista.FieldByName('DIRETORIOREMOTO').AsString := ExtractFilePath(ParamStr(0));
        ADQueryLista.Post;
      end;
      Application.ProcessMessages;
      ProgressBar1.Position := I;
    end;

    if not(ViaSQL) then
      ADQueryLista.ApplyUpdates();
  finally
    ADQueryLista.EnableControls;
    if (Resetar) then
      OpenDB;
    ADQueryLista.Last;
    ButtonOpen.Enabled := True;
    ButtonInsert.Enabled := True;
  end;
end;

end.
