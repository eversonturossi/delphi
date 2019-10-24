unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TForm7 = class(TForm)
    Panel1: TPanel;
    ButtonListarExcluir: TButton;
    ListBoxTempFiles: TListBox;
    procedure ButtonListarExcluirClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  ACBrUtil, System.IOUtils;

{$R *.dfm}

procedure ListarArquivosDiretorio(ADiretorio: String; var ALista: TStringList);

  function TemAtributo(AAttr, AVal: Integer): Boolean;
  begin
    Result := AAttr and AVal = AVal;
  end;

var
  F: TSearchRec;
  LRet: Integer;
  LTempNome: String;
begin
  LRet := FindFirst(ADiretorio + '\*.*', faAnyFile, F);
  try
    while (LRet = 0) do
    begin
      if (TemAtributo(F.Attr, faDirectory)) then
      begin
        if (F.Name <> '.') and (F.Name <> '..') then
        begin
          LTempNome := ADiretorio + '\' + F.Name;
          ListarArquivosDiretorio(LTempNome, ALista);
        end;
      end
      else
        ALista.Add(ADiretorio + '\' + F.Name);
      LRet := FindNext(F);
    end;
  finally
    FindClose(F);
  end;
end;

procedure Reciclar(const AArquivos: TStringList);
var
  I: Integer;
begin
  for I := 0 to Pred(AArquivos.Count) do
  begin
    try
      DeleteFile(AArquivos[I]);
    except
    end;
  end;
end;

function GetWincryptDiretorioTemporario: String; { http://docwiki.embarcadero.com/RADStudio/XE7/en/Standard_RTL_Path_Functions_across_the_Supported_Target_Platforms }
begin
  Result := PathWithoutDelim(TPath.GetHomePath) + '\Microsoft\Crypto\RSA\';
end;

procedure TForm7.ButtonListarExcluirClick(Sender: TObject);
var
  LArquivos: TStringList;
  LDiretorio: String;
begin
  TButton(Sender).Enabled := False;
  LArquivos := TStringList.Create;
  ListBoxTempFiles.Clear;
  LDiretorio := GetWincryptDiretorioTemporario();
  try
    ListarArquivosDiretorio(LDiretorio, LArquivos);
    ListBoxTempFiles.Items.AddStrings(LArquivos);
    Reciclar(LArquivos);
  finally
    FreeAndNil(LArquivos);
    TButton(Sender).Enabled := True;
  end;
end;

end.
