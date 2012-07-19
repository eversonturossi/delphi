unit UDynamicMessageBox;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TDynamicMessageBox = class // create a dummy class
    procedure btnClick(Sender: TObject);
  private
    fOpcao: integer;
    FForm: TForm;
    function Converte(Arg: TVarRec): String;
  public

    function MensagemEscolha(AOwner: TComponent; Titulo, Mensagem: String; Args: array of const ): String;

    property Opcao: integer read fOpcao write fOpcao;
    property Form: TForm read FForm write FForm;
  end;

var
  EvHandler: TDynamicMessageBox;

implementation

{ TDynamicMessageBox }

procedure TDynamicMessageBox.btnClick(Sender: TObject);
begin
  fOpcao := TButton(Sender).Tag;
  Form.Close;
end;

function TDynamicMessageBox.Converte(Arg: TVarRec): String;
var
  PonteiroWideString: ^widestring;
  PonteiroWideChar: ^WideChar;
  PonteiroExtended: ^Extended;
  PonteiroVariant: ^Variant;
begin
  Result := 'nulo';
  case Arg.VType of
    vtInteger:
      Result := IntToStr(Arg.VInteger); // ok
    vtBoolean:
      Result := BoolToStr(Arg.VBoolean); // ok
    vtChar:
      Result := Arg.VChar; // nao usado
    vtExtended:
      begin
        PonteiroExtended := @Arg.vExtended;
        // vExtended := PonteiroExtended^;
        // Result := FloatToStr(PonteiroExtended^);
      end;
    vtString:
      Result := String(Arg.VString);
    vtPointer:
      Result := 'ponteiro';
    vtPChar:
      Result := Arg.VPChar;
    vtObject:
      Result := String(Arg.VObject);
    vtClass:
      Result := Arg.VClass.ClassName;
    vtWideChar:
      Result := Arg.VWideChar; // ok e tambem usado pelo ansichar
    vtPWideChar:
      begin
        PonteiroWideChar := @Arg.VPWideChar;
        // Result := Arg.VPWideChar^;
        // Result := WideCharToString(Arg.VPWideChar);
      end;
    vtAnsiString:
      Result := String(Arg.VAnsiString);
    vtCurrency:
      Result := String(Arg.VCurrency);
    vtVariant:
      begin
        PonteiroVariant := @Arg.VVariant;
        Result := VarToStr(PonteiroVariant^);
        // Result := String(Arg.VVariant);
      end;
    vtInterface:
      Result := 'interface';
    vtWideString:
      begin
        PonteiroWideString := @Arg.VWideString;
        Result := PonteiroWideString^;
      end;
    vtInt64:
      Result := String(Arg.VInt64);
    vtUnicodeString:
      Result := string(Arg.VUnicodeString);
  else
    ShowMessage(IntToStr(Arg.VType));
  end;
end;

function TDynamicMessageBox.MensagemEscolha(AOwner: TComponent; Titulo, Mensagem: String; Args: array of const ): String;
var
  I: integer;
  TypeStr: String;
  btn: TButton;
  pnl: TPanel;
  memo: TMemo;
begin
  try
    Form := TForm.Create(AOwner);
    Form.BorderStyle := bsDialog;
    Form.Position := poDesktopCenter;
    Form.Caption := Titulo;
    Form.Height := 200;
    Form.Width := 370;

    pnl := TPanel.Create(Form);
    pnl.Parent := Form;
    pnl.BevelOuter := bvNone;
    pnl.Color := $00D2D2D2;
    pnl.ParentBackground := False;
    pnl.Align := alBottom;
    pnl.Height := 50;
    pnl.Visible := True;
    pnl.Name := 'pnlXXXXXX';
    pnl.Caption := '';

    memo := TMemo.Create(Form);
    memo.Parent := Form;
    memo.Color := clWhite;
    memo.Top := 8;
    memo.Left := 8;
    memo.Height := 97;
    memo.Width := 340;
    memo.Visible := True;
    memo.BorderStyle := bsNone;
    memo.Enabled := False;

    I := Low(Args);
    while (I < High(Args)) do
    begin
      btn := TButton.Create(pnl);
      btn.Top := 12;
      btn.Left := (I * 100) + 2;
      btn.Caption := Converte(Args[I]);
      btn.Tag := I;
      btn.Visible := True;
      btn.Width := 100;
      btn.Height := 30;
      btn.Parent := pnl;
      btn.Name := 'btnDinamico' + IntToStr(I);
      btn.OnClick := btnClick;
      Inc(I, 1);
    end;

    Form.ShowModal;
    Result := IntToStr(fOpcao);
  finally
    FreeAndNil(FForm);
  end;
end;

end.
