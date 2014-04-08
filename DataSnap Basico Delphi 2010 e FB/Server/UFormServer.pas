unit UFormServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDataModuleConexao, UDSServerModuleCadastro, UDatasnapContainer,
  UDSServerModuleMovimento;

type
  TFormServer = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    // DataModuleConexao: TDataModuleConexao;
    DSServerModuleCadastro: TDSServerModuleCadastro;
    DSServerModuleMovimento: TDSServerModuleMovimento;
    DatasnapContainer: TDatasnapContainer;
  public

  end;

var
  FormServer: TFormServer;

implementation

{$R *.dfm}

procedure TFormServer.FormCreate(Sender: TObject);
begin
  // DataModuleConexao := TDataModuleConexao.Create(Self);
  DSServerModuleCadastro := TDSServerModuleCadastro.Create(Self);
  DSServerModuleMovimento := TDSServerModuleMovimento.Create(Self);
  DatasnapContainer := TDatasnapContainer.Create(Self);
end;

procedure TFormServer.FormDestroy(Sender: TObject);
begin
  try
    FreeAndNil(DSServerModuleCadastro);
    FreeAndNil(DSServerModuleMovimento);
    FreeAndNil(DatasnapContainer);
  finally
    // FreeAndNil(DataModuleConexao);
  end;
end;

end.
