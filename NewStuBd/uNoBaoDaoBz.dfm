object NoBaoDaoBz: TNoBaoDaoBz
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #35774#32622#26032#29983#26410#25253#21040#21407#22240
  ClientHeight = 332
  ClientWidth = 497
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  DesignSize = (
    497
    332)
  PixelsPerInch = 96
  TextHeight = 14
  object RadioGroup1: TRzRadioGroup
    Left = 18
    Top = 8
    Width = 461
    Height = 272
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #26410#25253#21040#21407#22240#65306
    GroupStyle = gsStandard
    Items.Strings = (
      #30003#35831#24310#32531#25253#21040#65288#35831#20551#65289
      #25918#24323#20837#23398#36164#26684
      #26080#27861#32852#31995#32771#29983
      #20854#20182#21407#22240#65306)
    TabOrder = 0
    OnClick = RadioGroup1Click
    object Memo1: TMemo
      Left = 24
      Top = 104
      Width = 425
      Height = 153
      Enabled = False
      TabOrder = 0
      OnChange = Memo1Change
    end
  end
  object btn_OK: TBitBtn
    Left = 303
    Top = 295
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #30830#23450'[&O]'
    Enabled = False
    ModalResult = 1
    TabOrder = 1
    ExplicitLeft = 211
    ExplicitTop = 216
  end
  object btn_Close: TBitBtn
    Left = 397
    Top = 295
    Width = 75
    Height = 25
    Anchors = [akRight, akBottom]
    Caption = #21462#28040'[&C]'
    ModalResult = 2
    TabOrder = 2
    ExplicitLeft = 305
    ExplicitTop = 216
  end
  object cds_Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 272
    Top = 32
  end
end
