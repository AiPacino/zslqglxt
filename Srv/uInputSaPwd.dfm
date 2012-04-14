object InputSaPwd: TInputSaPwd
  Left = 0
  Top = 0
  ActiveControl = edt_Pwd
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsDialog
  Caption = 'MS SQL Server '#25968#25454#24211'SA'#23494#30721#36755#20837
  ClientHeight = 194
  ClientWidth = 318
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 14
  object bvl1: TBevel
    Left = 13
    Top = 12
    Width = 292
    Height = 133
    Shape = bsFrame
  end
  object lbl_1: TLabel
    Left = 23
    Top = 6
    Width = 87
    Height = 14
    Caption = #35831#36755#20837'SA'#23494#30721#65306
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object lbl1: TLabel
    Left = 51
    Top = 80
    Width = 237
    Height = 42
    Caption = #35686#21578#65306' '#25968#25454#24211#24674#22797#25805#20316#35201#27714#25805#20316#32773#25317#26377'SA'#26435#38480#65281#32780#19988#25968#25454#24674#22797#25805#20316#20250#21024#38500#24403#21069#25968#25454#24211#30340#20013#30340#25152#26377#35760#24405#65281#35831#24910#37325#25805#20316#65281
    Color = clBtnFace
    Font.Charset = ANSI_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Verdana'
    Font.Style = []
    ParentColor = False
    ParentFont = False
    WordWrap = True
  end
  object lbl2: TLabel
    Left = 38
    Top = 43
    Width = 51
    Height = 14
    Caption = 'SA'#23494#30721#65306
  end
  object btn_OK: TBitBtn
    Left = 125
    Top = 158
    Width = 75
    Height = 25
    Caption = #30830#23450'[&O]'
    Default = True
    TabOrder = 0
    OnClick = btn_OKClick
  end
  object btn_Exit: TBitBtn
    Left = 226
    Top = 158
    Width = 75
    Height = 25
    Cancel = True
    Caption = #21462#28040'[&C]'
    ModalResult = 2
    TabOrder = 1
    OnClick = btn_ExitClick
  end
  object edt_Pwd: TEdit
    Left = 89
    Top = 39
    Width = 197
    Height = 22
    PasswordChar = '*'
    TabOrder = 2
  end
end
