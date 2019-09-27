unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin;

type
  TForm7 = class(TForm)
    ButtonGerar: TButton;
    SpinEditQuantidade: TSpinEdit;
    procedure ButtonGerarClick(Sender: TObject);
  private
    procedure GerarUnit(AGuid: String);
    function GetFileName(AGuid: String): String;
    function GetDiretorioProjeto: String; overload;
    function GetDiretorioUnit(AGuid: String): String; overload;
    procedure WriteLnFmt(const AArquivo: TextFile; ATexto: String; const AArgs: array of const); overload;
    procedure WriteLnFmt(const AArquivo: TextFile; ATexto: String); overload;
    procedure AdicionarProcedureLPR(AGuid: String);
    procedure AdicionarUnitLPI(AID: Int64; AGuid: String);
    procedure AdicionarUnitLPR(AID, ATotal: Int64; AGuid: String);
    procedure AdicionarUnitLPS(AID: Int64; AGuid: String);
    procedure Gerar(AQuantidade: Int64);
    procedure GerarLPI(ALista: TStringList);
    procedure GerarLPR(ALista: TStringList);
    procedure GerarLPS(ALista: TStringList);
    procedure FinicializarArquivos;
    procedure InicializarArquivos;
    function GetCaminhoUnidade(ALista: TStringList): String;
    function GetDiretorioTXT(AGuid: String): String;
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

procedure RemoverDuplicadosStringList(const ALista: TStringList);
{ remove duplicate strings from the string list
  http://delphi.about.com/od/delphitips2009/qt/remove-duplicat.htm }
var
  LBuffer: TStringList;
  I: Integer;
begin
  ALista.Sort;
  LBuffer := TStringList.Create;
  try
    LBuffer.Sorted := True;
    LBuffer.Duplicates := dupIgnore;
    LBuffer.BeginUpdate;
    for I := 0 to ALista.Count - 1 do
      LBuffer.add(ALista[I]);
    LBuffer.EndUpdate;
    ALista.Assign(LBuffer);
  finally
    FreeAndNil(LBuffer);
    ALista.Sort;
  end;
end;

function TForm7.GetDiretorioProjeto: String;
begin
  Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingBackslash(Result);
  Result := Result + 'projeto\';
end;

function TForm7.GetDiretorioUnit(AGuid: String): String;
begin
  Result := GetDiretorioProjeto;
  Result := Result + 'src\';
  Result := Result + GetGuid2(AGuid);;
  Result := Result + '\';
end;

function TForm7.GetDiretorioTXT(AGuid: String): String;
begin
  Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingBackslash(Result);
  Result := Result + 'projeto\TXT\';
  Result := Result + GetGuid2(AGuid) + '\';
end;

function TForm7.GetFileName(AGuid: String): String;
begin
  Result := GetDiretorioUnit(AGuid);
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
  I: Int64;
  LLinhas: Integer;
  LGuid, ADiterorioTXT: String;
begin
  LLinhas := RandomRange(1, 1000);
  ADiterorioTXT := GetDiretorioTXT(AGuid);
  try
    ForceDirectories(GetDiretorioUnit(AGuid));
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
    WriteLnFmt(LArquivoUnit, '  writeln(''%S - %D Linhas'');', [AGuid, LLinhas]);
    WriteLnFmt(LArquivoUnit, '  ForceDirectories(''%S'');', [ADiterorioTXT]);
    WriteLnFmt(LArquivoUnit, '  AssignFile(LTextFile, ''%S\%S.txt'');', [ADiterorioTXT, AGuid]);
    WriteLnFmt(LArquivoUnit, '  Rewrite(LTextFile);');
    for I := 0 to Pred(LLinhas) do
    begin
      LGuid := GuidCreate38;
      WriteLnFmt(LArquivoUnit, '  Writeln(LTextFile, ''%S'');', [LGuid]);
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
  WriteLnFmt(FArquivoLPI, '      <Unit%D>', [AID]);
  WriteLnFmt(FArquivoLPI, '        <Filename Value="src\%S\uclasse%S.pas"/>', [GetGuid2(AGuid), AnsiLowerCase(AGuid)]);
  WriteLnFmt(FArquivoLPI, '        <IsPartOfProject Value="True"/>');
  WriteLnFmt(FArquivoLPI, '        <UnitName Value="UClasse%S"/>', [AGuid]);
  WriteLnFmt(FArquivoLPI, '      </Unit%D>', [AID]);
end;

procedure TForm7.AdicionarUnitLPR(AID, ATotal: Int64; AGuid: String);
begin
  if ((AID + 1) < ATotal) then
    WriteLnFmt(FArquivoLPR, '  UClasse%S,', [AGuid])
  else
    WriteLnFmt(FArquivoLPR, '  UClasse%S;', [AGuid]);
end;

procedure TForm7.AdicionarUnitLPS(AID: Int64; AGuid: String);
begin
  WriteLnFmt(FArquivoLPS, '      <Unit%D>', [AID]);
  WriteLnFmt(FArquivoLPS, '        <Filename Value="src\%S\uclasse%S.pas"/>', [GetGuid2(AGuid), AGuid]);
  WriteLnFmt(FArquivoLPS, '        <IsPartOfProject Value="True"/>');
  WriteLnFmt(FArquivoLPS, '        <UnitName Value="UClasse%S"/>', [AGuid]);
  WriteLnFmt(FArquivoLPS, '        <EditorIndex Value="%D"/>', [AID]);
  WriteLnFmt(FArquivoLPS, '        <UsageCount Value="20"/>');
  WriteLnFmt(FArquivoLPS, '        <Loaded Value="True"/>');
  WriteLnFmt(FArquivoLPS, '      </Unit%D>', [AID]);
end;

procedure TForm7.AdicionarProcedureLPR(AGuid: String);
begin
  WriteLnFmt(FArquivoLPR, '  Procedure%S;', [AGuid]);
end;

function TForm7.GetCaminhoUnidade(ALista: TStringList): String;
var
  I: Int64;
  LLista: TStringList;
begin
  Result := '';
  LLista := TStringList.Create;
  try
    for I := 0 to Pred(ALista.Count) do
      LLista.add('src\' + GetGuid2(ALista[I]));

    RemoverDuplicadosStringList(LLista);

    for I := 0 to Pred(LLista.Count) do
    begin
      if (I > 0) then
        Result := Result + ';';
      Result := Result + LLista[I];
    end;

  finally
    FreeAndNil(LLista);
  end;

end;

procedure TForm7.GerarLPI(ALista: TStringList);
var
  I: Int64;
begin
  WriteLnFmt(FArquivoLPI, '<?xml version="1.0" encoding="UTF-8"?>');
  WriteLnFmt(FArquivoLPI, '<CONFIG>');
  WriteLnFmt(FArquivoLPI, '  <ProjectOptions>');
  WriteLnFmt(FArquivoLPI, '    <Version Value="11"/>');
  WriteLnFmt(FArquivoLPI, '    <PathDelim Value="\"/>');
  WriteLnFmt(FArquivoLPI, '    <General>');
  WriteLnFmt(FArquivoLPI, '      <Flags>');
  WriteLnFmt(FArquivoLPI, '        <MainUnitHasCreateFormStatements Value="False"/>');
  WriteLnFmt(FArquivoLPI, '        <MainUnitHasTitleStatement Value="False"/>');
  WriteLnFmt(FArquivoLPI, '        <MainUnitHasScaledStatement Value="False"/>');
  WriteLnFmt(FArquivoLPI, '      </Flags>');
  WriteLnFmt(FArquivoLPI, '      <SessionStorage Value="InProjectDir"/>');
  WriteLnFmt(FArquivoLPI, '      <MainUnit Value="0"/>');
  WriteLnFmt(FArquivoLPI, '      <Title Value="project1"/>');
  WriteLnFmt(FArquivoLPI, '      <UseAppBundle Value="False"/>');
  WriteLnFmt(FArquivoLPI, '      <ResourceType Value="res"/>');
  WriteLnFmt(FArquivoLPI, '    </General>');
  WriteLnFmt(FArquivoLPI, '    <BuildModes Count="1">');
  WriteLnFmt(FArquivoLPI, '      <Item1 Name="Default" Default="True"/>');
  WriteLnFmt(FArquivoLPI, '    </BuildModes>');
  WriteLnFmt(FArquivoLPI, '    <PublishOptions>');
  WriteLnFmt(FArquivoLPI, '      <Version Value="2"/>');
  WriteLnFmt(FArquivoLPI, '      <UseFileFilters Value="True"/>');
  WriteLnFmt(FArquivoLPI, '    </PublishOptions>');
  WriteLnFmt(FArquivoLPI, '    <RunParams>');
  WriteLnFmt(FArquivoLPI, '      <FormatVersion Value="2"/>');
  WriteLnFmt(FArquivoLPI, '      <Modes Count="0"/>');
  WriteLnFmt(FArquivoLPI, '    </RunParams>');
  WriteLnFmt(FArquivoLPI, '    <Units Count="%D">', [ALista.Count + 1]);
  WriteLnFmt(FArquivoLPI, '      <Unit0>');
  WriteLnFmt(FArquivoLPI, '        <Filename Value="project1.lpr"/>');
  WriteLnFmt(FArquivoLPI, '        <IsPartOfProject Value="True"/>');
  WriteLnFmt(FArquivoLPI, '      </Unit0>');

  for I := 0 to Pred(ALista.Count) do
    AdicionarUnitLPI(I + 1, ALista[I]);

  WriteLnFmt(FArquivoLPI, '    </Units>');
  WriteLnFmt(FArquivoLPI, '  </ProjectOptions>');
  WriteLnFmt(FArquivoLPI, '  <CompilerOptions>');
  WriteLnFmt(FArquivoLPI, '    <Version Value="11"/>');
  WriteLnFmt(FArquivoLPI, '    <PathDelim Value="\"/>');
  WriteLnFmt(FArquivoLPI, '    <Target>');
  WriteLnFmt(FArquivoLPI, '      <Filename Value="project1"/>');
  WriteLnFmt(FArquivoLPI, '    </Target>');
  WriteLnFmt(FArquivoLPI, '    <SearchPaths>');
  WriteLnFmt(FArquivoLPI, '      <IncludeFiles Value="$(ProjOutDir)"/>');
  WriteLnFmt(FArquivoLPI, '      <OtherUnitFiles Value="%S"/>', [GetCaminhoUnidade(ALista)]);
  WriteLnFmt(FArquivoLPI, '      <UnitOutputDirectory Value="lib\$(TargetCPU)-$(TargetOS)"/>');
  WriteLnFmt(FArquivoLPI, '    </SearchPaths>');
  WriteLnFmt(FArquivoLPI, '  </CompilerOptions>');
  WriteLnFmt(FArquivoLPI, '  <Debugging>');
  WriteLnFmt(FArquivoLPI, '    <Exceptions Count="3">');
  WriteLnFmt(FArquivoLPI, '      <Item1>');
  WriteLnFmt(FArquivoLPI, '        <Name Value="EAbort"/>');
  WriteLnFmt(FArquivoLPI, '      </Item1>');
  WriteLnFmt(FArquivoLPI, '      <Item2>');
  WriteLnFmt(FArquivoLPI, '        <Name Value="ECodetoolError"/>');
  WriteLnFmt(FArquivoLPI, '      </Item2>');
  WriteLnFmt(FArquivoLPI, '      <Item3>');
  WriteLnFmt(FArquivoLPI, '        <Name Value="EFOpenError"/>');
  WriteLnFmt(FArquivoLPI, '      </Item3>');
  WriteLnFmt(FArquivoLPI, '    </Exceptions>');
  WriteLnFmt(FArquivoLPI, '  </Debugging>');
  WriteLnFmt(FArquivoLPI, '</CONFIG>');
end;

procedure TForm7.GerarLPR(ALista: TStringList);
var
  I: Int64;
begin
  WriteLnFmt(FArquivoLPR, 'program project1;');
  WriteLnFmt(FArquivoLPR, '');
  WriteLnFmt(FArquivoLPR, 'uses');
  for I := 0 to Pred(ALista.Count) do
    AdicionarUnitLPR(I, ALista.Count, ALista[I]);
  WriteLnFmt(FArquivoLPR, '');
  WriteLnFmt(FArquivoLPR, 'begin');
  for I := 0 to Pred(ALista.Count) do
    AdicionarProcedureLPR(ALista[I]);
  WriteLnFmt(FArquivoLPR, 'end.');
end;

procedure TForm7.GerarLPS(ALista: TStringList);
var
  I: Int64;
begin
  WriteLnFmt(FArquivoLPS, '<?xml version="1.0" encoding="UTF-8"?>');
  WriteLnFmt(FArquivoLPS, '<CONFIG>');
  WriteLnFmt(FArquivoLPS, '  <ProjectSession>');
  WriteLnFmt(FArquivoLPS, '    <PathDelim Value="\"/>');
  WriteLnFmt(FArquivoLPS, '    <Version Value="11"/>');
  WriteLnFmt(FArquivoLPS, '    <BuildModes Active="Default"/>');
  WriteLnFmt(FArquivoLPS, '    <Units Count="%D">', [ALista.Count + 1]);
  WriteLnFmt(FArquivoLPS, '      <Unit0>');
  WriteLnFmt(FArquivoLPS, '        <Filename Value="project1.lpr"/>');
  WriteLnFmt(FArquivoLPS, '        <IsPartOfProject Value="True"/>');
  WriteLnFmt(FArquivoLPS, '        <IsVisibleTab Value="True"/>');
  WriteLnFmt(FArquivoLPS, '        <UsageCount Value="20"/>');
  WriteLnFmt(FArquivoLPS, '        <Loaded Value="True"/>');
  WriteLnFmt(FArquivoLPS, '      </Unit0>');
  for I := 0 to Pred(ALista.Count) do
    AdicionarUnitLPS(I + 1, ALista[I]);
  WriteLnFmt(FArquivoLPS, '    </Units>');
  WriteLnFmt(FArquivoLPS, '    <JumpHistory HistoryIndex="-1"/>');
  WriteLnFmt(FArquivoLPS, '    <RunParams>');
  WriteLnFmt(FArquivoLPS, '      <FormatVersion Value="2"/>');
  WriteLnFmt(FArquivoLPS, '      <Modes Count="0" ActiveMode=""/>');
  WriteLnFmt(FArquivoLPS, '    </RunParams>');
  WriteLnFmt(FArquivoLPS, '  </ProjectSession>');
  WriteLnFmt(FArquivoLPS, '</CONFIG>');
end;

procedure TForm7.InicializarArquivos;
begin
  AssignFile(FArquivoLPI, GetDiretorioProjeto + 'project1.lpi');
  Rewrite(FArquivoLPI);

  AssignFile(FArquivoLPR, GetDiretorioProjeto + 'project1.lpr');
  Rewrite(FArquivoLPR);

  AssignFile(FArquivoLPS, GetDiretorioProjeto + 'project1.lps');
  Rewrite(FArquivoLPS);
end;

procedure TForm7.FinicializarArquivos;
begin
  CloseFile(FArquivoLPI);
  CloseFile(FArquivoLPR);
  CloseFile(FArquivoLPS);
end;

procedure TForm7.Gerar(AQuantidade: Int64);
var
  I: Integer;
  LGuid: String;
  FLista: TStringList;
begin
  FLista := TStringList.Create;
  try
    ForceDirectories(GetDiretorioProjeto());
    for I := 0 to Pred(AQuantidade) do
    begin
      LGuid := GuidCreate32;
      FLista.add(LGuid);
      GerarUnit(LGuid);
    end;

    InicializarArquivos;
    GerarLPI(FLista);
    GerarLPR(FLista);
    GerarLPS(FLista);
  finally
    FinicializarArquivos;
    FreeAndNil(FLista);
  end;
end;

procedure TForm7.ButtonGerarClick(Sender: TObject);
begin
  TButton(Sender).Enabled := False;
  Application.ProcessMessages;
  try
    Self.Gerar(SpinEditQuantidade.Value);
  finally
    TButton(Sender).Enabled := True;
  end;
end;

end.
