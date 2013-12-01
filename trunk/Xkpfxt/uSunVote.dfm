object Form2: TForm2
  Left = 0
  Top = 0
  Caption = 'Form2'
  ClientHeight = 609
  ClientWidth = 554
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object mmo1: TMemo
    Left = 24
    Top = 16
    Width = 289
    Height = 577
    Lines.Strings = (
      'mmo1')
    TabOrder = 0
  end
  object btn1: TButton
    Left = 368
    Top = 14
    Width = 162
    Height = 25
    Caption = 'BaseConnectionOpen'
    TabOrder = 1
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 368
    Top = 56
    Width = 162
    Height = 25
    Caption = #35835#22522#31449#20449#24687
    TabOrder = 2
    OnClick = btn2Click
  end
  object btn3: TButton
    Left = 368
    Top = 96
    Width = 162
    Height = 25
    Caption = #35835#38190#30424#20449#24687
    TabOrder = 3
    OnClick = btn3Click
  end
  object btn4: TButton
    Left = 368
    Top = 127
    Width = 162
    Height = 25
    Caption = #20851#38381#38190#30424
    TabOrder = 4
    OnClick = btn4Click
  end
  object btn5: TButton
    Left = 368
    Top = 158
    Width = 162
    Height = 25
    Caption = #26174#31034#38190#30424#21495
    TabOrder = 5
    OnClick = btn5Click
  end
  object btn6: TButton
    Left = 368
    Top = 193
    Width = 162
    Height = 25
    Caption = #31614#21040
    TabOrder = 6
    OnClick = btn6Click
  end
  object btn7: TButton
    Left = 368
    Top = 241
    Width = 162
    Height = 25
    Caption = #30701#20449
    TabOrder = 7
    OnClick = btn7Click
  end
  object BaseConnection1: TBaseConnection
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnBaseOnLine = BaseConnection1BaseOnLine
    Left = 336
    Top = 8
  end
  object BaseManage1: TBaseManage
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnBaseConfig = BaseManage1BaseConfig
    Left = 336
    Top = 48
  end
  object KeypadManage1: TKeypadManage
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnKeyConfig = KeypadManage1KeyConfig
    Left = 336
    Top = 96
  end
  object SignIn1: TSignIn
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    OnKeyStatus = SignIn1KeyStatus
    OnKeyAuthorize = SignIn1KeyAuthorize
    OnKeyAuthorizeSN = SignIn1KeyAuthorizeSN
    OnKeyStatusSN = SignIn1KeyStatusSN
    Left = 336
    Top = 192
  end
  object Message1: TMessage
    AutoConnect = False
    ConnectKind = ckRunningOrNew
    Left = 336
    Top = 240
  end
end
