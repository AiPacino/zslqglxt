object ExportToAccess: TExportToAccess
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #32771#29983#25968#25454#23548#20986#21040'Access'#25991#20214
  ClientHeight = 314
  ClientWidth = 475
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
  object lbl1: TLabel
    Left = 25
    Top = 19
    Width = 157
    Height = 14
    Caption = #23384#25918#23548#20986#20869#23481#30340'Access'#25991#20214#65306
  end
  object lbl2: TLabel
    Left = 25
    Top = 93
    Width = 120
    Height = 14
    Caption = #35201#23548#20986#30340#25968#25454#28304#20869#23481#65306
  end
  object bvl1: TBevel
    Left = 0
    Top = 264
    Width = 475
    Height = 9
    Align = alBottom
    Shape = bsTopLine
    ExplicitTop = 249
  end
  object lbl_Hint: TLabel
    Left = 48
    Top = 216
    Width = 4
    Height = 14
  end
  object btnedt_Path: TCnButtonEdit
    Left = 48
    Top = 48
    Width = 409
    Height = 21
    ButtonFlat = False
    ButtonKind = bkLookup
    AutoSize = False
    TabOrder = 0
    OnChange = btnedt_PathChange
    ButtonPic.Data = {
      FE040000424DFE040000000000003604000028000000140000000A0000000100
      080000000000C8000000330B0000330B00000001000000010000000000003300
      00006600000099000000CC000000FF0000000033000033330000663300009933
      0000CC330000FF33000000660000336600006666000099660000CC660000FF66
      000000990000339900006699000099990000CC990000FF99000000CC000033CC
      000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
      0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
      330000333300333333006633330099333300CC333300FF333300006633003366
      33006666330099663300CC663300FF6633000099330033993300669933009999
      3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
      330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
      66006600660099006600CC006600FF0066000033660033336600663366009933
      6600CC336600FF33660000666600336666006666660099666600CC666600FF66
      660000996600339966006699660099996600CC996600FF99660000CC660033CC
      660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
      6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
      990000339900333399006633990099339900CC339900FF339900006699003366
      99006666990099669900CC669900FF6699000099990033999900669999009999
      9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
      990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
      CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
      CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
      CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
      CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
      CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
      FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
      FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
      FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
      FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
      000000808000800000008000800080800000C0C0C00080808000191919004C4C
      4C00B2B2B200E5E5E500C8AC2800E0CC6600F2EABF00B59B2400D8E9EC009933
      6600D075A300ECC6D900646F710099A8AC00E2EFF10000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000232323232323
      2323232323232323232323232323232323232323232323232323232323232323
      2323232323232323232323232323232323232323232323232323232323232323
      2323232323232323232323E10023E10023E100232381D72381D72381D7232381
      E12381E12381E123238181238181238181232323232323232323232323232323
      2323232323232323232323232323232323232323232323232323232323232323
      2323232323232323232323232323232323232323232323232323232323232323
      2323}
    OnButtonClick = btnedt_PathButtonClick
  end
  object edt_Sql: TEdit
    Left = 48
    Top = 125
    Width = 409
    Height = 22
    TabOrder = 1
    Text = 'select * from '#24405#21462#20449#24687#34920' where 1>0'
  end
  object pb1: TProgressBar
    Left = 48
    Top = 169
    Width = 409
    Height = 18
    TabOrder = 2
  end
  object chk_ReleaseAll: TCheckBox
    Left = 292
    Top = 217
    Width = 164
    Height = 17
    Caption = #23548#20986#21069#28165#31354'Access'#20013#30340#25968#25454
    TabOrder = 3
    OnClick = chk_ReleaseAllClick
  end
  object pnl_1: TPanel
    Left = 0
    Top = 273
    Width = 475
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 4
    object btn_Start: TBitBtn
      Left = 244
      Top = 4
      Width = 75
      Height = 25
      Caption = #24320#22987#23548#20986
      TabOrder = 0
      OnClick = btn_StartClick
    end
    object btn_Exit: TBitBtn
      Left = 366
      Top = 4
      Width = 75
      Height = 25
      Caption = #36864#20986
      TabOrder = 1
      OnClick = btn_ExitClick
    end
  end
  object dlgOpen1: TOpenDialog
    Left = 336
    Top = 56
  end
  object qry_Access: TADOQuery
    Parameters = <>
    Left = 336
    Top = 96
  end
  object ADOConnection1: TADOConnection
    Left = 368
    Top = 96
  end
  object cds_lqmd: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 288
    Top = 96
  end
end
