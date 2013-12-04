object Xkpf: TXkpf
  Left = 0
  Top = 0
  Caption = #35780#20998#31383#21475
  ClientHeight = 673
  ClientWidth = 965
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
  PixelsPerInch = 96
  TextHeight = 14
  object bvl2: TBevel
    Left = 662
    Top = 0
    Width = 2
    Height = 632
    Align = alRight
    Shape = bsRightLine
    ExplicitLeft = 661
    ExplicitHeight = 605
  end
  object pnl_right: TPanel
    Left = 664
    Top = 0
    Width = 301
    Height = 632
    Align = alRight
    BevelOuter = bvNone
    TabOrder = 0
    object pnl1: TPanel
      Left = 0
      Top = 0
      Width = 301
      Height = 209
      Align = alTop
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 0
      object led_Time: TRzLEDDisplay
        Left = 9
        Top = 85
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
      Top = 209
      Width = 301
      Height = 423
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
      object dbedt1: TDBEdit
        Left = 72
        Top = 63
        Width = 160
        Height = 22
        DataField = #32771#29983#21495
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 0
      end
      object dbedt2: TDBEdit
        Left = 72
        Top = 96
        Width = 160
        Height = 22
        DataField = #20934#32771#35777#21495
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 1
      end
      object dbedt3: TDBEdit
        Left = 72
        Top = 128
        Width = 160
        Height = 22
        DataField = #36523#20221#35777#21495
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 2
      end
      object dbedt4: TDBEdit
        Left = 72
        Top = 161
        Width = 160
        Height = 22
        DataField = #22995#21517
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 3
      end
      object dbedt5: TDBEdit
        Left = 72
        Top = 194
        Width = 32
        Height = 22
        DataField = #24615#21035
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 4
      end
      object dbedt6: TDBEdit
        Left = 72
        Top = 226
        Width = 222
        Height = 22
        DataField = #25215#32771#38498#31995
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 5
      end
      object dbedt7: TDBEdit
        Left = 72
        Top = 259
        Width = 222
        Height = 22
        DataField = #19987#19994
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 6
      end
      object dbedt8: TDBEdit
        Left = 72
        Top = 292
        Width = 222
        Height = 22
        DataField = #32852#31995#30005#35805
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 7
      end
      object dbedt9: TDBEdit
        Left = 72
        Top = 324
        Width = 222
        Height = 22
        DataField = #27605#19994#20013#23398
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 8
      end
      object dbedt11: TDBEdit
        Left = 72
        Top = 357
        Width = 88
        Height = 22
        DataField = #37038#25919#32534#30721
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 9
      end
      object dbmmo1: TDBMemo
        Left = 72
        Top = 386
        Width = 222
        Height = 44
        DataField = #36890#20449#22320#22336
        DataSource = ds_stu
        ReadOnly = True
        TabOrder = 10
      end
      object dbedt_Rch: TDBEdit
        Left = 72
        Top = 28
        Width = 160
        Height = 22
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlue
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ReadOnly = True
        TabOrder = 11
      end
    end
  end
  object pnl2: TPanel
    Left = 0
    Top = 0
    Width = 662
    Height = 632
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 1
    object pnl3: TPanel
      Left = 0
      Top = 0
      Width = 662
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
      object btn_1: TBitBtn
        Left = 40
        Top = 1
        Width = 123
        Height = 56
        Caption = #9312#35780#22996#31614#21040
        TabOrder = 0
        OnClick = btn_1Click
      end
      object btn_2: TBitBtn
        Left = 169
        Top = 1
        Width = 123
        Height = 56
        Caption = #9313#32771#29983#20837#22330
        Enabled = False
        TabOrder = 1
        OnClick = btn_2Click
      end
      object btn_3: TBitBtn
        Left = 298
        Top = 1
        Width = 123
        Height = 56
        Caption = #9314#24320#22987#35745#26102
        Enabled = False
        TabOrder = 2
        OnClick = btn_3Click
      end
      object btn_4: TBitBtn
        Left = 427
        Top = 1
        Width = 123
        Height = 56
        Caption = #9315#32771#29983#36864#22330
        Enabled = False
        TabOrder = 3
        OnClick = btn_4Click
      end
    end
    object pnl_cj: TPanel
      Left = 17
      Top = 96
      Width = 632
      Height = 530
      BevelKind = bkTile
      BevelOuter = bvNone
      TabOrder = 1
      object lbl_Rch: TLabel
        Left = 2
        Top = 14
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
      object DBGridEh2: TDBGridEh
        Left = 0
        Top = 57
        Width = 628
        Height = 407
        Align = alBottom
        ColumnDefValues.Layout = tlCenter
        Ctl3D = False
        DataGrouping.GroupLevels = <>
        DataSource = ds_Cj
        Flat = False
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -12
        FooterFont.Name = 'Tahoma'
        FooterFont.Style = []
        HorzScrollBar.Visible = False
        Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
        OptionsEh = [dghClearSelection, dghDialogFind, dghHotTrack]
        ParentCtl3D = False
        RowDetailPanel.Color = clBtnFace
        RowHeight = 25
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -12
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        TitleHeight = 25
        VertScrollBar.VisibleMode = sbNeverShowEh
        Columns = <
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = #24405#20837#20998#32452
            Footers = <>
            HideDuplicates = True
            Title.Alignment = taCenter
            Title.Caption = #35780#20221#22120#32534#21495
            Width = 79
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = #35780#22996
            Footers = <>
            HideDuplicates = True
            Title.Alignment = taCenter
            Title.Caption = #35780#22996#22995#21517
            Width = 85
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = #32771#29983#21495
            Footers = <>
            Title.Alignment = taCenter
            Visible = False
            Width = 99
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = #25215#32771#38498#31995
            Footers = <>
            Title.Alignment = taCenter
            Visible = False
            Width = 72
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = #32771#35797#31185#30446
            Footers = <>
            Title.Alignment = taCenter
            Width = 126
          end
          item
            Alignment = taCenter
            EditButtons = <>
            FieldName = #25104#32489
            Footers = <>
            Title.Alignment = taCenter
            Width = 108
          end>
        object RowDetailData: TRowDetailPanelControlEh
        end
      end
      object pnl5: TPanel
        Left = 0
        Top = 464
        Width = 628
        Height = 62
        Align = alBottom
        BevelOuter = bvNone
        TabOrder = 1
        object btn_5: TBitBtn
          Left = 479
          Top = 3
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
          TabOrder = 0
          OnClick = btn_5Click
        end
      end
    end
  end
  object pnl4: TPanel
    Left = 0
    Top = 632
    Width = 965
    Height = 41
    Align = alBottom
    BevelKind = bkTile
    BevelOuter = bvSpace
    TabOrder = 2
  end
  object cds_Cj: TClientDataSet
    Aggregates = <>
    CommandText = 'select top 100 * from '#26657#32771#21367#38754#25104#32489#24405#20837#34920' where 1=0'
    Params = <>
    Left = 296
    Top = 424
  end
  object ds_Cj: TDataSource
    DataSet = cds_Cj
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
end
