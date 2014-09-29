unit UFormPrincipal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, uADStanIntf, uADPhysManager, uADPhysIB;

type
  TFormPrincipal = class(TForm)
    ADIBBackup1: TADIBBackup;
    ButtonBackup: TButton;
    OpenDialog1: TOpenDialog;
    MemoLog: TMemo;
    LabelArquivoBanco: TLabel;
    ADPhysIBDriverLink1: TADPhysIBDriverLink;
    procedure ButtonBackupClick(Sender: TObject);
    procedure ADIBBackup1BeforeExecute(Sender: TObject);
    procedure ADIBBackup1AfterExecute(Sender: TObject);
    procedure ADIBBackup1Error(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
    procedure ADIBBackup1Progress(ASender: TADPhysDriverService; const AMessage: string);
    procedure FormCreate(Sender: TObject);
  private
    function getHora: string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormPrincipal: TFormPrincipal;

implementation

uses uADStanDef;
{$R *.dfm}

function TFormPrincipal.getHora(): string;
begin
  Result := FormatDateTime('hh:nn:ss', Now);
end;

procedure TFormPrincipal.ADIBBackup1AfterExecute(Sender: TObject);
begin
  MemoLog.Lines.Add(getHora() + ' ->  Terninado');
end;

procedure TFormPrincipal.ADIBBackup1BeforeExecute(Sender: TObject);
begin
  MemoLog.Lines.Add(getHora() + ' ->  Iniciado');
end;

procedure TFormPrincipal.ADIBBackup1Error(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
begin
  MemoLog.Lines.Add(getHora() + ' -> ERRO: ' + AException.Message);
end;

procedure TFormPrincipal.ADIBBackup1Progress(ASender: TADPhysDriverService; const AMessage: string);
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

    OpenDialog1.Filter := 'FireBird Database(*.fdb)|*.fdb';
    if not(OpenDialog1.Execute()) then
      raise Exception.Create('Cancelado');
    FileDBOrigem := OpenDialog1.FileName;
    LabelArquivoBanco.Caption := FileDBOrigem;
    if (UpperCase(ExtractFileExt(FileDBOrigem)) <> UpperCase('.fdb')) then
      raise Exception.Create('Arquivo inválido');

    FileDBDestino := ChangeFileExt(FileDBOrigem, '.fbk');
    try
      ADIBBackup1.Database := FileDBOrigem;
      ADIBBackup1.BackupFiles.Add(FileDBDestino);
      ADIBBackup1.Verbose := True;
      ADIBBackup1.Host := 'localhost';
      ADIBBackup1.UserName := 'SYSDBA';
      ADIBBackup1.Password := 'masterkey';
      ADIBBackup1.Backup;
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
