unit ClassesEnum;

interface

uses
  Classes;

procedure EnumClasses(Strings: TStrings);

implementation

type
  TClassesEnum = class(TObject)
  private
    FStrings: TStrings;
    procedure GetClassesProc(AClass: TPersistentClass);
  public
    procedure EnumClasses(Strings: TStrings);
  end;

procedure EnumClasses(Strings: TStrings);
begin
  with TClassesEnum.Create do
    try
      EnumClasses(Strings);
    finally
      Free;
    end;
end;

{ TClassesEnum }

procedure TClassesEnum.EnumClasses(Strings: TStrings);
begin
  if not Assigned(Strings) then
    Exit;
  FStrings := Strings;
  with TClassFinder.Create(nil, True) do
    try
      GetClasses(GetClassesProc);
    finally
      Free;
    end;
end;

procedure TClassesEnum.GetClassesProc(AClass: TPersistentClass);
begin
  FStrings.Add(AClass.ClassName);
end;

end.
