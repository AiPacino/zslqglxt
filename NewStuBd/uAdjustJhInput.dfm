object AdjustJhInput: TAdjustJhInput
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #35745#21010#35843#25972#24405#20837
  ClientHeight = 302
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object lbl1: TLabel
    Left = 52
    Top = 25
    Width = 36
    Height = 14
    Caption = #30465#20221#65306
  end
  object lbl2: TLabel
    Left = 28
    Top = 84
    Width = 60
    Height = 14
    Caption = #35843#25972#19987#19994#65306
  end
  object lbl3: TLabel
    Left = 52
    Top = 114
    Width = 36
    Height = 14
    Caption = #31185#31867#65306
  end
  object lbl4: TLabel
    Left = 28
    Top = 143
    Width = 60
    Height = 14
    Caption = #21407#35745#21010#25968#65306
  end
  object lbl5: TLabel
    Left = 40
    Top = 229
    Width = 48
    Height = 14
    Caption = #22686#20943#25968#65306
  end
  object bvl1: TBevel
    Left = 16
    Top = 202
    Width = 374
    Height = 9
    Shape = bsBottomLine
  end
  object Label1: TLabel
    Left = 28
    Top = 54
    Width = 60
    Height = 14
    Caption = #19987#19994#31867#21035#65306
  end
  object lbl6: TLabel
    Left = 200
    Top = 143
    Width = 60
    Height = 14
    Caption = #24050#35843#25972#25968#65306
  end
  object lbl7: TLabel
    Left = 16
    Top = 175
    Width = 72
    Height = 14
    Caption = #21097#20313#35745#21010#25968#65306
  end
  object cbb_Sf: TDBComboBoxEh
    Left = 92
    Top = 23
    Width = 265
    Height = 22
    EditButtons = <>
    TabOrder = 0
    Visible = True
    OnChange = cbb_SfChange
  end
  object cbb_Zy: TDBComboBoxEh
    Left = 92
    Top = 82
    Width = 265
    Height = 22
    EditButtons = <>
    TabOrder = 2
    Visible = True
    OnChange = cbb_ZyChange
  end
  object cbb_Kl: TDBComboBoxEh
    Left = 92
    Top = 111
    Width = 265
    Height = 22
    EditButtons = <>
    TabOrder = 3
    Visible = True
    OnChange = cbb_KlChange
  end
  object edt_Count: TEdit
    Left = 92
    Top = 226
    Width = 265
    Height = 22
    TabOrder = 5
    OnChange = edt_CountChange
  end
  object edt_OldCount: TDBEditEh
    Left = 92
    Top = 140
    Width = 93
    Height = 22
    EditButtons = <>
    Enabled = False
    TabOrder = 4
    Visible = True
    OnChange = edt_OldCountChange
  end
  object pnl_1: TPanel
    Left = 0
    Top = 263
    Width = 402
    Height = 39
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 6
    DesignSize = (
      402
      39)
    object btn_Post: TBitBtn
      Left = 196
      Top = 7
      Width = 78
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #25552#20132
      Enabled = False
      ModalResult = 1
      TabOrder = 0
      OnClick = btn_PostClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000320B0000320B00000001000000000000000000003300
        00006600000099000000CC000000FF0000000033000033330000663300009933
        0000CC330000FF33000000660000336600006666000099660000CC660000FF66
        000000990000339900006699000099990000CC990000FF99000000CC000033CC
        000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
        0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
        330000333300333333006633330099333300CC333300FF333300006633003366
        33006666330099663300CC663300FF6633000099330033993300669933009999
        3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
        330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
        66006600660099006600CC006600FF0066000033660033336600663366009933
        6600CC336600FF33660000666600336666006666660099666600CC666600FF66
        660000996600339966006699660099996600CC996600FF99660000CC660033CC
        660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
        6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
        990000339900333399006633990099339900CC339900FF339900006699003366
        99006666990099669900CC669900FF6699000099990033999900669999009999
        9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
        990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
        CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
        CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
        CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
        CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
        CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
        FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
        FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
        FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
        FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
        000000808000800000008000800080800000C0C0C00080808000191919004C4C
        4C00B2B2B200E5E5E5005A1E1E00783C3C0096646400C8969600FFC8C800465F
        82005591B9006EB9D7008CD2E600B4E6F000D8E9EC0099A8AC00646F7100E2EF
        F100C56A31000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000EEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE0909
        EEEEEEEEEEEEEEEEEEEEEEEEEEEE8181EEEEEEEEEEEEEEEEEEEEEEEEEE091010
        09EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEEEEEEEE09101010
        1009EEEEEEEEEEEEEEEEEEEE81ACACACAC81EEEEEEEEEEEEEEEEEE0910101010
        101009EEEEEEEEEEEEEEEE81ACACACACACAC81EEEEEEEEEEEEEEEE0910100909
        10101009EEEEEEEEEEEEEE81ACAC8181ACACAC81EEEEEEEEEEEEEE091009EEEE
        0910101009EEEEEEEEEEEE81AC81EEEE81ACACAC81EEEEEEEEEEEE0909EEEEEE
        EE0910101009EEEEEEEEEE8181EEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEE
        EEEE0910101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEE
        EEEEEE0910101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEE
        EEEEEEEE09101009EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEE
        EEEEEEEEEE091009EEEEEEEEEEEEEEEEEEEEEEEEEE81AC81EEEEEEEEEEEEEEEE
        EEEEEEEEEEEE0909EEEEEEEEEEEEEEEEEEEEEEEEEEEE8181EEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
      NumGlyphs = 2
    end
    object btn_Exit: TBitBtn
      Left = 306
      Top = 7
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20851#38381'[&C]'
      ModalResult = 2
      TabOrder = 1
      OnClick = btn_ExitClick
    end
  end
  object cbb_ZyLb: TDBComboBoxEh
    Left = 92
    Top = 52
    Width = 265
    Height = 22
    EditButtons = <>
    TabOrder = 1
    Visible = True
    OnChange = cbb_ZyLbChange
  end
  object edt_oldzjs: TDBEditEh
    Left = 264
    Top = 140
    Width = 93
    Height = 22
    EditButtons = <>
    Enabled = False
    TabOrder = 7
    Visible = True
    OnChange = edt_OldCountChange
  end
  object edt_Syjhs: TDBEditEh
    Left = 92
    Top = 172
    Width = 93
    Height = 22
    EditButtons = <>
    Enabled = False
    TabOrder = 8
    Visible = True
  end
  object cds_Zy: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#35745#21010#35843#25972#26126#32454#34920
    Params = <>
    Left = 584
    Top = 240
  end
  object cds_Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 128
  end
end