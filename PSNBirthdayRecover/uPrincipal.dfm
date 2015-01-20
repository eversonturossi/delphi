object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 509
  ClientWidth = 823
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 823
    Height = 97
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      823
      97)
    object Label1: TLabel
      Left = 7
      Top = 5
      Width = 61
      Height = 13
      Caption = 'Date Inicio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label2: TLabel
      Left = 127
      Top = 5
      Width = 50
      Height = 13
      Caption = 'Data Fim'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label3: TLabel
      Left = 686
      Top = 29
      Width = 56
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'Testando:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 615
    end
    object LabelDataTeste: TLabel
      Left = 748
      Top = 29
      Width = 68
      Height = 13
      Anchors = [akTop, akRight]
      Caption = '00/00/0000'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitLeft = 677
    end
    object Label4: TLabel
      Left = 7
      Top = 51
      Width = 22
      Height = 13
      Caption = 'URL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object ButtonParar: TButton
      Left = 319
      Top = 24
      Width = 75
      Height = 21
      Caption = 'Parar'
      TabOrder = 0
      OnClick = ButtonPararClick
    end
    object ButtonIniciar: TButton
      Left = 238
      Top = 24
      Width = 75
      Height = 21
      Caption = 'Iniciar'
      TabOrder = 1
      OnClick = ButtonIniciarClick
    end
    object dtDataInicio: TDateTimePicker
      Left = 7
      Top = 24
      Width = 105
      Height = 21
      Date = 42020.481245636580000000
      Time = 42020.481245636580000000
      TabOrder = 2
    end
    object dtDataFim: TDateTimePicker
      Left = 127
      Top = 24
      Width = 105
      Height = 21
      Date = 42020.481245636580000000
      Time = 42020.481245636580000000
      TabOrder = 3
    end
    object EditUrl: TEdit
      Left = 7
      Top = 67
      Width = 809
      Height = 21
      Anchors = [akLeft, akTop, akRight]
      TabOrder = 4
      Text = 
        'https://account.sonyentertainmentnetwork.com/liquid/external/val' +
        'idate-forgot-password-token!input.action?token=IYIHU3MD998V1U4LC' +
        'ICGLKHF769E3W82JZJCI59RPYFYGSH4YJWVU38P5RVY0UGS&request_locale=e' +
        'n_US&service-entity=psn'
      OnClick = EditUrlClick
      OnKeyPress = EditUrlKeyPress
    end
    object Button1: TButton
      Left = 472
      Top = 22
      Width = 75
      Height = 25
      Caption = 'setar'
      TabOrder = 5
    end
  end
  object Browser: TWebBrowser
    Left = 0
    Top = 97
    Width = 823
    Height = 393
    Align = alClient
    TabOrder = 1
    OnStatusTextChange = BrowserStatusTextChange
    OnProgressChange = BrowserProgressChange
    OnDocumentComplete = BrowserDocumentComplete
    ExplicitTop = 94
    ExplicitWidth = 749
    ControlData = {
      4C0000000F5500009E2800000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object BarraStatusNavegador: TStatusBar
    Left = 0
    Top = 490
    Width = 823
    Height = 19
    Panels = <
      item
        Width = 200
      end
      item
        Width = 50
      end>
  end
  object ProgressoNavegador: TProgressBar
    Left = 8
    Top = 462
    Width = 150
    Height = 17
    TabOrder = 3
  end
end
