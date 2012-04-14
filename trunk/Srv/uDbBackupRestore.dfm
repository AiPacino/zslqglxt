object DbBackupRestore: TDbBackupRestore
  Left = 0
  Top = 0
  ActiveControl = btn_Exit
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25968#25454#24211#22791#20221#19982#24674#22797
  ClientHeight = 330
  ClientWidth = 493
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
  object lbl_Hint: TLabel
    Left = 10
    Top = 300
    Width = 300
    Height = 14
    Caption = #8251#35831#30830#20445#25968#25454#24211#26381#21153#22120#20013#30340#22791#20221#25991#20214#22841#20107#20808#24050#21019#24314#23436#25104#65281
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object RzPageControl1: TRzPageControl
    Left = 9
    Top = 8
    Width = 475
    Height = 152
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 0
    FixedDimension = 20
    object TabSheet1: TRzTabSheet
      Caption = #25968#25454#22791#20221
      object btn_Browse: TSpeedButton
        Left = 352
        Top = 55
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = btn_BrowseClick
      end
      object btn_Dir: TSpeedButton
        Left = 352
        Top = 17
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = btn_DirClick
      end
      object lbledt_Backup: TLabeledEdit
        Left = 94
        Top = 56
        Width = 252
        Height = 22
        EditLabel.Width = 60
        EditLabel.Height = 14
        EditLabel.Caption = #22791#20221#25991#20214#65306
        LabelPosition = lpLeft
        TabOrder = 0
        OnChange = lbledt_BackupChange
      end
      object chk_Auto: TCheckBox
        Left = 250
        Top = 95
        Width = 206
        Height = 17
        Caption = #27599#26085#33258#21160#22791#20221'('#27599#26085'03:00'#33258#21160#22791#20221')'
        TabOrder = 2
        OnClick = chk_AutoClick
      end
      object btn_Backup: TBitBtn
        Left = 381
        Top = 54
        Width = 75
        Height = 25
        Caption = #25968#25454#22791#20221
        Enabled = False
        TabOrder = 1
        OnClick = btn_BackupClick
      end
      object lbledt_BakPath: TLabeledEdit
        Left = 94
        Top = 17
        Width = 252
        Height = 22
        EditLabel.Width = 84
        EditLabel.Height = 14
        EditLabel.Caption = #40664#35748#22791#20221#30446#24405#65306
        LabelPosition = lpLeft
        ReadOnly = True
        TabOrder = 3
        OnChange = lbledt_BakPathChange
      end
      object btn_SetBakPath: TBitBtn
        Left = 381
        Top = 16
        Width = 75
        Height = 25
        Caption = #20445#23384#35774#32622
        Enabled = False
        TabOrder = 4
        OnClick = btn_SetBakPathClick
      end
    end
  end
  object RzPageControl2: TRzPageControl
    Left = 9
    Top = 165
    Width = 475
    Height = 121
    ActivePage = TabSheet2
    TabIndex = 0
    TabOrder = 1
    FixedDimension = 20
    object TabSheet2: TRzTabSheet
      Caption = #25968#25454#24674#22797
      object btn_FileName: TSpeedButton
        Left = 352
        Top = 17
        Width = 23
        Height = 22
        Caption = '...'
        OnClick = btn_FileNameClick
      end
      object lbl1: TLabel
        Left = 75
        Top = 58
        Width = 348
        Height = 14
        Caption = #27880#24847#65306#25968#25454#24674#22797#25805#20316#23558#21024#38500#24403#21069#25968#25454#24211#30340#25152#26377#35760#24405#65292#35831#21315#19975#24910#37325#65281
        Color = clYellow
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentColor = False
        ParentFont = False
      end
      object lbledt_Restore: TLabeledEdit
        Left = 94
        Top = 18
        Width = 252
        Height = 22
        EditLabel.Width = 60
        EditLabel.Height = 14
        EditLabel.Caption = #24674#22797#25991#20214#65306
        LabelPosition = lpLeft
        TabOrder = 0
        OnChange = lbledt_RestoreChange
      end
      object btn_Restore: TBitBtn
        Left = 381
        Top = 16
        Width = 75
        Height = 25
        Caption = #25968#25454#24674#22797
        Enabled = False
        TabOrder = 1
        OnClick = btn_RestoreClick
      end
    end
  end
  object btn_Exit: TBitBtn
    Left = 384
    Top = 295
    Width = 81
    Height = 25
    Caption = #36864#20986'[&X]'
    TabOrder = 2
    OnClick = btn_ExitClick
  end
  object dlgOpen1: TOpenDialog
    DefaultExt = '*.dbk'
    Filter = #25152#26377#25991#20214'(*.*)|*.*|'#25968#25454#24211#22791#20221#25991#20214'(*.dbk)|*.dbk'
    FilterIndex = 2
    Title = #35831#36873#25321#35201#24674#22797#30340#24050#22791#20221#25968#25454#25991#20214
    Left = 225
    Top = 206
  end
  object dlgSave1: TSaveDialog
    DefaultExt = '*.dbk'
    Filter = #25152#26377#25991#20214'(*.*)|*.*|'#25968#25454#24211#22791#20221#25991#20214'(*.dbk)|*.dbk'
    FilterIndex = 2
    Title = #35831#36873#25321#25968#25454#22791#20221#30446#24405
    Left = 225
    Top = 40
  end
end
