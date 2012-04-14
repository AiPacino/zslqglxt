object NetPayTimeSet: TNetPayTimeSet
  Left = 0
  Top = 0
  ActiveControl = btn_Exit
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #32593#19978#32564#36153#26102#38388#35774#32622
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
      Width = 60
      Height = 14
      Caption = #24320#22987#26102#38388#65306
    end
    object Label2: TLabel
      Left = 48
      Top = 88
      Width = 60
      Height = 14
      Caption = #32467#26463#26102#38388#65306
    end
    object Label3: TLabel
      Left = 288
      Top = 41
      Width = 17
      Height = 14
      Caption = '(*)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label4: TLabel
      Left = 288
      Top = 88
      Width = 17
      Height = 14
      Caption = '(*)'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object dbchk1: TDBCheckBox
      Left = 122
      Top = 130
      Width = 95
      Height = 17
      Caption = #26159#21542#21551#29992
      DataField = #26159#21542#21551#29992
      DataSource = ds1
      TabOrder = 2
      ValueChecked = 'True'
      ValueUnchecked = 'False'
    end
    object DBDateTimeEditEh1: TDBDateTimeEditEh
      Left = 122
      Top = 37
      Width = 147
      Height = 22
      DataField = #24320#22987#26102#38388
      DataSource = ds1
      EditButtons = <>
      TabOrder = 0
      Visible = True
      EditFormat = 'YYYY-MM-DD HH:NN:SS'
    end
    object DBDateTimeEditEh2: TDBDateTimeEditEh
      Left = 122
      Top = 84
      Width = 147
      Height = 22
      DataField = #32467#26463#26102#38388
      DataSource = ds1
      EditButtons = <>
      TabOrder = 1
      Visible = True
      EditFormat = 'YYYY-MM-DD 23:59:59'
    end
  end
  object cds_1: TClientDataSet
    Aggregates = <>
    CommandText = 'select * from '#32593#19978#25903#20184#35774#32622#34920
    Params = <>
    BeforePost = cds_1BeforePost
    OnNewRecord = cds_1NewRecord
    Left = 64
    Top = 152
    object cds_1ID: TAutoIncField
      FieldName = 'ID'
      ReadOnly = True
    end
    object cds_1DateTimeField: TDateTimeField
      FieldName = #24320#22987#26102#38388
    end
    object cds_1DateTimeField2: TDateTimeField
      FieldName = #32467#26463#26102#38388
    end
    object cds_1BooleanField: TBooleanField
      FieldName = #26159#21542#21551#29992
    end
    object cds_1WideStringField: TWideStringField
      FieldName = #25805#20316#21592
      Size = 15
    end
    object cds_1ActionTime: TDateTimeField
      FieldName = 'ActionTime'
    end
  end
  object ds1: TDataSource
    DataSet = cds_1
    Left = 32
    Top = 152
  end
end
