unit UTodasCombinacoesLotoFacil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls,
  UAposta, UCombinacao, UNumeros, USorteio, UCombinacao.Geracao,
  UNumerosOcorrencias;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);

  private
    FCombinacoes: TCombinacoes;
    FSorteios: TSorteios;
    procedure AssociarSorteio(AGeracao: TCombinacaoGeracao);
    procedure AssociarCombinacao(AGeracao: TCombinacaoGeracao);
  published
  public
    property Combinacoes: TCombinacoes read FCombinacoes write FCombinacoes;
    property Sorteios: TSorteios read FSorteios write FSorteios;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.AssociarSorteio(AGeracao: TCombinacaoGeracao);
var
  I: Integer;
  LSorteio: TSorteio;
begin
  for I := 0 to Pred(AGeracao.Combinacoes.Count) do
  begin
    LSorteio := TSorteio.Create;
    LSorteio.NumerosSorteio.Assign(AGeracao.Combinacoes[I].NumerosCombinacao);
    FSorteios.Add(LSorteio);
  end;
end;

procedure TForm1.AssociarCombinacao(AGeracao: TCombinacaoGeracao);
var
  I: Integer;
  LCombinacao: TCombinacao;
begin
  for I := 0 to Pred(AGeracao.Combinacoes.Count) do
  begin
    LCombinacao := TCombinacao.Create;
    LCombinacao.NumerosCombinacao.Assign(AGeracao.Combinacoes[I].NumerosCombinacao);
    FCombinacoes.Add(LCombinacao);
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
var
  LGeracao: TCombinacaoGeracao;
begin
  LGeracao := TCombinacaoGeracao.Create;
  try
    LGeracao.Gerar(15);
    AssociarSorteio(LGeracao);
    //LGeracao.Clear;
   // LGeracao.Gerar(10);
    AssociarCombinacao(LGeracao);
  finally
    FreeAndNil(LGeracao);
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
var
  LOcorrencias: TNumerosOcorrencias;
  I: Integer;
begin
  LOcorrencias := TNumerosOcorrencias.Create;
  try
    for I := 0 to Pred(FSorteios.Count) do
      LOcorrencias.Ocorrencias(FSorteios[I].NumerosSorteio);

    ShowMessageFmt('Ocorrencia 01 = %D', [LOcorrencias.Numero01]);
  finally
    FreeAndNil(LOcorrencias);
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
  I, Y: Integer;
begin
  for I := 0 to Pred(FCombinacoes.Count) do
  begin
    for Y := 0 to Pred(FSorteios.Count) do
      FCombinacoes[I].VerificaOcorrencias(15, FSorteios[Y].NumerosSorteio);
  end;
  ShowMessageFmt('%S - %d', [FCombinacoes[0].NumerosCombinacao.ToStr, FCombinacoes[0].Ocorrencias]);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  FCombinacoes := TCombinacoes.Create();
  FSorteios := TSorteios.Create();
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FreeAndNil(FCombinacoes);
  FreeAndNil(FSorteios);
end;

end.
