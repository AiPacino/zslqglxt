object XkBmEdit: TXkBmEdit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26657#32771#32534#21495#24405#20837
  ClientHeight = 380
  ClientWidth = 540
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object Panel2: TPanel
    Left = 0
    Top = 330
    Width = 540
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    DesignSize = (
      540
      50)
    object btn_Exit: TBitBtn
      Left = 432
      Top = 10
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20851#38381'[&C]'
      TabOrder = 1
      OnClick = btn_ExitClick
    end
    object btn_Save: TBitBtn
      Left = 332
      Top = 10
      Width = 75
      Height = 25
      Caption = #20445#23384'[&S]'
      Enabled = False
      TabOrder = 0
      OnClick = btn_SaveClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 540
    Height = 330
    Align = alClient
    Caption = #32771#29983#20449#24687#65306
    TabOrder = 0
    object Label1: TLabel
      Left = 68
      Top = 82
      Width = 48
      Height = 14
      Caption = #32771#29983#21495#65306
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 56
      Top = 150
      Width = 60
      Height = 14
      Caption = #32771#29983#22995#21517#65306
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 326
      Top = 150
      Width = 36
      Height = 14
      Caption = #24615#21035#65306
      FocusControl = DBEdit3
    end
    object Label7: TLabel
      Left = 326
      Top = 82
      Width = 36
      Height = 14
      Caption = #30465#20221#65306
      FocusControl = DBEdit7
    end
    object Label8: TLabel
      Left = 56
      Top = 183
      Width = 60
      Height = 14
      Caption = #36523#20221#35777#21495#65306
      FocusControl = DBEdit8
    end
    object Label4: TLabel
      Left = 56
      Top = 116
      Width = 60
      Height = 14
      Caption = #20934#32771#35777#21495#65306
      FocusControl = DBEditEh1
    end
    object lbl_pw: TLabel
      Left = 56
      Top = 251
      Width = 60
      Height = 14
      Caption = #26657#32771#32534#21495#65306
    end
    object lbl1: TLabel
      Left = 320
      Top = 256
      Width = 53
      Height = 14
      Caption = '(*'#24517#22635#39033')'
    end
    object lbl_Len: TLabel
      Left = 391
      Top = 32
      Width = 94
      Height = 14
      Caption = '('#20445#30041#20301#25968#65306#12288#12288')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Bevel1: TBevel
      Left = 16
      Top = 64
      Width = 512
      Height = 10
      Shape = bsTopLine
    end
    object lbl2: TLabel
      Left = 56
      Top = 217
      Width = 60
      Height = 14
      Caption = #25253#32771#19987#19994#65306
      FocusControl = DBEditEh2
    end
    object DBEdit1: TDBEditEh
      Left = 124
      Top = 80
      Width = 177
      Height = 24
      Alignment = taLeftJustify
      BorderStyle = bsNone
      DataField = #32771#29983#21495
      DataSource = DataSource1
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 4
      Visible = True
    end
    object DBEdit2: TDBEditEh
      Left = 124
      Top = 148
      Width = 177
      Height = 24
      Alignment = taLeftJustify
      BorderStyle = bsNone
      DataField = #22995#21517
      DataSource = DataSource1
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 7
      Visible = True
    end
    object DBEdit3: TDBEditEh
      Left = 368
      Top = 148
      Width = 67
      Height = 24
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      BorderStyle = bsNone
      DataField = #24615#21035
      DataSource = DataSource1
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 8
      Visible = True
    end
    object DBEdit7: TDBEditEh
      Left = 368
      Top = 80
      Width = 67
      Height = 24
      Alignment = taLeftJustify
      BorderStyle = bsNone
      DataField = #30465#20221
      DataSource = DataSource1
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 5
      Visible = True
    end
    object DBEdit8: TDBEditEh
      Left = 124
      Top = 181
      Width = 177
      Height = 24
      Alignment = taLeftJustify
      BorderStyle = bsNone
      DataField = #36523#20221#35777#21495
      DataSource = DataSource1
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 9
      Visible = True
    end
    object DBEditEh1: TDBEditEh
      Left = 124
      Top = 114
      Width = 177
      Height = 24
      Alignment = taLeftJustify
      BorderStyle = bsNone
      DataField = #20934#32771#35777#21495
      DataSource = DataSource1
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 6
      Visible = True
    end
    object edt_xkbh: TEdit
      Left = 124
      Top = 249
      Width = 177
      Height = 22
      Color = clWhite
      TabOrder = 10
      OnKeyPress = edt_CjKeyPress
    end
    object cbb_Field: TDBComboBoxEh
      Left = 42
      Top = 29
      Width = 70
      Height = 22
      Alignment = taCenter
      EditButtons = <>
      Items.Strings = (
        #20934#32771#35777#21495
        #32771#29983#21495
        #36523#20221#35777#21495)
      KeyItems.Strings = (
        #27169#31946#26597#35810
        #32771#29983#21495
        #20934#32771#35777#21495
        #36523#20221#35777#21495)
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = #20934#32771#35777#21495
      Visible = True
    end
    object edt_Value: TEdit
      Left = 122
      Top = 29
      Width = 179
      Height = 22
      AutoSelect = False
      TabOrder = 2
      OnChange = edt_ValueChange
      OnKeyPress = edt_ValueKeyPress
    end
    object btn_Search: TBitBtn
      Left = 308
      Top = 27
      Width = 75
      Height = 25
      Caption = #26597#35810'[&F]'
      TabOrder = 0
      OnClick = btn_SearchClick
    end
    object edt_Length: TDBNumberEditEh
      Left = 452
      Top = 29
      Width = 28
      Height = 22
      Alignment = taCenter
      EditButtons = <>
      TabOrder = 3
      Value = 0.000000000000000000
      Visible = True
    end
    object DBEditEh2: TDBEditEh
      Left = 124
      Top = 215
      Width = 177
      Height = 24
      Alignment = taLeftJustify
      BorderStyle = bsNone
      DataField = #19987#19994
      DataSource = DataSource1
      EditButtons = <>
      Enabled = False
      ReadOnly = True
      TabOrder = 11
      Visible = True
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 360
    Top = 224
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from view_'#26657#32771#21333#31185#25104#32489#34920
    Params = <>
    Left = 392
    Top = 224
  end
  object cds_Sjfzb: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#26657#32771#21333#31185#25104#32489#21367#38754#20998#20540#34920
    Params = <>
    ProviderName = 'DSP_Query'
    RemoteServer = DM.SoapConnection1
    Left = 392
    Top = 256
  end
end
