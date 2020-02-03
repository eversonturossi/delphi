unit UCampoList;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils,
  UCampo,
  Generics.Collections, Generics.Defaults;

type
  TCampoList = class(TObjectList<TCampo>)
  public
    function Text: String;
  end;

implementation

{ TCampoList }

function TCampoList.Text: String;
var
  I: Integer;
begin
  Result := '';
  for I := 0 to Pred(count) do
    Result := Result + Format('%S:%S', [Self[I].Nome, Self[I].Tipo]) + #13#10;
end;

end.
