object ChangeZy: TChangeZy
  Left = 0
  Top = 0
  ActiveControl = edt_Value
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26356#25442#19987#19994#22788#29702
  ClientHeight = 410
  ClientWidth = 601
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 601
    Height = 89
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object bvl1: TBevel
      Left = 6
      Top = 40
      Width = 589
      Height = 9
      Shape = bsTopLine
    end
    object lbl1: TLabel
      Left = 24
      Top = 56
      Width = 36
      Height = 14
      Caption = #22995#21517#65306
      FocusControl = edt_Xm
    end
    object lbl2: TLabel
      Left = 145
      Top = 56
      Width = 48
      Height = 14
      Caption = #32771#29983#21495#65306
      FocusControl = edt_Ksh
    end
    object lbl3: TLabel
      Left = 354
      Top = 56
      Width = 36
      Height = 14
      Caption = #30465#20221#65306
      FocusControl = edt_Sf
    end
    object lbl8: TLabel
      Left = 464
      Top = 56
      Width = 60
      Height = 14
      Caption = #19987#19994#31867#21035#65306
      FocusControl = edt_Kl
    end
    object lbl11: TLabel
      Left = 6
      Top = 12
      Width = 91
      Height = 14
      Caption = #26032#29983#20449#24687#26597#35810#65306
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lbl12: TLabel
      Left = 469
      Top = 13
      Width = 17
      Height = 14
      Caption = '(*)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Image1: TImage
      Left = 296
      Top = 18
      Width = 105
      Height = 105
    end
    object cbb_Field: TDBComboBoxEh
      Left = 102
      Top = 9
      Width = 86
      Height = 22
      Alignment = taCenter
      EditButtons = <>
      Items.Strings = (
        #27969#27700#21495
        #36890#30693#20070#32534#21495
        #32771#29983#21495
        #32771#29983#22995#21517
        #30465#20221
        #24405#21462#19987#19994
        #19987#19994#31867#21035)
      KeyItems.Strings = (
        #27969#27700#21495
        #36890#30693#20070#32534#21495
        #32771#29983#21495
        #32771#29983#22995#21517
        #30465#20221
        #24405#21462#19987#19994#35268#33539#21517
        #19987#19994#31867#21035)
      TabOrder = 0
      Text = #36890#30693#20070#32534#21495
      Visible = True
    end
    object edt_Value: TEdit
      Left = 195
      Top = 9
      Width = 268
      Height = 22
      CharCase = ecUpperCase
      TabOrder = 1
      OnChange = edt_ValueChange
      OnKeyPress = edt_ValueKeyPress
    end
    object btn_Search: TBitBtn
      Left = 508
      Top = 7
      Width = 75
      Height = 25
      Caption = #26597#35810'[&S]'
      TabOrder = 2
      OnClick = btn_SearchClick
    end
    object edt_Xm: TDBEdit
      Left = 60
      Top = 53
      Width = 72
      Height = 22
      DataField = #32771#29983#22995#21517
      DataSource = DataSource1
      Enabled = False
      TabOrder = 3
    end
    object edt_Ksh: TDBEdit
      Left = 196
      Top = 53
      Width = 137
      Height = 22
      DataField = #32771#29983#21495
      DataSource = DataSource1
      Enabled = False
      TabOrder = 4
    end
    object edt_Sf: TDBEdit
      Left = 394
      Top = 53
      Width = 53
      Height = 22
      DataField = #30465#20221
      DataSource = DataSource1
      Enabled = False
      TabOrder = 5
    end
    object edt_Kl: TDBEdit
      Left = 524
      Top = 53
      Width = 74
      Height = 22
      DataField = #31867#21035
      DataSource = DataSource1
      Enabled = False
      TabOrder = 6
    end
  end
  object pgc1: TPageControl
    Left = 0
    Top = 89
    Width = 262
    Height = 276
    ActivePage = TabSheet1
    Align = alLeft
    TabOrder = 1
    object TabSheet1: TTabSheet
      Caption = #26087#19987#19994#20449#24687
      object Label1: TLabel
        Left = 20
        Top = 6
        Width = 72
        Height = 14
        Caption = #21407#24405#21462#19987#19994#65306
        FocusControl = edt_OldZy
      end
      object Label2: TLabel
        Left = 20
        Top = 62
        Width = 48
        Height = 14
        Caption = #21407#38498#31995#65306
        FocusControl = edt_OldYx
      end
      object lbl4: TLabel
        Left = 20
        Top = 117
        Width = 60
        Height = 14
        Caption = #25253#21040#26657#21306#65306
        FocusControl = edt_OldXq
      end
      object lbl9: TLabel
        Left = 20
        Top = 168
        Width = 60
        Height = 14
        Caption = #23398#21382#23618#27425#65306
        FocusControl = edt_OldXlcc
      end
      object edt_OldZy: TDBEdit
        Left = 42
        Top = 26
        Width = 205
        Height = 22
        DataField = #24405#21462#19987#19994#35268#33539#21517
        DataSource = DataSource1
        Enabled = False
        TabOrder = 0
      end
      object edt_OldYx: TDBEdit
        Left = 42
        Top = 82
        Width = 205
        Height = 22
        DataField = #38498#31995
        DataSource = DataSource1
        Enabled = False
        TabOrder = 1
      end
      object edt_OldXq: TDBEdit
        Left = 42
        Top = 137
        Width = 205
        Height = 22
        DataField = #25253#21040#26657#21306
        DataSource = DataSource1
        Enabled = False
        TabOrder = 2
      end
      object edt_OldXlcc: TDBEdit
        Left = 42
        Top = 186
        Width = 88
        Height = 22
        DataField = #23398#21382#23618#27425
        DataSource = DataSource1
        Enabled = False
        TabOrder = 3
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 365
    Width = 601
    Height = 45
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    object btn_OK: TBitBtn
      Left = 359
      Top = 11
      Width = 107
      Height = 25
      Caption = #24320#22987#26356#25442#19987#19994'[&O]'
      TabOrder = 0
      OnClick = btn_OKClick
    end
    object btn_Close: TBitBtn
      Left = 509
      Top = 11
      Width = 75
      Height = 25
      Caption = #20851#38381'[&C]'
      TabOrder = 1
      OnClick = btn_CloseClick
    end
    object btn_History: TBitBtn
      Left = 12
      Top = 11
      Width = 75
      Height = 25
      Caption = #21382#21490#35760#24405
      TabOrder = 2
      Visible = False
    end
    object btn_Design: TBitBtn
      Left = 102
      Top = 11
      Width = 75
      Height = 25
      Caption = #25253#34920#35774#35745'[&S]'
      Enabled = False
      TabOrder = 3
      Visible = False
      OnClick = btn_DesignClick
    end
  end
  object pgc2: TPageControl
    Left = 333
    Top = 89
    Width = 268
    Height = 276
    ActivePage = ts1
    Align = alClient
    TabOrder = 3
    object ts1: TTabSheet
      Caption = #26032#19987#19994#20449#24687
      object lbl5: TLabel
        Left = 20
        Top = 7
        Width = 72
        Height = 14
        Caption = #26032#24405#21462#19987#19994#65306
        FocusControl = edt_NewZy
      end
      object lbl6: TLabel
        Left = 20
        Top = 63
        Width = 48
        Height = 14
        Caption = #26032#38498#31995#65306
        FocusControl = edt_NewYx
      end
      object lbl7: TLabel
        Left = 20
        Top = 118
        Width = 60
        Height = 14
        Caption = #25253#21040#26657#21306#65306
        FocusControl = edt_NewXq
      end
      object lbl10: TLabel
        Left = 20
        Top = 168
        Width = 60
        Height = 14
        Caption = #23398#21382#23618#27425#65306
        FocusControl = dbedt10
      end
      object edt_NewZy: TDBComboBoxEh
        Left = 42
        Top = 27
        Width = 205
        Height = 22
        EditButtons = <>
        TabOrder = 0
        Visible = True
        OnChange = edt_NewZyChange
      end
      object edt_NewYx: TEdit
        Left = 42
        Top = 83
        Width = 205
        Height = 22
        Enabled = False
        TabOrder = 1
      end
      object edt_NewXq: TEdit
        Left = 42
        Top = 138
        Width = 205
        Height = 22
        Enabled = False
        TabOrder = 2
      end
      object dbedt10: TDBEdit
        Left = 42
        Top = 186
        Width = 88
        Height = 22
        DataField = #23398#21382#23618#27425
        DataSource = DataSource1
        Enabled = False
        TabOrder = 3
      end
    end
  end
  object pnl1: TPanel
    Left = 262
    Top = 89
    Width = 71
    Height = 276
    Align = alLeft
    BevelOuter = bvNone
    TabOrder = 4
    object btn1: TSpeedButton
      Left = 6
      Top = 21
      Width = 59
      Height = 255
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000610D0000610D00000001000000000000000000003300
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
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE0909EE
        EE0909EEEEEEEEEEEEEEEEEEEE8181EEEE8181EEEEEEEEEEEEEEEEEEEE091009
        EE091009EEEEEEEEEEEEEEEEEE81AC81EE81AC81EEEEEEEEEEEEEEEEEE091010
        0909101009EEEEEEEEEEEEEEEE81ACAC8181ACAC81EEEEEEEEEEEE0909091010
        100910101009EEEEEEEEEE818181ACACAC81ACACAC81EEEEEEEEEE0910101010
        10100910101009EEEEEEEE81ACACACACACAC81ACACAC81EEEEEEEE0910101010
        1010100910101009EEEEEE81ACACACACACACAC81ACACAC81EEEEEE0910101010
        101010100910101009EEEE81ACACACACACACACAC81ACACAC81EEEE0910101010
        1010100910101009EEEEEE81ACACACACACACAC81ACACAC81EEEEEE0910101010
        10100910101009EEEEEEEE81ACACACACACAC81ACACAC81EEEEEEEE0909091010
        100910101009EEEEEEEEEE818181ACACAC81ACACAC81EEEEEEEEEEEEEE091010
        0909101009EEEEEEEEEEEEEEEE81ACAC8181ACAC81EEEEEEEEEEEEEEEE091009
        EE091009EEEEEEEEEEEEEEEEEE81AC81EE81AC81EEEEEEEEEEEEEEEEEE0909EE
        EE0909EEEEEEEEEEEEEEEEEEEE8181EEEE8181EEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
      NumGlyphs = 2
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 120
    Top = 352
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 152
    Top = 352
  end
  object cds_Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 280
    Top = 264
  end
end
