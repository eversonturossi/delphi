unit UPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Samples.Spin,
  Vcl.ComCtrls;

type
  TFormGerador = class(TForm)
    ButtonGerar: TButton;
    SpinEditClasses: TSpinEdit;
    Label1: TLabel;
    SpinEditLinhaMin: TSpinEdit;
    Label2: TLabel;
    SpinEditLinhaMax: TSpinEdit;
    Label3: TLabel;
    ProgressBar1: TProgressBar;
    ButtonParar: TButton;
    procedure ButtonGerarClick(Sender: TObject);
    procedure ButtonPararClick(Sender: TObject);
  private
    FExecutando: Boolean;
    procedure GerarUnit(AGuid: String; AQuantidadeLinhaMin, AQuantidadeLinhaMax: Integer);
    function GetFileName(AGuid: String): String;
    function GetDiretorioProjeto: String; overload;
    function GetDiretorioUnit(AGuid: String): String; overload;
    procedure WriteLnFmt(const AArquivo: TextFile; ATexto: String; const AArgs: array of const); overload;
    procedure WriteLnFmt(const AArquivo: TextFile; ATexto: String); overload;
    procedure AdicionarProcedureLPR(AGuid: String);
    procedure AdicionarUnitLPI(AID: Integer; AGuid: String);
    procedure AdicionarUnitLPR(AID, ATotal: Integer; AGuid: String);
    procedure AdicionarUnitLPS(AID: Integer; AGuid: String);
    procedure Gerar(AQuantidadeClasse, AQuantidadeLinhaMin, AQuantidadeLinhaMax: Integer);
    procedure GerarLPI(ALista: TStringList);
    procedure GerarLPR(ALista: TStringList);
    procedure GerarLPS(ALista: TStringList);
    procedure FinicializarArquivos;
    procedure InicializarArquivos;
    function GetCaminhoUnidade(ALista: TStringList): String;
    function GetDiretorioTXT(AGuid: String): String;
    procedure GerarDPR(ALista: TStringList);
    procedure AdicionarUnitDPR(AID, ATotal: Integer; AGuid: String);
    procedure AdicionarProcedureDPR(AGuid: String);
    procedure GerarDPROJ(ALista: TStringList);
  public
    FArquivoLPI: TextFile;
    FArquivoLPR: TextFile;
    FArquivoLPS: TextFile;
    FArquivoDPR: TextFile;
    FArquivoDPROJ: TextFile;
  end;

var
  FormGerador: TFormGerador;

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

function TFormGerador.GetDiretorioProjeto: String;
begin
  Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingBackslash(Result);
  Result := Result + 'projeto\';
end;

function TFormGerador.GetDiretorioUnit(AGuid: String): String;
begin
  Result := GetDiretorioProjeto;
  Result := Result + 'src\';
  Result := Result + GetGuid2(AGuid);;
  Result := Result + '\';
end;

function TFormGerador.GetDiretorioTXT(AGuid: String): String;
begin
  Result := ExtractFilePath(ParamStr(0));
  Result := IncludeTrailingBackslash(Result);
  Result := Result + 'projeto\txt\';
  Result := Result + GetGuid2(AGuid) + '\';
end;

function TFormGerador.GetFileName(AGuid: String): String;
begin
  Result := GetDiretorioUnit(AGuid);
  Result := Result + 'UClasse' + AGuid + '.pas';
end;

procedure TFormGerador.WriteLnFmt(const AArquivo: TextFile; ATexto: String);
begin
  Writeln(AArquivo, ATexto);
end;

procedure TFormGerador.WriteLnFmt(const AArquivo: TextFile; ATexto: String; const AArgs: array of const);
begin
  Writeln(AArquivo, Format(ATexto, AArgs));
end;

procedure TFormGerador.GerarUnit(AGuid: String; AQuantidadeLinhaMin, AQuantidadeLinhaMax: Integer);
var
  LArquivoUnit: TextFile;
  I: Integer;
  LLinhas: Integer;
  LGuid: String;
begin
  LLinhas := RandomRange(AQuantidadeLinhaMin, AQuantidadeLinhaMax);
  try
    ForceDirectories(GetDiretorioUnit(AGuid));
    AssignFile(LArquivoUnit, GetFileName(AGuid));
    Rewrite(LArquivoUnit);
    WriteLnFmt(LArquivoUnit, 'unit UClasse%S;', [AGuid]);
    WriteLnFmt(LArquivoUnit, '');
    WriteLnFmt(LArquivoUnit, '{$IFDEF FPC}{$mode objfpc}{$H+}{$ENDIF}');
    WriteLnFmt(LArquivoUnit, '');
    WriteLnFmt(LArquivoUnit, 'interface');
    WriteLnFmt(LArquivoUnit, '');
    WriteLnFmt(LArquivoUnit, 'uses');
    WriteLnFmt(LArquivoUnit, '{$IFDEF FPC}');
    WriteLnFmt(LArquivoUnit, '  Classes, SysUtils;');
    WriteLnFmt(LArquivoUnit, '{$ELSE}');
    WriteLnFmt(LArquivoUnit, '  System.Classes, System.SysUtils;');
    WriteLnFmt(LArquivoUnit, '{$ENDIF}');
    WriteLnFmt(LArquivoUnit, '');
    WriteLnFmt(LArquivoUnit, 'procedure Procedure%S;', [AGuid]);
    WriteLnFmt(LArquivoUnit, '');
    WriteLnFmt(LArquivoUnit, 'implementation');
    WriteLnFmt(LArquivoUnit, '');

    WriteLnFmt(LArquivoUnit, '');
    WriteLnFmt(LArquivoUnit, 'function GetDiretorioTXT%S:String;', [AGuid]);
    WriteLnFmt(LArquivoUnit, 'begin');
    WriteLnFmt(LArquivoUnit, '  Result := ExtractFilePath(ParamStr(0));');
    WriteLnFmt(LArquivoUnit, '  Result := IncludeTrailingBackslash(Result);');
    WriteLnFmt(LArquivoUnit, '  Result := Result + ''txt\'';');
    WriteLnFmt(LArquivoUnit, '  Result := Result + ''%S'';', [GetGuid2(AGuid)]);
    WriteLnFmt(LArquivoUnit, 'end;');
    WriteLnFmt(LArquivoUnit, '');
    WriteLnFmt(LArquivoUnit, 'procedure Procedure%S;', [AGuid]);
    WriteLnFmt(LArquivoUnit, 'var');
    WriteLnFmt(LArquivoUnit, '  LTextFile: TextFile;');
    WriteLnFmt(LArquivoUnit, '  LDiterorioTXT: String;');
    WriteLnFmt(LArquivoUnit, 'begin');
    WriteLnFmt(LArquivoUnit, '  LDiterorioTXT := GetDiretorioTXT%S;', [AGuid]);
    WriteLnFmt(LArquivoUnit, '  writeln(''%S - %D Linhas'');', [AGuid, LLinhas]);
    WriteLnFmt(LArquivoUnit, '  ForceDirectories(LDiterorioTXT);');
    WriteLnFmt(LArquivoUnit, '  AssignFile(LTextFile, LDiterorioTXT + ''\%S.txt'');', [AGuid]);
    WriteLnFmt(LArquivoUnit, '  Rewrite(LTextFile);');
    for I := 0 to Pred(LLinhas) do
    begin
      LGuid := GuidCreate38;
      WriteLnFmt(LArquivoUnit, '  Writeln(LTextFile, ''%S'');', [LGuid]);
    end;
    WriteLnFmt(LArquivoUnit, '  CloseFile(LTextFile);');
    WriteLnFmt(LArquivoUnit, 'end;');
    WriteLnFmt(LArquivoUnit, '');
    WriteLnFmt(LArquivoUnit, 'end.');
  finally
    CloseFile(LArquivoUnit);
  end;
end;

procedure TFormGerador.AdicionarUnitLPI(AID: Integer; AGuid: String);
begin
  WriteLnFmt(FArquivoLPI, '      <Unit%D>', [AID]);
  WriteLnFmt(FArquivoLPI, '        <Filename Value="src\%S\uclasse%S.pas"/>', [GetGuid2(AGuid), AnsiLowerCase(AGuid)]);
  WriteLnFmt(FArquivoLPI, '        <IsPartOfProject Value="True"/>');
  WriteLnFmt(FArquivoLPI, '        <UnitName Value="UClasse%S"/>', [AGuid]);
  WriteLnFmt(FArquivoLPI, '      </Unit%D>', [AID]);
end;

procedure TFormGerador.AdicionarUnitLPR(AID, ATotal: Integer; AGuid: String);
begin
  if ((AID + 1) < ATotal) then
    WriteLnFmt(FArquivoLPR, '  UClasse%S,', [AGuid])
  else
    WriteLnFmt(FArquivoLPR, '  UClasse%S;', [AGuid]);
end;

procedure TFormGerador.AdicionarUnitLPS(AID: Integer; AGuid: String);
begin
  WriteLnFmt(FArquivoLPS, '      <Unit%D>', [AID]);
  WriteLnFmt(FArquivoLPS, '        <Filename Value="src\%S\uclasse%S.pas"/>', [GetGuid2(AGuid), AGuid]);
  WriteLnFmt(FArquivoLPS, '        <IsPartOfProject Value="True"/>');
  WriteLnFmt(FArquivoLPS, '        <UnitName Value="UClasse%S"/>', [AGuid]);
  WriteLnFmt(FArquivoLPS, '        <EditorIndex Value="-1"/>');
  WriteLnFmt(FArquivoLPS, '        <UsageCount Value="20"/>');
  WriteLnFmt(FArquivoLPS, '        <Loaded Value="True"/>');
  WriteLnFmt(FArquivoLPS, '      </Unit%D>', [AID]);
end;

procedure TFormGerador.AdicionarProcedureLPR(AGuid: String);
begin
  WriteLnFmt(FArquivoLPR, '  Procedure%S;', [AGuid]);
end;

function TFormGerador.GetCaminhoUnidade(ALista: TStringList): String;
var
  I: Integer;
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

procedure TFormGerador.GerarLPI(ALista: TStringList);
var
  I: Integer;
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
  WriteLnFmt(FArquivoLPI, '      <Title Value="Lazarus"/>');
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
  WriteLnFmt(FArquivoLPI, '        <Filename Value="Lazarus.lpr"/>');
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
  WriteLnFmt(FArquivoLPI, '      <Filename Value="Lazarus"/>');
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

procedure TFormGerador.GerarLPR(ALista: TStringList);
var
  I: Integer;
begin
  WriteLnFmt(FArquivoLPR, 'program lazarus;');
  WriteLnFmt(FArquivoLPR, '');
  WriteLnFmt(FArquivoLPR, 'uses');
  WriteLnFmt(FArquivoLPR, '  SysUtils,');
  for I := 0 to Pred(ALista.Count) do
    AdicionarUnitLPR(I, ALista.Count, ALista[I]);
  WriteLnFmt(FArquivoLPR, '');
  WriteLnFmt(FArquivoLPR, 'var');
  WriteLnFmt(FArquivoLPR, '  FTempoInicio, FTempoFim: TTime;');
  WriteLnFmt(FArquivoLPR, 'begin');
  WriteLnFmt(FArquivoLPR, '  FTempoInicio := Now;');
  for I := 0 to Pred(ALista.Count) do
    AdicionarProcedureLPR(ALista[I]);
  WriteLnFmt(FArquivoLPR, '  FTempoFim := Now;');
  WriteLnFmt(FArquivoLPR, '  Writeln(''Tempo de Execucao: '' + FormatDateTime(''hh:nn:ss-zzz'', FTempoFim - FTempoInicio));');
  WriteLnFmt(FArquivoLPR, '  ReadLn;');
  WriteLnFmt(FArquivoLPR, 'end.');
end;

procedure TFormGerador.GerarLPS(ALista: TStringList);
var
  I: Integer;
begin
  WriteLnFmt(FArquivoLPS, '<?xml version="1.0" encoding="UTF-8"?>');
  WriteLnFmt(FArquivoLPS, '<CONFIG>');
  WriteLnFmt(FArquivoLPS, '  <ProjectSession>');
  WriteLnFmt(FArquivoLPS, '    <PathDelim Value="\"/>');
  WriteLnFmt(FArquivoLPS, '    <Version Value="11"/>');
  WriteLnFmt(FArquivoLPS, '    <BuildModes Active="Default"/>');
  WriteLnFmt(FArquivoLPS, '    <Units Count="%D">', [ALista.Count + 1]);
  WriteLnFmt(FArquivoLPS, '      <Unit0>');
  WriteLnFmt(FArquivoLPS, '        <Filename Value="Lazarus.lpr"/>');
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

procedure TFormGerador.AdicionarProcedureDPR(AGuid: String);
begin
  WriteLnFmt(FArquivoDPR, '    Procedure%S;', [AGuid]);
end;

procedure TFormGerador.AdicionarUnitDPR(AID, ATotal: Integer; AGuid: String);
begin
  if ((AID + 1) < ATotal) then
    WriteLnFmt(FArquivoDPR, '  UClasse%S in ''src\%S\UClasse%S.pas'',', [AGuid, GetGuid2(AGuid), AGuid])
  else
    WriteLnFmt(FArquivoDPR, '  UClasse%S in ''src\%S\UClasse%S.pas'';', [AGuid, GetGuid2(AGuid), AGuid]);
end;

procedure TFormGerador.GerarDPR(ALista: TStringList);
var
  I: Integer;
begin
  WriteLnFmt(FArquivoDPR, 'program Project7;');
  WriteLnFmt(FArquivoDPR, '{$APPTYPE CONSOLE}');
  // WriteLnFmt(FArquivoDPR, '{$R *.res}');
  WriteLnFmt(FArquivoDPR, 'uses');
  WriteLnFmt(FArquivoDPR, '  System.SysUtils,');
  for I := 0 to Pred(ALista.Count) do
    AdicionarUnitDPR(I, ALista.Count, ALista[I]);
  WriteLnFmt(FArquivoDPR, 'var');
  WriteLnFmt(FArquivoDPR, '  FTempoInicio, FTempoFim: TTime;');
  WriteLnFmt(FArquivoDPR, 'begin');
  WriteLnFmt(FArquivoDPR, '  FTempoInicio := Now;');
  WriteLnFmt(FArquivoDPR, '  try');
  WriteLnFmt(FArquivoDPR, '    { TODO -oUser -cConsole Main : Insert code here }');
  for I := 0 to Pred(ALista.Count) do
    AdicionarProcedureDPR(ALista[I]);
  WriteLnFmt(FArquivoDPR, '    FTempoFim := Now;');
  WriteLnFmt(FArquivoDPR, '    Writeln(''Tempo de Execucao: '' + FormatDateTime(''hh:nn:ss-zzz'', FTempoFim - FTempoInicio));');
  WriteLnFmt(FArquivoDPR, '    ReadLN;');
  WriteLnFmt(FArquivoDPR, '  except');
  WriteLnFmt(FArquivoDPR, '    on E: Exception do');
  WriteLnFmt(FArquivoDPR, '      Writeln(E.ClassName, '': '', E.Message);');
  WriteLnFmt(FArquivoDPR, '  end;');
  WriteLnFmt(FArquivoDPR, 'end.');
end;

procedure TFormGerador.GerarDPROJ(ALista: TStringList);
begin
  WriteLnFmt(FArquivoDPROJ, '<Project xmlns="http://schemas.microsoft.com/developer/msbuild/2003">');
  WriteLnFmt(FArquivoDPROJ, '    <PropertyGroup>');
  WriteLnFmt(FArquivoDPROJ, '        <ProjectGuid>{8B124B4E-6DE2-4244-A934-A1597AAED7CA}</ProjectGuid>');
  WriteLnFmt(FArquivoDPROJ, '        <ProjectVersion>18.3</ProjectVersion>');
  WriteLnFmt(FArquivoDPROJ, '        <FrameworkType>None</FrameworkType>');
  WriteLnFmt(FArquivoDPROJ, '        <MainSource>Delphi.dpr</MainSource>');
  WriteLnFmt(FArquivoDPROJ, '        <Base>True</Base>');
  WriteLnFmt(FArquivoDPROJ, '        <Config Condition="''$(Config)''==''''">Debug</Config>');
  WriteLnFmt(FArquivoDPROJ, '        <Platform Condition="''$(Platform)''==''''">Win32</Platform>');
  WriteLnFmt(FArquivoDPROJ, '        <TargetedPlatforms>1</TargetedPlatforms>');
  WriteLnFmt(FArquivoDPROJ, '        <AppType>Console</AppType>');
  WriteLnFmt(FArquivoDPROJ, '    </PropertyGroup>');
  WriteLnFmt(FArquivoDPROJ, '    <PropertyGroup Condition="''$(Config)''==''Base'' or ''$(Base)''!=''''">');
  WriteLnFmt(FArquivoDPROJ, '        <Base>true</Base>');
  WriteLnFmt(FArquivoDPROJ, '    </PropertyGroup>');
  WriteLnFmt(FArquivoDPROJ, '</Project>');
end;

procedure TFormGerador.InicializarArquivos;
begin
  AssignFile(FArquivoLPI, GetDiretorioProjeto + 'Lazarus.lpi');
  Rewrite(FArquivoLPI);

  AssignFile(FArquivoLPR, GetDiretorioProjeto + 'Lazarus.lpr');
  Rewrite(FArquivoLPR);

  AssignFile(FArquivoLPS, GetDiretorioProjeto + 'Lazarus.lps');
  Rewrite(FArquivoLPS);

  AssignFile(FArquivoDPR, GetDiretorioProjeto + 'Delphi.dpr');
  Rewrite(FArquivoDPR);

  AssignFile(FArquivoDPROJ, GetDiretorioProjeto + 'Delphi.dproj');
  Rewrite(FArquivoDPROJ);
end;

procedure TFormGerador.FinicializarArquivos;
begin
  CloseFile(FArquivoLPI);
  CloseFile(FArquivoLPR);
  CloseFile(FArquivoLPS);
  CloseFile(FArquivoDPR);
  CloseFile(FArquivoDPROJ);
end;

procedure TFormGerador.Gerar(AQuantidadeClasse, AQuantidadeLinhaMin, AQuantidadeLinhaMax: Integer);
var
  I: Integer;
  LGuid: String;
  FLista: TStringList;
begin
  FExecutando := True;
  FLista := TStringList.Create;
  try
    ForceDirectories(GetDiretorioProjeto());
    ProgressBar1.Max := AQuantidadeClasse;
    ProgressBar1.Position := 0;
    for I := 0 to Pred(AQuantidadeClasse) do
    begin
      LGuid := GuidCreate32;
      FLista.add(LGuid);
      GerarUnit(LGuid, AQuantidadeLinhaMin, AQuantidadeLinhaMax);
      ProgressBar1.StepBy(1);
      if (I mod 10 = 0) then
      begin
        Application.ProcessMessages;
        if not(FExecutando) then
          Break;
      end;
    end;
    FLista.Sort;
    InicializarArquivos;
    GerarLPI(FLista);
    GerarLPR(FLista);
    GerarLPS(FLista);
    GerarDPR(FLista);
    GerarDPROJ(FLista);
  finally
    FinicializarArquivos;
    FreeAndNil(FLista);
  end;
end;

procedure TFormGerador.ButtonGerarClick(Sender: TObject);
begin
  TButton(Sender).Enabled := False;
  Application.ProcessMessages;
  ButtonParar.Enabled := True;
  try
    Self.Gerar(SpinEditClasses.Value, SpinEditLinhaMin.Value, SpinEditLinhaMax.Value);
  finally
    TButton(Sender).Enabled := True;
    ButtonParar.Enabled := False;
  end;
end;

procedure TFormGerador.ButtonPararClick(Sender: TObject);
begin
  FExecutando := False;
end;

end.
