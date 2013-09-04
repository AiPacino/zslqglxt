object ToolsMain: TToolsMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  Caption = #31995#32479#26381#21153#37197#32622#24037#20855
  ClientHeight = 284
  ClientWidth = 460
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnHide = CoolTrayIcon1MinimizeToTray
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object albl_Title: TCnAALabel
    Left = 53
    Top = 78
    Width = 362
    Height = 26
    ParentEffect.ParentFont = False
    Caption = #39640#25307#24405#21462#21450#25253#21040#31995#32479#26381#21153#37197#32622#31243#24207
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -24
    Font.Name = #26999#20307
    Font.Style = []
    Effect.FontEffect.Shadow.Enabled = True
  end
  object albl_Dwmc: TCnAALabel
    Left = 106
    Top = 141
    Width = 272
    Height = 22
    ParentEffect.ParentFont = False
    Caption = '---'#31995#32479#26410#27880#20876#65281#35831#23613#24555#27880#20876#65281
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -20
    Font.Name = #26999#20307
    Font.Style = []
    Effect.FontEffect.Shadow.Enabled = True
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 265
    Width = 460
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 0
    object RzImage_msg: TRzGlyphStatus
      Left = 422
      Top = 0
      Width = 38
      Height = 19
      Hint = #27491#22312#36830#25509#26381#21153#22120'......'
      FrameStyle = fsStatus
      Align = alRight
      ParentShowHint = False
      ShowHint = True
      Alignment = taCenter
      ImageIndex = 5
      ExplicitLeft = 395
    end
    object sp_SrvState: TRzStatusPane
      Left = 93
      Top = 0
      Width = 329
      Height = 19
      FrameStyle = fsStatus
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Caption = #27491#22312#33719#21462#26381#21153#22120#29366#24577'......'
      ExplicitLeft = 216
      ExplicitWidth = 173
    end
    object RzStatusPane1: TRzStatusPane
      Left = 0
      Top = 0
      Width = 93
      Height = 19
      FrameStyle = fsStatus
      Align = alLeft
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Alignment = taRightJustify
      Caption = #26381#21153#22120#29366#24577#65306
    end
  end
  object MainMenu1: TMainMenu
    Left = 136
    object N1: TMenuItem
      Caption = #31995#32479'[&S]'
      object mi_DbSet: TMenuItem
        Caption = #25968#25454#24211#36830#25509#35774#32622'[&D]'
        OnClick = mi_DbSetClick
      end
      object N2: TMenuItem
        Caption = #26381#21153#22120#21442#25968#35774#32622'[&S]'
        OnClick = N2Click
      end
      object N10: TMenuItem
        Caption = #29031#29255#23384#25918#36335#24452#35774#32622'[&P]'
        OnClick = N10Click
      end
      object N11: TMenuItem
        Caption = #31995#32479#26381#21153#21551#29992'/'#20572#27490
        OnClick = N11Click
      end
      object N12: TMenuItem
        Caption = '-'
      end
      object mi_BackUp_Restore: TMenuItem
        Caption = #25968#25454#22791#20221'/'#24674#22797
        OnClick = mi_BackUp_RestoreClick
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object mi_Hide: TMenuItem
        Caption = #38544#34255#26412#31383#21475'[&H]'
        OnClick = mi_HideClick
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object mi_Exit: TMenuItem
        Caption = #36864#20986'[&X]'
        OnClick = pi_ExitClick
      end
    end
    object N6: TMenuItem
      Caption = #24110#21161'[&H]'
      object I1: TMenuItem
        Caption = #24110#21161#32034#24341'[&I]'
        ShortCut = 112
      end
      object N7: TMenuItem
        Caption = #25216#26415#25903#25345'[&S]'
        OnClick = mi_UrlClick
      end
      object N3: TMenuItem
        Caption = #36719#20214#27880#20876'[&R]'
        OnClick = N3Click
      end
      object mi_Update: TMenuItem
        Caption = #22312#32447#21319#32423'[&U]'
        OnClick = mi_UpdateClick
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object A1: TMenuItem
        Caption = #20851#20110#26412#31995#32479'[&A]'
        OnClick = A1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 176
    object pi_Show: TMenuItem
      Caption = #26174#31034#20027#31383#21475'[&M]'
      OnClick = pi_ShowClick
    end
    object N9: TMenuItem
      AutoCheck = True
      Caption = #38378#28865#23567#22270#26631'[&H]'
      OnClick = N9Click
    end
    object mi_Url: TMenuItem
      Caption = #25216#26415#25903#25345#32593#31449'[&S]'
      OnClick = mi_UrlClick
    end
    object pi_ShowHint: TMenuItem
      Caption = '-'
    end
    object pi_Exit: TMenuItem
      Caption = #36864#20986'[&X]'
      OnClick = pi_ExitClick
    end
  end
  object CoolTrayIcon1: TCoolTrayIcon
    IconList = ImageList1
    CycleInterval = 500
    Hint = #26032#29983#24405#21462#25253#21040#31995#32479#23567#31934#28789
    Icon.Data = {
      0000010001001010200000000000680400001600000028000000100000002000
      0000010020000000000000040000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC9966009933000099330000993300009933000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000CC99
      6600993300000000000000000000000000000000000099330000993300000000
      0000000000000000000099330000000000000000000000000000000000009933
      0000000000000000000000000000000000000000000000000000000000009933
      0000000000009933000099330000000000000000000000000000000000009933
      0000000000000000000000000000000000000000000000000000000000000000
      0000993300009933000099330000000000000000000000000000000000009933
      0000000000000000000000000000000000000000000000000000000000009933
      000099330000993300009933000000000000000000000000000000000000CC99
      6600993300000000000000000000000000000000000000000000993300009933
      0000993300009933000099330000000000000000000000000000000000000000
      000099330000CC99660000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000CC9966009933000000000000000000000000
      0000000000000000000099330000993300009933000099330000993300000000
      00000000000000000000000000000000000099330000CC996600000000000000
      0000000000000000000099330000993300009933000099330000000000000000
      0000000000000000000000000000000000000000000099330000000000000000
      0000000000000000000099330000993300009933000000000000000000000000
      0000000000000000000000000000000000000000000099330000000000000000
      0000000000000000000099330000993300000000000099330000000000000000
      0000000000000000000000000000000000000000000099330000000000000000
      0000000000000000000099330000000000000000000000000000993300009933
      00000000000000000000000000000000000099330000CC996600000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000099330000993300009933000099330000CC99660000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      000083FF00003CEF00007F4F00007F8F00007F0F00003E0F00009FFF0000FFF3
      0000E0F90000E1FD0000E3FD0000E5FD0000EE790000FF830000FFFF0000}
    IconVisible = True
    IconIndex = 0
    PopupMenu = PopupMenu1
    LeftPopup = True
    MinimizeToTray = True
    OnDblClick = CoolTrayIcon1DblClick
    OnBalloonHintClick = CoolTrayIcon1BalloonHintClick
    OnMinimizeToTray = CoolTrayIcon1MinimizeToTray
    Left = 208
  end
  object tmr_AutoBackup: TTimer
    Interval = 4000
    OnTimer = tmr_AutoBackupTimer
    Left = 280
  end
  object auAutoUpgrader1: TauAutoUpgrader
    InfoFile.Files.Strings = (
      'http://vir.jxstnu.edu.cn/jcgl/')
    InfoFileURL = 'http://vir.jxstnu.edu.cn/NetPay/download/AutoUpdte.inf'
    VersionControl = byNumber
    VersionDate = '2013-09-04 00:00:00'
    VersionDateAutoSet = True
    OnFileStart = auAutoUpgrader1FileStart
    OnDoOwnCloseAppMethod = auAutoUpgrader1DoOwnCloseAppMethod
    OnAfterRestart = auAutoUpgrader1AfterRestart
    Left = 80
  end
  object ImageList1: TImageList
    Left = 248
    Bitmap = {
      494C010102000400200010001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000001000000001002000000000000010
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CC996600993300009933
      0000993300009933000000000000000000000000000000000000000000000000
      00000000000000000000000000000000000000000000CCCCCC00999999009999
      9900999999009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC99660099330000000000000000
      0000000000000000000099330000993300000000000000000000000000009933
      000000000000000000000000000000000000CCCCCC0099999900000000000000
      0000000000000000000099999900999999000000000000000000000000009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009933000000000000000000000000
      0000000000000000000000000000000000009933000000000000993300009933
      0000000000000000000000000000000000009999990000000000000000000000
      0000000000000000000000000000000000009999990000000000999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009933000000000000000000000000
      0000000000000000000000000000000000000000000099330000993300009933
      0000000000000000000000000000000000009999990000000000000000000000
      0000000000000000000000000000000000000000000099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000009933000000000000000000000000
      0000000000000000000000000000000000009933000099330000993300009933
      0000000000000000000000000000000000009999990000000000000000000000
      0000000000000000000000000000000000009999990099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000CC99660099330000000000000000
      0000000000000000000000000000993300009933000099330000993300009933
      000000000000000000000000000000000000CCCCCC0099999900000000000000
      0000000000000000000000000000999999009999990099999900999999009999
      9900000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000CC9966000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900CCCCCC000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CC9966009933000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000CCCCCC009999990000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000993300009933000099330000993300000000000000000000000000000000
      00000000000099330000CC996600000000000000000000000000000000009999
      9900999999009999990099999900999999000000000000000000000000000000
      00000000000099999900CCCCCC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000993300009933000099330000000000000000000000000000000000000000
      0000000000000000000099330000000000000000000000000000000000009999
      9900999999009999990099999900000000000000000000000000000000000000
      0000000000000000000099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000993300009933000000000000000000000000000000000000000000000000
      0000000000000000000099330000000000000000000000000000000000009999
      9900999999009999990000000000000000000000000000000000000000000000
      0000000000000000000099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000993300000000000099330000000000000000000000000000000000000000
      0000000000000000000099330000000000000000000000000000000000009999
      9900999999000000000099999900000000000000000000000000000000000000
      0000000000000000000099999900000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009933
      0000000000000000000000000000993300009933000000000000000000000000
      00000000000099330000CC996600000000000000000000000000000000009999
      9900000000000000000000000000999999009999990000000000000000000000
      00000000000099999900CCCCCC00000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099330000993300009933
      000099330000CC99660000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000099999900999999009999
      990099999900CCCCCC0000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000424D3E000000000000003E000000
      2800000040000000100000000100010000000000800000000000000000000000
      000000000000000000000000FFFFFF00FFFFFFFF0000000083FF83FF00000000
      3CEF3CEF000000007F4F7F4F000000007F8F7F8F000000007F0F7F0F00000000
      3E0F3E0F000000009FFF9FFF00000000FFF3FFF300000000E0F9E0F900000000
      E1FDE1FD00000000E3FDE3FD00000000E5FDE5FD00000000EE79EE7900000000
      FF83FF8300000000FFFFFFFF0000000000000000000000000000000000000000
      000000000000}
  end
end
