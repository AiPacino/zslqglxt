object ConnSet: TConnSet
  Left = 0
  Top = 0
  ActiveControl = btn_Test
  BorderStyle = bsDialog
  Caption = #26381#21153#22120#36830#25509#35774#32622
  ClientHeight = 206
  ClientWidth = 335
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 14
  object GroupBox1: TGroupBox
    Left = 16
    Top = 12
    Width = 301
    Height = 141
    Caption = #24212#29992#26381#21153#22120'URL'#65306
    TabOrder = 0
    object Label1: TLabel
      Left = 20
      Top = 65
      Width = 266
      Height = 56
      Caption = 
        #25552#31034#65306'URL'#24212#22635#20889#26032#29983#25253#21040#31995#32479#26381#21153#22120#25152#22312'WEB'#22320#22336#65292#22914#26524#31471#21475#19981#26159#40664#35748#30340'80'#31471#21475#65292#35831#20889#19978#31471#21475#21517#65292#20854#26684#24335#20026#65306'http://'#26381#21153#22120'IP' +
        ':'#31471#21475'/'#34394#25311#30446#24405'/  '#22914#65306' http://172.18.34.127:81/NewStuLqBd/'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clMaroon
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      WordWrap = True
    end
    object Edit1: TEdit
      Left = 20
      Top = 33
      Width = 253
      Height = 22
      Enabled = False
      TabOrder = 0
      Text = 'http://'
    end
    object chk1: TCheckBox
      Left = 279
      Top = 35
      Width = 13
      Height = 17
      TabOrder = 1
      OnClick = chk1Click
    end
  end
  object btn_Test: TBitBtn
    Left = 112
    Top = 167
    Width = 75
    Height = 25
    Caption = #27979#35797'[&T]'
    TabOrder = 1
    OnClick = btn_TestClick
  end
  object btn_Close: TBitBtn
    Left = 227
    Top = 167
    Width = 75
    Height = 25
    Caption = #20851#38381'[&C]'
    TabOrder = 2
    OnClick = btn_CloseClick
  end
end
