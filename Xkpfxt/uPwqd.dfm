object Pwqd: TPwqd
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #35780#22996#31614#21040
  ClientHeight = 333
  ClientWidth = 469
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  object DBGridEh1: TDBGridEh
    Left = 11
    Top = 15
    Width = 446
    Height = 266
    ColumnDefValues.Layout = tlCenter
    Ctl3D = False
    DataGrouping.GroupLevels = <>
    DataSource = ds_pw
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -12
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    HorzScrollBar.Visible = False
    Options = [dgTitles, dgIndicator, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
    OptionsEh = [dghClearSelection, dghDialogFind, dghShowRecNo, dghHotTrack]
    ParentCtl3D = False
    RowDetailPanel.Color = clBtnFace
    RowHeight = 35
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    TitleHeight = 35
    VertScrollBar.VisibleMode = sbNeverShowEh
    Columns = <
      item
        EditButtons = <>
        FieldName = #30465#20221
        Footers = <>
        Visible = False
        Width = 36
      end
      item
        EditButtons = <>
        FieldName = #32771#28857#21517#31216
        Footers = <>
        Visible = False
        Width = 108
      end
      item
        EditButtons = <>
        FieldName = #19987#19994
        Footers = <>
        Visible = False
        Width = 85
      end
      item
        EditButtons = <>
        FieldName = #35780#22996
        Footers = <>
        Width = 119
      end
      item
        EditButtons = <>
        FieldName = #22522#31449
        Footers = <>
        Visible = False
        Width = 50
      end
      item
        EditButtons = <>
        FieldName = #35780#20998#22120
        Footers = <>
        Width = 91
      end
      item
        EditButtons = <>
        FieldName = #31614#21040#30721
        Footers = <>
        Width = 106
      end
      item
        EditButtons = <>
        FieldName = #26159#21542#31614#21040
        Footers = <>
        Width = 91
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object btn_OK: TButton
    Left = 192
    Top = 294
    Width = 95
    Height = 25
    Caption = #35780#22996#31614#21040#25104#21151
    ModalResult = 1
    TabOrder = 1
  end
  object btn_Close: TButton
    Left = 312
    Top = 294
    Width = 95
    Height = 25
    Caption = #35780#22996#31614#21040#26410#23436#25104
    ModalResult = 2
    TabOrder = 2
  end
  object cds_pw: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#26657#32771#32771#28857#35780#22996#34920
    Params = <>
    Left = 104
    Top = 192
  end
  object ds_pw: TDataSource
    DataSet = cds_pw
    Left = 133
    Top = 192
  end
end
