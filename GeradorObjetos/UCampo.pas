unit UCampo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils;

type
  TCampo = class(TObject)
  private
    FNome: String;
    FTipo: String;
    procedure SetNome(const Value: String);
    procedure SetTipo(const Value: String);
  public
    constructor Create;
    procedure Clear;
    property Nome: String read FNome write SetNome;
    property Tipo: String read FTipo write SetTipo;
  end;

implementation

{ TCampo }

procedure TCampo.Clear;
begin
  FNome := '';
  FTipo := '';
end;

constructor TCampo.Create;
begin
  self.Clear;
end;

procedure TCampo.SetNome(const Value: String);
begin
  FNome := Trim(Value);
end;

procedure TCampo.SetTipo(const Value: String);
begin
  FTipo := Trim(Value);
end;

end.
