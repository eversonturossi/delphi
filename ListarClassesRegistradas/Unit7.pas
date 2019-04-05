unit Unit7;

{ Fonte: http://www.planetadelphi.com.br/artigo/27/registro-de-classes-no-delphi }

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, ClassesEnum, Vcl.ExtCtrls;

type
  TForm7 = class(TForm)
    Memo1: TMemo;
    procedure FormCreate(Sender: TObject);
  private
  public
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.FormCreate(Sender: TObject);
begin
  RegisterClass(TPanel);
  RegisterClass(TPersistentClass(Self.ClassType));
  RegisterClass(TPersistentClass(Memo1.ClassType));

  EnumClasses(Memo1.Lines);
end;

initialization

RegisterClass(TButton);
RegisterClass(TEdit);
RegisterClass(TForm);

end.
