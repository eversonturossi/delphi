unit UFormServer;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, UDataModuleConexao, URdmCadastro, UDatasnapContainer;

type
  TFormServer = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    //DataModuleConexao: TDataModuleConexao;
    RdmCadastro: TRdmCadastro;
    DatasnapContainer: TDatasnapContainer;
  public

  end;

var
  FormServer: TFormServer;

implementation

{$R *.dfm}

procedure TFormServer.FormCreate(Sender: TObject);
begin
  //DataModuleConexao := TDataModuleConexao.Create(Self);
  RdmCadastro := TRdmCadastro.Create(Self);
  DatasnapContainer := TDatasnapContainer.Create(Self);
end;

procedure TFormServer.FormDestroy(Sender: TObject);
begin
  try
    FreeAndNil(RdmCadastro);
    FreeAndNil(DatasnapContainer);
  finally
    //FreeAndNil(DataModuleConexao);
  end;
end;

end.
