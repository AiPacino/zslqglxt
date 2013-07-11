object DbTools: TDbTools
  Left = 0
  Top = 0
  ActiveControl = edt_File
  Caption = #25968#25454#24211#25991#20214#27983#35272#24037#20855
  ClientHeight = 528
  ClientWidth = 809
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
  PixelsPerInch = 96
  TextHeight = 14
  object spl1: TSplitter
    Left = 0
    Top = 169
    Width = 809
    Height = 3
    Cursor = crVSplit
    Align = alTop
    Color = clSkyBlue
    ParentColor = False
    ExplicitLeft = -22
    ExplicitTop = 163
  end
  object grp1: TGroupBox
    Left = 0
    Top = 0
    Width = 809
    Height = 57
    Align = alTop
    Caption = #36873#25321#35201#27983#35272#30340#25968#25454#24211#25991#20214#65306
    TabOrder = 0
    DesignSize = (
      809
      57)
    object edt_File: TCnButtonEdit
      Left = 157
      Top = 24
      Width = 372
      Height = 21
      Hint = #25171#24320#25968#25454#24211#25991#20214
      ButtonFlat = False
      ButtonKind = bkLookup
      Anchors = [akLeft, akTop, akRight]
      AutoSize = False
      ParentShowHint = False
      ReadOnly = True
      ShowHint = True
      TabOrder = 1
      ButtonPic.Data = {
        FE040000424DFE040000000000003604000028000000140000000A0000000100
        080000000000C8000000330B0000330B00000001000000010000000000003300
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
        4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
        6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000232323232323
        2323232323232323232323232323232323232323232323232323232323232323
        2323232323232323232323232323232323232323232323232323232323232323
        2323232323232323232323E10023E10023E100232381D72381D72381D7232381
        E12381E12381E123238181238181238181232323232323232323232323232323
        2323232323232323232323232323232323232323232323232323232323232323
        2323232323232323232323232323232323232323232323232323232323232323
        2323}
      OnButtonClick = edt_FileButtonClick
    end
    object cbb_DbType: TDBComboBoxEh
      Left = 22
      Top = 24
      Width = 129
      Height = 22
      Alignment = taCenter
      EditButtons = <>
      Items.Strings = (
        'Paradox'#25991#20214'(*.db)'
        'dBase'#25991#20214'(*.dbf)'
        'VFP'#25991#20214'(*.dbf)'
        'Access'#25991#20214'(*.mdb)')
      KeyItems.Strings = (
        '*.db'
        '*.dbf'
        '*.dbf'
        '*.mdb')
      TabOrder = 0
      Text = 'Paradox'#25991#20214'(*.db)'
      Visible = True
    end
    object btn_Open: TBitBtn
      Left = 649
      Top = 21
      Width = 75
      Height = 25
      Hint = #25171#24320#25968#25454#34920
      Anchors = [akTop, akRight]
      Caption = #25171#24320
      Enabled = False
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btn_OpenClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000520B0000520B00000001000000000000000000003300
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
        EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEA378787878
        787878787878AAEEEEEEEE8181818181818181818181ACEEEEEEA3A3D5CECECE
        CECECECECEA378EEEEEE8181E3ACACACACACACACAC8181EEEEEEA3A3CED5D5D5
        D5D5D5D5D5CE78A3EEEE8181ACE3E3E3E3E3E3E3E3AC8181EEEEA3A3CED5D5D5
        D5D5D5D5D5CEAA78EEEE8181ACE3E3E3E3E3E3E3E3ACAC81EEEEA3CEA3D5D5D5
        D5D5D5D5D5CED578A3EE81AC81E3E3E3E3E3E3E3E3ACE38181EEA3CEAAAAD5D5
        D5D5D5D5D5CED5AA78EE81ACACACE3E3E3E3E3E3E3ACE3AC81EEA3D5CEA3D6D6
        D6D6D6D6D6D5D6D678EE81E3AC81E3E3E3E3E3E3E3E3E3E381EEA3D5D5CEA3A3
        A3A3A3A3A3A3A3A3CEEE81E3E3AC81818181818181818181ACEEA3D6D5D5D5D5
        D6D6D6D6D678EEEEEEEE81E3E3E3E3E3E3E3E3E3E381EEEEEEEEEEA3D6D6D6D6
        A3A3A3A3A3EEEEEEEEEEEE81E3E3E3E38181818181EEEEEEEEEEEEEEA3A3A3A3
        EEEEEEEEEEEEEE090909EEEE81818181EEEEEEEEEEEEEE818181EEEEEEEEEEEE
        EEEEEEEEEEEEEEEE0909EEEEEEEEEEEEEEEEEEEEEEEEEEEE8181EEEEEEEEEEEE
        EEEEEE09EEEEEE09EE09EEEEEEEEEEEEEEEEEE81EEEEEE81EE81EEEEEEEEEEEE
        EEEEEEEE090909EEEEEEEEEEEEEEEEEEEEEEEEEE818181EEEEEE}
      NumGlyphs = 2
    end
    object chk_ShowSqlEdit: TCheckBox
      Left = 732
      Top = 26
      Width = 66
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #25163#21160'SQL'
      TabOrder = 4
      OnClick = chk_ShowSqlEditClick
    end
    object cbb_TbName: TDBComboBoxEh
      Left = 535
      Top = 23
      Width = 109
      Height = 22
      Alignment = taCenter
      Anchors = [akTop, akRight]
      Enabled = False
      EditButtons = <>
      TabOrder = 2
      Visible = True
      OnChange = cbb_TbNameChange
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 481
    Width = 809
    Height = 47
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      809
      47)
    object lbl_Rec: TLabel
      Left = 103
      Top = 17
      Width = 48
      Height = 14
      Caption = #35760#24405#21495#65306
    end
    object btn_Exit: TBitBtn
      Left = 712
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20851#38381
      TabOrder = 0
      OnClick = btn_ExitClick
    end
    object chk_Filter: TCheckBox
      Left = 608
      Top = 14
      Width = 86
      Height = 17
      Anchors = [akRight, akBottom]
      Caption = #25171#24320#36807#28193#22120
      TabOrder = 1
      OnClick = chk_FilterClick
    end
    object chk_Edit: TCheckBox
      Left = 13
      Top = 16
      Width = 73
      Height = 17
      Caption = #20801#35768#32534#36753
      TabOrder = 2
      OnClick = chk_EditClick
    end
  end
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 172
    Width = 809
    Height = 309
    Align = alClient
    DataGrouping.GroupLevels = <>
    DataSource = DataSource1
    DrawMemoText = True
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clBlack
    FooterFont.Height = -12
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    IndicatorTitle.DropdownMenu = DM.PopupMenu1
    IndicatorTitle.ShowDropDownSign = True
    IndicatorTitle.TitleButton = True
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack, dghExtendVertLines]
    PopupMenu = pm2
    ReadOnly = True
    RowDetailPanel.Color = clBtnFace
    STFilter.InstantApply = True
    STFilter.Local = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clBlack
    TitleFont.Height = -12
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object pnl_SqlEdit: TPanel
    Left = 0
    Top = 57
    Width = 809
    Height = 112
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 3
    Visible = False
    DesignSize = (
      809
      112)
    object mmo_Sql: TMemo
      Left = 21
      Top = 6
      Width = 775
      Height = 69
      Anchors = [akLeft, akTop, akRight, akBottom]
      PopupMenu = pm1
      ScrollBars = ssVertical
      TabOrder = 0
    end
    object btn_ExecSql: TBitBtn
      Left = 22
      Top = 81
      Width = 75
      Height = 25
      Anchors = [akLeft, akBottom]
      Caption = #25191#34892'Sql'
      TabOrder = 1
      OnClick = btn_ExecSqlClick
    end
    object btn_OpenSql: TBitBtn
      Left = 720
      Top = 81
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #27983#35272#25968#25454
      TabOrder = 2
      OnClick = btn_OpenSqlClick
    end
  end
  object dlgOpen_1: TOpenDialog
    DefaultExt = '*.db'
    Filter = 
      'Paradox'#25991#20214'(*.db)|*.db|dBase'#25991#20214'(*.dbf)|*.dbf|VFP'#25991#20214'(*.dbf)|*.dbf|Acc' +
      'ess'#25991#20214'(*.mdb)|*.mdb'
    Title = #25171#24320#25968#25454#24211#25991#20214
    Left = 256
    Top = 16
  end
  object Con_BDE: TDatabase
    DatabaseName = 'MyBDE'
    DriverName = 'STANDARD'
    LoginPrompt = False
    Params.Strings = (
      
        'PATH=C:\Users\Administrator\Documents\.NacuesCStorage\Jiangsu\11' +
        '31800'
      'DEFAULT DRIVER=PARADOX')
    SessionName = 'Default'
    Left = 296
    Top = 16
  end
  object qry_BDE: TQuery
    AfterOpen = qry_BDEAfterOpen
    DatabaseName = 'MyBDE'
    Left = 328
    Top = 16
  end
  object qry_Temp: TQuery
    DatabaseName = 'MyBDE'
    Left = 368
    Top = 16
  end
  object DataSource1: TDataSource
    DataSet = qry_BDE
    OnDataChange = DataSource1DataChange
    Left = 480
    Top = 192
  end
  object qry_Access: TADOQuery
    Connection = Con_Access
    AfterOpen = qry_AccessAfterOpen
    Parameters = <>
    Left = 608
    Top = 192
  end
  object Con_Access: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=Test.mdb;Persist Se' +
      'curity Info=False'
    LoginPrompt = False
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 576
    Top = 192
  end
  object pm1: TPopupMenu
    Left = 464
    Top = 88
    object C1: TMenuItem
      Action = DM.EditCopy1
    end
    object T1: TMenuItem
      Action = DM.EditCut1
    end
    object P1: TMenuItem
      Action = DM.EditPaste1
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #20840#36873
      ShortCut = 16449
      OnClick = N2Click
    end
  end
  object qry_VFP: TADOQuery
    Connection = con_VFP
    CursorType = ctStatic
    AfterOpen = qry_AccessAfterOpen
    Parameters = <>
    SQL.Strings = (
      'select * from t_tddxx')
    Left = 608
    Top = 224
  end
  object con_VFP: TADOConnection
    ConnectionString = 
      'Provider=VFPOLEDB.1;Data Source=C:\Users\Administrator\Desktop;C' +
      'ollating Sequence=MACHINE;'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'VFPOLEDB.1'
    Left = 576
    Top = 224
  end
  object pm2: TPopupMenu
    Left = 480
    Top = 248
    object L1: TMenuItem
      Action = DM.act_Locate
    end
    object MenuItem4: TMenuItem
      Caption = '-'
    end
    object MenuItem1: TMenuItem
      Action = DM.EditCopy1
    end
    object MenuItem2: TMenuItem
      Action = DM.EditCut1
    end
    object MenuItem3: TMenuItem
      Action = DM.EditPaste1
    end
    object N3: TMenuItem
      Caption = '-'
    end
    object N4: TMenuItem
      Caption = #21305#37197#20013#25991#23383#27573#21517#31216
      OnClick = N4Click
    end
    object E1: TMenuItem
      Action = DM.act_DataExport
    end
  end
end
