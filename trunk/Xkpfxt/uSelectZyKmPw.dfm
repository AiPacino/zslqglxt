object SelectZyKmPw: TSelectZyKmPw
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = #35780#20998#31185#30446#21644#35780#22996#36873#25321
  ClientHeight = 364
  ClientWidth = 490
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  DesignSize = (
    490
    364)
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox2: TGroupBox
    Left = 8
    Top = 6
    Width = 474
    Height = 303
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = #35780#22996#36873#25321#65306
    TabOrder = 0
    ExplicitWidth = 623
    ExplicitHeight = 345
    object RzCheckList1: TRzCheckList
      Left = 2
      Top = 16
      Width = 470
      Height = 285
      Align = alClient
      Columns = 3
      ItemHeight = 25
      TabOrder = 0
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 315
    Width = 490
    Height = 49
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitTop = 357
    ExplicitWidth = 639
    DesignSize = (
      490
      49)
    object Bevel1: TBevel
      Left = 0
      Top = 0
      Width = 490
      Height = 8
      Align = alTop
      Shape = bsTopLine
      ExplicitWidth = 639
    end
    object btn_OK: TBitBtn
      Left = 309
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #30830#23450#36873#25321
      TabOrder = 0
      ExplicitLeft = 451
    end
    object btn_Exit: TBitBtn
      Left = 405
      Top = 13
      Width = 75
      Height = 25
      Anchors = [akRight, akBottom]
      Caption = #36864#20986
      TabOrder = 1
      OnClick = btn_ExitClick
      ExplicitLeft = 547
    end
  end
  object cds_Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 488
    Top = 160
  end
  object cds_Delta: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 144
    Top = 168
  end
  object cds_Master: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 112
    Top = 168
  end
end
