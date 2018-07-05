unit UTodasCombinacoesLotoFacil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,
  UAposta, UCombinacao, UNumeros, USorteio, UCombinacao.Geracao;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure GerarTodasCombinacoesFor();
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);

  private
    FCombinacoes: TCombinacoes;
    procedure GerarTodasCombinacoes08d;

  published
  public
    property Combinacoes: TCombinacoes read FCombinacoes write FCombinacoes;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  GerarTodasCombinacoesFor();
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  I: Integer;
  LArqqui: TextFile;
begin
  AssignFile(LArqqui, 'TodasCombinacoess.txt');
  Rewrite(LArqqui);
  try
    for I := 0 to Pred(FCombinacoes.Count) do
    begin
      Writeln(LArqqui, FCombinacoes[I].NumerosCombinacao.ToStr);
    end;
  finally
    CloseFile(LArqqui);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  GerarTodasCombinacoes08d;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  Lcombinacoes: TCombinacaoGeracao;
begin
  Lcombinacoes := TCombinacaoGeracao.Create;
  try
    Lcombinacoes.GerarFor(15);
    Lcombinacoes.Salvar('teste.txt');
  finally
    FreeAndNil(Lcombinacoes);
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FCombinacoes := TCombinacoes.Create();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCombinacoes);
end;

function R2D(I: Integer): String;
begin
  if (I >= 10) then
    Result := IntToStr(I)
  else
    Result := '0' + IntToStr(I);
end;

procedure TForm1.GerarTodasCombinacoesFor();
var
  P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12, P13, P14, P15: Integer;
  A01: Integer;
  LContador: Integer;
  LArqqui: TextFile;
  LCombinacaoStr: string;
  LSpr: String;
  LCombinacao: TCombinacao;
begin
  LContador := 0;
  AssignFile(LArqqui, 'TodasCombinacoes.txt');
  Rewrite(LArqqui);
  LSpr := ';';
  A01 := 11;
  FCombinacoes.Clear;
  for P01 := 1 to A01 do
  begin
    Form1.Caption := IntToStr(P01);
    for P02 := (P01 + 1) to (A01 + 1) do
      for P03 := (P02 + 1) to (A01 + 2) do
        for P04 := (P03 + 1) to (A01 + 3) do
          for P05 := (P04 + 1) to (A01 + 4) do
            for P06 := (P05 + 1) to (A01 + 5) do
              for P07 := (P06 + 1) to (A01 + 6) do
                for P08 := (P07 + 1) to (A01 + 7) do
                  for P09 := (P08 + 1) to (A01 + 8) do
                    for P10 := (P09 + 1) to (A01 + 9) do
                      for P11 := (P10 + 1) to (A01 + 10) do
                        for P12 := (P11 + 1) to (A01 + 11) do
                          for P13 := (P12 + 1) to (A01 + 12) do
                            for P14 := (P13 + 1) to (A01 + 13) do
                              for P15 := (P14 + 1) to (A01 + 14) do
                              begin
                                LContador := LContador + 1;
                                ProgressBar1.Position := LContador;
                                Application.ProcessMessages;
                                LCombinacaoStr := '' + //
                                  R2D(P01) + LSpr + //
                                  R2D(P02) + LSpr + //
                                  R2D(P03) + LSpr + //
                                  R2D(P04) + LSpr + //
                                  R2D(P05) + LSpr + //
                                  R2D(P06) + LSpr + //
                                  R2D(P07) + LSpr + //
                                  R2D(P08) + LSpr + //
                                  R2D(P09) + LSpr + //
                                  R2D(P10) + LSpr + //
                                  R2D(P11) + LSpr + //
                                  R2D(P12) + LSpr + //
                                  R2D(P13) + LSpr + //
                                  R2D(P14) + LSpr + //
                                  R2D(P15);

                                LCombinacao := TCombinacao.Create;
                                LCombinacao.NumerosCombinacao.Carregar(LCombinacaoStr);
                                FCombinacoes.Add(LCombinacao);

                                // Writeln(LArqqui, LCombinacaoStr);
                              end;
  end;
  Form1.Caption := IntToStr(LContador);
  CloseFile(LArqqui);
end;

procedure TForm1.GerarTodasCombinacoes08d();
var
  P01, P02, P03, P04, P05, P06, P07, P08: Integer;
  A01: Integer;
  LContador: Integer;
  LArqqui: TextFile;
  LCombinacao: string;
  LSpr: String;
begin
  LContador := 0;
  AssignFile(LArqqui, 'TodasCombinacoes08d.txt');
  Rewrite(LArqqui);
  LSpr := ';';
  A01 := 16; { 14 = 12 /   13 = 13 /  12 = 14 /   11 = 15 /  10 = 16 /   09 = 17 /   08 = 16 }
  for P01 := 1 to A01 do
  begin
    Form1.Caption := IntToStr(P01);
    for P02 := (P01 + 1) to (A01 + 1) do
      for P03 := (P02 + 1) to (A01 + 2) do
        for P04 := (P03 + 1) to (A01 + 3) do
          for P05 := (P04 + 1) to (A01 + 4) do
            for P06 := (P05 + 1) to (A01 + 5) do
              for P07 := (P06 + 1) to (A01 + 6) do
                for P08 := (P07 + 1) to (A01 + 7) do
                begin
                  LContador := LContador + 1;
                  ProgressBar1.Position := LContador;
                  Application.ProcessMessages;
                  LCombinacao := '' + //
                    R2D(P01) + LSpr + //
                    R2D(P02) + LSpr + //
                    R2D(P03) + LSpr + //
                    R2D(P04) + LSpr + //
                    R2D(P05) + LSpr + //
                    R2D(P06) + LSpr + //
                    R2D(P07) + LSpr + //
                    R2D(P08);
                  Writeln(LArqqui, LCombinacao);
                end;
  end;
  Form1.Caption := IntToStr(LContador);
  CloseFile(LArqqui);
end;

end.
