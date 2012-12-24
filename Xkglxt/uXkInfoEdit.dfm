object XkInfoEdit: TXkInfoEdit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32771#29983#25253#32771#20449#24687#24405#20837
  ClientHeight = 380
  ClientWidth = 540
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
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
    Caption = #32771#29983#25253#32771#20449#24687#65306
    TabOrder = 0
    ExplicitLeft = 8
    ExplicitTop = 8
    object Label1: TLabel
      Left = 37
      Top = 63
      Width = 48
      Height = 14
      Caption = #32771#29983#21495#65306
      FocusControl = DBEdit1
    end
    object Label2: TLabel
      Left = 25
      Top = 119
      Width = 60
      Height = 14
      Caption = #32771#29983#22995#21517#65306
      FocusControl = DBEdit2
    end
    object Label3: TLabel
      Left = 49
      Top = 147
      Width = 36
      Height = 14
      Caption = #24615#21035#65306
      FocusControl = DBEdit3
    end
    object Label8: TLabel
      Left = 25
      Top = 91
      Width = 60
      Height = 14
      Caption = #36523#20221#35777#21495#65306
      FocusControl = DBEdit8
    end
    object Label4: TLabel
      Left = 25
      Top = 36
      Width = 60
      Height = 14
      Caption = #20934#32771#35777#21495#65306
      FocusControl = DBEditEh1
    end
    object lbl2: TLabel
      Left = 279
      Top = 36
      Width = 53
      Height = 14
      Caption = '(*'#24517#22635#39033')'
    end
    object lbl3: TLabel
      Left = 25
      Top = 204
      Width = 60
      Height = 14
      Caption = #32852#31995#30005#35805#65306
      FocusControl = DBEditEh2
    end
    object lbl4: TLabel
      Left = 25
      Top = 233
      Width = 60
      Height = 14
      Caption = #37038#25919#32534#30721#65306
      FocusControl = DBEditEh3
    end
    object lbl5: TLabel
      Left = 25
      Top = 176
      Width = 60
      Height = 14
      Caption = #25253#32771#19987#19994#65306
      FocusControl = DBEditEh4
    end
    object lbl6: TLabel
      Left = 25
      Top = 261
      Width = 60
      Height = 14
      Caption = #36890#20449#22320#22336#65306
      FocusControl = DBEditEh5
    end
    object lbl7: TLabel
      Left = 279
      Top = 119
      Width = 53
      Height = 14
      Caption = '(*'#24517#22635#39033')'
    end
    object lbl8: TLabel
      Left = 446
      Top = 176
      Width = 53
      Height = 14
      Caption = '(*'#24517#22635#39033')'
    end
    object DBEdit1: TDBEditEh
      Left = 93
      Top = 61
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      DataField = #32771#29983#21495
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 0
      Visible = True
    end
    object DBEdit2: TDBEditEh
      Left = 93
      Top = 117
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      DataField = #22995#21517
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 2
      Visible = True
    end
    object DBEdit3: TDBEditEh
      Left = 93
      Top = 145
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #24615#21035
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 3
      Visible = True
    end
    object DBEdit8: TDBEditEh
      Left = 93
      Top = 89
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      DataField = #36523#20221#35777#21495
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 4
      Visible = True
    end
    object DBEditEh1: TDBEditEh
      Left = 93
      Top = 33
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      DataField = #20934#32771#35777#21495
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 1
      Visible = True
    end
    object DBEditEh2: TDBEditEh
      Left = 93
      Top = 174
      Width = 340
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #19987#19994
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 5
      Visible = True
    end
    object DBEditEh3: TDBEditEh
      Left = 93
      Top = 202
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #32852#31995#30005#35805
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 6
      Visible = True
    end
    object DBEditEh4: TDBEditEh
      Left = 93
      Top = 231
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #37038#25919#32534#30721
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 7
      Visible = True
    end
    object DBEditEh5: TDBEditEh
      Left = 93
      Top = 259
      Width = 340
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #36890#20449#22320#22336
      DataSource = DataSource1
      EditButtons = <>
      ReadOnly = True
      TabOrder = 8
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
    AfterOpen = ClientDataSet1AfterOpen
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
