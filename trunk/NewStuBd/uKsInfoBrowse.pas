unit uKsInfoBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ActnList, DB,StrUtils, DBGridEhImpExp,
  Menus, ImgList, frxClass, frxDBSet, frxDesgn, StdCtrls, Spin, DBCtrls,
  MyDBNavigator, StatusBarEx, GridsEh, DBGridEh, uStuInfo,uFormatKL,uFormatZy,
  DBFieldComboBox, StdActns, pngimage, DBClient, DBGridEhGrouping, frxpngimage,
  Mask, DBCtrlsEh;

type
  TKsInfoBrowse = class(TForm)
    pnl2: TPanel;
    lbl_Filter: TLabel;
    cbb_Value: TEdit;
    il1: TImageList;
    pm1: TPopupMenu;
    MenuItem1: TMenuItem;
    pmi_PrnLqtzs: TMenuItem;
    pmi_PrnEMS: TMenuItem;
    pmi_PrnLqmd: TMenuItem;
    MenuItem3: TMenuItem;
    pmi_Excel: TMenuItem;
    ds_Access: TDataSource;
    dlgSave_1: TSaveDialog;
    btn_OK: TBitBtn;
    btn_Adv: TBitBtn;
    N4: TMenuItem;
    pmi_Refresh: TMenuItem;
    mmi_BH: TMenuItem;
    cbb_Field: TDBFieldComboBox;
    C1: TMenuItem;
    X1: TMenuItem;
    P1: TMenuItem;
    pnl_Title: TPanel;
    img_Title: TImage;
    lbl_Title: TLabel;
    lbl1: TLabel;
    mmi_AllowEdit: TMenuItem;
    mmi_FormatZymc: TMenuItem;
    DBGridEH1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    grp_Yx: TGroupBox;
    cbb_XlCc: TDBComboBoxEh;
    GroupBox1: TGroupBox;
    cbb_KL: TDBComboBoxEh;
    grp_Sf: TGroupBox;
    cbb_Sf: TDBComboBoxEh;
    grp_Lb: TGroupBox;
    cbb_Lb: TDBComboBoxEh;
    N1: TMenuItem;
    mni_Sf: TMenuItem;
    btn_Refresh: TBitBtn;
    btn_SqlWhere: TBitBtn;
    chk_Filter: TCheckBox;
    cbb_Compare: TDBComboBoxEh;
    btn_Save: TBitBtn;
    img_Hint: TImage;
    lbl_Len: TLabel;
    chk_ZyNoSame: TCheckBox;
    procedure RzGroup2Items0Click(Sender: TObject);
    procedure RzGroup4Items1Click(Sender: TObject);
    procedure RzGroup3Items0Click(Sender: TObject);
    procedure mmi_ExitClick(Sender: TObject);
    procedure mmi_PrnLQTZSClick(Sender: TObject);
    procedure mmi_PrnLQKSMDClick(Sender: TObject);
    procedure mmi_ExcelClick(Sender: TObject);
    procedure mmi_FormatZymcClick(Sender: TObject);
    procedure mmi_ExecSQLClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ds_AccessDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmi_PrnEMSClick(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure UpDownNumEdit1Change(Sender: TObject);
    procedure rg2Click(Sender: TObject);
    procedure mmi_DesEMSClick(Sender: TObject);
    procedure mmi_DesLQTZSClick(Sender: TObject);
    procedure mmi_DesLQKSMDClick(Sender: TObject);
    procedure mmi_AllowEditClick(Sender: TObject);
    procedure pmi_RefreshClick(Sender: TObject);
    procedure mmi_BHClick(Sender: TObject);
    procedure DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mmi_ProcessSJRClick(Sender: TObject);
    procedure DBGridEH1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N9Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chk_NotJxClick(Sender: TObject);
    procedure cbb_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure chk_ZyNotSameClick(Sender: TObject);
    procedure dxDBMemo1DblClick(Sender: TObject);
    procedure mi_FormatKLClick(Sender: TObject);
    procedure DBGridEH1DblClick(Sender: TObject);
    procedure mni_FormatKLClick(Sender: TObject);
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
    procedure cbb_XlCcChange(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure edt1Change(Sender: TObject);
    procedure mni_SfClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure chk_FilterClick(Sender: TObject);
    procedure DBGridEH1TitleClick(Column: TColumnEh);
    procedure btn_SqlWhereClick(Sender: TObject);
    procedure cbb_CompareChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure cbb_ValueChange(Sender: TObject);
    procedure chk_ZyNoSameClick(Sender: TObject);
  private
    { Private declarations }
    //FormatKL:TFormatKL;
    //FormatZy:TFormatZyMc;
    StuInfo:TStuInfo;
    vsorted :Boolean;
    repfn:string;
    sWhereList:Tstrings;
    procedure Open_Access_Table(const sWhere:string='');
    procedure Print_EMS(const designed:Boolean = False);
    procedure Print_LQTZS(const designed:Boolean = False);
    procedure Print_LQKSMD(const designed:Boolean = False);
    function  GetOrderString:string;
    function  GetFilterString:String;
    function  GetXznxString:String;
    procedure GetWhereList;
    function  GetMaxNo(const Sf,Lb:string):string;
  public
    { Public declarations }
  end;

var
  KsInfoBrowse: TKsInfoBrowse;

implementation

uses uDM, uMareData_BDE,uMain,uSQLWhere;//, uFormatZymc,
  //uSqlExecute,uBh,uPhotoProcess,uSQLWhere,uFormatKL;

{$R *.dfm}

procedure TKsInfoBrowse.RzGroup2Items0Click(Sender: TObject);
var
  path,fn :string;
begin
{
  path := ExtractFileDir(Application.ExeName);
  fn := path+'\lqmd.mdb';
  if not FileExists(fn) then
  begin
    MessageBox(Handle, PChar('���ݿ��ļ���'+fn+' �����ڣ�����'), '���ݿⲻ����', MB_OK +
      MB_ICONWARNING);
    exit;
  end;

  Connect_Access(path);

  ClientDataSet1.Close;
  ClientDataSet1.Open;
  //frm_Ksxt.show;
}
end;

procedure TKsInfoBrowse.RzGroup4Items1Click(Sender: TObject);
begin
  Close;
end;

procedure TKsInfoBrowse.RzGroup3Items0Click(Sender: TObject);
begin
  //frm_PrintLqtzs.ShowModal;
end;

procedure TKsInfoBrowse.mmi_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsInfoBrowse.mmi_PrnLQTZSClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select * from ¼ȡ��Ϣ�� '+sWhereList.Text+' order by ��ˮ��');
    //Print_LQTZS(True);
    dm.PrintReport('����¼ȡ֪ͨ��.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TKsInfoBrowse.mmi_PrnLQKSMDClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select * from ¼ȡ��Ϣ�� '+sWhereList.Text+' order by ѧ�����,ʡ��,���,����,¼ȡרҵ�淶��');
    //Print_LQKSMD();
    dm.PrintReport('רҵ����¼ȡ����.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TKsInfoBrowse.mmi_ExcelClick(Sender: TObject);
var
  fn,Ext,mfn:string;
begin
  dlgSave_1.FileName := '��������.xls';
  if dlgSave_1.Execute then
  begin
    if FileExists(dlgSave_1.FileName) then
      if MessageBox(Handle, PChar('Excel�ļ���'+dlgSave_1.FileName+'�Ѵ��ڣ�Ҫ�������𣿡���'), '�ļ��Ѵ���', MB_YESNO + MB_ICONWARNING +
        MB_DEFBUTTON2) = IDNO then
        Exit
      else
        DeleteFile(dlgSave_1.FileName);

    try
      Screen.Cursor := crHourGlass;
      fn := dlgSave_1.FileName;
      Ext := ExtractFileExt(fn);
      mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,DBGridEH1, fn,True);
      DBGridEH1.SetFocus;
    finally
      Screen.Cursor := crDefault;
      MessageBox(Handle, 'Excel�ļ�������ɣ�����', '�����ɹ�', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TKsInfoBrowse.mmi_FormatZymcClick(Sender: TObject);
var
  xlcc,sf,pc,kl,zydm,zy:string;
//  bm:TBookmark;
begin
  xlcc := ClientDataSet1.FieldByName('ѧ�����').Asstring;
  sf := ClientDataSet1.FieldByName('ʡ��').Asstring;
  pc := ClientDataSet1.FieldByName('��������').Asstring;
  kl := ClientDataSet1.FieldByName('���').Asstring;//ClientDataSet1.FieldByName('��������').Asstring;
  zydm := ClientDataSet1.FieldByName('¼ȡ����').Asstring;
  zy := ClientDataSet1.FieldByName('¼ȡרҵ').Asstring;

  with TFormatZy.Create(Application) do
  begin
    FillData(xlcc,sf,pc,kl,zydm,zy,ClientDataSet1,'¼ȡ������Ϣ��');
    if ShowModal=mrOk then
    try
      DBGridEH1.SaveBookmark;
//      bm := ClientDataSet1.GetBookmark;
      Open_Access_Table;
    finally
      DBGridEH1.RestoreBookmark;
//      ClientDataSet1.GotoBookmark(bm);
    end;
  end;
end;

procedure TKsInfoBrowse.mmi_ExecSQLClick(Sender: TObject);
begin
  //Tfrm_SqlExecute.Create(Application).Show;
end;

procedure TKsInfoBrowse.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Access_Table;
  if Self.Showing then
    DBGridEH1.SetFocus;
end;

procedure TKsInfoBrowse.chk_FilterClick(Sender: TObject);
begin
  DBGridEH1.STFilter.Visible := chk_Filter.Checked;
end;

procedure TKsInfoBrowse.btn_OKClick(Sender: TObject);
begin
  Open_Access_Table;
  if cbb_Value.CanFocus then
    cbb_Value.SetFocus;
end;

procedure TKsInfoBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Access_Table();
end;

procedure TKsInfoBrowse.btn_SaveClick(Sender: TObject);
begin
  if MessageBox(Handle, 'ȷ��Ҫ���ֹ��޸ĵ�����ʱ�б����𣿡�', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  dm.UpdateData('������','select top 0 * from ¼ȡ��Ϣ��',ClientDataSet1.Delta,True);
end;

procedure TKsInfoBrowse.btn_SqlWhereClick(Sender: TObject);
begin
  if GetSqlWhere(ClientDataSet1,sWhereList) then
    Open_Access_Table(sWhereList.Text);
end;

procedure TKsInfoBrowse.FormCreate(Sender: TObject);
var
  path,fn :string;
  sList:TStrings;
  ii:Integer;
begin
  Self.Left := Trunc((Main.Width - Self.Width)/2);
  //Self.Top := Trunc((Main.Height - Self.Height)/2);
  Self.Top := 15;
  sList := TStringList.Create;
  dm.SetXlCcComboBox(cbb_XlCc);

  dm.SetCzySfComboBox(cbb_XlCc.Items[cbb_XlCc.ItemIndex],cbb_Sf,True);
{
  dm.SetSfComboBox(cbb_Sf,True);
  ii := cbb_Sf.Items.IndexOf('����');
  if (ii>=0) and (not dm.IsDisplayJiangXi) then
    cbb_Sf.Items.Delete(ii);
}

  dm.SetLbComboBox(cbb_Lb,True);

  dm.SetKlComboBox(cbb_KL,True);

  try
    StuInfo := TStuInfo.Create(Self);
    StuInfo.DataSource1.DataSet := ClientDataSet1;
    sWhereList := TStringList.Create;
    Open_Access_Table;
  finally
    sList.Free;
  end;
end;

procedure TKsInfoBrowse.FormDestroy(Sender: TObject);
begin
  FreeAndNil(StuInfo);
  FreeAndNil(sWhereList);
end;

procedure TKsInfoBrowse.Open_Access_Table(const sWhere:string='');
var
  vxzstr,vfilterstr,vordstr:string;
  sqlStr:string;
begin
  Repfn := ExtractFilePath(Application.ExeName)+'Rep\'+cbb_xlcc.Text+'¼ȡ֪ͨ��.fr3';

  if sWhere='' then
    GetWhereList
  else
    sWhereList.Text := sWhere;

  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    sqlStr := 'select * from ¼ȡ��Ϣ�� '+sWhereList.Text+' order by ��ˮ��';
    ClientDataSet1.XMLData := dm.OpenData(sqlStr);
  finally
    ClientDataSet1.EnableControls;
    ClientDataSet1.Filtered := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TKsInfoBrowse.ds_AccessDataChange(Sender: TObject; Field: TField);
begin
  lbl1.Caption := '��¼��'+IntToStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount);
end;

procedure TKsInfoBrowse.chk_NotJxClick(Sender: TObject);
begin
  btn_OK.Click;
end;

procedure TKsInfoBrowse.chk_ZyNoSameClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := chk_ZyNoSame.Checked;
end;

procedure TKsInfoBrowse.chk_ZyNotSameClick(Sender: TObject);
begin
  //ClientDataSet1.Filtered := chk_ZyNotSame.Checked;
end;

procedure TKsInfoBrowse.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  RealseSortedIcon(DBGridEH1);
end;

procedure TKsInfoBrowse.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if not DataSet.Active then Exit;
  if not chk_ZyNoSame.Checked then Exit;

  if (chk_ZyNoSame.Checked)  then
  begin
    Accept := not ZyIsEqual(ClientDataSet1.FieldByName('¼ȡרҵ').AsString,ClientDataSet1.FieldByName('¼ȡרҵ�淶��').AsString);
  end else
    Accept := True;
end;

procedure TKsInfoBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TKsInfoBrowse.mmi_PrnEMSClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select * from ¼ȡ��Ϣ�� '+sWhereList.Text+' order by ��ˮ��');
    //Print_LQTZS(True);
    dm.PrintReport('EMS.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TKsInfoBrowse.rg1Click(Sender: TObject);
begin
{
  if rg1.ItemIndex=0 then
  begin
    frxDBDataSet1.RangeBegin := rbFirst;
    frxDBDataset1.RangeEnd := reLast;
  end else if rg1.ItemIndex=1 then
  begin
    frxDBDataSet1.RangeBegin := rbCurrent;
    frxDBDataset1.RangeEnd := reCurrent;
  end else if rg1.ItemIndex=2 then
  begin
    frxDBDataSet1.RangeBegin := rbCurrent;
    frxDBDataset1.RangeEnd := reLast;
  end else
  begin
    frxDBDataSet1.RangeBegin := rbCurrent;
    frxDBDataset1.RangeEnd := reCount;
    frxDBDataset1.RangeEndCount := UpDownNumEdit1.Value;
  end;
}
end;

procedure TKsInfoBrowse.UpDownNumEdit1Change(Sender: TObject);
begin
  //frxDBDataset1.RangeEndCount := UpDownNumEdit1.Value;
end;

procedure TKsInfoBrowse.rg2Click(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsInfoBrowse.Print_EMS(const designed: Boolean);
begin
end;

procedure TKsInfoBrowse.Print_LQKSMD(const designed: Boolean);
begin
end;

procedure TKsInfoBrowse.Print_LQTZS(const designed: Boolean);
begin
end;

procedure TKsInfoBrowse.mmi_DesEMSClick(Sender: TObject);
begin
  Print_EMS(True);
end;

procedure TKsInfoBrowse.mmi_DesLQTZSClick(Sender: TObject);
begin
  Print_LQTZS(True);
end;

procedure TKsInfoBrowse.mmi_DesLQKSMDClick(Sender: TObject);
begin
  Print_LQKSMD(True);
end;

procedure TKsInfoBrowse.mi_FormatKLClick(Sender: TObject);
var
  sf,pc,kl,sqlstr:string;
begin
{
  sf := Trim(ClientDataSet1.FieldByName('ʡ��').AsString);
  pc := Trim(ClientDataSet1.FieldByName('����').AsString);
  kl := Trim(ClientDataSet1.FieldByName('����').AsString);
  with Tfrm_FormatKL.Create(nil) do
  begin
    lbledt_sf.Text := sf;
    lbledt_pc.Text := pc;
    lbledt_KL.Text := kl;
    ShowModal;
    //Open_Access_Table;
  end;
}
end;

procedure TKsInfoBrowse.mmi_AllowEditClick(Sender: TObject);
begin
  DBGridEH1.ReadOnly := not mmi_AllowEdit.Checked;
  btn_Save.Visible := mmi_AllowEdit.Checked;
end;

procedure TKsInfoBrowse.pmi_RefreshClick(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsInfoBrowse.mmi_BHClick(Sender: TObject);
var
  sKsh,sMsg,sqlstr:string;
  cds_Temp:TClientDataSet;
begin
  if MessageBox(Handle,
    '���ҪΪ����δ��ŵĿ�������¼ȡ֪ͨ�����𣿡�', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  DBGridEH1.SaveBookmark;
  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    sMsg := '';
    if not vobj.UpdateLqtzsNo('',sMsg) then
        MessageBox(Handle, PChar('¼ȡ֪ͨ��������ʧ�ܣ���'+#13+sMsg), 'ϵͳ��ʾ', MB_OK
          + MB_ICONSTOP + MB_TOPMOST);
{
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      sKsh := ClientDataSet1.FieldByName('������').AsString;
      sMsg := '';
      if not vobj.UpdateLqtzsNo(sKsh,sMsg) then
      begin
        MessageBox(Handle, PChar('������'+sKsh+'��¼ȡ֪ͨ��������ʧ�ܣ���'+#13+sMsg), 'ϵͳ��ʾ', MB_OK
          + MB_ICONSTOP + MB_TOPMOST);
        Exit;
      end;
      ClientDataSet1.Next;
    end;
}
    Open_Access_Table();
    MessageBox(Handle, '¼ȡ֪ͨ�������Ƴɹ�����', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  finally
    ClientDataSet1.EnableControls;
    DBGridEH1.RestoreBookmark;
    Screen.Cursor := crDefault;
  end;

end;

procedure TKsInfoBrowse.dxDBMemo1DblClick(Sender: TObject);
begin
{
  if (ClientDataSet1.FieldByName('¼ȡרҵ').AsString<>ClientDataSet1.FieldByName('¼ȡרҵ�淶��').AsString)
     and mmi_AllowEdit.Checked then
  begin
    ClientDataSet1.Edit;
    dxDBMemo1.Text := FormatDateTime('yyyy-mm-dd',Date)+' '+ClientDataSet1.FieldByName('¼ȡרҵ').AsString+'->'+
                      ClientDataSet1.FieldByName('¼ȡרҵ�淶��').AsString+' ί���ˣ�';
    ClientDataSet1.Post;
  end;
}
end;

procedure TKsInfoBrowse.DBGridEH1DblClick(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('������').IsNull then
  begin
    StuInfo.Show;
    StuInfo.DataSource1DataChange(Self,nil);
  end;
end;

procedure TKsInfoBrowse.DBGridEH1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  zy1,zy2:string;
  iLen:Integer;
begin
  if (Column.FieldName='��ע') then
  begin
    if Column.Field.AsString<>'' then
    begin
      Column.Font.Color := clWhite;
      TDBGridEh(Sender).Canvas.Brush.Color := clRed;
    end;
  end;

  if (Column.FieldName='¼ȡרҵ�淶��') then
  begin
    //Column.Font.Style := Font.Style-[fsStrikeOut];
    if Pos('�˵�',Column.Field.AsString)>0 then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clRed;
      //Column.Font.Color := clRed;
      //Column.Font.Style := Font.Style+[fsStrikeOut];
    end else
    zy1 := ClientDataSet1.FieldByName('¼ȡרҵ').Asstring;
    zy2 := ClientDataSet1.FieldByName('¼ȡרҵ�淶��').Asstring;
    if not ZyIsEqual(zy1,zy2) then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := $00D392C1;//$007D332D;//clMaroon;
      //Column.Font.Color := clWhite;
    end else
      Column.Font.Color := clBlack;
  end;

  if (Column.FieldName='ID') then
  begin
    if Trim(Column.Field.AsString) = '��' then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clYellow;
      Column.Font.Color := clNavy;
    end;
  end;

  if (Column.FieldName='��ӡ״̬') then
  begin
    if Trim(Column.Field.AsString) = '' then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clYellow;
      Column.Font.Color := clNavy;
    end;
  end;
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);

end;

function TKsInfoBrowse.GetOrderString: string;
begin
end;

procedure TKsInfoBrowse.GetWhereList;
var
  sTemp :string;
begin
  sWhereList.Clear;
  sWhereList.Add('where ѧ�����='+quotedstr(cbb_XlCc.Text));
  if cbb_Lb.Text<>'ȫ��' then
    sWhereList.Add(' and ���='+quotedstr(cbb_Lb.Text));
  if cbb_KL.Text<>'ȫ��' then
    sWhereList.Add(' and ����='+quotedstr(cbb_KL.Text));

  if cbb_Sf.Text<>'ȫ��' then
    sWhereList.Add(' and ʡ��='+quotedstr(cbb_Sf.Text));
  if not dm.IsDisplayJiangXi then
    sWhereList.Add(' and ʡ��<>'+quotedstr('����'));

  sTemp := GetFilterString;
  
  if sTemp<>'' then
    sWhereList.Add(sTemp);
end;

procedure TKsInfoBrowse.DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if vsorted then
    Open_Access_Table;
  vsorted := False;
end;

procedure TKsInfoBrowse.DBGridEH1TitleClick(Column: TColumnEh);
begin
  if Column.FieldName='ѡ���' then
  begin
    DBGridEH1.SaveBookmark;
    ClientDataSet1.DisableControls;
    ClientDataSet1.First;
    try
      while not ClientDataSet1.Eof do
      begin
        ClientDataSet1.Edit;
        ClientDataSet1.FieldByName('ѡ���').AsBoolean := not ClientDataSet1.FieldByName('ѡ���').AsBoolean;
        ClientDataSet1.Post;
        ClientDataSet1.Next;
      end;
    finally
      DBGridEH1.RestoreBookmark;
      ClientDataSet1.EnableControls;
    end;
  end;
end;

procedure TKsInfoBrowse.edt1Change(Sender: TObject);
begin
 // ClientDataSet1.Filtered := False;
 // ClientDataSet1.Filtered := (Length(edt1.Text)>=4) and chk1.Checked;
end;

procedure TKsInfoBrowse.cbb_CompareChange(Sender: TObject);
begin
  cbb_Value.Enabled := (cbb_Compare.ItemIndex<>7) and (cbb_Compare.ItemIndex<>8);
end;

procedure TKsInfoBrowse.cbb_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(cbb_Value.Text))+')';
  if (LeftStr(cbb_Value.Text,1)='B') or (LeftStr(cbb_Value.Text,1)='Z') then
  begin
    if Copy(cbb_Value.Text,2,1)>'9' then
    begin
      cbb_Field.Text := '��ˮ��';
      if Length(cbb_Value.Text)=7 then btn_OK.Click;
    end else
    begin
      cbb_Field.Text := '֪ͨ����';
      if Length(cbb_Value.Text)=8 then btn_OK.Click;
    end;
  end
  else  if LeftStr(cbb_Value.Text,2)=Copy(FormatDateTime('yyyy',Now),3,2) then
    cbb_Field.Text := '������';
end;

procedure TKsInfoBrowse.cbb_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_OK.Click;
end;

function TKsInfoBrowse.GetFilterString: String;
var
  sWhere,sValue:string;
begin
  sWhere := '';
  if (not ClientDataSet1.Active) then Exit;
  if cbb_Value.Enabled and (cbb_Value.Text='') then Exit;

  if cbb_Compare.KeyItems[cbb_Compare.ItemIndex]='Like' then
    sValue := '%'+cbb_Value.Text+'%'
  else
    sValue := cbb_Value.Text;

  if cbb_Value.Enabled then
    sWhere := 'and ('+cbb_Field.GetField+' '+cbb_Compare.KeyItems[cbb_Compare.ItemIndex]+' '+quotedstr(sValue)+')'
  else
    sWhere := 'and ('+cbb_Field.GetField+' '+cbb_Compare.KeyItems[cbb_Compare.ItemIndex]+')';

  Result := sWhere;
end;

function TKsInfoBrowse.GetMaxNo(const Sf, Lb: string): string;
var
  sKsh,sMsg,sqlstr:string;
  cds_Temp:TClientDataSet;
begin
  sqlstr := 'select max(֪ͨ����) from ¼ȡ��Ϣ�� where ʡ��='+quotedstr(Sf)+
            ' and ���='+quotedstr(Lb);
  DBGridEH1.SaveBookmark;
  Screen.Cursor := crHourGlass;
  try
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      sKsh := ClientDataSet1.FieldByName('������').AsString;
      sMsg := '';
      if not vobj.UpdateLqtzsNo(sKsh,sMsg) then
      begin
        MessageBox(Handle, PChar('������'+sKsh+'��¼ȡ֪ͨ��������ʧ�ܣ���'), 'ϵͳ��ʾ', MB_OK
          + MB_ICONSTOP + MB_TOPMOST);
        Exit;
      end;
      ClientDataSet1.Next;
    end;
    MessageBox(Handle, '��ǰ���п�����¼ȡ֪ͨ�������Ƴɹ�����', 'ϵͳ��ʾ', 
      MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    Open_Access_Table();  
  finally
    DBGridEH1.RestoreBookmark;
    Screen.Cursor := crDefault;
  end;
end;

function TKsInfoBrowse.GetXznxString: String;
begin
end;

procedure TKsInfoBrowse.mmi_ProcessSJRClick(Sender: TObject);
var
  sqlstr:string;
  updateCount:Integer;
begin
  if Application.MessageBox('���Ҫϵͳ�Զ�����հ��ռ����𣿡���',
    '������ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  sqlstr := 'update ¼ȡ��Ϣ�� set �ռ���=�������� '+GetXznxString+' and �ռ��� is null';
  dm.ExecSql(sqlstr);
  Application.MessageBox(PChar('������ɣ���'), 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
end;

procedure TKsInfoBrowse.mni_FormatKLClick(Sender: TObject);
var
  sf,pc,kl:string;
//  bm:TBookmark;
begin
  sf := ClientDataSet1.FieldByName('ʡ��').Asstring;
  pc := ClientDataSet1.FieldByName('����').Asstring;
  kl := ClientDataSet1.FieldByName('��������').Asstring;
  with TFormatKL.Create(Application) do
  begin
    FillData(sf,pc,kl,ClientDataSet1);
    if ShowModal=mrOk then
    try
      DBGridEH1.SaveBookmark;
//      bm := ClientDataSet1.GetBookmark;
      Open_Access_Table;
    finally
      DBGridEH1.RestoreBookmark;
//      ClientDataSet1.GotoBookmark(bm);
    end;
  end;
end;

procedure TKsInfoBrowse.mni_SfClick(Sender: TObject);
begin
  if mni_Sf.Checked then
    cbb_sf.Text := ClientDataSet1.FieldByName('ʡ��').AsString
  else
    cbb_Sf.Text := 'ȫ��';
end;

procedure TKsInfoBrowse.N9Click(Sender: TObject);
var
  sqlstr:string;
  updateCount:Integer;
begin
  if Application.MessageBox('���Ҫ��ϵͳ�Զ�����¼ȡ���������𣿡���',
    '������ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;
  sqlstr := 'update ¼ȡ��Ϣ�� set ¼ȡ��������=format(Action_Time,'+quotedstr('yyyy-mm-dd')+') where ¼ȡ�������� is null';
  dm.ExecSql(sqlstr);
  Application.MessageBox(PChar('������ɣ�����'), 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
end;

end.
