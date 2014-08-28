unit UFormInicial;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UFormBase, StdCtrls;

type
  TFormInicial = class(TFormBase)
    Memo1: TMemo;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormInicial: TFormInicial;

implementation

{$R *.dfm}

end.
