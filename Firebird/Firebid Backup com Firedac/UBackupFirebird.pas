unit UBackupFirebird;

interface

uses
  Windows, SysUtils
{$IFDEF VER210}, uADStanIntf, uADPhysManager, uADPhysIB {$ENDIF}
{$IFDEF VER270}, OutrasUses {$ENDIF}
  ;

type
{$IFDEF VER210}
  TComponenteBackup = class(TADIBBackup);
    TComponenteLink = class(TADPhysIBDriverLink);
{$ENDIF}
{$IFDEF VER270}
    TComponenteBackup = class(TADIBBackup);
    TComponenteLink = class(TADPhysIBDriverLink);
{$ENDIF}
    TBackupFirebird = class(TObject)private fArquivoDB: String;
    fSenha: String;
    fUsuario: String;
    fComponenteBackup: TComponenteBackup;
    fComponenteLink: TComponenteLink;
    fArquivoBackup: String;

    property ComponenteBackup: TComponenteBackup read fComponenteBackup write fComponenteBackup;
    property ComponenteLink: TComponenteLink read fComponenteLink write fComponenteLink;
    property ArquivoBackup: String read fArquivoBackup write fArquivoBackup;

    procedure Backup();
  public
    property ArquivoDB: String read fArquivoDB write fArquivoDB;
    property Usuario: String read fUsuario write fUsuario;
    property Senha: String read fSenha write fSenha;

    Constructor Create();
    Destructor Destroy; override;

    class procedure Executar(AArquivoDB, AUsuario, ASenha: String);
  published
    procedure EventoBeforeExecute(Sender: TObject);
    procedure EventoAfterExecute(Sender: TObject);
    procedure EventoError(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
    procedure EventoProgress(ASender: TADPhysDriverService; const AMessage: String);
  end;

implementation

{ TBackupFirebird }

procedure TBackupFirebird.Backup();
begin
  ArquivoBackup := ChangeFileExt(ArquivoDB, '.fbk2');

  fComponenteBackup.Host := 'localhost';
  fComponenteBackup.DriverLink := fComponenteLink;
  fComponenteBackup.Protocol := ipLocal;
  fComponenteBackup.Verbose := True;

  fComponenteBackup.Database := ArquivoDB;
  fComponenteBackup.BackupFiles.Add(ArquivoBackup);
  fComponenteBackup.Verbose := True;
  fComponenteBackup.Host := 'localhost';
  fComponenteBackup.UserName := 'SYSDBA';
  fComponenteBackup.Password := 'masterkey';
  fComponenteBackup.Backup;

  ComponenteBackup.Backup;
end;

Constructor TBackupFirebird.Create;
begin
  fComponenteLink := TComponenteLink.Create(nil);
  fComponenteBackup := TComponenteBackup.Create(nil);

  fComponenteBackup.BeforeExecute := EventoBeforeExecute;
  fComponenteBackup.AfterExecute := EventoAfterExecute;
  fComponenteBackup.OnError := EventoError;
  fComponenteBackup.OnProgress := EventoProgress;
end;

Destructor TBackupFirebird.Destroy;
begin
  fComponenteBackup.DriverLink := nil;
  FreeAndNil(fComponenteLink);
  FreeAndNil(fComponenteBackup);
  inherited;
end;

class procedure TBackupFirebird.Executar(AArquivoDB, AUsuario, ASenha: String);
var
  BackupFirebird: TBackupFirebird;
begin
  try
    BackupFirebird := TBackupFirebird.Create;
    BackupFirebird.ArquivoDB := AArquivoDB;
    BackupFirebird.Usuario := AUsuario;
    BackupFirebird.Senha := ASenha;
    BackupFirebird.Backup();
  finally
    FreeAndNil(BackupFirebird);
  end;
end;

procedure TBackupFirebird.EventoAfterExecute(Sender: TObject);
begin

end;

procedure TBackupFirebird.EventoBeforeExecute(Sender: TObject);
begin

end;

procedure TBackupFirebird.EventoError(ASender: TObject; const AInitiator: IADStanObject; var AException: Exception);
begin

end;

procedure TBackupFirebird.EventoProgress(ASender: TADPhysDriverService; const AMessage: String);
begin

end;

end.
