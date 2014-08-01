unit URelatorioFonte;

interface

uses
  Windows,
  SysUtils,
  Messages,
  Classes,
  Graphics,
  Controls,
  QuickRpt,
  QRPrntr,
  QRCtrls,
  DBClient,
  QRPDFFilt;

type
  TFonte = class(TObject)
  private
    fCor: TColor;
    fSublinhado: Boolean;
    fNegrito: Boolean;
    fNome: String;
    fItalico: Boolean;
    fTamanho: Integer;
  public
    property Nome: String read fNome write fNome;
    property Tamanho: Integer read fTamanho write fTamanho;
    property Negrito: Boolean read fNegrito write fNegrito;
    property Italico: Boolean read fItalico write fItalico;
    property Sublinhado: Boolean read fSublinhado write fSublinhado;
    property Cor: TColor read fCor write fCor;
  end;

implementation

end.
