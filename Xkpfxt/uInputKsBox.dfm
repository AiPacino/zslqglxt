object InputKsBox: TInputKsBox
  Left = 0
  Top = 0
  ActiveControl = edt_Value
  BorderStyle = bsToolWindow
  Caption = #32771#29983#26597#39564
  ClientHeight = 249
  ClientWidth = 422
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  object albl1: TCnAALabel
    Left = 16
    Top = 16
    Width = 350
    Height = 25
    ParentEffect.ParentFont = False
    Caption = #35831#36755#20837#32771#29983#21495#12289#20934#32771#35777#21495#25110#32773#36523#20221#35777#21495#65306
    Font.Charset = GB2312_CHARSET
    Font.Color = clBlue
    Font.Height = -19
    Font.Name = #26041#27491#23002#20307#31616#20307
    Font.Style = []
    Effect.FontEffect.Shadow.Enabled = True
  end
  object bvl1: TBevel
    Left = 10
    Top = 173
    Width = 401
    Height = 6
    Shape = bsTopLine
  end
  object lbl_Len: TLabel
    Left = 376
    Top = 88
    Width = 17
    Height = 14
    Caption = '(*)'
  end
  object edt_Value: TEdit
    Left = 64
    Top = 80
    Width = 305
    Height = 31
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    OnChange = edt_ValueChange
    OnKeyPress = edt_ValueKeyPress
  end
  object btn_OK: TRzBitBtn
    Left = 102
    Top = 195
    Width = 105
    Height = 37
    ModalResult = 1
    Caption = #30830#23450
    Enabled = False
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #26041#27491#23002#20307#31616#20307
    Font.Style = []
    HotTrack = True
    HotTrackColorType = htctComplement
    ParentFont = False
    TabOrder = 1
    ThemeAware = False
    Layout = blGlyphBottom
  end
  object btn_Cancel: TRzBitBtn
    Left = 254
    Top = 195
    Width = 105
    Height = 37
    ModalResult = 2
    Caption = #21462#28040
    Font.Charset = GB2312_CHARSET
    Font.Color = clWindowText
    Font.Height = -19
    Font.Name = #26041#27491#23002#20307#31616#20307
    Font.Style = []
    HotTrack = True
    HotTrackColorType = htctComplement
    ParentFont = False
    TabOrder = 2
    ThemeAware = False
    Layout = blGlyphBottom
  end
end
