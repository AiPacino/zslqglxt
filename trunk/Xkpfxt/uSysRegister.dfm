object SysRegister: TSysRegister
  Left = 0
  Top = 0
  ActiveControl = btn_Exit
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #36719#20214#27880#20876
  ClientHeight = 277
  ClientWidth = 443
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object RzPageControl1: TRzPageControl
    Left = 16
    Top = 15
    Width = 411
    Height = 210
    ActivePage = TabSheet1
    TabIndex = 0
    TabOrder = 0
    FixedDimension = 20
    object TabSheet1: TRzTabSheet
      Caption = #36719#20214#27880#20876
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 93
        Top = 135
        Width = 70
        Height = 17
        Caption = #27880#20876#29366#24577#65306
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object lbl_RegMsg: TLabel
        Left = 164
        Top = 135
        Width = 84
        Height = 17
        Caption = #26412#31995#32479#26410#27880#20876
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clMaroon
        Font.Height = -14
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object Label11: TLabel
        Left = 15
        Top = 96
        Width = 72
        Height = 14
        Caption = #36719#20214#27880#20876#30721#65306
        FocusControl = edt_Code
      end
      object Label2: TLabel
        Left = 15
        Top = 22
        Width = 72
        Height = 14
        Caption = #31995#32479#29992#25143#21517#65306
        FocusControl = edt_User
      end
      object Label3: TLabel
        Left = 15
        Top = 59
        Width = 72
        Height = 14
        Caption = #31995#32479#26426#22120#30721#65306
        FocusControl = edt_User
      end
      object edt_Code: TDBEditEh
        Left = 89
        Top = 95
        Width = 300
        Height = 22
        EditButtons = <>
        TabOrder = 2
        Visible = True
      end
      object edt_User: TDBEditEh
        Left = 88
        Top = 21
        Width = 300
        Height = 22
        EditButtons = <>
        TabOrder = 0
        Visible = True
      end
      object edt_SrvCode: TDBEditEh
        Left = 88
        Top = 58
        Width = 300
        Height = 22
        EditButtons = <>
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clGray
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
        ReadOnly = True
        TabOrder = 1
        Visible = True
      end
    end
  end
  object btn_Reg: TBitBtn
    Left = 221
    Top = 241
    Width = 75
    Height = 25
    Caption = #27880#20876'[&R]'
    TabOrder = 1
    OnClick = btn_RegClick
  end
  object btn_Exit: TBitBtn
    Left = 335
    Top = 241
    Width = 75
    Height = 25
    Caption = #36864#20986'[&X]'
    TabOrder = 2
    OnClick = btn_ExitClick
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 192
    object ClientDataSet1WideStringField: TWideStringField
      FieldName = #29992#25143#21517#31216
      Size = 50
    end
    object ClientDataSet1WideStringField2: TWideStringField
      FieldName = #22320#22336
      Size = 50
    end
    object ClientDataSet1WideStringField3: TWideStringField
      FieldName = #32852#31995#20154
      Size = 50
    end
    object ClientDataSet1WideStringField4: TWideStringField
      FieldName = #37038#25919#32534#30721
      Size = 6
    end
    object ClientDataSet1WideStringField5: TWideStringField
      FieldName = #21040#31449
      Size = 50
    end
    object ClientDataSet1WideStringField6: TWideStringField
      FieldName = #21457#34892#21517#31216
      Size = 50
    end
    object ClientDataSet1WideStringField7: TWideStringField
      FieldName = #36135#36816#26041#24335
      Size = 50
    end
    object ClientDataSet1WideStringField8: TWideStringField
      FieldName = #25143#21517
      Size = 50
    end
    object ClientDataSet1WideStringField9: TWideStringField
      FieldName = #24320#25143#34892
      Size = 50
    end
    object ClientDataSet1WideStringField10: TWideStringField
      FieldName = #24080#21495
      Size = 50
    end
    object ClientDataSet1WideStringField11: TWideStringField
      FieldName = #27880#20876#30721
      Size = 50
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 224
  end
end
