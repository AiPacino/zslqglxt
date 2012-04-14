object ZySelect: TZySelect
  Left = 0
  Top = 0
  ActiveControl = chklst_Zy
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #35831#21246#36873#35201#22686#21152#30340#19987#19994
  ClientHeight = 410
  ClientWidth = 587
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 587
    Height = 369
    Align = alClient
    Caption = #19987#19994#20449#24687#65306
    TabOrder = 0
    object chklst_Zy: TRzCheckList
      Left = 2
      Top = 16
      Width = 583
      Height = 351
      Items.Strings = (
        'aa')
      Items.ItemEnabled = (
        True)
      Items.ItemState = (
        0)
      OnChange = chklst_ZyChange
      Align = alClient
      Columns = 3
      ShowItemHints = True
      HorzScrollBar = True
      ItemHeight = 22
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 369
    Width = 587
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      587
      41)
    object Label1: TLabel
      Left = 8
      Top = 13
      Width = 60
      Height = 14
      Caption = #19987#19994#31867#21035#65306
    end
    object btn_Select: TBitBtn
      Left = 388
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #30830#23450
      Enabled = False
      TabOrder = 0
      OnClick = btn_SelectClick
      Kind = bkOK
    end
    object btn_Close: TBitBtn
      Left = 484
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #21462#28040
      TabOrder = 1
      Kind = bkCancel
    end
    object cbb_Lb: TDBComboBoxEh
      Left = 67
      Top = 10
      Width = 121
      Height = 22
      EditButtons = <>
      TabOrder = 2
      Text = '=='#19981#38480'=='
      Visible = True
      OnChange = cbb_LbChange
    end
  end
end
