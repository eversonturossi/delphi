unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uADStanIntf, uADStanOption, uADStanError, uADGUIxIntf,
  uADPhysIntf, uADStanDef, uADStanPool, uADStanAsync, uADPhysManager,
  uADStanParam, uADDatSManager, uADDAptIntf, uADDAptManager, Grids, DBGrids, DB,
  uADCompDataSet, uADCompClient, uADStanExprFuncs, uADGUIxFormsWait,
  uADCompGUIx, uADPhysSQLite, ComCtrls, XPMan, ExtCtrls;

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
    TimerLimpaMemoria: TTimer;
    CheckBoxAutoCommit: TCheckBox;
    procedure ButtonOpenClick(Sender: TObject);
    procedure ButtonInsertClick(Sender: TObject);
    procedure TimerLimpaMemoriaTimer(Sender: TObject);
  private
    procedure OpenDB;
    procedure LimparMemoriaResidual;
    procedure OpenQueryListaNoRecords;
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
  ADQueryLista.SQL.Text := 'SELECT * FROM VERSAO WHERE (CODIGO <=1000)';
  ADQueryLista.Open();
  ButtonInsert.Enabled := True;
end;

procedure TForm1.OpenQueryListaNoRecords();
begin
  ADQueryLista.Close;
  ADQueryLista.SQL.Text := 'SELECT * FROM VERSAO WHERE (CODIGO IS NULL)';
  ADQueryLista.Open();
end;

procedure TForm1.ButtonInsertClick(Sender: TObject);
const
  AutoComitCount = 50000;
var
  I, MaxRegistros, ID: Integer;
  ViaSQL, Resetar, AutoCommit: Boolean;
  TempoInicial, TempoFinal, TempoAtual: TDateTime;
begin
  ADQueryLista.DisableControls;
  ButtonOpen.Enabled := False;
  ButtonInsert.Enabled := False;
  Application.ProcessMessages;
  try
    ID := 0;
    ViaSQL := CheckBoxInserirViaSQL.Checked;
    Resetar := CheckBoxResetarDados.Checked;
    AutoCommit := CheckBoxAutoCommit.Checked;
    if (Resetar) then
    begin
      ADQueryInsert.SQL.Text := 'DELETE FROM VERSAO';
      ADQueryInsert.ExecSQL;
    end;

    ADQueryInsert.SQL.Text := 'SELECT MAX(CODIGO) MAX_CODIGO FROM VERSAO';
    ADQueryInsert.Open();
    if (ADQueryInsert.FieldByName('max_codigo').AsString <> '') then
      ID := ADQueryInsert.FieldByName('max_codigo').AsInteger;

    TempoInicial := Now;
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
        ADQueryInsert.ParamByName('NOMESISTEMA').AsString := 'nome do sistema';
        ADQueryInsert.ParamByName('VERSAOSISTEMA').AsString := 'X.XX.X';
        ADQueryInsert.ParamByName('DATAALTERACAO').AsDate := Now;
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
        ADQueryLista.FieldByName('NOMESISTEMA').AsString := 'nome do sistema';
        ADQueryLista.FieldByName('VERSAOSISTEMA').AsString := 'X.XX.X';
        ADQueryLista.FieldByName('DATAALTERACAO').AsDateTime := Now;
        ADQueryLista.FieldByName('USARCOMPACTACAO').AsString := 'S';
        ADQueryLista.FieldByName('ATUALIZACAOAUTOMATICA').AsString := 'S';
        ADQueryLista.FieldByName('DIRETORIOREMOTO').AsString := ExtractFilePath(ParamStr(0));
        ADQueryLista.Post;
        if (AutoCommit) then
          if ((I mod AutoComitCount) = 0) then
          begin
            ADQueryLista.ApplyUpdates();
            OpenQueryListaNoRecords();
            TempoAtual := (Now - TempoInicial);
            Self.Caption := Format('Insidiro %d registros em %S', [I, FormatDateTime('hh:nn:ss', TempoAtual)]);
            Application.ProcessMessages;
          end;
      end;
      Application.ProcessMessages;
      ProgressBar1.Position := I;
    end;

    if not(ViaSQL) then
      ADQueryLista.ApplyUpdates();
  finally
    TempoFinal := (Now - TempoInicial);
    Self.Caption := Format('Finalizado em %S', [FormatDateTime('hh:nn:ss', TempoFinal)]);
    ADQueryLista.EnableControls;
    if (Resetar) then
      OpenDB;
    ADQueryLista.Last;
    ButtonOpen.Enabled := True;
    ButtonInsert.Enabled := True;
  end;
end;

procedure TForm1.TimerLimpaMemoriaTimer(Sender: TObject);
begin
  LimparMemoriaResidual();
end;

procedure TForm1.LimparMemoriaResidual();
var
  MainHandle: THandle;
begin
  try
    MainHandle := OpenProcess(PROCESS_ALL_ACCESS, False, GetCurrentProcessID);
    SetProcessWorkingSetSize(MainHandle, $FFFFFFFF, $FFFFFFFF);
    CloseHandle(MainHandle);
  except
  end;
  Application.ProcessMessages;
end;

end.
