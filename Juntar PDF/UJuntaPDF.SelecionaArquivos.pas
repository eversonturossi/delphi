unit UJuntaPDF.SelecionaArquivos;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ComCtrls,
  UJuntaPDF;

type
  TJuntaPDFSelecionaArquivos = class(TObject)
  private
    FOwner: TJuntaPDF;
    FOpenDialog: TOpenDialog;
    procedure Seleciona;
  public
    constructor Create(AJuntaPDF: TJuntaPDF);
    destructor Destroy; override;

    procedure Executa;
  end;

implementation

{ TJuntaPDFSelecionaArquivos }

constructor TJuntaPDFSelecionaArquivos.Create(AJuntaPDF: TJuntaPDF);
begin
  Self.FOwner := AJuntaPDF;
  Self.FOpenDialog := TOpenDialog.Create(nil);
  Self.FOpenDialog.DefaultExt := '*.pdf';
  Self.FOpenDialog.Filter := 'PDF|*.pdf';
  Self.FOpenDialog.Title := 'Selecione os PDFs';
  Self.FOpenDialog.Options := [ofHideReadOnly, ofEnableSizing, ofAllowMultiSelect, ofFileMustExist];
end;

destructor TJuntaPDFSelecionaArquivos.Destroy;
begin
  FreeAndNil(FOpenDialog);
  Self.FOwner := nil;
  inherited;
end;

procedure TJuntaPDFSelecionaArquivos.Executa;
begin
  if (Self.FOpenDialog.Execute()) then
  begin
    Self.Seleciona;
  end;
end;

procedure TJuntaPDFSelecionaArquivos.Seleciona;
var
  I: Integer;
begin
  for I := 0 to Pred(FOpenDialog.Files.Count) do
  begin
    Self.FOwner.Arquivos.Add(FOpenDialog.Files[I]);
  end;
end;

end.
