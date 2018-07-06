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
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);

  private
    FCombinacoes: TCombinacoes;
    FSorteios: TSorteios;

  published
  public
    property Combinacoes: TCombinacoes read FCombinacoes write FCombinacoes;
    property Sorteios: TSorteios read FSorteios write FSorteios;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  LGeracao: TCombinacaoGeracao;
begin
  LGeracao := TCombinacaoGeracao.Create;
  try
    LGeracao.Gerar(15);
    LGeracao.Salvar('15.txt');
  finally
    FreeAndNil(LGeracao);
  end;
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
