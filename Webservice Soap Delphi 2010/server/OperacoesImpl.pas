{ Invokable implementation File for TOperacoes which implements IOperacoes }

unit OperacoesImpl;

interface

uses InvokeRegistry, Types, XSBuiltIns, OperacoesIntf;

type

  { TOperacoes }
  TOperacoes = class(TInvokableClass, IOperacoes)
  public
    function echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
    function echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
    function echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
    function echoDouble(const Value: Double): Double; stdcall;
  end;

implementation

function TOperacoes.echoEnum(const Value: TEnumTest): TEnumTest; stdcall;
begin
  { TODO : Implement method echoEnum }
  Result := Value;
end;

function TOperacoes.echoDoubleArray(const Value: TDoubleArray): TDoubleArray; stdcall;
begin
  { TODO : Implement method echoDoubleArray }
  Result := Value;
end;

function TOperacoes.echoMyEmployee(const Value: TMyEmployee): TMyEmployee; stdcall;
begin
  { TODO : Implement method echoMyEmployee }
  Result := TMyEmployee.Create;
end;

function TOperacoes.echoDouble(const Value: Double): Double; stdcall;
begin
  { TODO : Implement method echoDouble }
  Result := Value;
end;


initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TOperacoes);
end.

