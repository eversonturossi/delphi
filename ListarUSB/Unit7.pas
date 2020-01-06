unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrPosPrinter, Vcl.StdCtrls;

type
  TForm7 = class(TForm)
    Button1: TButton;
    ACBrPosPrinter1: TACBrPosPrinter;
    MemoDispositivos: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation

uses
  ACBrWinUSBDevice;

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
var
  K: Integer;
  LDevice: TACBrUSBWinDevice;
begin
  MemoDispositivos.Lines.Clear;
  ACBrPosPrinter1.Device.WinUSB.FindUSBPrinters();
  // ACBrPosPrinter1.Device.WinUSB.FindUSBKnownDevices;
  for K := 0 to ACBrPosPrinter1.Device.WinUSB.DeviceList.Count - 1 do
  begin
    LDevice := ACBrPosPrinter1.Device.WinUSB.DeviceList.Items[K];
    // memodispositivos.Lines.Add('DeviceKind:' + LDevice.DeviceKind);
    MemoDispositivos.Lines.Add('DeviceName:' + LDevice.DeviceName);
    MemoDispositivos.Lines.Add('VendorID:' + LDevice.VendorID);
    MemoDispositivos.Lines.Add('VendorName:' + LDevice.VendorName);
    MemoDispositivos.Lines.Add('ProductID:' + LDevice.ProductID);
    MemoDispositivos.Lines.Add('ProductModel:' + LDevice.ProductModel);
    MemoDispositivos.Lines.Add('DeviceInterface:' + LDevice.DeviceInterface);
    MemoDispositivos.Lines.Add('USBPort:' + LDevice.USBPort);
    MemoDispositivos.Lines.Add('ClassGUID:' + LDevice.ClassGUID);
    MemoDispositivos.Lines.Add('GUID:' + LDevice.GUID);
    MemoDispositivos.Lines.Add('FrendlyName:' + LDevice.FrendlyName);
    MemoDispositivos.Lines.Add('HardwareID:' + LDevice.HardwareID);
    // memodispositivos.Lines.Add('ACBrProtocol:' + LDevice.ACBrProtocol);
    MemoDispositivos.Lines.Add('-----------------------------------');
  end;
end;

end.
