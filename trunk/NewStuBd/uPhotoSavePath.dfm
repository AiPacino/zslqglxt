object PhotoSavePath: TPhotoSavePath
  Left = 0
  Top = 0
  ActiveControl = btn_Exit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #26381#21153#22120#29031#29255#23384#25918#36335#24452
  ClientHeight = 253
  ClientWidth = 390
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = False
  Position = poMainFormCenter
  Visible = True
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
    object lbl2: TLabel
      Left = 14
      Top = 12
      Width = 161
      Height = 14
      Caption = '(*'#21487#22312#26381#21153#22120#37197#32622#24037#20855#20013#26356#25913')'
      Color = clYellow
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
      Transparent = False
    end
    object btn_Update: TBitBtn
      Left = 193
      Top = 8
      Width = 75
      Height = 25
      Caption = #35774#32622'[&S]'
      Enabled = False
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
    Caption = #23384#25918#30446#24405#20449#24687#65306
    TabOrder = 0
    object Label1: TLabel
      Left = 18
      Top = 27
      Width = 93
      Height = 14
      Caption = #26381#21153#22120'URL'#30446#24405#65306
    end
    object Label2: TLabel
      Left = 18
      Top = 96
      Width = 96
      Height = 14
      Caption = #26381#21153#22120#29289#29702#36335#24452#65306
    end
    object lbl1: TLabel
      Left = 56
      Top = 160
      Width = 206
      Height = 14
      Caption = '(*'#26381#21153#22120'URL'#30446#24405#21644#29289#29702#36335#24452#24517#39035#23384#22312')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object DBEditEh1: TDBEditEh
      Left = 50
      Top = 55
      Width = 291
      Height = 22
      DataField = 'sUrl'
      DataSource = ds1
      EditButtons = <>
      Enabled = False
      TabOrder = 0
      Visible = True
    end
    object DBEditEh2: TDBEditEh
      Left = 50
      Top = 123
      Width = 291
      Height = 22
      DataField = 'SavePath'
      DataSource = ds1
      EditButtons = <>
      Enabled = False
      TabOrder = 1
      Visible = True
    end
  end
  object cds_1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#29031#29255#36335#24452#20449#24687#34920
    Params = <>
    Left = 256
    Top = 24
  end
  object ds1: TDataSource
    DataSet = cds_1
    Left = 224
    Top = 24
  end
end
