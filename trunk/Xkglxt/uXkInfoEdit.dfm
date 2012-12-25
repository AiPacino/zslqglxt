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
    object Label1: TLabel
      Left = 37
      Top = 63
      Width = 48
      Height = 14
      Caption = #32771#29983#21495#65306
      FocusControl = edt_Ksh
    end
    object Label2: TLabel
      Left = 25
      Top = 119
      Width = 60
      Height = 14
      Caption = #32771#29983#22995#21517#65306
      FocusControl = edt_Xm
    end
    object Label3: TLabel
      Left = 49
      Top = 147
      Width = 36
      Height = 14
      Caption = #24615#21035#65306
    end
    object Label8: TLabel
      Left = 25
      Top = 91
      Width = 60
      Height = 14
      Caption = #36523#20221#35777#21495#65306
      FocusControl = edt_Sfzh
    end
    object Label4: TLabel
      Left = 25
      Top = 36
      Width = 60
      Height = 14
      Caption = #20934#32771#35777#21495#65306
      FocusControl = edt_Zkzh
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
      FocusControl = edt_zy
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
    object lbl_Len: TLabel
      Left = 371
      Top = 36
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
    object edt_Ksh: TDBEditEh
      Left = 93
      Top = 61
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      DataField = #32771#29983#21495
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      TabOrder = 1
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object edt_Xm: TDBEditEh
      Left = 93
      Top = 117
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      DataField = #22995#21517
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      TabOrder = 3
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object edt_Sfzh: TDBEditEh
      Left = 93
      Top = 89
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      DataField = #36523#20221#35777#21495
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      TabOrder = 2
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object edt_Zkzh: TDBEditEh
      Left = 93
      Top = 33
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      DataField = #20934#32771#35777#21495
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      TabOrder = 0
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object edt_zy: TDBComboBoxEh
      Left = 93
      Top = 174
      Width = 340
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #19987#19994
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      TabOrder = 5
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object DBEditEh3: TDBEditEh
      Left = 93
      Top = 202
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #32852#31995#30005#35805
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      TabOrder = 6
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object DBEditEh4: TDBEditEh
      Left = 93
      Top = 231
      Width = 67
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #37038#25919#32534#30721
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      TabOrder = 7
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object DBEditEh5: TDBEditEh
      Left = 93
      Top = 259
      Width = 340
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #36890#20449#22320#22336
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      TabOrder = 8
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object cbb_1: TDBComboBoxEh
      Left = 93
      Top = 145
      Width = 60
      Height = 22
      Alignment = taLeftJustify
      DataField = #24615#21035
      DataSource = XkInfoInput.DataSource2
      EditButtons = <>
      Items.Strings = (
        #30007
        #22899)
      TabOrder = 4
      Visible = True
      OnChange = edt_ZkzhChange
    end
    object edt_Length: TDBNumberEditEh
      Left = 432
      Top = 33
      Width = 28
      Height = 22
      Alignment = taCenter
      EditButtons = <>
      TabOrder = 9
      Value = 0.000000000000000000
      Visible = True
    end
  end
end
