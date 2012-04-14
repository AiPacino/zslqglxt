object XkKdEdit: TXkKdEdit
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #32771#28857#20449#24687#24405#20837
  ClientHeight = 338
  ClientWidth = 515
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
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox1: TGroupBox
    Left = 15
    Top = 9
    Width = 484
    Height = 280
    Caption = #32771#28857#20449#24687#65306
    TabOrder = 0
    object lbl2: TLabel
      Left = 44
      Top = 61
      Width = 60
      Height = 14
      Caption = #32771#28857#21517#31216#65306
    end
    object lbl3: TLabel
      Left = 20
      Top = 97
      Width = 84
      Height = 14
      Caption = #25253#21517#36215#27490#26102#38388#65306
    end
    object lbl4: TLabel
      Left = 20
      Top = 131
      Width = 84
      Height = 14
      Caption = #32771#35797#36215#27490#26102#38388#65306
    end
    object lbl5: TLabel
      Left = 56
      Top = 164
      Width = 48
      Height = 14
      Caption = #32852#31995#20154#65306
    end
    object lbl6: TLabel
      Left = 44
      Top = 198
      Width = 60
      Height = 14
      Caption = #32852#31995#30005#35805#65306
    end
    object lbl7: TLabel
      Left = 241
      Top = 97
      Width = 14
      Height = 23
      Caption = '~'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl8: TLabel
      Left = 241
      Top = 129
      Width = 14
      Height = 23
      Caption = '~'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -19
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lbl1: TLabel
      Left = 44
      Top = 26
      Width = 60
      Height = 14
      Caption = #25152#22312#30465#20221#65306
    end
    object lbl9: TLabel
      Left = 243
      Top = 64
      Width = 209
      Height = 14
      Caption = '(*'#32771#28857#21517#31216#35831#20197#30465#20221#24320#22836#65292#22914#28246#21335#38271#27801')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edt_BmStart: TDBDateTimeEditEh
      Left = 112
      Top = 95
      Width = 120
      Height = 22
      EditButtons = <>
      TabOrder = 2
      Visible = True
      OnChange = cbb_SfChange
      EditFormat = 'YYYY-MM-DD'
    end
    object edt_KsStart: TDBDateTimeEditEh
      Left = 112
      Top = 130
      Width = 120
      Height = 22
      EditButtons = <>
      TabOrder = 4
      Visible = True
      OnChange = cbb_SfChange
      EditFormat = 'YYYY-MM-DD'
    end
    object edt_lxr: TEdit
      Left = 112
      Top = 164
      Width = 184
      Height = 22
      TabOrder = 6
      OnChange = cbb_SfChange
    end
    object edt_Tel: TEdit
      Left = 112
      Top = 197
      Width = 184
      Height = 22
      TabOrder = 7
      OnChange = cbb_SfChange
    end
    object edt_BmEnd: TDBDateTimeEditEh
      Left = 265
      Top = 95
      Width = 120
      Height = 22
      EditButtons = <>
      TabOrder = 3
      Visible = True
      OnChange = cbb_SfChange
      EditFormat = 'YYYY-MM-DD'
    end
    object edt_KsEnd: TDBDateTimeEditEh
      Left = 265
      Top = 130
      Width = 120
      Height = 22
      EditButtons = <>
      TabOrder = 5
      Visible = True
      OnChange = cbb_SfChange
      EditFormat = 'YYYY-MM-DD'
    end
    object edt_Kdmc: TEdit
      Left = 112
      Top = 60
      Width = 121
      Height = 22
      TabOrder = 1
      OnChange = cbb_SfChange
    end
    object cbb_Sf: TDBComboBoxEh
      Left = 112
      Top = 24
      Width = 121
      Height = 22
      EditButtons = <>
      TabOrder = 0
      Visible = True
      OnChange = cbb_SfChange
    end
  end
  object btn_Save: TBitBtn
    Left = 312
    Top = 303
    Width = 75
    Height = 25
    Caption = #20445#23384'[&S]'
    Enabled = False
    TabOrder = 1
    OnClick = btn_SaveClick
  end
  object btn_Cancel: TBitBtn
    Left = 424
    Top = 303
    Width = 75
    Height = 25
    Caption = #21462#28040'[&C]'
    TabOrder = 2
    OnClick = btn_CancelClick
  end
  object DataSource1: TDataSource
    Left = 32
    Top = 40
  end
end
