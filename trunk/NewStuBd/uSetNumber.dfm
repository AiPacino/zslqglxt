object SetNumber: TSetNumber
  Left = 385
  Top = 263
  ActiveControl = btn_Exit
  BorderStyle = bsDialog
  Caption = #32534#21046#27969#27700#21495
  ClientHeight = 291
  ClientWidth = 474
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  FormStyle = fsStayOnTop
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 14
  object grp1: TGroupBox
    Left = 12
    Top = 12
    Width = 296
    Height = 211
    Caption = #32534#21495#35268#21017#65306
    TabOrder = 0
    object Label1: TLabel
      Left = 19
      Top = 37
      Width = 48
      Height = 14
      Caption = #21069#23548#31526#65306
    end
    object Label2: TLabel
      Left = 19
      Top = 101
      Width = 48
      Height = 14
      Caption = #36215#22987#21495#65306
    end
    object lbl3: TLabel
      Left = 73
      Top = 159
      Width = 102
      Height = 14
      Caption = #26368#32456#26679#24335#65306'Z00001'
      Transparent = True
    end
    object lbl1: TLabel
      Left = 200
      Top = 102
      Width = 83
      Height = 14
      Caption = #65288#22914#65306'00001'#65289
    end
    object edt1: TEdit
      Left = 73
      Top = 34
      Width = 41
      Height = 22
      TabOrder = 0
      Text = 'Z'
      OnChange = edt1Change
    end
    object edt2: TEdit
      Left = 73
      Top = 98
      Width = 121
      Height = 22
      Hint = #21452#20987#21487#20197#33258#21160#33719#24471#36215#22987#21495
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = '00001'
      OnChange = edt2Change
      OnDblClick = edt2DblClick
    end
  end
  object StatusBarEx1: TStatusBarEx
    Left = 0
    Top = 270
    Width = 474
    Height = 21
    Panels = <
      item
        Alignment = taCenter
        Text = #25552#31034#65306
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object rg1: TRzRadioGroup
    Left = 314
    Top = 14
    Width = 145
    Height = 209
    Caption = #32534#21495#33539#22260#65306
    ItemHeight = 24
    ItemIndex = 0
    Items.Strings = (
      #20165#31354#30333#35760#24405
      #25152#26377#35760#24405)
    StartYPos = 10
    TabOrder = 2
  end
  object pnl1: TPanel
    Left = 0
    Top = 229
    Width = 474
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 3
    object btn_OK: TBitBtn
      Left = 262
      Top = 5
      Width = 75
      Height = 25
      Caption = #24320#22987#32534#21495
      TabOrder = 0
      OnClick = btn_OKClick
    end
    object btn_Exit: TBitBtn
      Left = 383
      Top = 5
      Width = 75
      Height = 25
      Caption = #20851#38381
      TabOrder = 1
      OnClick = btn_ExitClick
    end
  end
  object cds_Temp: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 184
    Top = 72
  end
  object ds_lqmd: TDataSource
    Left = 184
    Top = 32
  end
end
