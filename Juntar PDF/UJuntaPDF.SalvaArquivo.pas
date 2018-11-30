unit UJuntaPDF.SalvaArquivo;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  UJuntaPDF;

type
  TJuntaPDFSalvaArquivo = class(TObject)
  private
    FOwner: TJuntaPDF;
    FSaveDialog: TSaveDialog;
  public
    constructor Create(AJuntaPDF: TJuntaPDF);
    destructor Destroy; override;

    procedure Executa;
  end;

implementation

{ TJuntaPDFSalvaArquivo }

constructor TJuntaPDFSalvaArquivo.Create(AJuntaPDF: TJuntaPDF);
begin
  Self.FOwner := AJuntaPDF;
  Self.FSaveDialog := TSaveDialog.Create(nil);
end;

destructor TJuntaPDFSalvaArquivo.Destroy;
begin
  FreeAndNil(FSaveDialog);
  Self.FOwner := nil;
  inherited;
end;

procedure TJuntaPDFSalvaArquivo.Executa;
begin
  if (Self.FSaveDialog.Execute()) then
  begin
    FOwner.NomeArquivo := Self.FSaveDialog.FileName;
  end;
end;

end.
