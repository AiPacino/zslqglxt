object FileBrowse: TFileBrowse
  Left = 0
  Top = 0
  Anchors = [akTop, akRight]
  Caption = #24405#21462#25991#20214#21450#25805#20316#35268#33539#26597#35810
  ClientHeight = 567
  ClientWidth = 865
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object pnl1: TPanel
    Left = 0
    Top = 525
    Width = 865
    Height = 42
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      865
      42)
    object btn_Exit: TBitBtn
      Left = 771
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20851#38381'[&C]'
      TabOrder = 5
      OnClick = btn_ExitClick
    end
    object btn_SaveAs: TBitBtn
      Left = 671
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #21478#23384#20026'...'
      TabOrder = 4
      OnClick = btn_SaveAsClick
    end
    object btn_Save: TBitBtn
      Left = 454
      Top = 10
      Width = 78
      Height = 25
      Caption = #20445#23384
      TabOrder = 3
      Visible = False
      OnClick = btn_SaveClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000750E0000750E00000001000000000000000000003300
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
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE09090909
        090909090909090909EEEEEE81818181818181818181818181EEEE09101009E3
        1009E3E3E309101009EEEE81ACAC81E3AC81E3E3E381ACAC81EEEE09101009E3
        1009E3E3E309101009EEEE81ACAC81E3AC81E3E3E381ACAC81EEEE09101009E3
        1009E3E3E309101009EEEE81ACAC81E3AC81E3E3E381ACAC81EEEE09101009E3
        E3E3E3E3E309101009EEEE81ACAC81E3E3E3E3E3E381ACAC81EEEE0910101009
        090909090910101009EEEE81ACACAC818181818181ACACAC81EEEE0910101010
        101010101010101009EEEE81ACACACACACACACACACACACAC81EEEE0910100909
        090909090909101009EEEE81ACAC8181818181818181ACAC81EEEE091009D7D7
        D7D7D7D7D7D7091009EEEE81AC81D7D7D7D7D7D7D7D781AC81EEEE091009D709
        0909090909D7091009EEEE81AC81D7818181818181D781AC81EEEE091009D7D7
        D7D7D7D7D7D7091009EEEE81AC81D7D7D7D7D7D7D7D781AC81EEEE09E309D709
        0909090909D7090909EEEE81E381D7818181818181D7818181EEEE091009D7D7
        D7D7D7D7D7D7091009EEEE81AC81D7D7D7D7D7D7D7D781AC81EEEE0909090909
        090909090909090909EEEE8181818181818181818181818181EEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
      NumGlyphs = 2
    end
    object btn_Add: TBitBtn
      Left = 220
      Top = 10
      Width = 78
      Height = 25
      Caption = #26032#22686
      TabOrder = 0
      Visible = False
      OnClick = btn_AddClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000850B0000850B00000001000000000000000000003300
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
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        09090909EEEEEEEEEEEEEEEEEEEEEEEE81818181EEEEEEEEEEEEEEEEEEEEEEEE
        09101009EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEEEEEEEEEE
        09101009EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEEEEEEEEEE
        09101009EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEE09090909
        0910100909090909EEEEEEEE8181818181ACAC8181818181EEEEEEEE09101010
        1010101010101009EEEEEEEE81ACACACACACACACACACAC81EEEEEEEE09101010
        1010101010101009EEEEEEEE81ACACACACACACACACACAC81EEEEEEEE09090909
        0910100909090909EEEEEEEE8181818181ACAC8181818181EEEEEEEEEEEEEEEE
        09101009EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEEEEEEEEEE
        09101009EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEEEEEEEEEE
        09101009EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEEEEEEEEEE
        09090909EEEEEEEEEEEEEEEEEEEEEEEE81818181EEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
      NumGlyphs = 2
    end
    object btn_Del: TBitBtn
      Left = 298
      Top = 10
      Width = 78
      Height = 25
      Caption = #21024#38500
      TabOrder = 1
      Visible = False
      OnClick = btn_DelClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000850B0000850B00000001000000000000000000003300
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
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE09090909
        0909090909090909EEEEEEEE818181818181818181818181EEEEEEEE09101010
        1010101010101009EEEEEEEE81ACACACACACACACACACAC81EEEEEEEE09101010
        1010101010101009EEEEEEEE81ACACACACACACACACACAC81EEEEEEEE09090909
        0909090909090909EEEEEEEE818181818181818181818181EEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
      NumGlyphs = 2
    end
    object btn_Cancel: TBitBtn
      Left = 376
      Top = 10
      Width = 78
      Height = 25
      Caption = #21462#28040
      TabOrder = 2
      Visible = False
      OnClick = btn_CancelClick
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
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE09090909EE
        EEEEEEEE09090909EEEEEE81818181EEEEEEEEEE81818181EEEEEE0910101009
        EEEEEE0910101009EEEEEE81ACACAC81EEEEEE81ACACAC81EEEEEEEE09101010
        09EE0910101009EEEEEEEEEE81ACACAC81EE81ACACAC81EEEEEEEEEEEE091010
        100910101009EEEEEEEEEEEEEE81ACACAC81ACACAC81EEEEEEEEEEEEEEEE0910
        1010101009EEEEEEEEEEEEEEEEEE81ACACACACAC81EEEEEEEEEEEEEEEEEEEE09
        10101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEE0910
        1010101009EEEEEEEEEEEEEEEEEE81ACACACACAC81EEEEEEEEEEEEEEEE091010
        100910101009EEEEEEEEEEEEEE81ACACAC81ACACAC81EEEEEEEEEEEE09101010
        09EE0910101009EEEEEEEEEE81ACACAC81EE81ACACAC81EEEEEEEE0910101009
        EEEEEE0910101009EEEEEE81ACACAC81EEEEEE81ACACAC81EEEEEE09090909EE
        EEEEEEEE09090909EEEEEE81818181EEEEEEEEEE81818181EEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
      NumGlyphs = 2
    end
  end
  object grp3: TGroupBox
    Left = 0
    Top = 0
    Width = 217
    Height = 525
    Align = alLeft
    Caption = #25991#20214#39033#30446#65306
    TabOrder = 1
    object DBGridEh1: TDBGridEh
      Left = 2
      Top = 16
      Width = 213
      Height = 507
      Align = alClient
      AutoFitColWidths = True
      DataGrouping.GroupLevels = <>
      DataSource = DataSource1
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clBlack
      FooterFont.Height = -12
      FooterFont.Name = 'Tahoma'
      FooterFont.Style = []
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove]
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      SortLocal = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clBlack
      TitleFont.Height = -12
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          EditButtons = <>
          FieldName = #26631#39064
          Footers = <>
          Width = 174
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object pnl2: TPanel
    Left = 217
    Top = 0
    Width = 648
    Height = 525
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 2
    object grp2: TGroupBox
      Left = 0
      Top = 0
      Width = 648
      Height = 525
      Align = alClient
      Caption = #32534#36753#65306
      TabOrder = 0
      object pnl3: TPanel
        Left = 2
        Top = 16
        Width = 644
        Height = 9
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
        Visible = False
        DesignSize = (
          644
          9)
        object lbl1: TLabel
          Left = 16
          Top = 16
          Width = 60
          Height = 14
          Caption = #25991#20214#26631#39064#65306
        end
        object Label1: TLabel
          Left = 28
          Top = 50
          Width = 48
          Height = 14
          Caption = #25991#20214#21517#65306
        end
        object lbl2: TLabel
          Left = 16
          Top = 79
          Width = 60
          Height = 14
          Caption = #25991#20214#20869#23481#65306
        end
        object DBEditEh1: TDBEditEh
          Left = 82
          Top = 13
          Width = 551
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          DataField = #26631#39064
          DataSource = DataSource1
          EditButtons = <>
          TabOrder = 0
          Visible = True
        end
        object DBEditEh2: TDBEditEh
          Left = 82
          Top = 47
          Width = 463
          Height = 22
          Anchors = [akLeft, akTop, akRight]
          DataField = #25991#20214#21517
          DataSource = DataSource1
          EditButtons = <>
          TabOrder = 1
          Visible = True
        end
        object btn_Open: TBitBtn
          Left = 557
          Top = 46
          Width = 75
          Height = 25
          Anchors = [akTop, akRight]
          Caption = #25171#24320
          TabOrder = 2
          OnClick = btn_OpenClick
        end
      end
      object DBRichEdit1: TDBRichEdit
        Left = 2
        Top = 25
        Width = 644
        Height = 498
        Align = alClient
        DataField = #25991#20214#20869#23481
        DataSource = DataSource1
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        ScrollBars = ssVertical
        TabOrder = 1
        ExplicitTop = 121
        ExplicitHeight = 402
      end
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#24405#21462#35268#33539#25991#20214#34920
    Params = <>
    Left = 160
    Top = 256
  end
  object DataSource1: TDataSource
    AutoEdit = False
    DataSet = ClientDataSet1
    Left = 160
    Top = 296
  end
  object dlgSave1: TSaveDialog
    Left = 688
    Top = 464
  end
  object dlgOpen1: TOpenDialog
    DefaultExt = '*.rtf'
    Filter = 'Word'#25991#26723'(*.doc)|*.doc|RTF'#25991#26723'(*.rtf)|*.rtf|'#25152#26377#25991#26723'(*.*)|*.*'
    Left = 696
    Top = 56
  end
end
