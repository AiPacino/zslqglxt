object SelectYxKdZy: TSelectYxKdZy
  Left = 0
  Top = 0
  ActiveControl = btn_Exit
  BorderStyle = bsDialog
  Caption = #35780#20998#32771#28857#21450#19987#19994#36873#25321#65306
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
    Top = 67
    Width = 36
    Height = 14
    Caption = #32771#28857#65306
  end
  object lbl4: TLabel
    Left = 34
    Top = 102
    Width = 36
    Height = 14
    Caption = #19987#19994#65306
  end
  object cbb_yx: TComboBox
    Left = 102
    Top = 31
    Width = 174
    Height = 22
    ItemHeight = 14
    ItemIndex = 0
    TabOrder = 0
    Text = #33402#26415#35774#35745#23398#38498
    OnChange = cbb_yxChange
    Items.Strings = (
      #33402#26415#35774#35745#23398#38498
      #38899#20048#23398#38498)
  end
  object cbb_Kd: TComboBox
    Left = 102
    Top = 65
    Width = 252
    Height = 22
    ItemHeight = 14
    TabOrder = 1
    OnChange = cbb_KdChange
  end
  object cbb_Zy: TComboBox
    Left = 102
    Top = 99
    Width = 252
    Height = 22
    ItemHeight = 14
    TabOrder = 2
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
    ExplicitTop = 218
    ExplicitWidth = 442
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
end
