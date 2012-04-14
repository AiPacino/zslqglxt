object NewStuLqBdSoapDM: TNewStuLqBdSoapDM
  OldCreateOrder = False
  OnCreate = SoapDataModuleCreate
  OnDestroy = SoapDataModuleDestroy
  Height = 467
  Width = 519
  object qry_Update: TADOQuery
    CacheSize = 1000
    Connection = con_Access
    CursorType = ctStatic
    Parameters = <>
    Left = 215
    Top = 23
  end
  object qry_Access: TADOQuery
    CacheSize = 1000
    Connection = con_Access
    CursorType = ctStatic
    Parameters = <>
    Left = 127
    Top = 23
    object qry_AccessDSDesigner: TWideStringField
      FieldName = #24207#21495
      Size = 6
    end
    object qry_AccessDSDesigner2: TWideStringField
      FieldName = #30465#20221
      Size = 10
    end
    object qry_AccessDSDesigner3: TWideStringField
      FieldName = #25209#27425
      Size = 50
    end
    object qry_AccessWideStringField4: TWideStringField
      FieldName = #25209#27425#35268#33539#21517
      Size = 5
    end
    object qry_AccessDSDesigner4: TWideStringField
      FieldName = #31185#31867
      Size = 50
    end
    object qry_AccessWideStringField5: TWideStringField
      FieldName = #31185#31867#35268#33539#21517
      Size = 5
    end
    object qry_AccessDSDesigner5: TWideStringField
      FieldName = #32771#29983#21495
      Size = 14
    end
    object qry_AccessDSDesigner26: TWideStringField
      FieldName = #20934#32771#35777#21495
      Size = 14
    end
    object qry_AccessDSDesigner6: TWideStringField
      FieldName = #36523#20221#35777#21495
      Size = 18
    end
    object qry_AccessDSDesigner7: TWideStringField
      FieldName = #32771#29983#22995#21517
      Size = 64
    end
    object qry_AccessDSDesigner8: TWideStringField
      FieldName = #24615#21035
      Size = 2
    end
    object qry_AccessDSDesigner9: TWideStringField
      FieldName = #24405#21462#19987#19994
      Size = 64
    end
    object qry_AccessDSDesigner10: TWideStringField
      FieldName = #38498#31995
      Size = 50
    end
    object qry_AccessDSDesigner11: TWideStringField
      FieldName = #24405#21462#19987#19994#35268#33539#21517
      Size = 64
    end
    object qry_AccessDSDesigner12: TWideStringField
      FieldName = #24072#33539#31867
      Size = 1
    end
    object qry_AccessDSDesigner13: TWideStringField
      FieldName = #23398#21046
      Size = 2
    end
    object qry_AccessDSDesigner14: TFloatField
      FieldName = #25237#26723#25104#32489
    end
    object qry_AccessDSDesigner15: TWideStringField
      FieldName = #25237#26723#24535#24895
      Size = 2
    end
    object qry_AccessDSDesigner16: TWideStringField
      FieldName = #23478#24237#22320#22336
      Size = 128
    end
    object qry_AccessDSDesigner17: TWideStringField
      FieldName = #37038#25919#32534#30721
      Size = 6
    end
    object qry_AccessDSDesigner18: TWideStringField
      FieldName = #25910#20214#20154
      Size = 12
    end
    object qry_AccessDSDesigner19: TWideStringField
      FieldName = #32852#31995#30005#35805
    end
    object qry_AccessDSDesigner20: TWideStringField
      FieldName = #27605#19994#20013#23398
      Size = 30
    end
    object qry_AccessDSDesigner21: TWideStringField
      FieldName = #22791#27880
      Size = 254
    end
    object qry_AccessDSDesigner22: TWideStringField
      FieldName = #26159#21542#25171#21360
      Size = 2
    end
    object qry_AccessDSDesigner23: TWideStringField
      FieldName = #20837#23398#26657#21306
      Size = 250
    end
    object qry_AccessAction_Time: TWideStringField
      FieldName = 'Action_Time'
    end
    object qry_AccessDSDesigner24: TWideStringField
      FieldName = #27665#26063
    end
    object qry_AccessDSDesigner25: TWideStringField
      FieldName = #29031#29255#25991#20214
      Size = 150
    end
    object qry_AccessWideStringField: TWideStringField
      FieldName = #19968#24535#24895#20195#30721
      Size = 5
    end
    object qry_AccessWideStringField2: TWideStringField
      FieldName = #24405#21462#20195#30721
      Size = 5
    end
    object qry_AccessBooleanField: TBooleanField
      FieldName = #26159#21542#19968#24535#24895#19987#19994
    end
    object qry_AccessWideStringField3: TWideStringField
      FieldName = #24405#21462#32467#26463#26085#26399
      Size = 10
    end
  end
  object con_Access: TADOConnection
    ConnectionString = 
      'Provider=SQLOLEDB.1;Password=xlinuxx@3721;Persist Security Info=' +
      'True;User ID=sa;Initial Catalog='#25307#29983#31649#29702';Data Source=172.18.8.66'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'SQLOLEDB.1'
    Left = 32
    Top = 23
  end
  object con_DBF: TADOConnection
    ConnectionString = 
      'Provider=Microsoft.Jet.OLEDB.4.0;Data Source=I:\2006.7.26\'#28246#21271'\'#25991';E' +
      'xtended Properties=dbase 5.0;Persist Security Info=False'
    LoginPrompt = False
    Mode = cmShareDenyNone
    Provider = 'Microsoft.Jet.OLEDB.4.0'
    Left = 368
    Top = 23
  end
  object qry_DBF: TADOQuery
    Connection = con_DBF
    CursorType = ctStatic
    Parameters = <>
    Left = 439
    Top = 23
  end
  object con_Srv: TLocalConnection
    Left = 32
    Top = 96
  end
  object qry_Temp: TADOQuery
    Connection = con_Access
    Parameters = <>
    Left = 290
    Top = 21
  end
  object DataSet_Query: TADODataSet
    Connection = con_Access
    CursorType = ctStatic
    Parameters = <>
    Left = 32
    Top = 234
  end
  object DSP_Query: TDataSetProvider
    DataSet = DataSet_Query
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 125
    Top = 235
  end
  object cds_Query: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'DSP_Query'
    Left = 224
    Top = 235
  end
  object cds_Update: TClientDataSet
    Aggregates = <>
    PacketRecords = 0
    Params = <>
    ProviderName = 'DSP_Update'
    Left = 224
    Top = 291
  end
  object DSP_Update: TDataSetProvider
    DataSet = DataSet_Update
    Options = [poAllowMultiRecordUpdates, poAllowCommandText, poUseQuoteChar]
    UpdateMode = upWhereKeyOnly
    OnUpdateError = DSP_UpdateUpdateError
    Left = 125
    Top = 291
  end
  object DataSet_Update: TADODataSet
    Connection = con_Access
    OnPostError = DataSet_UpdatePostError
    Parameters = <>
    Left = 32
    Top = 291
  end
  object DataSet_Temp: TADODataSet
    Connection = con_Access
    CursorType = ctStatic
    Parameters = <>
    Left = 32
    Top = 167
  end
  object frxDesigner1: TfrxDesigner
    DefaultScriptLanguage = 'PascalScript'
    DefaultFont.Charset = DEFAULT_CHARSET
    DefaultFont.Color = clWindowText
    DefaultFont.Height = -13
    DefaultFont.Name = 'Arial'
    DefaultFont.Style = []
    DefaultLeftMargin = 10.000000000000000000
    DefaultRightMargin = 10.000000000000000000
    DefaultTopMargin = 10.000000000000000000
    DefaultBottomMargin = 10.000000000000000000
    DefaultPaperSize = 9
    DefaultOrientation = poPortrait
    GradientEnd = 11982554
    GradientStart = clWindow
    TemplatesExt = 'fr3'
    Restrictions = []
    RTLLanguage = False
    MemoParentFont = False
    Left = 224
    Top = 363
  end
  object frxDBDataset1: TfrxDBDataset
    UserName = 'lqtzs_db'
    CloseDataSource = False
    BCDToCurrency = False
    Left = 128
    Top = 363
  end
  object frxReport1: TfrxReport
    Version = '4.7.91'
    DotMatrixReport = False
    IniFile = '\Software\Fast Reports'
    PreviewOptions.Buttons = [pbPrint, pbLoad, pbSave, pbExport, pbZoom, pbFind, pbOutline, pbPageSetup, pbTools, pbEdit, pbNavigator]
    PreviewOptions.Zoom = 1.000000000000000000
    PrintOptions.Printer = #39044#35774
    PrintOptions.PrintOnSheet = 0
    ReportOptions.CreateDate = 38927.333079421310000000
    ReportOptions.LastChange = 40027.441908807900000000
    ScriptLanguage = 'PascalScript'
    ScriptText.Strings = (
      ''
      'procedure Picture1OnAfterData(Sender: TfrxComponent);'
      'var'
      '  fn:string;'
      'begin'
      '  Picture1.Picture := nil;'
      '  fn := <lqtzs_db."'#29031#29255#25991#20214'">;'
      '  if fn <> '#39#39' then'
      '     Picture1.Picture.LoadFromFile(fn)'
      '  else'
      '     Picture1.Picture := nil;'
      'end;'
      ''
      'begin'
      ''
      'end.')
    Left = 24
    Top = 363
    Datasets = <
      item
        DataSet = frxDBDataset1
        DataSetName = 'lqtzs_db'
      end>
    Variables = <
      item
        Name = ' User'
        Value = Null
      end
      item
        Name = 'XH'
        Value = Null
      end>
    Style = <>
    object Page1: TfrxReportPage
      PaperWidth = 187.000000000000000000
      PaperHeight = 285.000000000000000000
      PaperSize = 256
      LeftMargin = 5.000000000000000000
      RightMargin = 3.000000000000000000
      TopMargin = 3.000000000000000000
      BottomMargin = 1.000000000000000000
      object MasterData1: TfrxMasterData
        Height = 1043.150280000000000000
        Top = 18.897650000000000000
        Width = 676.535870000000000000
        DataSet = frxDBDataset1
        DataSetName = 'lqtzs_db'
        RowCount = 0
        object Memo6: TfrxMemoView
          Left = 374.173470000000000000
          Top = 767.244590000001000000
          Width = 132.283550000000000000
          Height = 98.267780000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -12
          Font.Name = #23435#20307
          Font.Style = []
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          HAlign = haCenter
          Memo.UTF8 = (
            '')
          ParentFont = False
          Rotation = 270
          VAlign = vaCenter
        end
        object Memo1: TfrxMemoView
          Left = 196.535560000000000000
          Top = 49.133889999999990000
          Width = 132.283550000000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = #32771#29983#22995#21517
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          Memo.UTF8 = (
            '[lqtzs_db."'#38000#20906#25939#28654#25779#24725'"]')
          ParentFont = False
        end
        object Memo2: TfrxMemoView
          Left = 351.496290000000000000
          Top = 49.133889999999990000
          Width = 68.031540000000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = #24615#21035
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          Memo.UTF8 = (
            '[lqtzs_db."'#37804#1091#22470'"]')
          ParentFont = False
        end
        object Memo3: TfrxMemoView
          Left = 457.323130000000000000
          Top = 49.133889999999990000
          Width = 151.181200000000000000
          Height = 22.677180000000000000
          ShowHint = False
          DataField = #32771#29983#21495
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
        end
        object Memo4: TfrxMemoView
          Left = 200.315090000000000000
          Top = 86.929190000000000000
          Width = 396.850650000000000000
          Height = 22.677180000000000000
          ShowHint = False
          AutoWidth = True
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
        end
        object Memo5: TfrxMemoView
          Left = 457.323130000000000000
          Top = 196.535560000000000000
          Width = 154.960730000000000000
          Height = 18.897650000000000000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #40657#20307
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
        end
        object Memo9: TfrxMemoView
          Left = 464.882190000000000000
          Top = 302.362400000000000000
          Width = 30.236240000000000000
          Height = 249.448980000000000000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = #40657#20307
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
          Rotation = 270
        end
        object Memo10: TfrxMemoView
          Left = 396.850650000000000000
          Top = 302.362400000000000000
          Width = 34.015770000000000000
          Height = 434.645950000000000000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -24
          Font.Name = #40657#20307
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
          Rotation = 270
        end
        object Memo11: TfrxMemoView
          Left = 272.126160000000000000
          Top = 725.669760000000000000
          Width = 49.133890000000000000
          Height = 317.480520000000000000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = #40657#20307
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '')
          ParentFont = False
          Rotation = 270
          VAlign = vaCenter
        end
        object Memo12: TfrxMemoView
          Left = 154.960730000000000000
          Top = 449.764070000000000000
          Width = 56.692950000000000000
          Height = 555.590910000000000000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = #40657#20307
          Font.Style = []
          Memo.UTF8 = (
            '[lqtzs_db."'#37711#12517#57631#37837#8243#23599'"]')
          ParentFont = False
          Rotation = 270
        end
        object Memo13: TfrxMemoView
          Left = 272.126160000000000000
          Top = 313.700990000000000000
          Width = 49.133890000000000000
          Height = 294.803340000000000000
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = #40657#20307
          Font.Style = [fsBold]
          HAlign = haCenter
          Memo.UTF8 = (
            '[lqtzs_db."'#38340#12834#37108'"]')
          ParentFont = False
          Rotation = 270
          VAlign = vaCenter
        end
        object Memo14: TfrxMemoView
          Left = 268.346630000000000000
          Top = 162.519790000000000000
          Width = 340.157700000000000000
          Height = 18.897650000000000000
          ShowHint = False
          AutoWidth = True
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
        end
        object MemoXH: TfrxMemoView
          Left = 506.457020000000000000
          Top = 3.779530000000001000
          Width = 166.299320000000000000
          Height = 18.897650000000000000
          OnAfterPrint = 'MemoXHOnAfterPrint'
          ShowHint = False
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #26999#20307'_GB2312'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            'No'#38171#27476'lqtzs_db."'#25652#24531#24447'"]')
          ParentFont = False
        end
        object Memo16: TfrxMemoView
          Left = 608.504330000000000000
          Top = 839.055660000000000000
          Width = 30.236240000000000000
          Height = 173.858380000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = []
          HAlign = haRight
          Memo.UTF8 = (
            'No'#38171#27476'lqtzs_db."'#25652#24531#24447'"]')
          ParentFont = False
          Rotation = 270
        end
        object Memo17: TfrxMemoView
          Left = 41.574830000000000000
          Top = 759.685530000000000000
          Width = 22.677180000000000000
          Height = 166.299320000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -19
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
          Rotation = 270
          VAlign = vaCenter
        end
        object Memo18: TfrxMemoView
          Left = 268.346630000000000000
          Top = 120.944960000000000000
          Width = 249.448980000000000000
          Height = 22.677180000000000000
          ShowHint = False
          AutoWidth = True
          DataSet = frxDBDataset1
          DataSetName = 'lqtzs_db'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = #23435#20307
          Font.Style = []
          Memo.UTF8 = (
            '[lqtzs_db."'#23011#26330#31519#28051#57694#57631'"]')
          ParentFont = False
        end
        object Memo7: TfrxMemoView
          Left = 234.330860000000000000
          Top = 491.338900000000000000
          Width = 26.456710000000000000
          Height = 215.433210000000000000
          ShowHint = False
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -21
          Font.Name = 'Arial'
          Font.Style = []
          Memo.UTF8 = (
            '')
          ParentFont = False
          Rotation = 270
          VAlign = vaCenter
        end
        object Picture1: TfrxPictureView
          Description = #26080#29031#29255
          Left = 374.173470000000000000
          Top = 767.244590000001000000
          Width = 132.283550000000000000
          Height = 98.267780000000000000
          OnAfterData = 'Picture1OnAfterData'
          OnAfterPrint = 'Picture1OnAfterPrint'
          ShowHint = False
          Center = True
          Frame.Typ = [ftLeft, ftRight, ftTop, ftBottom]
          TagStr = #26080#29031#29255
          HightQuality = False
        end
      end
    end
  end
  object dlgSave_1: TSaveDialog
    DefaultExt = '.xls'
    Filter = 'Excel '#25991#20214'(*.xls)|*.xls|'#25152#26377#25991#20214'(*.*)|*.*'
    Title = #23548#20986#21040'Excel'#25991#20214
    Left = 312
    Top = 363
  end
  object VCLZip1: TVCLZip
    MultiZipInfo.BlockSize = 1457600
    Left = 368
    Top = 88
  end
  object VCLUnZip1: TVCLUnZip
    Left = 440
    Top = 88
  end
  object cds_Temp: TClientDataSet
    Aggregates = <>
    PacketRecords = 0
    Params = <>
    ProviderName = 'DSP_Temp'
    Left = 224
    Top = 168
  end
  object DSP_Temp: TDataSetProvider
    DataSet = DataSet_Temp
    Options = [poAllowCommandText, poUseQuoteChar]
    Left = 126
    Top = 169
  end
  object sp_GetJhNo: TADOStoredProc
    Connection = con_Access
    ProcedureName = 'up_GetJhNo;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@res_No'
        Attributes = [paNullable]
        DataType = ftWideString
        Direction = pdInputOutput
        Size = 19
        Value = Null
      end>
    Prepared = True
    Left = 119
    Top = 96
  end
  object sp_UpdateLqInfo: TADOStoredProc
    Connection = con_Access
    ProcedureName = 'up_UpdateLqInfo;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@Xlcc'
        Attributes = [paNullable]
        DataType = ftString
        Size = 15
        Value = Null
      end>
    Prepared = True
    Left = 223
    Top = 96
  end
  object sp_GetLqztsNo: TADOStoredProc
    Connection = con_Access
    ProcedureName = 'up_GetLqtzsNo;1'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = Null
      end
      item
        Name = '@ksh'
        Attributes = [paNullable]
        DataType = ftWideString
        Size = 19
        Value = Null
      end
      item
        Name = '@res_No'
        Attributes = [paNullable]
        DataType = ftWideString
        Direction = pdInputOutput
        Size = 19
        Value = Null
      end>
    Prepared = True
    Left = 319
    Top = 168
  end
end
