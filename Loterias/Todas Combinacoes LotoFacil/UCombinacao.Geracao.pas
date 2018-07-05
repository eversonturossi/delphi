unit UCombinacao.Geracao;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  UCombinacao;

const
  cSeparador = ';';

type
  TCombinacaoGeracao = class(TObject)
  private
    FCombinacoes: TCombinacoes;
    FCombinacao: TStringBuilder;
    function getLimiteFor(AQuantidadeCombinacao: Integer): Integer;
    procedure Gerar05d;
    procedure Gerar06d;
    procedure Gerar07d;
    procedure Gerar08d;
    procedure Gerar09d;
    procedure Gerar10d;
    procedure Gerar11d;
    procedure Gerar12d;
    procedure Gerar13d;
    procedure Gerar14d;
    procedure Gerar15d;
    procedure GerarSubForr(AQuantidade, AInicioFor, ALimiteFor, ANivel: Integer);

    property Combinacao: TStringBuilder read FCombinacao write FCombinacao;
  public
    constructor Create;
    destructor Destroy; override;

    procedure Gerar(AquantidadeNumeros: Integer);
    procedure GerarFor(AQuantidade: Integer);
    procedure GerarSubFor(AQuantidade, AInicioFor, ALimiteFor, ANivel: Integer);
    procedure Carregar(AArquivoCombinacoes: String);
    procedure Salvar(AArquivoCombinacoes: String);

    property Combinacoes: TCombinacoes read FCombinacoes write FCombinacoes;
  end;

implementation

function Round2D(I: Integer): String;
begin
  if (I >= 10) then
    Result := IntToStr(I)
  else
    Result := '0' + IntToStr(I);
end;

{ TCombinacaoGeracao }

constructor TCombinacaoGeracao.Create;
begin
  FCombinacoes := TCombinacoes.Create;
  FCombinacao := TStringBuilder.Create;
end;

destructor TCombinacaoGeracao.Destroy;
begin
  FreeAndNil(FCombinacoes);
  FreeAndNil(FCombinacao);
  inherited;
end;

procedure TCombinacaoGeracao.Carregar(AArquivoCombinacoes: String);
begin

end;

procedure TCombinacaoGeracao.Salvar(AArquivoCombinacoes: String);
var
  I: Integer;
  LArquivo: TextFile;
begin
  AssignFile(LArquivo, AArquivoCombinacoes);
  Rewrite(LArquivo);
  try
    for I := 0 to Pred(FCombinacoes.Count) do
    begin
      Writeln(LArquivo, FCombinacoes[I].NumerosCombinacao.ToStr);
    end;
  finally
    CloseFile(LArquivo);
  end;
end;

procedure TCombinacaoGeracao.Gerar(AquantidadeNumeros: Integer);
begin
  case AquantidadeNumeros of
    15:
      Gerar15d;
    14:
      Gerar14d;
    13:
      Gerar13d;
    12:
      Gerar12d;
    11:
      Gerar11d;
    10:
      Gerar10d;
    09:
      Gerar09d;
    08:
      Gerar08d;
    07:
      Gerar07d;
    06:
      Gerar06d;
    05:
      Gerar05d;
  end;
end;

function TCombinacaoGeracao.getLimiteFor(AQuantidadeCombinacao: Integer): Integer;
begin
  case AQuantidadeCombinacao of
    15:
      Result := 11;
    14:
      Result := 12;
    13:
      Result := 13;
    12:
      Result := 14;
    11:
      Result := 15;
    10:
      Result := 16;
    09:
      Result := 17;
    08:
      Result := 18;
    07:
      Result := 19;
    06:
      Result := 20;
    05:
      Result := 21;
  end;
end;

procedure TCombinacaoGeracao.Gerar05d;
begin

end;

procedure TCombinacaoGeracao.Gerar06d;
begin

end;

procedure TCombinacaoGeracao.Gerar07d;
begin

end;

procedure TCombinacaoGeracao.Gerar08d;
begin

end;

procedure TCombinacaoGeracao.Gerar09d;
begin

end;

procedure TCombinacaoGeracao.Gerar10d;
begin

end;

procedure TCombinacaoGeracao.Gerar11d;
begin

end;

procedure TCombinacaoGeracao.Gerar12d;
begin

end;

procedure TCombinacaoGeracao.Gerar13d;
begin

end;

procedure TCombinacaoGeracao.Gerar14d;
begin

end;

procedure TCombinacaoGeracao.Gerar15d;
var
  Posicao01, Posicao02, Posicao03, Posicao04, Posicao05: Integer;
  Posicao06, Posicao07, Posicao08, Posicao09, Posicao10: Integer;
  Posicao11, Posicao12, Posicao13, Posicao14, Posicao15: Integer;
  LLimiteFor: Integer;
begin
  LLimiteFor := getLimiteFor(15);
  FCombinacoes.Clear;

  for Posicao01 := 1 to LLimiteFor do
  begin
    for Posicao02 := Succ(Posicao01) to (LLimiteFor + 1) do
      for Posicao03 := Succ(Posicao02) to (LLimiteFor + 2) do
        for Posicao04 := Succ(Posicao03) to (LLimiteFor + 3) do
          for Posicao05 := Succ(Posicao04) to (LLimiteFor + 4) do
            for Posicao06 := Succ(Posicao05) to (LLimiteFor + 5) do
              for Posicao07 := Succ(Posicao06) to (LLimiteFor + 6) do
                for Posicao08 := Succ(Posicao07) to (LLimiteFor + 7) do
                  for Posicao09 := Succ(Posicao08) to (LLimiteFor + 8) do
                    for Posicao10 := Succ(Posicao09) to (LLimiteFor + 9) do
                      for Posicao11 := Succ(Posicao10) to (LLimiteFor + 10) do
                        for Posicao12 := Succ(Posicao11) to (LLimiteFor + 11) do
                          for Posicao13 := Succ(Posicao12) to (LLimiteFor + 12) do
                            for Posicao14 := Succ(Posicao13) to (LLimiteFor + 13) do
                              for Posicao15 := Succ(Posicao14) to (LLimiteFor + 14) do
                              begin
                                FCombinacao.Clear;
                                FCombinacao.Append(Round2D(Posicao01)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao02)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao03)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao04)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao05)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao06)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao07)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao08)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao09)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao10)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao11)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao12)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao13)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao14)).Append(cSeparador);
                                FCombinacao.Append(Round2D(Posicao15)).Append(cSeparador);

                                FCombinacoes.Add(TCombinacao.Create(FCombinacao.ToString));
                              end;
  end;
end;

procedure TCombinacaoGeracao.GerarFor(AQuantidade: Integer);
var
  InicioFor: Integer;
  LLimiteFor: Integer;
begin
  LLimiteFor := getLimiteFor(15);
  FCombinacoes.Clear;

  for InicioFor := 1 to LLimiteFor do
  begin
    FCombinacao.Clear;
    FCombinacao.Append(Round2D(InicioFor)).Append(cSeparador);
    GerarSubFor(AQuantidade, Succ(InicioFor), Succ(LLimiteFor), 2);
  end;
end;

procedure TCombinacaoGeracao.GerarSubFor(AQuantidade, AInicioFor, ALimiteFor, ANivel: Integer);
var
  I: Integer;
begin
  for I := AInicioFor to ALimiteFor do
  begin
    FCombinacao.Append(Round2D(i)).Append(cSeparador);
    // if (AQuantidade > 2) then
    // GerarSubFor(Pred(AQuantidade), Succ(AInicioFor), Succ(ALimiteFor), Succ(ANivel))
    // else
    // FCombinacoes.Add(TCombinacao.Create(FCombinacao.ToString));

    if (ANivel <= (AQuantidade - 2)) then
      GerarSubFor(AQuantidade, Succ(AInicioFor), Succ(ALimiteFor), Succ(ANivel));
    if (ANivel = (AQuantidade - 1)) then
      GerarSubForr(AQuantidade, Succ(AInicioFor), Succ(ALimiteFor), Succ(ANivel));
  end;
end;

procedure TCombinacaoGeracao.GerarSubForr(AQuantidade, AInicioFor, ALimiteFor, ANivel: Integer);
var
  I: Integer;
  LCombinacao: TStringBuilder;
begin
  for I := AInicioFor to ALimiteFor do
  begin
    LCombinacao := TStringBuilder.Create;
    try
      LCombinacao.Append(FCombinacao.ToString);
      LCombinacao.Append(Round2D(I)).Append(cSeparador);
      FCombinacoes.Add(TCombinacao.Create(LCombinacao.ToString));
    finally
      FreeAndNil(LCombinacao);
    end;
  end;
end;

end.
