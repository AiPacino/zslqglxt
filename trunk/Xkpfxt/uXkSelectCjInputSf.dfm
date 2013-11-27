object XkSelectCjInputSf: TXkSelectCjInputSf
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #25104#32489#24405#20837#30465#20221#36873#25321
  ClientHeight = 250
  ClientWidth = 409
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
  object btn_OK: TBitBtn
    Left = 220
    Top = 208
    Width = 75
    Height = 25
    Caption = #30830#23450'[&O]'
    Enabled = False
    ModalResult = 1
    TabOrder = 0
  end
  object btn_Cancel: TBitBtn
    Left = 316
    Top = 208
    Width = 75
    Height = 25
    Caption = #21462#28040'[&C]'
    ModalResult = 2
    TabOrder = 1
    OnClick = btn_CancelClick
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 8
    Width = 385
    Height = 193
    TabOrder = 2
    object lbl1: TLabel
      Left = 10
      Top = 96
      Width = 60
      Height = 14
      Caption = #24405#20837#30465#20221#65306
    end
    object lbl_Pw: TLabel
      Left = 188
      Top = 96
      Width = 60
      Height = 14
      Caption = #35797#21367#35780#22996#65306
    end
    object grp_Yx: TGroupBox
      Left = 10
      Top = 21
      Width = 159
      Height = 50
      Caption = #25215#32771#38498#31995#65306
      TabOrder = 0
      object cbb_Yx: TDBComboBoxEh
        Left = 8
        Top = 20
        Width = 142
        Height = 22
        Enabled = False
        EditButtons = <>
        TabOrder = 0
        Text = #19981#38480#38498#31995
        Visible = True
      end
    end
    object grp1: TGroupBox
      Left = 184
      Top = 21
      Width = 184
      Height = 50
      Caption = #24405#20837#31185#30446#65306
      TabOrder = 1
      object cbb_Zy: TDBComboBoxEh
        Left = 8
        Top = 20
        Width = 169
        Height = 22
        Enabled = False
        EditButtons = <>
        TabOrder = 0
        Text = #19981#38480#31185#30446
        Visible = True
      end
    end
    object cbb_Sf: TDBComboBoxEh
      Left = 71
      Top = 93
      Width = 97
      Height = 22
      EditButtons = <>
      TabOrder = 2
      Text = #19981#38480#30465#20221
      Visible = True
      OnChange = cbb_SfChange
    end
    object edt_Pw: TDBComboBoxEh
      Left = 251
      Top = 93
      Width = 116
      Height = 22
      EditButtons = <>
      TabOrder = 3
      Text = #26080
      Visible = True
      OnChange = cbb_SfChange
    end
  end
end
