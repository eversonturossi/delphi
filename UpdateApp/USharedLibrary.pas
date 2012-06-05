unit USharedLibrary;

interface

function ExistText(Word, Text: String): Boolean;

implementation

function ExistText(Word, Text: String): Boolean;
begin
  if (Pos(Word, Text) > 0) then
    Result := True
  else
    Result := False;
end;

end.
