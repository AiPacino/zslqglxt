object SelectYxKdZy: TSelectYxKdZy
  Left = 0
  Top = 0
  ActiveControl = btn_Exit
  BorderStyle = bsDialog
  Caption = #32771#28857#21450#19987#19994#36873#25321#65306
  ClientHeight = 249
  ClientWidth = 383
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel
    Left = 34
    Top = 33
    Width = 60
    Height = 14
    Caption = #25215#32771#38498#31995#65306
  end
  object lbl3: TLabel
    Left = 34
    Top = 102
    Width = 44
    Height = 14
    Caption = #32771'  '#28857#65306
  end
  object lbl4: TLabel
    Left = 34
    Top = 137
    Width = 44
    Height = 14
    Caption = #19987'  '#19994#65306
  end
  object lbl2: TLabel
    Left = 34
    Top = 67
    Width = 44
    Height = 14
    Caption = #30465'  '#20221#65306
  end
  object cbb_yx: TDBComboBoxEh
    Left = 102
    Top = 31
    Width = 250
    Height = 22
    EditButtons = <>
    Items.Strings = (
      #33402#26415#35774#35745#23398#38498
      #38899#20048#23398#38498)
    TabOrder = 0
    Text = #33402#26415#35774#35745#23398#38498
    Visible = True
    OnChange = cbb_KdChange
  end
  object cbb_Kd: TDBComboBoxEh
    Left = 102
    Top = 100
    Width = 250
    Height = 22
    EditButtons = <>
    TabOrder = 1
    Visible = True
    OnButtonDown = cbb_KdButtonDown
    OnChange = cbb_KdChange
  end
  object cbb_Zy: TDBComboBoxEh
    Left = 102
    Top = 134
    Width = 250
    Height = 22
    EditButtons = <>
    TabOrder = 2
    Visible = True
    OnButtonDown = cbb_ZyButtonDown
    OnChange = cbb_KdChange
  end
  object pnl1: TPanel
    Left = 0
    Top = 208
    Width = 383
    Height = 41
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 3
    object btn_OK: TBitBtn
      Left = 123
      Top = 5
      Width = 75
      Height = 25
      Caption = #30830#23450
      Enabled = False
      ModalResult = 1
      TabOrder = 0
    end
    object btn_Exit: TBitBtn
      Left = 262
      Top = 5
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 3
      TabOrder = 1
      OnClick = btn_ExitClick
      NumGlyphs = 2
    end
  end
  object cbb_Sf: TDBComboBoxEh
    Left = 102
    Top = 65
    Width = 250
    Height = 22
    EditButtons = <>
    TabOrder = 4
    Visible = True
    OnButtonDown = cbb_SfButtonDown
    OnChange = cbb_KdChange
  end
end
