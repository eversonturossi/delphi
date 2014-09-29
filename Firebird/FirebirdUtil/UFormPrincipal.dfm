object FormPrincipal: TFormPrincipal
  Left = 0
  Top = 0
  Caption = 'FormPrincipal'
  ClientHeight = 524
  ClientWidth = 756
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object EditVersaoFirebird: TEdit
    Left = 8
    Top = 8
    Width = 129
    Height = 21
    ReadOnly = True
    TabOrder = 0
    Text = 'EditVersaoFirebird'
  end
  object ButtonGetVersaoFirebird: TButton
    Left = 336
    Top = 6
    Width = 201
    Height = 25
    Caption = 'get Versao Firebird'
    TabOrder = 1
    OnClick = ButtonGetVersaoFirebirdClick
  end
  object CheckBox21: TCheckBox
    Left = 160
    Top = 8
    Width = 50
    Height = 17
    Caption = '2.1'
    TabOrder = 2
  end
  object CheckBox25: TCheckBox
    Left = 221
    Top = 8
    Width = 50
    Height = 17
    Caption = '2.5'
    TabOrder = 3
  end
  object CheckBox30: TCheckBox
    Left = 278
    Top = 8
    Width = 50
    Height = 17
    Caption = '3.0'
    TabOrder = 4
  end
  object EditPathFirebird: TEdit
    Left = 8
    Top = 48
    Width = 497
    Height = 21
    ReadOnly = True
    TabOrder = 5
    Text = 'EditPathFirebird'
  end
  object ButtonGetPathFirebird: TButton
    Left = 523
    Top = 46
    Width = 225
    Height = 25
    Caption = 'get Path Firebird'
    TabOrder = 6
    OnClick = ButtonGetPathFirebirdClick
  end
  object ListBoxProcessos: TListBox
    Left = 8
    Top = 141
    Width = 740
    Height = 375
    ItemHeight = 13
    TabOrder = 7
  end
  object ButtonProcessosRodandoComPath: TButton
    Left = 8
    Top = 110
    Width = 411
    Height = 25
    Caption = 'Processos Rodando com Path'
    TabOrder = 8
    OnClick = ButtonProcessosRodandoComPathClick
  end
  object OpenDialog1: TOpenDialog
    Left = 360
    Top = 88
  end
end
