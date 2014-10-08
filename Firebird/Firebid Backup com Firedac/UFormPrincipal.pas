unit UFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uADStanIntf, uADPhysManager, uADPhysIB, uADPhysIBWrapper, ExtCtrls;

type
  TFormPrincipal = class(TForm)
    DBBackup: TADIBBackup;
    ButtonBackup: TButton;
    OpenDialogDB: TOpenDialog;
    MemoLog: TMemo;
    LabelArquivoBanco: TLabel;
    DBLink: TADPhysIBDriverLink;
    Label2: TLabel;
    LabelTempoDecorrido: TLabel;
    Label1: TLabel;
    CheckBoxVerbose: TCheckBox;
    ButtonRestore: TButton;
    DBRestore: TADIBRestore;
    procedure ButtonBackupClick(Sender: TObject);
    procedure DBBackupBeforeExecute(Sender: TObject);
    procedure DBBackupAfterExecute(Sender: TObject);
    procedure DBBackupError(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
    procedure DBBackupProgress(ASender: TADPhysDriverService; const AMessage: String);
    procedure FormCreate(Sender: TObject);
    procedure ButtonRestoreClick(Sender: TObject);
    procedure DBRestoreAfterExecute(Sender: TObject);
    procedure DBRestoreBeforeExecute(Sender: TObject);
    procedure DBRestoreError(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
    procedure DBRestoreProgress(ASender: TADPhysDriverService; const AMessage: String);
  private
    fDataHoraInicio: TDateTime;
    fMensagemAnterior: String;
    function getHora(): String;
    procedure AtualizaProgresso;
    property DataHoraInicio: TDateTime read fDataHoraInicio write fDataHoraInicio;
  public
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses uADStanDef;
{$R *.dfm}

function TFormPrincipal.getHora(): String;
begin
  Result := FormatDateTime('hh:nn:ss', Now);
end;

procedure TFormPrincipal.AtualizaProgresso();
begin
  LabelTempoDecorrido.Caption := FormatDateTime('hh:nn:ss', Now - DataHoraInicio);
  Application.ProcessMessages;
end;

procedure TFormPrincipal.DBBackupAfterExecute(Sender: TObject);
begin
  MemoLog.Lines.Add(getHora() + ' ->  Terninado Backup');
end;

procedure TFormPrincipal.DBBackupBeforeExecute(Sender: TObject);
begin
  MemoLog.Lines.Add(getHora() + ' ->  Iniciado Backup');
end;

procedure TFormPrincipal.DBBackupError(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
begin
  MemoLog.Lines.Add(getHora() + ' -> ERRO: ' + AException.Message);
end;

procedure TFormPrincipal.DBBackupProgress(ASender: TADPhysDriverService; const AMessage: String);
begin
  if (CheckBoxVerbose.Checked) then
    MemoLog.Lines.Add(getHora() + ' -> ' + AMessage);
  AtualizaProgresso();
end;

procedure TFormPrincipal.DBRestoreAfterExecute(Sender: TObject);
begin
  MemoLog.Lines.Add(getHora() + ' ->  Terminado Restore');
end;

procedure TFormPrincipal.DBRestoreBeforeExecute(Sender: TObject);
begin
  MemoLog.Lines.Add(getHora() + ' ->  Iniciado Restore');
end;

procedure TFormPrincipal.DBRestoreError(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
begin
  MemoLog.Lines.Add(getHora() + ' -> ERRO: ' + AException.Message);
end;

procedure TFormPrincipal.DBRestoreProgress(ASender: TADPhysDriverService; const AMessage: String);
begin
  if (CheckBoxVerbose.Checked) then
    MemoLog.Lines.Add(getHora() + ' -> ' + AMessage);
  AtualizaProgresso();
end;

procedure TFormPrincipal.ButtonBackupClick(Sender: TObject);
var { adicionar nas uses uADStanDef }
  ArquivoBanco, ArquivoBackup: String;
begin
  try
    TButton(Sender).Enabled := False;
    MemoLog.Lines.Clear;
    DBBackup.BackupFiles.Clear;
    LabelArquivoBanco.Caption := '';

    OpenDialogDB.Filter := 'FireBird Database(*.fdb)|*.fdb';
    if not(OpenDialogDB.Execute()) then
      raise Exception.Create('Cancelado');
    ArquivoBanco := OpenDialogDB.FileName;
    LabelArquivoBanco.Caption := ArquivoBanco;
    if (UpperCase(ExtractFileExt(ArquivoBanco)) <> UpperCase('.fdb')) then
      raise Exception.Create('Arquivo inválido');

    DataHoraInicio := Now;
    AtualizaProgresso();
    ArquivoBackup := ChangeFileExt(ArquivoBanco, '.fbkfiredac');
    try
      DBBackup.Database := ArquivoBanco;
      DBBackup.BackupFiles.Add(ArquivoBackup);
      DBBackup.Verbose := True;
      DBBackup.Host := 'localhost';
      DBBackup.UserName := 'SYSDBA';
      DBBackup.Password := 'masterkey';
      DBBackup.Backup;
    except
      on E: Exception do
        MemoLog.Lines.Add('Erro' + E.Message);
    end;

  finally
    AtualizaProgresso();
    TButton(Sender).Enabled := True;
  end;
end;

procedure TFormPrincipal.ButtonRestoreClick(Sender: TObject);
var { adicionar nas uses uADPhysIBWrapper }
  ArquivoBackup, ArquivoRestore: String;
begin
  try
    TButton(Sender).Enabled := False;
    MemoLog.Lines.Clear;
    DBRestore.BackupFiles.Clear;
    LabelArquivoBanco.Caption := '';

    OpenDialogDB.Filter := 'FireBird Database(*.fbkfiredac)|*.fbkfiredac';
    if not(OpenDialogDB.Execute()) then
      raise Exception.Create('Cancelado');
    ArquivoBackup := OpenDialogDB.FileName;
    LabelArquivoBanco.Caption := ArquivoBackup;
    if (UpperCase(ExtractFileExt(ArquivoBackup)) <> UpperCase('.fbkfiredac')) then
      raise Exception.Create('Arquivo inválido');

    DataHoraInicio := Now;
    AtualizaProgresso();
    ArquivoRestore := ChangeFileExt(ArquivoBackup, '_novo.fdb');
    try
      DBRestore.Database := ArquivoRestore;
      DBRestore.BackupFiles.Add(ArquivoBackup);
      DBRestore.Verbose := True;
      DBRestore.Options := [roCreate];
      DBRestore.Host := 'localhost';
      DBRestore.UserName := 'SYSDBA';
      DBRestore.Password := 'masterkey';
      DBRestore.Restore;
    except
      on E: Exception do
        MemoLog.Lines.Add('Erro' + E.Message);
    end;

  finally
    AtualizaProgresso();
    TButton(Sender).Enabled := True;
  end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  LabelArquivoBanco.Caption := '';
  MemoLog.Lines.Clear;
  LabelTempoDecorrido.Caption := '00:00:00';
end;

end.
