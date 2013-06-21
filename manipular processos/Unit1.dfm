object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 430
  ClientWidth = 794
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  DesignSize = (
    794
    430)
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 8
    Top = 8
    Width = 122
    Height = 25
    Caption = 'Listar Processos'
    TabOrder = 0
    OnClick = Button1Click
  end
  object ListBoxProcessos: TListBox
    Left = 136
    Top = 8
    Width = 650
    Height = 414
    Anchors = [akLeft, akTop, akRight, akBottom]
    ItemHeight = 13
    TabOrder = 1
    OnDblClick = ListBoxProcessosDblClick
    ExplicitWidth = 303
    ExplicitHeight = 186
  end
end
