unit UMensagem;

interface

uses
  SysUtils, Classes, DateUtils, Dialogs, FileCtrl, StrUtils,
  Forms, Windows;

const
  QuebraLinha = #13#10;
  Espaco = ' ';

type
  TMensagem = class(TObject)
  private
    fMensagens: TStringList;
    function getTexto: String;
    function getTextoSemQuebra: String;
    property Mensagens: TStringList read fMensagens write fMensagens;
  public
    constructor Create();
    destructor Destroy; override;
    procedure Add(const AText: String); overload;
    procedure Add(const AText: String; Params: array of const ); overload;
    procedure AddQuebraLinha();
    procedure Clear;
    function Confirma(): Boolean;
    procedure Show();
    property Texto: String read getTexto;
    property TextoSemQuebra: String read getTextoSemQuebra;
  end;

implementation

procedure TMensagem.Add(const AText: String);
begin
  fMensagens.Add(AText);
end;

procedure TMensagem.Add(const AText: String; Params: array of const );
begin
  fMensagens.Add(Format(AText, Params));
end;

procedure TMensagem.AddQuebraLinha;
begin
  fMensagens.Add('');
end;

procedure TMensagem.Clear;
begin
  fMensagens.Clear;
end;

constructor TMensagem.Create;
begin
  fMensagens := TStringList.Create;
end;

destructor TMensagem.Destroy;
begin
  FreeAndNil(fMensagens);
  inherited;
end;

function TMensagem.getTexto: String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to fMensagens.Count - 1 do
  begin
    if (I > 0) then
      Result := Result + QuebraLinha;
    Result := Result + Trim(fMensagens[I]);
  end;
end;

function TMensagem.getTextoSemQuebra: String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to fMensagens.Count - 1 do
  begin
    if (I > 0) then
      Result := Result + Espaco;
    Result := Result + Trim(fMensagens[I]);
  end;
end;

function TMensagem.Confirma(): Boolean;
begin
  Result := (Application.MessageBox(PChar(getTexto()), PChar('Confirmação'), Mb_YesNo + mb_IconQuestion) = IDYES);
end;

procedure TMensagem.Show;
begin
  ShowMessage(getTexto());
end;

end.
