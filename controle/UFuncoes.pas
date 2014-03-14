unit UFuncoes;

interface

function ConverterDataParaIntairo(d: string): integer;

implementation

uses SysUtils;

function ConverterDataParaIntairo(d: string): integer;
var
  S: string;
begin
  S := copy(d, 7, 10) + copy(d, 4, 5) + copy(d, 1, 2);
  Result := StrToInt(S);
end;

end.
