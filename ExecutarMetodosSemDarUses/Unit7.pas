unit Unit7;
{
  Fonte:
  https://showdelphi.com.br/executar-metodos-de-classe-pelo-nome-e-sem-precisar-dar-uses-da-unit/
  https://stackoverflow.com/questions/8102255/delphi-dynamically-calling-different-functions
}

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, rtti;

type
  { Classe de exemplo, normalmente estará em outra unit }
  TExemploClasse = class(TPersistent)
    class function Teste(ANumber: Integer): string;
  end;

  TForm7 = class(TForm)
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

function ExecuteAwayMethod(ClassName, MethodName: string; MethosParams: array of TValue): TValue;
var
  ctx: TRttiContext;
  lType: TRttiType;
  lMethod: TRttiMethod;
  vClass: TClass;
begin
  ctx := TRttiContext.Create;
  vClass := FindClass(ClassName);

  lType := ctx.GetType(vClass);
  Result := nil;
  try
    if Assigned(lType) then
    begin
      lMethod := lType.GetMethod(MethodName);

      if Assigned(lMethod) then
        Result := lMethod.Invoke(vClass, MethosParams);
    end;
  finally
    lMethod.Free;
    lType.Free;
    ctx.Free;
  end;
end;

procedure TForm7.Button1Click(Sender: TObject);
var
  vValue, vResult: TValue;
begin
  vValue := 10;

  vResult := ExecuteAwayMethod('TExemploClasse', 'Teste', vValue);

  ShowMessage(vResult.AsString);
end;

{ TExemploClasse }

class function TExemploClasse.Teste(ANumber: Integer): string;
begin
  Result := ANumber.ToString;
end;

{ Para uso deste exemplo, a classe precisa estar registrada }
initialization

RegisterClass(TExemploClasse);

end.
