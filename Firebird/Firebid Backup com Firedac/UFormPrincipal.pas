unit UFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uADStanIntf, uADPhysManager, uADPhysIB;

type
  TFormPrincipal = class(TForm)
    DBBackup: TADIBBackup;
    ButtonBackup: TButton;
    OpenDialogDB: TOpenDialog;
    MemoLog: TMemo;
    LabelArquivoBanco: TLabel;
    DBLink: TADPhysIBDriverLink;
    procedure ButtonBackupClick(Sender: TObject);
    procedure DBBackupBeforeExecute(Sender: TObject);
    procedure DBBackupAfterExecute(Sender: TObject);
    procedure DBBackupError(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
    procedure DBBackupProgress(ASender: TADPhysDriverService; const AMessage: string);
    procedure FormCreate(Sender: TObject);
  private
    function getHora(): string;
  public
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses uADStanDef;
{$R *.dfm}

function TFormPrincipal.getHora(): string;
begin
  Result := FormatDateTime('hh:nn:ss', Now);
  Application.ProcessMessages;
end;

procedure TFormPrincipal.DBBackupAfterExecute(Sender: TObject);
begin
  MemoLog.Lines.Add(getHora() + ' ->  Terninado');
end;

procedure TFormPrincipal.DBBackupBeforeExecute(Sender: TObject);
begin
  MemoLog.Lines.Add(getHora() + ' ->  Iniciado');
end;

procedure TFormPrincipal.DBBackupError(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
begin
  MemoLog.Lines.Add(getHora() + ' -> ERRO: ' + AException.Message);
end;

procedure TFormPrincipal.DBBackupProgress(ASender: TADPhysDriverService; const AMessage: string);
begin
  MemoLog.Lines.Add(getHora() + ' -> ' + AMessage);
end;

procedure TFormPrincipal.ButtonBackupClick(Sender: TObject);
var { adicionar nas uses uADStanDef }
  FileDBOrigem, FileDBDestino: string;
begin
  try
    TButton(Sender).Enabled := False;
    MemoLog.Lines.Clear;
    LabelArquivoBanco.Caption := '';

    OpenDialogDB.Filter := 'FireBird Database(*.fdb)|*.fdb';
    if not(OpenDialogDB.Execute()) then
      raise Exception.Create('Cancelado');
    FileDBOrigem := OpenDialogDB.FileName;
    LabelArquivoBanco.Caption := FileDBOrigem;
    if (UpperCase(ExtractFileExt(FileDBOrigem)) <> UpperCase('.fdb')) then
      raise Exception.Create('Arquivo inválido');

    FileDBDestino := ChangeFileExt(FileDBOrigem, '.fbk');
    try
      DBBackup.Database := FileDBOrigem;
      DBBackup.BackupFiles.Add(FileDBDestino);
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
    TButton(Sender).Enabled := True;
  end;
end;

procedure TFormPrincipal.FormCreate(Sender: TObject);
begin
  LabelArquivoBanco.Caption := '';
  MemoLog.Lines.Clear;
end;

end.
