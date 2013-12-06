object XkBkxxInfoEdit: TXkBkxxInfoEdit
  Left = 0
  Top = 0
  ActiveControl = edt_zy
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32771#29983#25253#32771#20449#24687#24405#20837
  ClientHeight = 300
  ClientWidth = 404
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
    Top = 250
    Width = 404
    Height = 50
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 330
    ExplicitWidth = 540
    DesignSize = (
      404
      50)
    object btn_Exit: TBitBtn
      Left = 309
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = #20851#38381'[&C]'
      TabOrder = 1
      OnClick = btn_ExitClick
    end
    object btn_Save: TBitBtn
      Left = 217
      Top = 12
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #20445#23384'[&S]'
      Enabled = False
      TabOrder = 0
      OnClick = btn_SaveClick
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 404
    Height = 250
    Align = alClient
    Caption = #32771#29983#25253#32771#20449#24687#65306
    TabOrder = 0
    ExplicitWidth = 540
    ExplicitHeight = 330
    object Label1: TLabel
      Left = 37
      Top = 35
      Width = 48
      Height = 14
      Caption = #32771#29983#21495#65306
      Enabled = False
      FocusControl = edt_Ksh
    end
    object lbl3: TLabel
      Left = 25
      Top = 150
      Width = 60
      Height = 14
      Caption = #25253#32771#26102#38388#65306
      FocusControl = edt_zy
    end
    object lbl4: TLabel
      Left = 25
      Top = 188
      Width = 60
      Height = 14
      Caption = #32771#35797#26102#38388#65306
      FocusControl = DBEditEh3
    end
    object lbl5: TLabel
      Left = 25
      Top = 73
      Width = 60
      Height = 14
      Caption = #25253#32771#19987#19994#65306
      FocusControl = DBEditEh4
    end
    object lbl8: TLabel
      Left = 335
      Top = 73
      Width = 17
      Height = 14
      Caption = '(*)'
    end
    object bvl1: TBevel
      Left = 18
      Top = 132
      Width = 368
      Height = 6
      Shape = bsTopLine
    end
    object edt_Ksh: TDBEditEh
      Left = 93
      Top = 33
      Width = 236
      Height = 22
      Alignment = taLeftJustify
      DataField = #32771#29983#21495
      DataSource = XkInfoInput.ds_bkxx
      EditButtons = <>
      Enabled = False
      TabOrder = 0
      Visible = True
      OnChange = edt_KshChange
    end
    object edt_zy: TDBComboBoxEh
      Left = 93
      Top = 71
      Width = 236
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #19987#19994
      DataSource = XkInfoInput.ds_bkxx
      EditButtons = <>
      TabOrder = 1
      Visible = True
      OnChange = edt_KshChange
    end
    object DBEditEh3: TDBDateTimeEditEh
      Left = 93
      Top = 148
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #25253#32771#26102#38388
      DataSource = XkInfoInput.ds_bkxx
      EditButtons = <>
      Kind = dtkDateEh
      TabOrder = 2
      Visible = True
      OnChange = edt_KshChange
    end
    object DBEditEh4: TDBDateTimeEditEh
      Left = 93
      Top = 186
      Width = 177
      Height = 22
      Alignment = taLeftJustify
      AlwaysShowBorder = True
      DataField = #32771#35797#26102#38388
      DataSource = XkInfoInput.ds_bkxx
      EditButtons = <>
      Kind = dtkDateEh
      TabOrder = 3
      Visible = True
      OnChange = edt_KshChange
    end
  end
end
