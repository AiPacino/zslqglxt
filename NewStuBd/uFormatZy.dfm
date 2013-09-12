object FormatZy: TFormatZy
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
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_NewKl: TLabel
    Left = 20
    Top = 213
    Width = 84
    Height = 13
    Caption = #26032#35268#33539#19987#19994#21517#65306
  end
  object Label1: TLabel
    Left = 68
    Top = 17
    Width = 36
    Height = 13
    Caption = #30465#20221#65306
    Enabled = False
  end
  object Label2: TLabel
    Left = 68
    Top = 71
    Width = 36
    Height = 13
    Caption = #25209#27425#65306
    Enabled = False
  end
  object Label3: TLabel
    Left = 44
    Top = 151
    Width = 60
    Height = 13
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
  object lbl1: TLabel
    Left = 68
    Top = 44
    Width = 36
    Height = 13
    Caption = #23618#27425#65306
    Enabled = False
  end
  object lbl2: TLabel
    Left = 56
    Top = 124
    Width = 48
    Height = 13
    Caption = #21407#31185#31867#65306
    Enabled = False
  end
  object lbl3: TLabel
    Left = 68
    Top = 97
    Width = 36
    Height = 13
    Caption = #31867#21035#65306
    Enabled = False
  end
  object lbl4: TLabel
    Left = 20
    Top = 179
    Width = 84
    Height = 13
    Caption = #21407#35268#33539#19987#19994#21517#65306
    Enabled = False
  end
  object lbledt_sf: TEdit
    Left = 110
    Top = 14
    Width = 324
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object lbledt_Pc: TEdit
    Left = 110
    Top = 68
    Width = 324
    Height = 21
    Enabled = False
    TabOrder = 2
  end
  object lbledt_Zy: TEdit
    Left = 160
    Top = 148
    Width = 274
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 6
  end
  object cbb_NewZy: TDBComboBoxEh
    Left = 110
    Top = 210
    Width = 326
    Height = 21
    EditButtons = <>
    Items.Strings = (
      #25991#21490
      #29702#24037
      #33402#26415
      #20307#32946
      #38899#20048)
    TabOrder = 7
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
    TabOrder = 8
    OnClick = btn_OKClick
  end
  object btn_Cancel: TBitBtn
    Left = 352
    Top = 267
    Width = 75
    Height = 25
    Caption = #20851#38381'[&C]'
    ModalResult = 2
    TabOrder = 9
    OnClick = btn_CancelClick
  end
  object lbledt_XlCc: TEdit
    Left = 110
    Top = 41
    Width = 324
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object lbledt_kl: TEdit
    Left = 110
    Top = 121
    Width = 324
    Height = 21
    Enabled = False
    TabOrder = 4
  end
  object chk_OnlySf: TCheckBox
    Left = 32
    Top = 271
    Width = 137
    Height = 17
    Caption = #20165#26684#24335#21270#24403#21069#30465#20221#35760#24405
    Checked = True
    Enabled = False
    State = cbChecked
    TabOrder = 10
    OnClick = chk_OnlySfClick
  end
  object lbledt_zydm: TEdit
    Left = 110
    Top = 148
    Width = 44
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 5
  end
  object lbledt_Lb: TEdit
    Left = 110
    Top = 94
    Width = 324
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object edt_oldzygfm: TEdit
    Left = 110
    Top = 178
    Width = 324
    Height = 21
    Enabled = False
    ReadOnly = True
    TabOrder = 11
  end
end
