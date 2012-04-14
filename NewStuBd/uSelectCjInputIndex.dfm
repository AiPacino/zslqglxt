object SelectCjInputIndex: TSelectCjInputIndex
  Left = 0
  Top = 0
  ActiveControl = RadioGroup1
  BorderStyle = bsDialog
  Caption = #25104#32489#24405#20837#31185#30446#36873#25321
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
  PixelsPerInch = 96
  TextHeight = 14
  object RadioGroup1: TRzRadioGroup
    Left = 15
    Top = 11
    Width = 380
    Height = 182
    Caption = #35831#36873#25321#65306
    GroupStyle = gsStandard
    ItemHeight = 35
    Items.Strings = (
      #31532#19968#27425#25104#32489#24405#20837
      #31532#20108#27425#25104#32489#24405#20837)
    StartYPos = 70
    TabOrder = 0
    OnClick = RadioGroup1Click
    object grp_Yx: TGroupBox
      Left = 10
      Top = 21
      Width = 128
      Height = 50
      Caption = #25215#32771#38498#31995#65306
      TabOrder = 2
      object cbb_Yx: TDBComboBoxEh
        Left = 8
        Top = 20
        Width = 113
        Height = 22
        EditButtons = <>
        TabOrder = 0
        Text = #19981#38480#38498#31995
        Visible = True
        OnChange = cbb_YxChange
      end
    end
    object grp1: TGroupBox
      Left = 240
      Top = 21
      Width = 128
      Height = 50
      Caption = #31185#30446#65306
      TabOrder = 0
      object cbb_Zy: TDBComboBoxEh
        Left = 8
        Top = 20
        Width = 113
        Height = 22
        EditButtons = <>
        TabOrder = 0
        Text = #19981#38480#31185#30446
        Visible = True
      end
    end
    object grp2: TGroupBox
      Left = 144
      Top = 21
      Width = 89
      Height = 50
      Caption = #30465#20221#65306
      TabOrder = 1
      object cbb_Sf: TDBComboBoxEh
        Left = 8
        Top = 20
        Width = 73
        Height = 22
        EditButtons = <>
        TabOrder = 0
        Text = #19981#38480#30465#20221
        Visible = True
      end
    end
  end
  object btn_OK: TBitBtn
    Left = 220
    Top = 208
    Width = 75
    Height = 25
    Caption = #30830#23450'[&O]'
    Enabled = False
    ModalResult = 1
    TabOrder = 1
    OnClick = btn_OKClick
  end
  object btn_Cancel: TBitBtn
    Left = 316
    Top = 208
    Width = 75
    Height = 25
    Caption = #21462#28040'[&C]'
    ModalResult = 2
    TabOrder = 2
    OnClick = btn_CancelClick
  end
end
