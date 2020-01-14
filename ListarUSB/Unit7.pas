unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ACBrBase, ACBrPosPrinter, Vcl.StdCtrls, ACBrWinUSBDevice;

type
  TForm7 = class(TForm)
    ButtonListaImpressoras: TButton;
    ACBrPosPrinter1: TACBrPosPrinter;
    MemoDispositivos: TMemo;
    ButtonListaTodos: TButton;
    procedure ButtonListaImpressorasClick(Sender: TObject);
    procedure ButtonListaTodosClick(Sender: TObject);
  private
    procedure Listar(ADeviceList: TACBrUSBWinDeviceList);
  public
  end;

var
  Form7: TForm7;

implementation

{$R *.dfm}

procedure TForm7.ButtonListaImpressorasClick(Sender: TObject);
begin
  ACBrPosPrinter1.Device.WinUSB.FindUSBPrinters();
  Listar(ACBrPosPrinter1.Device.WinUSB.DeviceList);
end;

procedure TForm7.ButtonListaTodosClick(Sender: TObject);
begin
  ACBrPosPrinter1.Device.WinUSB.DeviceList.Clear;
  ACBrPosPrinter1.Device.WinUSB.FindUSBDevicesByGUID(GUID_DEVINTERFACE_USB_DEVICE);
  Listar(ACBrPosPrinter1.Device.WinUSB.DeviceList);
end;

procedure TForm7.Listar(ADeviceList: TACBrUSBWinDeviceList);
var
  I: Integer;
  LDevice: TACBrUSBWinDevice;
begin
  MemoDispositivos.Lines.Clear;
  for I := 0 to ADeviceList.Count - 1 do
  begin
    LDevice := ADeviceList.Items[I];
    MemoDispositivos.Lines.Add('DeviceKind:' + DeviceKindDescription(LDevice.DeviceKind));
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
    MemoDispositivos.Lines.Add('ACBrProtocol:' + LDevice.ACBrProtocol.ToString);
    MemoDispositivos.Lines.Add('-----------------------------------');
  end;
end;

end.
