object XkKsKmcjBrowse: TXkKsKmcjBrowse
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSizeToolWin
  Caption = #32771#29983#26657#32771#31185#30446#25104#32489#20449#24687
  ClientHeight = 291
  ClientWidth = 467
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 14
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 0
    Width = 467
    Height = 291
    Align = alClient
    DataGrouping.GroupLevels = <>
    DataSource = DataSource1
    EditActions = [geaCutEh, geaCopyEh, geaPasteEh, geaDeleteEh]
    Flat = False
    FooterColor = clWindow
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -12
    FooterFont.Name = 'Tahoma'
    FooterFont.Style = []
    ImeMode = imDisable
    OddRowColor = 13823456
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghAutoSortMarking, dghEnterAsTab, dghRowHighlight, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove]
    PopupMenu = DM.PopupMenu1
    RowDetailPanel.Color = clBtnFace
    SortLocal = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    VertScrollBar.VisibleMode = sbAlwaysShowEh
    Columns = <
      item
        EditButtons = <>
        FieldName = 'Id'
        Footers = <>
        ReadOnly = True
        Title.TitleButton = True
        Visible = False
      end
      item
        EditButtons = <>
        FieldName = #32771#29983#21495
        Footers = <>
        ReadOnly = True
        Title.TitleButton = True
        Width = 103
      end
      item
        EditButtons = <>
        FieldName = #25215#32771#38498#31995
        Footers = <>
        ReadOnly = True
        Title.TitleButton = True
        Visible = False
        Width = 61
      end
      item
        EditButtons = <>
        FieldName = #19987#19994
        Footers = <>
        Width = 111
      end
      item
        EditButtons = <>
        FieldName = #32771#35797#31185#30446
        Footers = <>
        ReadOnly = True
        Title.TitleButton = True
        Width = 100
      end
      item
        DisplayFormat = '0.000'
        EditButtons = <>
        FieldName = #25104#32489
        Footers = <>
        Title.TitleButton = True
        Width = 57
      end
      item
        DisplayFormat = '0%'
        EditButtons = <>
        FieldName = #25104#32489#25152#21344#27604#20363
        Footers = <>
        Title.Caption = #27604#20363
        Width = 46
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 256
    Top = 200
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#26657#32771#31185#30446#25104#32489#34920
    Params = <>
    Left = 288
    Top = 200
  end
end
