object SrvSetMain: TSrvSetMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #31995#32479#26381#21153#37197#32622#24037#20855'  ver1.0'
  ClientHeight = 236
  ClientWidth = 376
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  Position = poScreenCenter
  OnCanResize = FormCanResize
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnHide = CoolTrayIcon1MinimizeToTray
  PixelsPerInch = 96
  TextHeight = 13
  object CnAALabel1: TCnAALabel
    Left = 35
    Top = 55
    Width = 314
    Height = 26
    ParentEffect.ParentFont = False
    Caption = #23398#21592#25910#32564#36153#31649#29702#31995#32479#37197#32622#31243#24207
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -24
    Font.Name = #26999#20307'_GB2312'
    Font.Style = []
    Effect.FontEffect.Shadow.Enabled = True
  end
  object lbl_Dwmc: TCnAALabel
    Left = 61
    Top = 118
    Width = 263
    Height = 21
    ParentEffect.ParentFont = False
    Caption = '---'#31995#32479#26410#27880#20876#65281#35831#23613#24555#27880#20876#65281
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = #26999#20307'_GB2312'
    Font.Style = []
    Effect.FontEffect.Shadow.Enabled = True
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 217
    Width = 376
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 0
    object RzImage_msg: TRzGlyphStatus
      Left = 338
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
    object sp_Time: TRzStatusPane
      Left = 93
      Top = 0
      Width = 245
      Height = 19
      FrameStyle = fsStatus
      Align = alClient
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Caption = #31995#32479#24050#31283#23450#36816#34892#65306
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
      Caption = #31995#32479#21551#21160#26102#38388#65306
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
        Caption = #25216#26415#25903#25345#32593#31449
        OnClick = mi_UrlClick
      end
      object N3: TMenuItem
        Caption = #36719#20214#27880#20876
        OnClick = N3Click
      end
      object mi_Update: TMenuItem
        Caption = #22312#32447#21319#32423
        OnClick = mi_UpdateClick
      end
      object N8: TMenuItem
        Caption = '-'
      end
      object A1: TMenuItem
        Caption = #20851#20110'[&A]......'
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
    object mi_Url: TMenuItem
      Caption = #25216#26415#25903#25345#32593#31449
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
    CycleInterval = 0
    Hint = #25945#26448#31649#29702#31995#32479#23567#31934#28789
    Icon.Data = {
      0000010001001010200000000000680400001600000028000000100000002000
      0000010020000000000000040000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      00009C3100009C3100009C3100009C3100009C3100009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C310000000000000000
      00000000000000000000319CCE0000639C0000639C0000639C0000639C009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C310000000000000000
      00000000000000000000319CCE009CFFFF009CFFFF009CFFFF009CFFFF009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C310000000000000000
      00000000000000000000319CCE009CFFFF009CFFFF009CFFFF009CFFFF009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C310000000000000000
      00000000000000000000319CCE009CFFFF009CFFFF009CFFFF009CFFFF009C31
      00009C3100009C3100009C3100009C3100009C3100009C310000000000009C31
      00009C3100009C3100009C3100009C3100009C3100009C3100009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C00000000000000000000000000000000009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C3100009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C00000000000000000000000000000000009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C3100009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C00000000000000000000000000000000009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C3100009CFFFF009CFF
      FF009CFFFF009CFFFF0000639C00000000000000000000000000000000009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C310000319CCE00319C
      CE00319CCE00319CCE00319CCE00000000000000000000000000000000009C31
      0000CE9C6300CE9C6300CE9C6300CE9C6300CE9C63009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000009C31
      00009C3100009C3100009C3100009C3100009C3100009C310000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FFFF
      0000FF010000FF010000FF010000E0010000E0010000E0010000E0010000000F
      0000000F0000000F0000000F0000000F000001FF000001FF0000FFFF0000}
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
    InfoFileURL = 'http://vir.jxstnu.edu.cn/Jcgl/download/AutoUpdte.inf'
    VersionControl = byNumber
    VersionDate = '03/27/2009'
    VersionDateAutoSet = True
    ShowMessages = [mAskUpgrade, mConnLost, mLostFile, mNoUpdateAvailable, mPasswordRequest]
    OnDoOwnCloseAppMethod = auAutoUpgrader1DoOwnCloseAppMethod
    Left = 80
  end
end
