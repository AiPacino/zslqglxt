object FormatBkZy: TFormatBkZy
  Left = 0
  Top = 0
  ActiveControl = cbb_NewZy
  BorderStyle = bsDialog
  Caption = #19987#19994#35268#33539#21517#26684#24335#21270
  ClientHeight = 318
  ClientWidth = 464
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
  object lbl_NewKl: TLabel
    Left = 32
    Top = 199
    Width = 72
    Height = 14
    Caption = #35268#33539#19987#19994#21517#65306
  end
  object Label3: TLabel
    Left = 44
    Top = 155
    Width = 60
    Height = 14
    Caption = #21407#22987#19987#19994#65306
    Enabled = False
  end
  object Bevel1: TBevel
    Left = 20
    Top = 246
    Width = 434
    Height = 8
    Shape = bsTopLine
  end
  object lbl_1: TLabel
    Left = 68
    Top = 22
    Width = 36
    Height = 14
    Caption = #30465#20221#65306
    Enabled = False
  end
  object lbl_2: TLabel
    Left = 44
    Top = 111
    Width = 60
    Height = 14
    Caption = #32771#28857#21517#31216#65306
    Enabled = False
  end
  object lbl_lbl1: TLabel
    Left = 44
    Top = 66
    Width = 60
    Height = 14
    Caption = #25215#32771#38498#31995#65306
    Enabled = False
  end
  object lbledt_Zy: TEdit
    Left = 110
    Top = 152
    Width = 324
    Height = 22
    ReadOnly = True
    TabOrder = 0
  end
  object cbb_NewZy: TDBComboBoxEh
    Left = 110
    Top = 196
    Width = 326
    Height = 22
    EditButtons = <>
    Items.Strings = (
      #25991#21490
      #29702#24037
      #33402#26415
      #20307#32946
      #38899#20048)
    TabOrder = 1
    Visible = True
    OnChange = cbb_NewZyChange
  end
  object btn_OK: TBitBtn
    Left = 262
    Top = 267
    Width = 75
    Height = 25
    Caption = #30830#23450#25191#34892
    Enabled = False
    ModalResult = 1
    TabOrder = 2
    OnClick = btn_OKClick
  end
  object btn_Cancel: TBitBtn
    Left = 352
    Top = 267
    Width = 75
    Height = 25
    Caption = #20851#38381'[&C]'
    ModalResult = 2
    TabOrder = 3
    OnClick = btn_CancelClick
  end
  object edt_sf: TEdit
    Left = 110
    Top = 19
    Width = 324
    Height = 22
    Enabled = False
    TabOrder = 4
  end
  object edt_Kd: TEdit
    Left = 110
    Top = 107
    Width = 324
    Height = 22
    Enabled = False
    TabOrder = 5
  end
  object edt_Yx: TEdit
    Left = 110
    Top = 63
    Width = 324
    Height = 22
    Enabled = False
    TabOrder = 6
  end
end
