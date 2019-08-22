unit ObjectClone;

interface

type
  TObjectClone = record
    class function From<T: class>(ASource: T): T; static;
  end;

implementation

uses
  SysUtils, Classes, TypInfo, RTTI, Controls;

class function TObjectClone.From<T>(ASource: T): T;
var
  LContext: TRttiContext;
  LisComponent, LLookOutForNameProp: Boolean;
  LRttiType: TRttiType;
  LMethod: TRttiMethod;
  LMinVisibility: TMemberVisibility;
  LParams: TArray<TRttiParameter>;
  LProp: TRttiProperty;
  LSourceAsPointer, LResultAsPointer: Pointer;
begin
  LRttiType := LContext.GetType(ASource.ClassType);

  // find a suitable constructor, though treat components specially
  LisComponent := (ASource is TComponent);
  for LMethod in LRttiType.GetMethods do
  begin
    if LMethod.IsConstructor then
    begin
      LParams := LMethod.GetParameters;
      if LParams = nil then
        Break;
      if (Length(LParams) = 1) and LisComponent and (LParams[0].ParamType is TRttiInstanceType) and SameText(LMethod.Name, 'Create') then
        Break;
    end;
  end;

  if LParams = nil then
    Result := LMethod.Invoke(ASource.ClassType, []).AsType<T>
  else
    Result := LMethod.Invoke(ASource.ClassType, [TComponent(ASource).Owner]).AsType<T>;

  try
    // many VCL control properties require the Parent property to be set first
    if ASource is TControl then
      TControl(Result).Parent := TControl(ASource).Parent;

    // loop through the props, copying values across for ones that are read/write
    Move(ASource, LSourceAsPointer, SizeOf(Pointer));
    Move(Result, LResultAsPointer, SizeOf(Pointer));
    LLookOutForNameProp := LisComponent and (TComponent(ASource).Owner <> nil);

    if LisComponent then
      LMinVisibility := mvPublished // an alternative is to build an exception list
    else
      LMinVisibility := mvPublic;

    for LProp in LRttiType.GetProperties do
    begin
      if (LProp.Visibility >= LMinVisibility) and LProp.IsReadable and LProp.IsWritable then
      begin
        if LLookOutForNameProp and (LProp.Name = 'Name') and (LProp.PropertyType is TRttiStringType) then
          LLookOutForNameProp := False
        else
          LProp.SetValue(LResultAsPointer, LProp.GetValue(LSourceAsPointer));
      end;
    end;
  except
    Result.Free;
    raise;
  end;
end;

end.
