object XkPwpf: TXkPwpf
  Left = 0
  Top = 0
  Caption = #35780#20998#31383#21475
  ClientHeight = 572
  ClientWidth = 966
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  ShowHint = False
  Visible = True
  OnClose = FormClose
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object bvl2: TBevel
    Left = 663
    Top = 0
    Width = 2
    Height = 553
    Align = alRight
    Shape = bsRightLine
    ExplicitLeft = 661
    ExplicitHeight = 605
  end
  object pnl_right: TPanel
    Left = 665
    Top = 0
    Width = 301
    Height = 553
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 301
      Height = 65
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
      object led_Time: TRzLEDDisplay
        Left = 120
        Top = 8
        Width = 166
        Height = 45
        Alignment = taCenter
        Caption = '00:00'
      end
      object lbl1: TLabel
        Left = 6
        Top = 19
        Width = 112
        Height = 23
        Caption = #35745#26102'('#20998#38047')'#65306
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
      Top = 65
      Width = 301
      Height = 488
      Align = alClient
      Caption = #32771#29983#20449#24687#65306
      TabOrder = 1
      object lbl2: TLabel
        Left = 16
        Top = 30
        Width = 36
        Height = 13
        Caption = #32771#29983#21495
        FocusControl = dbedt1
      end
      object lbl3: TLabel
        Left = 16
        Top = 63
        Width = 48
        Height = 13
        Caption = #20934#32771#35777#21495
        FocusControl = dbedt2
      end
      object lbl4: TLabel
        Left = 16
        Top = 96
        Width = 48
        Height = 13
        Caption = #36523#20221#35777#21495
        FocusControl = dbedt3
      end
      object lbl5: TLabel
        Left = 16
        Top = 129
        Width = 48
        Height = 13
        Caption = #32771#29983#22995#21517
        FocusControl = dbedt4
      end
      object lbl6: TLabel
        Left = 16
        Top = 162
        Width = 24
        Height = 13
        Caption = #24615#21035
        FocusControl = dbedt5
      end
      object lbl7: TLabel
        Left = 16
        Top = 194
        Width = 48
        Height = 13
        Caption = #25253#32771#38498#31995
        FocusControl = dbedt6
      end
      object lbl8: TLabel
        Left = 16
        Top = 227
        Width = 48
        Height = 13
        Caption = #25253#32771#19987#19994
        FocusControl = dbedt7
      end
      object lbl9: TLabel
        Left = 16
        Top = 260
        Width = 48
        Height = 13
        Caption = #32852#31995#30005#35805
        FocusControl = dbedt8
      end
      object lbl10: TLabel
        Left = 16
        Top = 293
        Width = 48
        Height = 13
        Caption = #27605#19994#20013#23398
        FocusControl = dbedt9
      end
      object lbl11: TLabel
        Left = 16
        Top = 358
        Width = 48
        Height = 13
        Caption = #36890#20449#22320#22336
      end
      object lbl12: TLabel
        Left = 16
        Top = 326
        Width = 48
        Height = 13
        Caption = #37038#25919#32534#30721
        FocusControl = dbedt11
      end
      object dbedt1: TDBText
        Left = 72
        Top = 29
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
        Top = 62
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
        Top = 94
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
        Top = 127
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
        Top = 160
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
        Top = 192
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
        Top = 225
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
        Top = 258
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
        Top = 290
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
        Top = 323
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
        Top = 359
        Width = 222
        Height = 44
        Color = clWhite
        DataField = #36890#20449#22320#22336
        DataSource = ds_stu
        ParentColor = False
        Transparent = False
      end
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 663
    Height = 553
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
      object lbl_Rch: TLabel
        Left = 5
        Top = 15
        Width = 125
        Height = 28
        Caption = #27491#22312#23545#32771#29983
        Font.Charset = GB2312_CHARSET
        Font.Color = clBlue
        Font.Height = -24
        Font.Name = #26041#27491#23002#20307#31616#20307
        Font.Style = [fsBold]
        ParentFont = False
      end
      object led_Rch: TRzLEDDisplay
        Left = 134
        Top = 5
        Width = 151
        Height = 45
        Hint = #20837#22330#21495
        ParentShowHint = False
        ShowHint = True
        Alignment = taCenter
        Caption = '---'
        SegOnColor = clWhite
      end
      object lbl14: TLabel
        Left = 291
        Top = 15
        Width = 125
        Height = 28
        Caption = #36827#34892#35780#20998#65306
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
      Height = 488
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object pnl_Bottom: TPanel
        Left = 0
        Top = 420
        Width = 663
        Height = 68
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 0
        object Bevel1: TBevel
          Left = 0
          Top = 0
          Width = 663
          Height = 9
          Align = alTop
          Shape = bsTopLine
        end
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
        Top = 0
        Width = 663
        Height = 420
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        object DBGridEh2: TDBGridEh
          Left = 0
          Top = 0
          Width = 452
          Height = 420
          Align = alClient
          BorderStyle = bsNone
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
              Width = 130
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
              Width = 139
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
          Left = 452
          Top = 0
          Width = 211
          Height = 420
          Align = alRight
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
          object Bevel2: TBevel
            Left = 0
            Top = 0
            Width = 9
            Height = 420
            Align = alLeft
            Shape = bsLeftLine
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
    Top = 553
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
    Left = 592
    Top = 80
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
    Left = 621
    Top = 80
  end
  object tmr1: TTimer
    Enabled = False
    OnTimer = tmr1Timer
    Left = 720
    Top = 16
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
