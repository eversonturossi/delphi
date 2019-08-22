unit ObjectClone;

interface

type
  TObjectClone = record
    class function From<T: class>(Source: T): T; static;
  end;

implementation

uses
  SysUtils, Classes, TypInfo, RTTI, Controls;

class function TObjectClone.From<T>(Source: T): T;
var
  Context: TRttiContext;
  IsComponent, LookOutForNameProp: Boolean;
  RttiType: TRttiType;
  Method: TRttiMethod;
  MinVisibility: TMemberVisibility;
  Params: TArray<TRttiParameter>;
  Prop: TRttiProperty;
  SourceAsPointer, ResultAsPointer: Pointer;
begin
  RttiType := Context.GetType(Source.ClassType);
  // find a suitable constructor, though treat components specially
  IsComponent := (Source is TComponent);
  for Method in RttiType.GetMethods do
    if Method.IsConstructor then
    begin
      Params := Method.GetParameters;
      if Params = nil then
        Break;
      if (Length(Params) = 1) and IsComponent and (Params[0].ParamType is TRttiInstanceType) and SameText(Method.Name, 'Create') then
        Break;
    end;
  if Params = nil then
    Result := Method.Invoke(Source.ClassType, []).AsType<T>
  else
    Result := Method.Invoke(Source.ClassType, [TComponent(Source).Owner]).AsType<T>;
  try
    // many VCL control properties require the Parent property to be set first
    if Source is TControl then
      TControl(Result).Parent := TControl(Source).Parent;
    // loop through the props, copying values across for ones that are read/write
    Move(Source, SourceAsPointer, SizeOf(Pointer));
    Move(Result, ResultAsPointer, SizeOf(Pointer));
    LookOutForNameProp := IsComponent and (TComponent(Source).Owner <> nil);
    if IsComponent then
      MinVisibility := mvPublished // an alternative is to build an exception list
    else
      MinVisibility := mvPublic;
    for Prop in RttiType.GetProperties do
      if (Prop.Visibility >= MinVisibility) and Prop.IsReadable and Prop.IsWritable then
        if LookOutForNameProp and (Prop.Name = 'Name') and (Prop.PropertyType is TRttiStringType) then
          LookOutForNameProp := False
        else
          Prop.SetValue(ResultAsPointer, Prop.GetValue(SourceAsPointer));
  except
    Result.Free;
    raise;
  end;
end;

end.
