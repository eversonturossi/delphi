unit UTodasCombinacoesLotoFacil;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    ProgressBar1: TProgressBar;
    procedure GerarTodasCombinacoesFor();
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
begin
  GerarTodasCombinacoesFor();
end;

procedure TForm1.GerarTodasCombinacoesFor();
  function R2D(I: Integer): String;
  begin
    if (I >= 10) then
      Result := IntToStr(I)
    else
      Result := '0' + IntToStr(I);
  end;

var
  P01, P02, P03, P04, P05, P06, P07, P08, P09, P10, P11, P12, P13, P14, P15: Integer;
  Cont: Integer;
  Arq: TextFile;
  Combinacao: string;
  Spr: String;
begin
  Cont := 0;
  AssignFile(Arq, 'TodasCombinacoes.txt');
  Rewrite(Arq);
  Spr := ';';
  for P01 := 1 to 11 do
  begin
    Form1.Caption := IntToStr(P01);
    for P02 := (P01 + 1) to 12 do
      for P03 := (P02 + 1) to 13 do
        for P04 := (P03 + 1) to 14 do
          for P05 := (P04 + 1) to 15 do
            for P06 := (P05 + 1) to 16 do
              for P07 := (P06 + 1) to 17 do
                for P08 := (P07 + 1) to 18 do
                  for P09 := (P08 + 1) to 19 do
                    for P10 := (P09 + 1) to 20 do
                      for P11 := (P10 + 1) to 21 do
                        for P12 := (P11 + 1) to 22 do
                          for P13 := (P12 + 1) to 23 do
                            for P14 := (P13 + 1) to 24 do
                              for P15 := (P14 + 1) to 25 do
                              begin
                                Cont := Cont + 1;
                                ProgressBar1.Position := Cont;
                                Application.ProcessMessages;
                                Combinacao := R2D(P01) + Spr + R2D(P02) + Spr + R2D(P03) + Spr + R2D(P04) + Spr + R2D(P05) + Spr { }
                                  + R2D(P06) + Spr + R2D(P07) + Spr + R2D(P08) + Spr + R2D(P09) + Spr + R2D(P10) + ' ' { }
                                  + R2D(P11) + Spr + R2D(P12) + Spr + R2D(P13) + Spr + R2D(P14) + Spr + R2D(P15);
                                Writeln(Arq, Combinacao);
                              end;
  end;
  Form1.Caption := IntToStr(Cont);
  CloseFile(Arq);
end;

end.
