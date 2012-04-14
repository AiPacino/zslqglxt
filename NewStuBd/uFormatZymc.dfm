object FormatZymc: TFormatZymc
  Left = 325
  Top = 172
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #26684#24335#21270#24405#21462#19987#19994
  ClientHeight = 315
  ClientWidth = 402
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Verdana'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object grp1: TGroupBox
    Left = 0
    Top = 0
    Width = 402
    Height = 266
    Align = alClient
    Caption = #26684#24335#21270#39033#30446#65306
    TabOrder = 0
    object dbgrd1: TDBGridEh
      Left = 2
      Top = 16
      Width = 398
      Height = 248
      Align = alClient
      AutoFitColWidths = True
      DataGrouping.GroupLevels = <>
      DataSource = ds_Sql
      Flat = False
      FooterColor = clWindow
      FooterFont.Charset = ANSI_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -12
      FooterFont.Name = 'Verdana'
      FooterFont.Style = []
      ImeMode = imDisable
      OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghDialogFind, dghShowRecNo, dghColumnResize, dghColumnMove]
      PopupMenu = pm1
      RowDetailPanel.Color = clBtnFace
      TabOrder = 0
      TitleFont.Charset = ANSI_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Verdana'
      TitleFont.Style = []
      Columns = <
        item
          EditButtons = <>
          FieldName = 'Id'
          Footers = <>
          Width = 21
        end
        item
          EditButtons = <>
          FieldName = #32534#21495
          Footers = <>
          Title.TitleButton = True
        end
        item
          EditButtons = <>
          FieldName = #35828#26126
          Footers = <>
          Width = 267
        end>
      object RowDetailData: TRowDetailPanelControlEh
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 266
    Width = 402
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      402
      49)
    object btn_Rep: TBitBtn
      Left = 205
      Top = 12
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #25191#34892#21629#20196
      TabOrder = 0
      OnClick = btn_RepClick
    end
    object btn_All: TBitBtn
      Left = 9
      Top = 12
      Width = 85
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #25191#34892#20840#37096#21629#20196
      TabOrder = 1
      Visible = False
      OnClick = btn_AllClick
    end
    object btn_Cancel: TBitBtn
      Left = 310
      Top = 12
      Width = 80
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20851#38381
      TabOrder = 2
      OnClick = btn_CancelClick
    end
  end
  object ds_Sql: TDataSource
    DataSet = cds_Sql
    Left = 252
    Top = 120
  end
  object cds_Sql: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 220
    Top = 120
  end
  object pm1: TPopupMenu
    Left = 180
    Top = 120
    object mmi_replace: TMenuItem
      Caption = #25191#34892#24403#21069#21629#20196
      OnClick = mmi_replaceClick
    end
    object mmi_Del: TMenuItem
      Caption = #25191#34892#20840#37096#21629#20196
      OnClick = mmi_DelClick
    end
  end
end
