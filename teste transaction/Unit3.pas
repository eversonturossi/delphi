unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, WideStrings, DB, SqlExpr, StdCtrls, DBClient, SimpleDS, DBXCommon,
  DBXOracle, Data.DBXFirebird;

type
  TForm3 = class(TForm)
    SQLConnection1: TSQLConnection;
    Button1: TButton;
    SimpleDataSet1: TSimpleDataSet;
    SimpleDataSet2: TSimpleDataSet;
    SimpleDataSet3: TSimpleDataSet;
    SimpleDataSet4: TSimpleDataSet;
    SimpleDataSet1CODIGO: TFMTBCDField;
    SimpleDataSet1DESCRICAO: TWideStringField;
    SimpleDataSet2CODIGO: TFMTBCDField;
    SimpleDataSet2DESCRICAO: TWideStringField;
    SimpleDataSet3CODIGO: TFMTBCDField;
    SimpleDataSet3DESCRICAO: TWideStringField;
    SimpleDataSet4CODIGO: TFMTBCDField;
    SimpleDataSet4DESCRICAO: TWideStringField;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox1: TCheckBox;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
var
  Trans: TDBXTransaction;
begin
  try
    SQLConnection1.Open;
    try
      Trans := SQLConnection1.BeginTransaction;
      // ---
      SimpleDataSet1.Open;
      SimpleDataSet2.Open;
      SimpleDataSet3.Open;
      SimpleDataSet4.Open;

      SimpleDataSet1.Insert;
      SimpleDataSet1CODIGO.AsString := Edit1.Text;
      SimpleDataSet1DESCRICAO.AsString := Edit2.Text;
      SimpleDataSet1.Post;
      SimpleDataSet1.ApplyUpdates(-1);

      SimpleDataSet2.Insert;
      SimpleDataSet2CODIGO.AsString := Edit1.Text;
      SimpleDataSet2DESCRICAO.AsString := Edit2.Text;
      SimpleDataSet2.Post;
      SimpleDataSet2.ApplyUpdates(-1);

      SimpleDataSet3.Insert;
      SimpleDataSet3CODIGO.AsString := Edit1.Text;
      SimpleDataSet3DESCRICAO.AsString := Edit2.Text;
      SimpleDataSet3.Post;
      SimpleDataSet3.ApplyUpdates(-1);

      SimpleDataSet4.Insert;
      SimpleDataSet4CODIGO.AsString := Edit1.Text;
      SimpleDataSet4DESCRICAO.AsString := Edit2.Text;
      SimpleDataSet4.Post;
      SimpleDataSet4.ApplyUpdates(-1);

      if (CheckBox1.Checked) then
        raise Exception.Create('Error Message 666');
      // ---
      SQLConnection1.CommitFreeAndNil(Trans);
    except
      on E: Exception do
      begin
        SQLConnection1.RollbackFreeAndNil(Trans);
        ShowMessage(E.Message);
      end;
    end;
  finally
    SQLConnection1.Close;
  end;
end;

end.
