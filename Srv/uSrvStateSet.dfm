object SrvStateSet: TSrvStateSet
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26381#21153#22120#21551#29992'/'#20572#29992#35774#32622
  ClientHeight = 253
  ClientWidth = 390
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
  object pnl1: TPanel
    Left = 0
    Top = 207
    Width = 390
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object btn_Update: TBitBtn
      Left = 170
      Top = 8
      Width = 75
      Height = 25
      Caption = #35774#32622'[&S]'
      TabOrder = 0
      OnClick = btn_UpdateClick
    end
    object btn_Exit: TBitBtn
      Left = 297
      Top = 8
      Width = 75
      Height = 25
      Caption = #36864#20986'[&X]'
      TabOrder = 1
      OnClick = btn_ExitClick
    end
  end
  object grp1: TGroupBox
    Left = 14
    Top = 6
    Width = 361
    Height = 188
    Caption = #35774#32622#20449#24687#65306
    TabOrder = 0
    object Label1: TLabel
      Left = 48
      Top = 40
      Width = 96
      Height = 14
      Caption = #26381#21153#22120#24403#21069#29366#24577#65306
    end
    object Label2: TLabel
      Left = 48
      Top = 88
      Width = 96
      Height = 14
      Caption = #26381#21153#22120#35774#32622#20869#23481#65306
    end
    object lbl_State: TLabel
      Left = 168
      Top = 40
      Width = 65
      Height = 14
      Caption = #26381#21153#24050#20572#29992
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object dbchk1: TCheckBox
      Left = 122
      Top = 130
      Width = 95
      Height = 17
      Caption = #26159#21542#21551#29992
      TabOrder = 0
    end
  end
  object ds1: TDataSource
    DataSet = qry1
    Left = 32
    Top = 152
  end
  object qry1: TADOQuery
    Parameters = <>
    Left = 72
    Top = 152
  end
end
