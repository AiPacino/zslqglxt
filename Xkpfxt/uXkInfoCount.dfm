object XkInfoCount: TXkInfoCount
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  Caption = #26657#32771#19987#19994#25253#32771#24773#20917#32479#35745
  ClientHeight = 512
  ClientWidth = 836
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
  object Panel2: TPanel
    Left = 0
    Top = 471
    Width = 836
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 764
    DesignSize = (
      836
      41)
    object btn_Exit: TBitBtn
      Left = 746
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20851#38381'[&C]'
      TabOrder = 5
      OnClick = btn_ExitClick
      ExplicitLeft = 674
    end
    object btn_Excel: TBitBtn
      Left = 349
      Top = 9
      Width = 80
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #23548#20986'Excel'
      TabOrder = 3
      OnClick = btn_ExcelClick
    end
    object btn_Refresh: TBitBtn
      Left = 10
      Top = 9
      Width = 95
      Height = 25
      Caption = #21047#26032#32479#35745#39033#30446
      TabOrder = 0
      OnClick = btn_RefreshClick
    end
    object btn_RefreshBdl: TBitBtn
      Left = 258
      Top = 9
      Width = 80
      Height = 25
      Caption = #21047#26032#32467#26524
      TabOrder = 2
      OnClick = btn_RefreshBdlClick
    end
    object btn_Print: TBitBtn
      Left = 440
      Top = 9
      Width = 80
      Height = 25
      Caption = #25171#21360'[&P]'
      TabOrder = 4
      OnClick = btn_PrintClick
    end
    object BitBtn1: TBitBtn
      Left = 123
      Top = 9
      Width = 80
      Height = 25
      Caption = #26356#26032#35270#22270
      TabOrder = 1
      Visible = False
      OnClick = BitBtn1Click
    end
  end
  object GroupBox1: TGroupBox
    Left = 257
    Top = 0
    Width = 579
    Height = 471
    Align = alClient
    Caption = #32479#35745#32467#26524#65306
    TabOrder = 1
    ExplicitLeft = 227
    ExplicitWidth = 537
    object dxgrd_1: TDBGridEh
      Left = 2
      Top = 16
      Width = 575
      Height = 453
      Align = alClient
      DataGrouping.GroupLevels = <>
      DataSource = DataSource1
      EditActions = [geaCutEh, geaCopyEh, geaPasteEh]
      Flat = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -12
      FooterFont.Name = 'Verdana'
      FooterFont.Style = []
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      OddRowColor = 13823456
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack]
      ParentFont = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      RowHeight = 25
      SortLocal = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Verdana'
      TitleFont.Style = []
      TitleHeight = 25
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object grp1: TGroupBox
    Left = 0
    Top = 0
    Width = 257
    Height = 471
    Align = alLeft
    Caption = #32479#35745#39033#30446#65306
    TabOrder = 0
    object DBGridEh1: TDBGridEh
      Left = 2
      Top = 16
      Width = 253
      Height = 453
      Align = alClient
      AutoFitColWidths = True
      DataGrouping.GroupLevels = <>
      DataSource = ds_Master
      EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh]
      Flat = False
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Verdana'
      Font.Style = []
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -12
      FooterFont.Name = 'Verdana'
      FooterFont.Style = []
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      OddRowColor = clWindow
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
      OptionsEh = [dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghHotTrack]
      ParentFont = False
      PopupMenu = DM.PopupMenu1
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      RowHeight = 25
      SortLocal = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Verdana'
      TitleFont.Style = []
      TitleHeight = 25
      VertScrollBar.VisibleMode = sbAlwaysShowEh
      Columns = <
        item
          EditButtons = <>
          FieldName = #35828#26126
          Footers = <>
          Width = 207
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 592
    Top = 320
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    CommandText = 'select '#30465#20221',count(*) as '#24635#20154#25968' from '#24405#21462#20449#24687#34920' group by '#30465#20221
    Params = <>
    ProviderName = 'DSP_Query'
    Left = 624
    Top = 320
  end
  object PopupMenu1: TPopupMenu
    Left = 448
    Top = 208
    object mi_RefreshBdl: TMenuItem
      Caption = #21047#26032'(&R)'
      ShortCut = 116
      OnClick = mi_RefreshBdlClick
    end
    object mniLocate: TMenuItem
      Action = DM.act_Locate
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object C1: TMenuItem
      Action = DM.EditCopy1
    end
    object T1: TMenuItem
      Action = DM.EditCut1
    end
    object P1: TMenuItem
      Action = DM.EditPaste1
    end
    object N2: TMenuItem
      Caption = '-'
    end
    object mniDataExport: TMenuItem
      Action = DM.act_DataExport
    end
  end
  object cds_Master: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#32479#35745#39033#30446#34920
    Params = <>
    ProviderName = 'DSP_Query'
    RemoteServer = DM.SoapConnection1
    Left = 113
    Top = 144
  end
  object ds_Master: TDataSource
    DataSet = cds_Master
    OnDataChange = ds_MasterDataChange
    Left = 81
    Top = 144
  end
end
