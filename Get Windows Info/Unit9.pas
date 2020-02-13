unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls;

type
  TForm9 = class(TForm)
    Memo1: TMemo;
    Button1: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form9: TForm9;

implementation

{$R *.dfm}

function OSArchitectureToStr(const a: TOSVersion.TArchitecture): string;
begin
  case a of
    arIntelX86:
      Result := 'IntelX86';
    arIntelX64:
      Result := 'IntelX64';
  else
    Result := 'UNKNOWN OS architecture';
  end;
end;

function OSPlatformToStr(const p: TOSVersion.TPlatform): string;
begin
  case p of
    pfWindows:
      Result := 'Windows';
    pfMacOS:
      Result := 'MacOS';
  else
    Result := 'UNKNOWN OS Platform';
  end;
end;

function PlatformFromPointer: integer;
begin
  Result := SizeOf(Pointer) * 8;
end;

procedure TForm9.Button1Click(Sender: TObject);
begin
  with Memo1.Lines do
  begin
    Clear;
    Add(TOSVersion.ToString);
    Add('');
    Add('Nome do OS: ' + TOSVersion.Name);
    Add('Arquitetura do OS: ' + OSArchitectureToStr(TOSVersion.Architecture));
    Add('Arquitetura do Aplicativo: ' + OSPlatformToStr(TOSVersion.Platform) + IntToStr(PlatformFromPointer));
    Add('Build: ' + IntToStr(TOSVersion.Build));
    Add('Major: ' + IntToStr(TOSVersion.Major));
    Add('Minor: ' + IntToStr(TOSVersion.Minor));
    Add('Service Pack - Major: ' + IntToStr(TOSVersion.ServicePackMajor));
    Add('Service Pack - Minor: ' + IntToStr(TOSVersion.ServicePackMinor));
  end;
end;

end.
