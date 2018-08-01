unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls,

  {driver link}
  {FireDAC.Phys.FBDef,
    FireDAC.Phys.IBBase,
    FireDAC.Phys.FB,
    FireDAC.Stan.Intf,
    FireDAC.Phys}
  FireDAC.Phys.FBDef,
  FireDAC.Stan.Intf,
  FireDAC.Phys,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, Vcl.ExtCtrls;

type
  TForm7 = class(TForm)
    FDPhysFBDriverLink1: TFDPhysFBDriverLink;
    Button1: TButton;
    FDConnection1: TFDConnection;
    PanelConexao: TPanel;
    LabelBanco: TLabel;
    LabelCaminhoBanco: TLabel;
    Bevel1: TBevel;
    ButtonSelecionaBanco: TButton;
    OpenDialog1: TOpenDialog;
    procedure Button1Click(Sender: TObject);
    procedure ButtonSelecionaBancoClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
  FDPhysFBDriverLink1.Release;
  ShowMessage(FDPhysFBDriverLink1.VendorLib);
end;

procedure TForm7.ButtonSelecionaBancoClick(Sender: TObject);
begin
  if (OpenDialog1.Execute) then
  begin
    LabelCaminhoBanco.Caption := OpenDialog1.FileName;

    FDConnection1.Params.Clear;
    FDConnection1.Params.Values['DriverID'] := 'FB';
    FDConnection1.Params.Values['Database'] := LabelCaminhoBanco.Caption;
    FDConnection1.Params.Values['Server'] := 'localhost';
    FDConnection1.Params.Values['Port'] := '3050';
    FDConnection1.Params.Values['user_name'] := 'sysdba';
    FDConnection1.Params.Values['password'] := 'masterkey';
    FDConnection1.Params.Values['Protocol'] := 'Local';

    FDPhysFBDriverLink1.Release;
    FDPhysFBDriverLink1.VendorHome := 'c:\fb25_64\';
    FDPhysFBDriverLink1.VendorLib := 'fbclient.dll';
    FDConnection1.Connected := true;
  end;
end;

end.
