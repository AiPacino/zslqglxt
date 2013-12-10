object XkPwpf: TXkPwpf
  Left = 0
  Top = 0
  Caption = #35780#20998#31383#21475
  ClientHeight = 616
  ClientWidth = 966
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
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 14
  object bvl2: TBevel
    Left = 663
    Top = 0
    Width = 2
    Height = 597
    Align = alRight
    Shape = bsRightLine
    ExplicitLeft = 661
    ExplicitHeight = 605
  end
  object pnl_right: TPanel
    Left = 665
    Top = 0
    Width = 301
    Height = 597
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 301
      Height = 157
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
      object led_Time: TRzLEDDisplay
        Left = 9
        Top = 52
        Width = 273
        Height = 65
        Alignment = taCenter
        Caption = '00:00'
      end
      object lbl1: TLabel
        Left = 72
        Top = 16
        Width = 152
        Height = 23
        Caption = #32771#35797#35745#26102'('#20998#38047')'#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -19
        Font.Name = #26041#27491#23002#20307#31616#20307
        Font.Style = []
        ParentFont = False
      end
    end
    object grp1: TGroupBox
      Left = 0
      Top = 157
      Width = 301
      Height = 440
      Align = alClient
      Caption = #32771#29983#20449#24687#65306
      TabOrder = 1
      object lbl2: TLabel
        Left = 16
        Top = 64
        Width = 36
        Height = 14
        Caption = #32771#29983#21495
        FocusControl = dbedt1
      end
      object lbl3: TLabel
        Left = 16
        Top = 97
        Width = 48
        Height = 14
        Caption = #20934#32771#35777#21495
        FocusControl = dbedt2
      end
      object lbl4: TLabel
        Left = 16
        Top = 130
        Width = 48
        Height = 14
        Caption = #36523#20221#35777#21495
        FocusControl = dbedt3
      end
      object lbl5: TLabel
        Left = 16
        Top = 163
        Width = 48
        Height = 14
        Caption = #32771#29983#22995#21517
        FocusControl = dbedt4
      end
      object lbl6: TLabel
        Left = 16
        Top = 196
        Width = 24
        Height = 14
        Caption = #24615#21035
        FocusControl = dbedt5
      end
      object lbl7: TLabel
        Left = 16
        Top = 228
        Width = 48
        Height = 14
        Caption = #25253#32771#38498#31995
        FocusControl = dbedt6
      end
      object lbl8: TLabel
        Left = 16
        Top = 261
        Width = 48
        Height = 14
        Caption = #25253#32771#19987#19994
        FocusControl = dbedt7
      end
      object lbl9: TLabel
        Left = 16
        Top = 294
        Width = 48
        Height = 14
        Caption = #32852#31995#30005#35805
        FocusControl = dbedt8
      end
      object lbl10: TLabel
        Left = 16
        Top = 327
        Width = 48
        Height = 14
        Caption = #27605#19994#20013#23398
        FocusControl = dbedt9
      end
      object lbl11: TLabel
        Left = 16
        Top = 383
        Width = 48
        Height = 14
        Caption = #36890#20449#22320#22336
      end
      object lbl12: TLabel
        Left = 16
        Top = 360
        Width = 48
        Height = 14
        Caption = #37038#25919#32534#30721
        FocusControl = dbedt11
      end
      object lbl13: TLabel
        Left = 16
        Top = 29
        Width = 52
        Height = 14
        Caption = #20837#22330#21495#65306
        FocusControl = dbedt_Rch
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
      end
      object dbedt1: TDBText
        Left = 72
        Top = 63
        Width = 160
        Height = 22
        Color = clWhite
        DataField = #32771#29983#21495
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt2: TDBText
        Left = 72
        Top = 96
        Width = 160
        Height = 22
        Color = clWhite
        DataField = #20934#32771#35777#21495
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt3: TDBText
        Left = 72
        Top = 128
        Width = 160
        Height = 22
        Color = clWhite
        DataField = #36523#20221#35777#21495
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt4: TDBText
        Left = 72
        Top = 161
        Width = 160
        Height = 22
        Color = clWhite
        DataField = #22995#21517
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt5: TDBText
        Left = 72
        Top = 194
        Width = 32
        Height = 22
        Color = clWhite
        DataField = #24615#21035
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt6: TDBText
        Left = 72
        Top = 226
        Width = 222
        Height = 22
        Color = clWhite
        DataField = #25215#32771#38498#31995
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt7: TDBText
        Left = 72
        Top = 259
        Width = 222
        Height = 22
        Color = clWhite
        DataField = #19987#19994
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt8: TDBText
        Left = 72
        Top = 292
        Width = 222
        Height = 22
        Color = clWhite
        DataField = #32852#31995#30005#35805
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt9: TDBText
        Left = 72
        Top = 324
        Width = 222
        Height = 22
        Color = clWhite
        DataField = #27605#19994#20013#23398
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt11: TDBText
        Left = 72
        Top = 357
        Width = 88
        Height = 22
        Color = clWhite
        DataField = #37038#25919#32534#30721
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbmmo1: TDBText
        Left = 72
        Top = 384
        Width = 222
        Height = 44
        Color = clWhite
        DataField = #36890#20449#22320#22336
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
      object dbedt_Rch: TLabel
        Left = 72
        Top = 29
        Width = 121
        Height = 14
        AutoSize = False
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentColor = False
        ParentFont = False
        Transparent = False
      end
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 663
    Height = 597
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnl3: TPanel
      Left = 0
      Top = 0
      Width = 663
      Height = 65
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = #26041#27491#23002#20307#31616#20307
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      object lbl_zy: TLabel
        Left = 2
        Top = 12
        Width = 100
        Height = 28
        Caption = #32771#28857#20449#24687
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -24
        Font.Name = #26041#27491#23002#20307#31616#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
    end
    object pnl_cj: TPanel
      Left = 0
      Top = 65
      Width = 663
      Height = 532
      Align = alClient
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      object lbl_Rch: TLabel
        Left = 2
        Top = 10
        Width = 200
        Height = 24
        Caption = #27491#22312#23545#32771#29983#36827#34892#35780#20998#65306
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -20
        Font.Name = #26041#27491#23002#20307#31616#20307
        Font.Style = []
        ParentFont = False
      end
      object pnl_Bottom: TPanel
        Left = 0
        Top = 460
        Width = 659
        Height = 68
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object btn_goBack: TBitBtn
          Left = 476
          Top = 6
          Width = 123
          Height = 56
          Caption = #21457#22238#37325#35780
          Enabled = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = #26041#27491#23002#20307#31616#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          OnClick = btn_goBackClick
        end
      end
      object Panel1: TPanel
        Left = 0
        Top = 40
        Width = 659
        Height = 420
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object DBGridEh2: TDBGridEh
          Left = 0
          Top = 0
          Width = 448
          Height = 420
          Align = alClient
          ColumnDefValues.Layout = tlCenter
          Ctl3D = False
          DataGrouping.GroupLevels = <>
          DataSource = ds_Pf
          Flat = False
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = #26041#27491#23002#20307#31616#20307
          Font.Style = []
          FooterColor = clWindow
          FooterFont.Charset = GB2312_CHARSET
          FooterFont.Color = clBlue
          FooterFont.Height = -19
          FooterFont.Name = #26041#27491#23002#20307#31616#20307
          FooterFont.Style = [fsBold]
          FooterRowCount = 1
          HorzScrollBar.Visible = False
          ImeMode = imDisable
          Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
          OptionsEh = [dghClearSelection, dghDialogFind, dghHotTrack]
          ParentCtl3D = False
          ParentFont = False
          RowDetailPanel.Color = clBtnFace
          RowHeight = 45
          SumList.Active = True
          TabOrder = 0
          TitleFont.Charset = GB2312_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -19
          TitleFont.Name = #26041#27491#23002#20307#31616#20307
          TitleFont.Style = []
          TitleHeight = 45
          VertScrollBar.VisibleMode = sbNeverShowEh
          OnGetCellParams = DBGridEh2GetCellParams
          Columns = <
            item
              EditButtons = <>
              FieldName = #25215#32771#38498#31995
              Footers = <>
              Visible = False
            end
            item
              EditButtons = <>
              FieldName = #32771#29983#21495
              Footers = <>
              Visible = False
              Width = 103
            end
            item
              EditButtons = <>
              FieldName = #36827#22330#21495
              Footers = <>
              Visible = False
            end
            item
              EditButtons = <>
              FieldName = #22522#31449
              Footers = <>
              Visible = False
              Width = 44
            end
            item
              EditButtons = <>
              FieldName = #35780#22996
              Footers = <>
              HideDuplicates = True
              Title.Alignment = taCenter
              Width = 96
            end
            item
              Alignment = taCenter
              EditButtons = <>
              FieldName = #35780#20998#22120
              Footer.Alignment = taCenter
              Footer.Value = #26368#32456#24471#20998
              Footer.ValueType = fvtStaticText
              Footers = <>
              Title.Alignment = taCenter
              Width = 84
            end
            item
              Alignment = taCenter
              DisplayFormat = '0.00'
              EditButtons = <>
              FieldName = #31185#30446'1'
              Footer.Alignment = taCenter
              Footer.DisplayFormat = '0.00'
              Footer.ValueType = fvtAvg
              Footers = <>
              Title.Alignment = taCenter
              Width = 123
            end
            item
              Alignment = taCenter
              DisplayFormat = '0.00'
              EditButtons = <>
              FieldName = #31185#30446'2'
              Footer.Alignment = taCenter
              Footer.DisplayFormat = '0.00'
              Footer.ValueType = fvtAvg
              Footers = <>
              Title.Alignment = taCenter
              Width = 129
            end
            item
              Alignment = taCenter
              DisplayFormat = 'yyyy-mm-dd hh:nn:ss'
              EditButtons = <>
              FieldName = #25552#20132#26102#38388
              Footers = <>
              Visible = False
              Width = 188
            end>
          object RowDetailData: TRowDetailPanelControlEh
          end
        end
        object Panel2: TPanel
          Left = 448
          Top = 0
          Width = 211
          Height = 420
          Align = alRight
          BevelKind = bkSoft
          BevelOuter = bvNone
          Font.Charset = GB2312_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = #26041#27491#23002#20307#31616#20307
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          object viArrow1: TviArrow
            Left = 91
            Top = 130
            Width = 24
            Height = 47
            ThicknessRate = 10
            ArrowPosition = apRight
            Color = clGray
          end
          object viArrowEx1: TviArrowEx
            Left = 73
            Top = 215
            Width = 100
            Height = 49
            ThicknessRate = 10
            ArrowPosition = apRight
            ArrowDirection = adLeftToLeft
            Color = clGray
          end
          object viArrowEx2: TviArrowEx
            Left = 94
            Top = 289
            Width = 27
            Height = 60
            ThicknessRate = 10
            ArrowPosition = apLeft
            ArrowDirection = adBottomToTop
            Color = clGray
          end
          object viArrowEx3: TviArrowEx
            Left = 4
            Top = 116
            Width = 30
            Height = 117
            ThicknessRate = 10
            ArrowPosition = apRight
            ArrowDirection = adBottomToTop
            Color = clGray
          end
          object viArrowEx4: TviArrowEx
            Left = 4
            Top = 232
            Width = 40
            Height = 118
            ThicknessRate = 10
            ArrowPosition = apLeft
            Color = clGray
          end
          object btn_2: TBitBtn
            Left = 36
            Top = 88
            Width = 123
            Height = 56
            Caption = #9312#32771#29983#26597#39564
            Enabled = False
            TabOrder = 0
            OnClick = btn_2Click
          end
          object btn_3: TBitBtn
            Left = 60
            Top = 176
            Width = 123
            Height = 56
            Caption = #9314#32771#35797#24320#22987
            Enabled = False
            TabOrder = 1
            OnClick = btn_3Click
          end
          object btn_4: TBitBtn
            Left = 52
            Top = 262
            Width = 123
            Height = 56
            Caption = #9315#32771#35797#32467#26463
            Enabled = False
            TabOrder = 2
            OnClick = btn_4Click
          end
          object btn_5: TBitBtn
            Left = 28
            Top = 347
            Width = 123
            Height = 56
            Caption = #9316#30830#35748#25104#32489
            Enabled = False
            Font.Charset = GB2312_CHARSET
            Font.Color = clWindowText
            Font.Height = -19
            Font.Name = #26041#27491#23002#20307#31616#20307
            Font.Style = []
            ParentFont = False
            TabOrder = 3
            OnClick = btn_5Click
          end
          object btn_1: TBitBtn
            Left = 8
            Top = 3
            Width = 123
            Height = 56
            Caption = #35780#22996#31614#21040
            TabOrder = 4
            OnClick = btn_1Click
          end
        end
      end
    end
  end
  object RzStatusBar1: TRzStatusBar
    Left = 0
    Top = 597
    Width = 966
    Height = 19
    BorderInner = fsNone
    BorderOuter = fsNone
    BorderSides = [sdLeft, sdTop, sdRight, sdBottom]
    BorderWidth = 0
    TabOrder = 2
    object RzStatusPane1: TRzStatusPane
      Left = 0
      Top = 0
      Width = 65
      Height = 19
      Transparent = False
      Align = alLeft
      Color = clRed
      ParentColor = False
      Caption = #29366#24577#25552#31034':'
    end
    object RzStatusPane2: TRzStatusPane
      Left = 130
      Top = 0
      Width = 65
      Height = 19
      Align = alLeft
      Alignment = taRightJustify
      Caption = #24050#31614#21040
      ExplicitLeft = 65
    end
    object RzStatusPane3: TRzStatusPane
      Left = 65
      Top = 0
      Width = 65
      Height = 19
      Align = alLeft
      Alignment = taRightJustify
      Caption = #26410#31614#21040
    end
    object pnl4: TPanel
      Left = 70
      Top = 4
      Width = 12
      Height = 12
      BevelOuter = bvNone
      Color = clMaroon
      ParentBackground = False
      TabOrder = 0
    end
    object pnl6: TPanel
      Left = 135
      Top = 4
      Width = 12
      Height = 12
      BevelOuter = bvNone
      Color = clBlue
      ParentBackground = False
      TabOrder = 1
    end
  end
  object cds_Pf: TClientDataSet
    Aggregates = <>
    CommandText = 'select top 100 * from '#26657#32771#31185#30446#29616#22330#35780#20998#34920' where 1=0'
    FetchOnDemand = False
    Params = <>
    Left = 296
    Top = 424
  end
  object ds_Pf: TDataSource
    DataSet = cds_Pf
    Left = 325
    Top = 424
  end
  object cds_stu: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#26657#32771#32771#29983#25253#32771#19987#19994#34920
    Params = <>
    Left = 872
    Top = 272
    object cds_stuId: TAutoIncField
      FieldName = 'Id'
      ReadOnly = True
    end
    object cds_stuStringField: TStringField
      FieldName = #30465#20221
      Size = 10
    end
    object cds_stuStringField2: TStringField
      FieldName = #32771#28857#21517#31216
      Size = 30
    end
    object cds_stuStringField3: TStringField
      FieldName = #32771#29983#21495
      Size = 18
    end
    object cds_stuStringField4: TStringField
      FieldName = #20934#32771#35777#21495
      Size = 15
    end
    object cds_stuStringField5: TStringField
      FieldName = #36523#20221#35777#21495
      Size = 18
    end
    object cds_stuStringField6: TStringField
      FieldName = #22995#21517
      Size = 10
    end
    object cds_stuStringField7: TStringField
      FieldName = #24615#21035
      Size = 2
    end
    object cds_stuStringField8: TStringField
      FieldName = #25215#32771#38498#31995
      Size = 30
    end
    object cds_stuStringField9: TStringField
      FieldName = #19987#19994
      Size = 30
    end
    object cds_stuStringField10: TStringField
      FieldName = #23618#27425
      Size = 6
    end
    object cds_stuDateTimeField: TDateTimeField
      FieldName = #25253#32771#26102#38388
    end
    object cds_stuDateTimeField2: TDateTimeField
      FieldName = #32771#35797#26102#38388
    end
    object cds_stuFloatField: TFloatField
      FieldName = #25104#32489
    end
    object cds_stuStringField11: TStringField
      FieldName = #37038#25919#32534#30721
      Size = 6
    end
    object cds_stuStringField12: TStringField
      FieldName = #32852#31995#30005#35805
    end
    object cds_stuStringField13: TStringField
      FieldName = #27605#19994#20013#23398
      Size = 30
    end
    object cds_stuStringField14: TStringField
      FieldName = #36890#20449#22320#22336
      Size = 100
    end
  end
  object ds_stu: TDataSource
    DataSet = cds_stu
    Left = 901
    Top = 272
  end
  object tmr1: TTimer
    Enabled = False
    OnTimer = tmr1Timer
    Left = 792
    Top = 48
  end
  object MultipleAssess: TMultipleAssess
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnKeyStatus = MultipleAssessKeyStatus
    OnDataDownload = MultipleAssessDataDownload
    Left = 296
    Top = 376
  end
  object ScoreRuleExplain: TScoreRuleExplain
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnDataDownload = ScoreRuleExplainDataDownload
    Left = 328
    Top = 376
  end
end
