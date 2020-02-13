unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,
  Generics.Collections, Generics.Defaults,
  ACBrBase, ACBrDFe, ACBrNFe;

type
  TACBrNFeList = class(TObjectList<TACBrNFe>)
  end;

  TForm7 = class(TForm)
    ACBrNFe1: TACBrNFe;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    FACBrNFeList: TACBrNFeList;
    procedure GlobalExceptionHandler(Sender: TObject; E: Exception);
    procedure LotarMemoria;
  public
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
  Button1.Enabled := False;
  try
    LotarMemoria;
  finally
    Button1.Enabled := True;
  end;
end;

procedure TForm7.LotarMemoria;
var
  I, N: integer;
  LACBrNFe: TACBrNFe;
begin
  FACBrNFeList := TACBrNFeList.Create;
  try
    for I := 0 to 50000000 do
    begin
      LACBrNFe := TACBrNFe.Create(nil);
      FACBrNFeList.Add(LACBrNFe);

      for N := 0 to 10 do
        LACBrNFe.NotasFiscais.Add;

      Application.ProcessMessages;
      Self.Caption := I.ToString;
    end;
  except
    raise;
  end;
end;

procedure TForm7.GlobalExceptionHandler(Sender: TObject; E: Exception);
begin
  try
    ShowMessage(E.Message);
    FACBrNFeList.Clear;
    FreeAndNil(FACBrNFeList);
    ShowMessage('creu');
  except
  end;
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
  Application.OnException := GlobalExceptionHandler;
end;

end.
