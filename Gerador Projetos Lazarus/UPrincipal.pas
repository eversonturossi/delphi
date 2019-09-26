unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TForm7 = class(TForm)
    Button1: TButton;
    SpinEditQuantidade: TSpinEdit;
    procedure Button1Click(Sender: TObject);
  private
    procedure GerarUnit(AGuid: String);
    function GetFileName(AGuid: String): String;
    function GetDiretorio: String;
    procedure WriteLnFmt(const AArquivo: TextFile; ATexto: String; const AArgs: array of const); overload;
    procedure WriteLnFmt(const AArquivo: TextFile; ATexto: String); overload;
    procedure AdicionarProcedureLPR(AGuid: String);
    procedure AdicionarUnitLPI(AID: Int64; AGuid: String);
    procedure AdicionarUnitLPR(AID: Int64; AGuid: String);
    procedure AdicionarUnitLPS(AID: Int64; AGuid: String);
    procedure Gerar(AQuantidade: Int64);
    procedure GerarLPI(ALista: TStringList);
    procedure GerarLPR(ALista: TStringList);
    procedure GerarLPS(ALista: TStringList);
  public
    FArquivoLPI: TextFile;
    FArquivoLPR: TextFile;
    FArquivoLPS: TextFile;
  end;

var
  Form7: TForm7;

implementation

uses
  UGUID, Math;

{$R *.dfm}

function TForm7.GetDiretorio: String;
begin
  Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingBackslash(Result);
  Result := Result + 'src\';
end;

function TForm7.GetFileName(AGuid: String): String;
begin
  Result := GetDiretorio();
  Result := Result + 'UClasse' + AGuid + '.pas';
end;

procedure TForm7.WriteLnFmt(const AArquivo: TextFile; ATexto: String);
begin
  Writeln(AArquivo, ATexto);
end;

procedure TForm7.WriteLnFmt(const AArquivo: TextFile; ATexto: String; const AArgs: array of const);
begin
  Writeln(AArquivo, Format(ATexto, AArgs));
end;

procedure TForm7.GerarUnit(AGuid: String);
var
  LArquivoUnit: TextFile;
  I, LRandom: Integer;
  LGuid: String;
begin
  LRandom := RandomRange(1, 100);
  try
    AssignFile(LArquivoUnit, GetFileName(AGuid));
    Rewrite(LArquivoUnit);
    WriteLnFmt(LArquivoUnit, 'unit UClasse%S;', [AGuid]);
    WriteLnFmt(LArquivoUnit, '{$mode objfpc}{$H+}');
    WriteLnFmt(LArquivoUnit, 'interface');
    WriteLnFmt(LArquivoUnit, 'uses');
    WriteLnFmt(LArquivoUnit, '  Classes, SysUtils;');
    WriteLnFmt(LArquivoUnit, 'procedure Procedure%S;', [AGuid]);
    WriteLnFmt(LArquivoUnit, 'implementation');
    WriteLnFmt(LArquivoUnit, 'procedure Procedure%S;', [AGuid]);
    WriteLnFmt(LArquivoUnit, 'var');
    WriteLnFmt(LArquivoUnit, '  LTextFile: TextFile;');
    WriteLnFmt(LArquivoUnit, 'begin');
    WriteLnFmt(LArquivoUnit, '  AssignFile(LTextFile, %S.txt);', [AGuid]);
    WriteLnFmt(LArquivoUnit, '  Rewrite(LTextFile);');
    for I := 0 to Pred(LRandom) do
    begin
      LGuid := GuidCreate38;
      WriteLnFmt(LArquivoUnit, '  Writeln(LTextFile, %S)', [LGuid]);
    end;
    WriteLnFmt(LArquivoUnit, '  CloseFile(LTextFile);');
    WriteLnFmt(LArquivoUnit, 'end;');
    WriteLnFmt(LArquivoUnit, 'end.');
  finally
    CloseFile(LArquivoUnit);
  end;
end;

procedure TForm7.AdicionarUnitLPI(AID: Int64; AGuid: String);
begin
  WriteLnFmt(FArquivoLPI, '<Unit%D>', [AID]);
  WriteLnFmt(FArquivoLPI, '<Filename Value="uclasse%S.pas"/>', [AGuid]);
  WriteLnFmt(FArquivoLPI, '<IsPartOfProject Value="True"/>');
  WriteLnFmt(FArquivoLPI, '<UnitName Value="UClasse%S"/>', [AGuid]);
  WriteLnFmt(FArquivoLPI, '</Unit%D>', [AID]);
end;

procedure TForm7.AdicionarUnitLPR(AID: Int64; AGuid: String);
begin

end;

procedure TForm7.AdicionarUnitLPS(AID: Int64; AGuid: String);
begin
  WriteLnFmt(FArquivoLPS, '<Unit%D>', [AID]);
  WriteLnFmt(FArquivoLPS, '<Filename Value="uclasse%S.pas"/>', [AGuid]);
  WriteLnFmt(FArquivoLPS, '<IsPartOfProject Value="True"/>');
  WriteLnFmt(FArquivoLPS, '<UnitName Value="UClasse%S"/>', [AGuid]);
  WriteLnFmt(FArquivoLPS, '<EditorIndex Value="%D"/>', [AID]);
  WriteLnFmt(FArquivoLPS, '<UsageCount Value="20"/>');
  WriteLnFmt(FArquivoLPS, '<Loaded Value="True"/>');
  WriteLnFmt(FArquivoLPS, '</Unit%D>', [AID]);
end;

procedure TForm7.AdicionarProcedureLPR(AGuid: String);
begin

end;

procedure TForm7.GerarLPI(ALista: TStringList);
begin

end;

procedure TForm7.GerarLPR(ALista: TStringList);
begin

end;

procedure TForm7.GerarLPS(ALista: TStringList);
begin

end;

procedure TForm7.Gerar(AQuantidade: Int64);
var
  I: Integer;
  LGuid: String;
  FLista: TStringList;
begin
  FLista := TStringList.Create;
  try
    ForceDirectories(GetDiretorio);
    for I := 0 to Pred(AQuantidade) do
    begin
      LGuid := GuidCreate32;
      FLista.Add(LGuid);
      GerarUnit(LGuid);
    end;

    GerarLPI(FLista);
    GerarLPR(FLista);
    GerarLPS(FLista);
  finally
    FreeandNil(FLista);
  end;
end;

procedure TForm7.Button1Click(Sender: TObject);
begin
  Button1.Enabled := False;
  Application.ProcessMessages;
  try
    Self.Gerar(SpinEditQuantidade.Value);
  finally
    Button1.Enabled := True;
  end;
end;

end.
