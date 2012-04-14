object LqqkCount: TLqqkCount
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  Caption = #24405#21462#36827#24230#24773#20917#32479#35745#26597#35810
  ClientHeight = 610
  ClientWidth = 920
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel2: TPanel
    Left = 0
    Top = 569
    Width = 920
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitTop = 471
    ExplicitWidth = 764
    DesignSize = (
      920
      41)
    object btn_Exit: TBitBtn
      Left = 830
      Top = 9
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20851#38381'[&C]'
      TabOrder = 4
      OnClick = btn_ExitClick
      ExplicitLeft = 674
    end
    object btn_Excel: TBitBtn
      Left = 696
      Top = 9
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #23548#20986'Excel'
      TabOrder = 3
      OnClick = btn_ExcelClick
      ExplicitLeft = 540
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
      Left = 516
      Top = 9
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #21047#26032#32467#26524
      TabOrder = 1
      OnClick = btn_RefreshBdlClick
    end
    object btn_Print: TBitBtn
      Left = 607
      Top = 9
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #25171#21360'[&P]'
      TabOrder = 2
      OnClick = btn_PrintClick
    end
  end
  object RzRadioGroup1: TRzRadioGroup
    Left = 0
    Top = 0
    Width = 227
    Height = 569
    Align = alLeft
    Caption = #32479#35745#39033#30446#65306
    GroupStyle = gsStandard
    ItemHeight = 22
    Items.Strings = (
      #25353#38498#31995#32479#35745
      #25353#19987#19994#32479#35745
      #25353#38498#31995#19987#19994#32479#35745
      #25353#30465#20221#32479#35745
      #25353#25991#29702#33402#26415#32479#35745)
    TabOrder = 1
    OnClick = RzRadioGroup1Click
    ExplicitHeight = 471
  end
  object GroupBox1: TGroupBox
    Left = 227
    Top = 0
    Width = 693
    Height = 569
    Align = alClient
    Caption = #32479#35745#32467#26524#65306
    TabOrder = 2
    ExplicitWidth = 537
    ExplicitHeight = 471
    object DBGridEH1: TDBGridEh
      Left = 2
      Top = 16
      Width = 689
      Height = 551
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
      FooterFont.Color = clBlue
      FooterFont.Height = -12
      FooterFont.Name = 'Verdana'
      FooterFont.Style = []
      FooterRowCount = 1
      IndicatorTitle.ShowDropDownSign = True
      IndicatorTitle.TitleButton = True
      OddRowColor = 13823456
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghMultiSortMarking, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove, dghExtendVertLines]
      ParentFont = False
      PopupMenu = PopupMenu1
      ReadOnly = True
      RowDetailPanel.Color = clBtnFace
      SortLocal = True
      SumList.Active = True
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Verdana'
      TitleFont.Style = []
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
    RemoteServer = DM.SoapConnection1
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
    object mni_L1: TMenuItem
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
    object mni__Export: TMenuItem
      Action = DM.act_DataExport
    end
  end
end
