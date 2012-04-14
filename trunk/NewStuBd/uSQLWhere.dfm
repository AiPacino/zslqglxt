object SQLWhere: TSQLWhere
  Left = 0
  Top = 0
  ActiveControl = cbb_Value
  BorderIcons = [biSystemMenu]
  BorderStyle = bsToolWindow
  Caption = #26597#35810#26465#20214#35774#32622
  ClientHeight = 273
  ClientWidth = 394
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object GroupBox1: TGroupBox
    Left = 6
    Top = 6
    Width = 380
    Height = 89
    Caption = #23383#27573#65306
    TabOrder = 0
    object cbb_Field: TDBFieldComboBox
      Left = 16
      Top = 16
      Width = 97
      Height = 21
      ItemHeight = 13
      TabOrder = 0
      Text = #32771#29983#21495
      DataSource = DataSource1
    end
    object cbb_Compare: TDBComboBoxEh
      Left = 119
      Top = 16
      Width = 74
      Height = 21
      Alignment = taCenter
      EditButtons = <>
      Items.Strings = (
        #31561#20110
        #19981#31561#20110
        #21253#21547
        #22823#20110#31561#20110
        #22823#20110
        #23567#20110#31561#20110
        #23567#20110
        #20026#31354'(NULL)'
        #38750#31354'(NULL)')
      KeyItems.Strings = (
        '='
        '<>'
        'Like'
        '>='
        '>'
        '<='
        '<'
        'Is Null'
        'Is not Null')
      TabOrder = 1
      Text = #31561#20110
      Visible = True
      OnChange = cbb_CompareChange
    end
    object cbb_Value: TDBComboBoxEh
      Left = 199
      Top = 16
      Width = 170
      Height = 21
      EditButtons = <>
      TabOrder = 2
      Visible = True
    end
    object btn_Add: TBitBtn
      Left = 291
      Top = 46
      Width = 75
      Height = 25
      Caption = #22686#21152#26465#20214
      TabOrder = 3
      OnClick = btn_AddClick
    end
    object rg_1: TRadioGroup
      Left = 16
      Top = 41
      Width = 258
      Height = 32
      Columns = 2
      ItemIndex = 0
      Items.Strings = (
        #24182#19988' (AND)'
        #25110#32773' (OR)')
      TabOrder = 4
    end
  end
  object GroupBox3: TGroupBox
    Left = 6
    Top = 101
    Width = 380
    Height = 122
    Caption = #24050#21152#20837#30340#36807#28388#26465#20214#65306
    TabOrder = 1
    object mmo1: TMemo
      Left = 2
      Top = 15
      Width = 376
      Height = 105
      Align = alClient
      TabOrder = 0
    end
  end
  object btn_OK: TBitBtn
    Left = 208
    Top = 233
    Width = 75
    Height = 25
    Caption = #30830#23450'[&O]'
    ModalResult = 1
    TabOrder = 2
  end
  object btn_Exit: TBitBtn
    Left = 309
    Top = 233
    Width = 75
    Height = 25
    Caption = #21462#28040'[&C]'
    ModalResult = 2
    TabOrder = 3
    OnClick = btn_ExitClick
  end
  object btn_Clear: TBitBtn
    Left = 8
    Top = 233
    Width = 75
    Height = 25
    Caption = #28165#38500#26465#20214
    TabOrder = 4
    OnClick = btn_ClearClick
  end
  object DataSource1: TDataSource
    Left = 184
    Top = 120
  end
end
