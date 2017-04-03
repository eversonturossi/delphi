unit uAssinarAplicacoes;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ShellApi;

type
  TForm1 = class(TForm)
    EditAplicacao: TEdit;
    Label1: TLabel;
    ButtonSelecionaAplicacao: TButton;
    ButtonAssinarAplicacao: TButton;
    ButtonInstalarCertificado: TButton;
    OpenDialog1: TOpenDialog;
    CheckBoxCompactarUPX: TCheckBox;
    MemoLog: TMemo;
    procedure ButtonSelecionaAplicacaoClick(Sender: TObject);
    procedure ButtonAssinarAplicacaoClick(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

function ExecutarEEsperar(NomeArquivo: String; Parametro: String = ''): Boolean;
var
  Sh: TShellExecuteInfo;
  CodigoSaida: DWORD;
begin
  FillChar(Sh, SizeOf(Sh), 0);
  Sh.cbSize := SizeOf(TShellExecuteInfo);
  with Sh do
  begin
    fMask := SEE_MASK_NOCLOSEPROCESS;
    Wnd := Application.Handle;
    lpVerb := nil;
    lpFile := PChar(NomeArquivo);
    lpParameters := PChar(Parametro);
    nShow := SW_SHOWNORMAL;
  end;
  if ShellExecuteEx(@Sh) then
  begin
    repeat
      Application.ProcessMessages;
      GetExitCodeProcess(Sh.hProcess, CodigoSaida);
    until not(CodigoSaida = STILL_ACTIVE);
    Result := True;
  end
  else
    Result := False;
end;

procedure GetDosOutput(CommandLine: String; Work: String; var Memo: TMemo);
var { Copiado de: http://www.activedelphi.com.br/forum/viewtopic.php?p=315720&sid=ed2e74bd93a77e2c1f2eea0ee6afd498 }
  SA: TSecurityAttributes;
  SI: TStartupInfo;
  PI: TProcessInformation;
  StdOutPipeRead, StdOutPipeWrite: THandle;
  WasOK: Boolean;
  Buffer: array [0 .. 255] of AnsiChar; { mudar para ler buffer maior }
  BytesRead: Cardinal;
  WorkDir: String;
  Handle: Boolean;
begin
  with SA do
  begin
    nLength := SizeOf(SA);
    bInheritHandle := True;
    lpSecurityDescriptor := nil;
  end;
  CreatePipe(StdOutPipeRead, StdOutPipeWrite, @SA, 0);
  try

    FillChar(SI, SizeOf(SI), 0);
    SI.cb := SizeOf(SI);
    SI.dwFlags := STARTF_USESHOWWINDOW or STARTF_USESTDHANDLES;
    SI.wShowWindow := SW_HIDE;
    SI.hStdInput := GetStdHandle(STD_INPUT_HANDLE); // don't redirect stdin
    SI.hStdOutput := StdOutPipeWrite;
    SI.hStdError := StdOutPipeWrite;

    WorkDir := Work;
    Handle := CreateProcess(nil, PChar('cmd.exe /C ' + CommandLine), nil, nil, True, 0, nil, PChar(WorkDir), SI, PI);
    CloseHandle(StdOutPipeWrite);
    if Handle then
      try
        repeat
          Application.ProcessMessages;
          WasOK := ReadFile(StdOutPipeRead, Buffer, 255, BytesRead, nil); { mudar para ler buffer maior }
          if BytesRead > 0 then
          begin
            Buffer[BytesRead] := #0;
            { Result := Result + Buffer; comentado aqui }
            Memo.Lines.Add(Trim(Buffer)); { adicionado esta linha }
            Memo.Lines.Add('==============================================');
          end;
        until not WasOK or (BytesRead = 0);
        WaitForSingleObject(PI.hProcess, INFINITE);
      finally
        CloseHandle(PI.hThread);
        CloseHandle(PI.hProcess);
      end;
  finally
    CloseHandle(StdOutPipeRead);
  end;
end;

procedure TForm1.ButtonAssinarAplicacaoClick(Sender: TObject);
var
  ACmd: String;
begin
  ButtonSelecionaAplicacao.Enabled := False;
  ButtonAssinarAplicacao.Enabled := False;
  ButtonInstalarCertificado.Enabled := False;
  MemoLog.Lines.Clear;
  try
    if not(FileExists(EditAplicacao.Text)) then
      raise Exception.CreateFmt('Não encontrado arquivo %S', [EditAplicacao.Text]);

    if not(FileExists('certificado.pfx')) then
      raise Exception.Create('Error Message');

    if not(FileExists('signtool\signtool.exe')) then
      raise Exception.Create('Não encontrado signtool.exe');

    if (CheckBoxCompactarUPX.Checked) then
    begin
      if not(FileExists('upx\upx.exe')) then
        raise Exception.Create('Não encontrado upx.exe');

      ACmd := Format('upx\upx.exe %S', [EditAplicacao.Text]);
      GetDosOutput(ACmd, ExtractFilePath(ParamStr(0)), MemoLog);
    end;
    if not(FileExists('certificado.pfx')) then
      raise Exception.Create('Não encontrado arquivo certificado.pfx');

    ACmd := Format('signtool\signtool.exe sign /f certificado.pfx /p senhacertificado "%S"', [EditAplicacao.Text]);
    GetDosOutput(ACmd, ExtractFilePath(ParamStr(0)), MemoLog);

    if (ExecutarEEsperar(EditAplicacao.Text)) then
      ShowMessageFmt('Aplicação %S assinada com sucesso', [EditAplicacao.Text]);
  finally
    ButtonSelecionaAplicacao.Enabled := True;
    ButtonAssinarAplicacao.Enabled := True;
    ButtonInstalarCertificado.Enabled := True;
  end;
end;

procedure TForm1.ButtonSelecionaAplicacaoClick(Sender: TObject);
begin
  if (OpenDialog1.Execute) then
    EditAplicacao.Text := OpenDialog1.FileName;
end;

end.
