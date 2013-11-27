object Pwqd: TPwqd
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #35780#22996#31614#21040
  ClientHeight = 277
  ClientWidth = 385
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object DBGridEh1: TDBGridEh
    Left = 24
    Top = 15
    Width = 337
    Height = 210
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
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
    OptionsEh = [dghClearSelection, dghDialogFind, dghHotTrack]
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
        Alignment = taCenter
        EditButtons = <>
        FieldName = #25215#32771#38498#31995
        Footers = <>
        Title.Alignment = taCenter
        Width = 106
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = #35780#22996
        Footers = <>
        Title.Alignment = taCenter
        Width = 94
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = #35780#20998#22120#32534#21495
        Footers = <>
        Title.Alignment = taCenter
      end
      item
        Alignment = taCenter
        EditButtons = <>
        FieldName = #26159#21542#31614#21040
        Footers = <>
        Title.Alignment = taCenter
        Width = 58
      end>
    object RowDetailData: TRowDetailPanelControlEh
    end
  end
  object btn1: TButton
    Left = 152
    Top = 240
    Width = 89
    Height = 25
    Caption = #27169#25311#31614#21040#25104#21151
    ModalResult = 1
    TabOrder = 1
  end
  object cds_pw: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#26657#32771#35780#22996#21517#21333#34920' where '#35780#20998#22120#32534#21495'<'#39'0005'#39
    Params = <>
    Left = 200
    Top = 152
    object cds_pwid: TIntegerField
      FieldName = 'id'
    end
    object cds_pwStringField: TStringField
      FieldName = #25215#32771#38498#31995
      Size = 30
    end
    object cds_pwStringField2: TStringField
      FieldName = #35780#22996
      Size = 10
    end
    object cds_pwStringField3: TStringField
      FieldName = #35780#20998#22120#32534#21495
      Size = 10
    end
    object cds_pwField: TBooleanField
      FieldKind = fkCalculated
      FieldName = #26159#21542#31614#21040
      Calculated = True
    end
  end
  object ds_pw: TDataSource
    DataSet = cds_pw
    Left = 229
    Top = 152
  end
end
