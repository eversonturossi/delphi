object Form7: TForm7
  Left = 0
  Top = 0
  Caption = 'Form7'
  ClientHeight = 539
  ClientWidth = 626
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    626
    539)
  PixelsPerInch = 96
  TextHeight = 13
  object Label2: TLabel
    Left = 8
    Top = 8
    Width = 69
    Height = 13
    Caption = 'URL Download'
    Color = clBtnFace
    ParentColor = False
  end
  object Label11: TLabel
    Left = 8
    Top = 90
    Width = 109
    Height = 13
    Caption = 'Nome Arquivo a baixar'
    Color = clBtnFace
    ParentColor = False
  end
  object edURL: TComboBox
    Left = 8
    Top = 23
    Width = 398
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 0
    Text = 
      'https://nfem.joinville.sc.gov.br/processos/imprimir_nfe.aspx?cod' +
      'igo=FF7D2DC7-EA61-0880-4611-59308211A02E&numero=3958&documento_p' +
      'restador=06369202000272'
  end
  object edArq: TEdit
    Left = 8
    Top = 109
    Width = 398
    Height = 21
    Anchors = [akLeft, akTop, akRight]
    TabOrder = 1
    Text = 'teste.pdf'
  end
  object Button1: TButton
    Left = 344
    Top = 360
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 2
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 8
    Top = 136
    Width = 193
    Height = 25
    Caption = 'Download com Redirecionamento'
    TabOrder = 3
    OnClick = Button2Click
  end
end
