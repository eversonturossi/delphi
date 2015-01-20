object frmWebserviceCliente: TfrmWebserviceCliente
  Left = 0
  Top = 0
  Caption = 'frmWebserviceCliente'
  ClientHeight = 498
  ClientWidth = 628
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 233
    Width = 628
    Height = 7
    Cursor = crVSplit
    Align = alTop
    Color = clSilver
    ParentColor = False
    ExplicitTop = 202
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 628
    Height = 57
    Align = alTop
    TabOrder = 0
    object ButtonRealToDolar: TButton
      Left = 8
      Top = 17
      Width = 121
      Height = 25
      Caption = 'USD -> BRL'
      TabOrder = 0
      OnClick = ButtonRealToDolarClick
    end
    object Button1: TButton
      Left = 135
      Top = 17
      Width = 138
      Height = 25
      Caption = 'EUR -> BRL'
      TabOrder = 1
      OnClick = Button1Click
    end
  end
  object MemoRequest: TMemo
    Left = 0
    Top = 57
    Width = 628
    Height = 176
    Align = alTop
    TabOrder = 1
    ExplicitTop = 113
  end
  object MemoResponse: TMemo
    Left = 0
    Top = 240
    Width = 628
    Height = 258
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 232
    ExplicitTop = 224
    ExplicitWidth = 185
    ExplicitHeight = 89
  end
  object HTTPRIO: THTTPRIO
    OnAfterExecute = HTTPRIOAfterExecute
    OnBeforeExecute = HTTPRIOBeforeExecute
    HTTPWebNode.UseUTF8InHeader = True
    HTTPWebNode.InvokeOptions = [soIgnoreInvalidCerts, soAutoCheckAccessPointViaUDDI]
    HTTPWebNode.WebNodeOptions = []
    Converter.Options = [soSendMultiRefObj, soTryAllSchema, soRootRefNodesToBody, soCacheMimeResponse, soUTF8EncodeXML]
    Left = 256
    Top = 184
  end
end
