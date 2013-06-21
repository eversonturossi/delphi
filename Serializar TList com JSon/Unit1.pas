unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TForm1 = class(TForm)
    Button1: TButton;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  TPerson = class
  private
    FName: String;
    procedure SetName(const Value: String);
  published
    property Name: String read FName write SetName;
  end;

var
  Form1: TForm1;

implementation

uses
  Contnrs,
  DBXJSON,
  DBXJSONReflect;
{$R *.dfm}

procedure TForm1.Button1Click(Sender: TObject);
var
  list: TList;
  m: TJSONMarshal;
  json: TJSONObject;
  p1: TPerson;
  p2: TPerson;
begin
  p1 := TPerson.Create;
  p2 := TPerson.Create;
  try
    p1.Name := 'Daniele Teti';
    p2.Name := 'Peter Parker';
    list := TList.Create;
    try
      list.Add(p1);
      list.Add(p2);

      m := TJSONMarshal.Create(TJSONConverter.Create);
      try
        // Register a specific converter for field FList
        m.RegisterConverter(TList, 'FList', function(Data: TObject; Field: String): TListOfObjects var l: TList; j: integer; begin l := Data as TList; SetLength(Result, l.Count); for j := 0 to l.Count - 1 do Result[j] := TObject(l[j]);
          // HardCast from pointer
          end);

        json := m.Marshal(list) as TJSONObject;
        try
          Memo1.Lines.Text := json.tostring;
        finally
          json.Free;
        end;
      finally
        m.Free;
      end;
    finally
      list.Free;
    end;
  finally
    p1.Free;
    p2.Free;
  end;
end;

{ TPerson }

procedure TPerson.SetName(const Value: String);
begin
  FName := Value;
end;

end.
