object FormatKL: TFormatKL
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #31185#31867#21517#31216#26684#24335#21270
  ClientHeight = 227
  ClientWidth = 387
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object lbl_NewKl: TLabel
    Left = 203
    Top = 74
    Width = 72
    Height = 13
    Caption = #35268#33539#31185#31867#21517#65306
  end
  object Label1: TLabel
    Left = 20
    Top = 20
    Width = 84
    Height = 13
    Caption = #35201#35268#33539#30340#30465#20221#65306
    Enabled = False
  end
  object Label2: TLabel
    Left = 203
    Top = 20
    Width = 84
    Height = 13
    Caption = #21407#22987#25209#27425#21517#31216#65306
    Enabled = False
  end
  object Label3: TLabel
    Left = 20
    Top = 74
    Width = 84
    Height = 13
    Caption = #21407#22987#31185#31867#21517#31216#65306
    Enabled = False
  end
  object Bevel1: TBevel
    Left = 9
    Top = 160
    Width = 371
    Height = 8
    Shape = bsTopLine
  end
  object lbl1: TLabel
    Left = 194
    Top = 101
    Width = 27
    Height = 16
    Caption = '==>'
    Font.Charset = ANSI_CHARSET
    Font.Color = clBlue
    Font.Height = -16
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lbledt_sf: TEdit
    Left = 45
    Top = 40
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object lbledt_pc: TEdit
    Left = 240
    Top = 40
    Width = 121
    Height = 21
    Enabled = False
    TabOrder = 1
  end
  object lbledt_KL: TEdit
    Left = 45
    Top = 97
    Width = 121
    Height = 21
    ReadOnly = True
    TabOrder = 2
  end
  object cbb_NewKL: TDBComboBoxEh
    Left = 240
    Top = 97
    Width = 121
    Height = 21
    EditButtons = <>
    Items.Strings = (
      #25991#21490
      #29702#24037
      #33402#26415
      #20307#32946
      #38899#20048)
    TabOrder = 3
    Visible = True
    OnChange = cbb_NewKLChange
  end
  object btn_OK: TBitBtn
    Left = 194
    Top = 186
    Width = 75
    Height = 25
    Caption = #30830#23450#25191#34892
    Enabled = False
    ModalResult = 1
    TabOrder = 4
    OnClick = btn_OKClick
  end
  object btn_Cancel: TBitBtn
    Left = 284
    Top = 186
    Width = 75
    Height = 25
    Caption = #20851#38381'[&C]'
    ModalResult = 2
    TabOrder = 5
    OnClick = btn_CancelClick
  end
end
