unit UExemploIni;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IniFiles;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    ListBox1: TListBox;
    Button5: TButton;
    Button6: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    FCaminho: String;
    FIni: TiniFile;
  public
    property Caminho: String read FCaminho write FCaminho;
    property Ini: TiniFile read FIni write FIni;
    constructor Create(AOwner: TComponent); override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  try
    FIni := TiniFile.Create(Caminho);
    FIni.WriteString('sessao1', 'variavel1', 'valor1');
    FIni.WriteString('sessao2', 'variavel1', 'valor1');
    FIni.WriteString('sessao3', 'variavel1', 'valor1');
  finally
    FreeAndNil(FIni);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  S: String;
begin
  if FileExists(Caminho) then
  begin
    try
      FIni := TiniFile.Create(Caminho);
      S := Ini.ReadString('sessao1', 'variavel1', '');
      if (S <> EmptyStr) then
        ShowMessage(S);
    finally
      FreeAndNil(FIni);
    end;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  St: TStringList;
begin
  try
    FIni := TiniFile.Create(Caminho);
    St := TStringList.Create;
    FIni.ReadSections(St);
    ShowMessage(inttostr(St.Count));
  finally
    FreeAndNil(FIni);
    FreeAndNil(St);
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  try
    FIni := TiniFile.Create(Caminho);
    if FIni.SectionExists('sessao1') then
      ShowMessage('existe sessao')
    else
      ShowMessage('nao existe sessao');
  finally
    FreeAndNil(FIni);
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
begin
  try
    FIni := TiniFile.Create(Caminho);
    FIni.ReadSectionValues('sessao1', ListBox1.Items);
    // FIni.ReadSubSections('sessao1', ListBox1.Items);
  finally
    FreeAndNil(FIni);
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
begin
  try
    FIni := TiniFile.Create(Caminho);
    FIni.EraseSection('sessao1');
    FIni.EraseSection('sessao2');
  finally
    FreeAndNil(FIni);
  end;
end;

constructor TForm1.Create(AOwner: TComponent);
begin
  inherited;
  Caminho := ExtractFilePath(ParamStr(0)) + '\meu_ini.ini';
end;

end.
