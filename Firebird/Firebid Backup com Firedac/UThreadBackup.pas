unit UThreadBackup;

interface

uses
  SysUtils,
  IOUtils,
  Windows,
  Classes,
  StdCtrls, UBackupFirebird;

type
  TThreadBackup = class(TThread)
  private
    fArquivoDB: String;
    fSenha: String;
    fUsuario: String;
    fArquivoBackup: String;
    property ArquivoBackup: String read fArquivoBackup write fArquivoBackup;
  public
    class procedure IniciarBackup(AArquivoDB, AUsuario, ASenha: String);
    constructor Create(CreateSuspended: Boolean);
    destructor Destroy; override;

    property ArquivoDB: String read fArquivoDB write fArquivoDB;
    property Usuario: String read fUsuario write fUsuario;
    property Senha: String read fSenha write fSenha;
  protected
    procedure Execute; override;
  end;

implementation

{ TThreadBackup }

constructor TThreadBackup.Create(CreateSuspended: Boolean);
begin
  inherited Create(CreateSuspended);



end;

destructor TThreadBackup.Destroy;
begin

  inherited;
end;

procedure TThreadBackup.Execute;
begin
  inherited;
  TBackupFirebird.Executar(ArquivoDB, Usuario, Senha);
end;

class procedure TThreadBackup.IniciarBackup(AArquivoDB, AUsuario, ASenha: String);
var
  ThreadBackup: TThreadBackup;
begin
  try
    try
      ThreadBackup := TThreadBackup.Create(True);
      ThreadBackup.FreeOnTerminate := True;
      ThreadBackup.Priority := tpHighest;
      ThreadBackup.ArquivoDB := AArquivoDB;
      ThreadBackup.Usuario := AUsuario;
      ThreadBackup.Senha := ASenha;
      ThreadBackup.Resume;
    except
    end;
  finally
    ThreadBackup := nil;
  end;
end;

end.
