unit UDynamicMessageDlg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

const
  DefaultWidth = 370;
  DefaultHeight = 200;

type
  TDynamicMessageDlg = class
    procedure btnClick(Sender: TObject);
  private
    fOpcao: String;
    fForm: TForm;
    fFormHeight: Integer;
    fFormWidth: Integer;
    fValues: TStringList;
    function Converte(Arg: TVarRec): String;
    property Form: TForm read fForm write fForm;
    property Values: TStringList read fValues;
  public
    Constructor Create();
    Destructor Destroy; override;
    function MensagemEscolha(AOwner: TComponent; ATitle, ACaption: String; AItens, AValues: array of const ): String;
    property Opcao: String read fOpcao;
    property FormWidth: Integer read fFormWidth write fFormWidth;
    property FormHeight: Integer read fFormHeight write fFormHeight;
  end;

function DynamicMessageDlg(AOwner: TComponent; ATitle, ACaption: String; AItens, AValues: array of const ): String;

var
  EvHandler: TDynamicMessageDlg;

implementation

function DynamicMessageDlg(AOwner: TComponent; ATitle, ACaption: String; AItens, AValues: array of const ): String;
var
  DynamicMessageDlg: TDynamicMessageDlg;
begin
  try
    DynamicMessageDlg := TDynamicMessageDlg.Create;
    Result := DynamicMessageDlg.MensagemEscolha(AOwner, ATitle, ACaption, AItens, AValues);
  finally
    FreeAndNil(DynamicMessageDlg);
  end;
end;

{ TDynamicMessageDlg }

procedure TDynamicMessageDlg.btnClick(Sender: TObject);
var
  IndexButton: Integer;
begin
  IndexButton := TButton(Sender).Tag;
  fOpcao := Values[IndexButton];
  Form.Close;
end;

function TDynamicMessageDlg.Converte(Arg: TVarRec): String;
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

constructor TDynamicMessageDlg.Create;
begin
  fOpcao := '';
  FormHeight := DefaultHeight;
  FormWidth := DefaultWidth;
  fValues := TStringList.Create;
end;

destructor TDynamicMessageDlg.Destroy;
begin
  FreeAndNil(fValues);
  FreeAndNil(fForm);
  inherited;
end;

function TDynamicMessageDlg.MensagemEscolha(AOwner: TComponent; ATitle, ACaption: String; AItens, AValues: array of const ): String;
var
  I, X: Integer;
  TypeStr: String;
  btn: TButton;
  pnlBottom, pnlTop: TPanel;
  memo: TMemo;
  buttonWidth: Integer;
begin
  try
    if (Length(AItens) <> Length(AValues)) then
      raise Exception.Create('Array Values deve ter o mesmo tamanho do array Itens');

    Form := TForm.Create(AOwner);
    Form.BorderStyle := bsDialog;
    Form.Caption := ATitle;
    Form.Height := FormHeight;
    Form.Width := FormWidth;
    Form.Position := poDesktopCenter;

    pnlBottom := TPanel.Create(Form);
    pnlBottom.Align := alBottom;
    pnlBottom.BevelOuter := bvNone;
    pnlBottom.Color := $00F3F3F3;
    pnlBottom.Height := 39;
    pnlBottom.Name := 'pnlBottom';
    pnlBottom.Parent := Form;
    pnlBottom.ParentBackground := False;
    pnlBottom.Visible := True;
    pnlBottom.Caption := '';

    pnlTop := TPanel.Create(Form);
    pnlTop.Align := alClient;
    pnlTop.BevelOuter := bvNone;
    pnlTop.BorderWidth := 8;
    pnlTop.Color := clBtnFace;
    pnlTop.Name := 'pnlTop';
    pnlTop.Parent := Form;
    pnlTop.ParentBackground := False;
    pnlTop.Visible := True;
    pnlTop.Caption := '';

    memo := TMemo.Create(pnlTop);
    memo.Align := alClient;
    memo.BorderStyle := bsNone;
    memo.Color := clBtnFace;
    memo.Font.Size := 10;
    memo.Parent := pnlTop;
    memo.ReadOnly := True;
    memo.Visible := True;
    memo.Lines.Add(ACaption);

    buttonWidth := 100;
    I := High(AItens);
    X := 1;
    while (I >= Low(AItens)) do
    begin
      btn := TButton.Create(pnlBottom);
      btn.Caption := Converte(AItens[I]);
      btn.Height := 30;
      btn.Left := pnlBottom.Width - ((X * buttonWidth) + (8 * X));
      btn.Name := 'btnDinamico' + IntToStr(I);
      btn.Parent := pnlBottom;
      btn.Tag := I;
      btn.Top := 1;
      btn.Visible := True;
      btn.Width := buttonWidth;
      btn.OnClick := btnClick;
      I := I - 1;
      X := X + 1;
    end;
    for I := Low(AValues) to High(AValues) do
      fValues.Add(Converte(AValues[I]));
    Form.ShowModal;
    Result := fOpcao;
  finally
    FreeAndNil(fForm);
  end;
end;

end.
