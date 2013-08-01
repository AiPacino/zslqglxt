unit uKsList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ActnList, DB,StrUtils, DBGridEhImpExp,uSetNumber,
  Menus, ImgList, frxClass, frxDBSet, frxDesgn, StdCtrls, Spin, DBCtrls,
  MyDBNavigator, StatusBarEx, GridsEh, DBGridEh, uStuInfo,uFormatKL,uFormatZy,
  DBFieldComboBox, StdActns, pngimage, DBClient, DBGridEhGrouping, frxpngimage,
  Mask, DBCtrlsEh;

type
  TKsList = class(TForm)
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
    img_Hint: TImage;
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
    cbb_Compare: TDBComboBoxEh;
    btn_Save: TBitBtn;
    lbl_Len: TLabel;
    pm_Number: TMenuItem;
    pmi_Card: TMenuItem;
    pmi_EMS: TMenuItem;
    DBGridEh_Export: TDBGridEh;
    cds_Export: TClientDataSet;
    ds_Export: TDataSource;
    pmi_SetTd: TMenuItem;
    chk_Filter: TCheckBox;
    chk_ZyNoSame: TCheckBox;
    pmi_CancelEnd: TMenuItem;
    pmi_Jwxt: TMenuItem;
    N2: TMenuItem;
    chk_NoJx: TCheckBox;
    grp_Yk: TGroupBox;
    cbb_yk: TDBComboBoxEh;
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
    procedure chk2Click(Sender: TObject);
    procedure DBGridEH1TitleClick(Column: TColumnEh);
    procedure btn_SqlWhereClick(Sender: TObject);
    procedure cbb_CompareChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure cbb_ValueChange(Sender: TObject);
    procedure chk_ZyNoSameClick(Sender: TObject);
    procedure pm_NumberClick(Sender: TObject);
    procedure pmi_CardClick(Sender: TObject);
    procedure pmi_EMSClick(Sender: TObject);
    procedure pmi_SetTdClick(Sender: TObject);
    procedure chk_FilterClick(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
    procedure pmi_CancelEndClick(Sender: TObject);
    procedure pmi_JwxtClick(Sender: TObject);
    procedure chk_NoJxClick(Sender: TObject);
  private
    { Private declarations }
    //FormatKL:TFormatKL;
    //FormatZy:TFormatZyMc;
    aForm :TSetNumber;
    StuInfo:TStuInfo;
    vsorted :Boolean;
    repfn:string;
    sWhereList:Tstrings;
    procedure ExportToExcel(const iType:Integer);
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
  KsList: TKsList;

implementation

uses uDM, uMareData_BDE,uMain,uSQLWhere;//, uFormatZymc,
  //uSqlExecute,uBh,uPhotoProcess,uSQLWhere,uFormatKL;

{$R *.dfm}

procedure TKsList.RzGroup2Items0Click(Sender: TObject);
var
  path,fn :string;
begin
{
  path := ExtractFileDir(Application.ExeName);
  fn := path+'\lqmd.mdb';
  if not FileExists(fn) then
  begin
    MessageBox(Handle, PChar('数据库文件：'+fn+' 不存在！　　'), '数据库不存在', MB_OK +
      MB_ICONWARNING);
    exit;
  end;

  Connect_Access(path);

  ClientDataSet1.Close;
  ClientDataSet1.Open;
  //frm_Ksxt.show;
}
end;

procedure TKsList.RzGroup4Items1Click(Sender: TObject);
begin
  Close;
end;

procedure TKsList.RzGroup3Items0Click(Sender: TObject);
begin
  //frm_PrintLqtzs.ShowModal;
end;

procedure TKsList.mmi_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsList.mmi_PrnLQTZSClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
  ksh,fn:string;
  procedure GetRepName;
  begin
  if cbb_XlCc.Text='本科' then
  begin
    if Pos('预科',ClientDataSet1.FieldByName('录取专业规范名').AsString)>0 then
      fn := '预科录取通知书.fr3'
    else
      fn := '本科录取通知书.fr3';
  end else
    fn := '专科录取通知书.fr3';
  end;
begin
  if cbb_yk.Text='全部考生' then
  begin
    Application.MessageBox('请选择相应的预科过滤条件后再打印录取通知书！', 
      '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    Exit;
  end;
  if MessageBox(Handle, '真的要打印当前所显示的所有考生的录取通知书吗？　',
    '系统提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDNO then
  begin
    Exit;
  end;

  cds_Temp := TClientDataSet.Create(nil);
  ClientDataSet1.DisableControls;
  Screen.Cursor := crHourGlass;
  DBGridEH1.SaveBookmark;

  //cds_Temp.XMLData := ClientDataSet1.XMLData;
  cds_Temp.XMLData := dm.OpenData('select * from 录取信息表 '+sWhereList.Text+' order by 流水号');
  GetRepName;
  dm.PrintReport(fn,cds_Temp.XMLData,1,True);

  try
{
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      ksh := ClientDataSet1.FieldByName('考生号').AsString;
      cds_Temp.XMLData := dm.OpenData('select * from 录取信息表 where 考生号='+quotedstr(ksh));
      GetRepName;
      dm.PrintReport(fn,cds_Temp.XMLData,1,False);
      ClientDataSet1.Next;
    end;
}
  finally
    ClientDataSet1.EnableControls;
    Screen.Cursor := crDefault;
    DBGridEH1.RestoreBookmark;
    cds_Temp.Free;
  end;
end;

procedure TKsList.mmi_PrnLQKSMDClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select * from 录取信息表 '+sWhereList.Text+' order by 学历层次,采集员,省份,类别,科类,录取专业规范名');
    //Print_LQKSMD();
    dm.PrintReport('专业分类录取名单.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TKsList.mmi_ExcelClick(Sender: TObject);
begin
  ExportToExcel(3);
end;

procedure TKsList.mmi_FormatZymcClick(Sender: TObject);
var
  xlcc,sf,pc,kl,zydm,zy:string;
//  bm:TBookmark;
begin
  xlcc := ClientDataSet1.FieldByName('学历层次').Asstring;
  sf := ClientDataSet1.FieldByName('省份').Asstring;
  pc := ClientDataSet1.FieldByName('批次名称').Asstring;
  kl := ClientDataSet1.FieldByName('类别').Asstring;//ClientDataSet1.FieldByName('科类名称').Asstring;
  zydm := ClientDataSet1.FieldByName('录取代码').Asstring;
  zy := ClientDataSet1.FieldByName('录取专业').Asstring;

  with TFormatZy.Create(Application) do
  begin
    FillData(xlcc,sf,pc,kl,zydm,zy,ClientDataSet1,'录取信息表');
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

procedure TKsList.mmi_ExecSQLClick(Sender: TObject);
begin
  //Tfrm_SqlExecute.Create(Application).Show;
end;

procedure TKsList.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Access_Table;
  if Self.Showing then
    DBGridEH1.SetFocus;
end;

procedure TKsList.chk2Click(Sender: TObject);
begin
  Open_Access_Table();
end;

procedure TKsList.btn_OKClick(Sender: TObject);
begin
  Open_Access_Table;
  if cbb_Value.CanFocus then
    cbb_Value.SetFocus;
end;

procedure TKsList.btn_RefreshClick(Sender: TObject);
begin
  Open_Access_Table();
end;

procedure TKsList.btn_SaveClick(Sender: TObject);
begin
  if not DataSetNoSave(ClientDataSet1) then Exit;
  if MessageBox(Handle, '确定要对手工修改的数据时行保存吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  if dm.UpdateData('考生号','select top 0 * from 录取信息表',ClientDataSet1.Delta,True) then
    ClientDataSet1.MergeChangeLog;
end;

procedure TKsList.btn_SqlWhereClick(Sender: TObject);
begin
  if GetSqlWhere(ClientDataSet1,sWhereList) then
    Open_Access_Table(sWhereList.Text);
end;

procedure TKsList.FormCreate(Sender: TObject);
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
  ii := cbb_Sf.Items.IndexOf('江西');
  if (ii>=0) and (not dm.IsDisplayJiangXi) then
    cbb_Sf.Items.Delete(ii);
}

  dm.SetLbComboBox(cbb_Lb,True);

  dm.SetKlComboBox(cbb_KL,True);

  try
    aForm := TSetNumber.Create(Self);
    aForm.ds_lqmd.DataSet := ClientDataSet1;
    StuInfo := TStuInfo.Create(Self);
    StuInfo.DataSource1.DataSet := ClientDataSet1;
    sWhereList := TStringList.Create;
    Open_Access_Table;
  finally
    sList.Free;
  end;
end;

procedure TKsList.FormDestroy(Sender: TObject);
begin
  FreeAndNil(aForm);
  FreeAndNil(StuInfo);
  FreeAndNil(sWhereList);
end;

procedure TKsList.Open_Access_Table(const sWhere:string='');
var
  vxzstr,vfilterstr,vordstr:string;
  sqlStr:string;
begin
  Repfn := ExtractFilePath(Application.ExeName)+'Rep\'+cbb_xlcc.Text+'录取通知书.fr3';

  if sWhere='' then
    GetWhereList
  else
    sWhereList.Text := sWhere;

  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    sqlStr := 'select * from 录取信息表 '+sWhereList.Text+' order by 流水号';
    ClientDataSet1.XMLData := dm.OpenData(sqlStr);
  finally
    ClientDataSet1.EnableControls;
    ClientDataSet1.Filtered := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TKsList.ds_AccessDataChange(Sender: TObject; Field: TField);
begin
  lbl1.Caption := '记录：'+IntToStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount);
end;

procedure TKsList.chk_FilterClick(Sender: TObject);
begin
  DBGridEH1.STFilter.Visible := chk_Filter.Checked;
end;

procedure TKsList.chk_NoJxClick(Sender: TObject);
begin
  if Self.Showing then
    Open_Access_Table;
  if Self.Showing then
    DBGridEH1.SetFocus;
end;

procedure TKsList.chk_NotJxClick(Sender: TObject);
begin
  btn_OK.Click;
end;

procedure TKsList.chk_ZyNoSameClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := chk_ZyNoSame.Checked;
end;

procedure TKsList.chk_ZyNotSameClick(Sender: TObject);
begin
  //ClientDataSet1.Filtered := chk_ZyNotSame.Checked;
end;

procedure TKsList.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  RealseSortedIcon(DBGridEH1);
end;

procedure TKsList.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if not DataSet.Active then Exit;
  if not chk_ZyNoSame.Checked then Exit;

  if (chk_ZyNoSame.Checked)  then
  begin
    Accept := not ZyIsEqual(ClientDataSet1.FieldByName('录取专业').AsString,ClientDataSet1.FieldByName('录取专业规范名').AsString);
  end else
    Accept := True;
end;

procedure TKsList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TKsList.mmi_PrnEMSClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select * from 录取信息表 '+sWhereList.Text+' order by 流水号');
    //Print_LQTZS(True);
    dm.PrintReport('EMS.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TKsList.rg1Click(Sender: TObject);
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

procedure TKsList.UpDownNumEdit1Change(Sender: TObject);
begin
  //frxDBDataset1.RangeEndCount := UpDownNumEdit1.Value;
end;

procedure TKsList.rg2Click(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsList.Print_EMS(const designed: Boolean);
begin
end;

procedure TKsList.Print_LQKSMD(const designed: Boolean);
begin
end;

procedure TKsList.Print_LQTZS(const designed: Boolean);
begin
end;

procedure TKsList.mmi_DesEMSClick(Sender: TObject);
begin
  Print_EMS(True);
end;

procedure TKsList.mmi_DesLQTZSClick(Sender: TObject);
begin
  Print_LQTZS(True);
end;

procedure TKsList.mmi_DesLQKSMDClick(Sender: TObject);
begin
  Print_LQKSMD(True);
end;

procedure TKsList.mi_FormatKLClick(Sender: TObject);
var
  sf,pc,kl,sqlstr:string;
begin
{
  sf := Trim(ClientDataSet1.FieldByName('省份').AsString);
  pc := Trim(ClientDataSet1.FieldByName('批次').AsString);
  kl := Trim(ClientDataSet1.FieldByName('科类').AsString);
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

procedure TKsList.mmi_AllowEditClick(Sender: TObject);
begin
  DBGridEH1.ReadOnly := not mmi_AllowEdit.Checked;
  btn_Save.Visible := mmi_AllowEdit.Checked;
end;

procedure TKsList.pm1Popup(Sender: TObject);
begin
  pmi_SetTd.Visible := gb_Czy_Level='-1';
  pmi_CancelEnd.Visible := gb_Czy_Level='-1';
end;

procedure TKsList.pmi_CancelEndClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '真的要取消当前考生的录取结束状态吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if UpperCase(InputBox('操作确认','请输入【OK】字符以便确认！',''))<>'OK' then Exit;
    sqlstr := 'update lqmd set 考生状态='+quotedstr('1')+
              'where 考生号='+quotedstr(ClientDataSet1.FieldByName('考生号').AsString);
    if dm.ExecSql(sqlstr) then
      MessageBox(Handle, '操作完成！已取消了当前考生的录取结束状态！　', '系统提示',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TKsList.pmi_CardClick(Sender: TObject);
begin
  ExportToExcel(0);
end;

procedure TKsList.pmi_EMSClick(Sender: TObject);
begin
  ExportToExcel(1);
end;

procedure TKsList.pmi_JwxtClick(Sender: TObject);
begin
  ExportToExcel(2);
end;

procedure TKsList.pmi_RefreshClick(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsList.pmi_SetTdClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '真的要为当前考生作退档处理吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if UpperCase(InputBox('操作确认','请输入【OK】字符以便确认！',''))<>'OK' then Exit;
    sqlstr := 'update lqmd set 考生状态='+quotedstr('3')+',录取代码=NULL,录取专业=NULL,录取专业规范名=NULL,'+
              '院系=NULL,报到校区=NULL,类别=NULL,考生类别=NULL,科类=NULL '+
              'where 考生号='+quotedstr(ClientDataSet1.FieldByName('考生号').AsString);
    if dm.ExecSql(sqlstr) then
      MessageBox(Handle, '操作完成！已为当前考生作了退档处理！　', '系统提示',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TKsList.pm_NumberClick(Sender: TObject);
var
  sfyk:Boolean;
begin
  if cbb_yk.Text='全部考生' then
  begin
    Application.MessageBox('请选择相应的预科过滤条件后编制流水号！',
      '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    Exit;
  end;
  if MessageBox(Handle, '真的要为当前所显示的记录编制流水号吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  sfyk := cbb_yk.Text='预科考生';
  aForm.SetData(cbb_XlCc.Text,sfyk,ClientDataSet1);
  aForm.Show;
end;

procedure TKsList.mmi_BHClick(Sender: TObject);
var
  sKsh,sMsg,sqlstr:string;
  cds_Temp:TClientDataSet;
begin
  if MessageBox(Handle,
    '真的要为所有未编号的考生编制录取通知书编号吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  DBGridEH1.SaveBookmark;
  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    sMsg := '';
{
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      sKsh := ClientDataSet1.FieldByName('考生号').AsString;
      sMsg := '';
      if not vobj.UpdateLqtzsNo(sKsh,sMsg) then
      begin
        MessageBox(Handle, PChar('考生【'+sKsh+'】录取通知书号码编制失败！　'+#13+sMsg), '系统提示', MB_OK
          + MB_ICONSTOP + MB_TOPMOST);
        Exit;
      end;
      ClientDataSet1.Next;
    end;
}
    if not vobj.UpdateLqtzsNo('',sMsg) then
    begin
      MessageBox(Handle, PChar('录取通知书号码编制失败！　'+#13+sMsg), '系统提示', MB_OK
        + MB_ICONSTOP + MB_TOPMOST);
    end else
    begin
      vobj.UpdateLqInfo(cbb_XlCc.Text);
      Open_Access_Table();
      MessageBox(Handle, '录取通知书号码编制成功！　', '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    end;
  finally
    ClientDataSet1.EnableControls;
    DBGridEH1.RestoreBookmark;
    Screen.Cursor := crDefault;
  end;

end;

procedure TKsList.dxDBMemo1DblClick(Sender: TObject);
begin
{
  if (ClientDataSet1.FieldByName('录取专业').AsString<>ClientDataSet1.FieldByName('录取专业规范名').AsString)
     and mmi_AllowEdit.Checked then
  begin
    ClientDataSet1.Edit;
    dxDBMemo1.Text := FormatDateTime('yyyy-mm-dd',Date)+' '+ClientDataSet1.FieldByName('录取专业').AsString+'->'+
                      ClientDataSet1.FieldByName('录取专业规范名').AsString+' 委托人：';
    ClientDataSet1.Post;
  end;
}
end;

procedure TKsList.DBGridEH1DblClick(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('考生号').IsNull then
  begin
    StuInfo.Show;
    StuInfo.DataSource1DataChange(Self,nil);
  end;
end;

procedure TKsList.DBGridEH1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  zy1,zy2:string;
  iLen:Integer;
begin
  if (Column.FieldName='备注') then
  begin
    if Column.Field.AsString<>'' then
    begin
      Column.Font.Color := clWhite;
      TDBGridEh(Sender).Canvas.Brush.Color := clRed;
    end;
  end;

  if (Column.FieldName='录取专业规范名') then
  begin
    //Column.Font.Style := Font.Style-[fsStrikeOut];
    if Pos('退档',Column.Field.AsString)>0 then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clRed;
      //Column.Font.Color := clRed;
      //Column.Font.Style := Font.Style+[fsStrikeOut];
    end else
    zy1 := ClientDataSet1.FieldByName('录取专业').Asstring;
    zy2 := ClientDataSet1.FieldByName('录取专业规范名').Asstring;
    if not ZyIsEqual(zy1,zy2) then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := $00D392C1;//$007D332D;//clMaroon;
      //Column.Font.Color := clWhite;
    end else
      Column.Font.Color := clBlack;
  end;

  if (Column.FieldName='ID') then
  begin
    if Trim(Column.Field.AsString) = '是' then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clYellow;
      Column.Font.Color := clNavy;
    end;
  end;

  if (Column.FieldName='打印状态') then
  begin
    if Trim(Column.Field.AsString) = '' then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clYellow;
      Column.Font.Color := clNavy;
    end;
  end;
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);

end;

function TKsList.GetOrderString: string;
begin
end;

procedure TKsList.GetWhereList;
var
  sTemp :string;
begin
  sWhereList.Clear;
  sWhereList.Add('where 学历层次='+quotedstr(cbb_XlCc.Text));
  if cbb_Lb.Text<>'全部' then
    sWhereList.Add(' and 类别='+quotedstr(cbb_Lb.Text));
  if cbb_KL.Text<>'全部' then
    sWhereList.Add(' and 科类='+quotedstr(cbb_KL.Text));

  if cbb_Sf.Text<>'全部' then
    sWhereList.Add(' and 省份='+quotedstr(cbb_Sf.Text));
  if (not dm.IsDisplayJiangXi) or (chk_NoJx.Checked) then
    sWhereList.Add(' and 省份<>'+quotedstr('江西'));
  if cbb_yk.Text<>'全部考生' then
    sWhereList.Add(' and '+cbb_yk.Value);

  sTemp := GetFilterString;
  
  if sTemp<>'' then
    sWhereList.Add(sTemp);
end;

procedure TKsList.DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if vsorted then
    Open_Access_Table;
  vsorted := False;
end;

procedure TKsList.DBGridEH1TitleClick(Column: TColumnEh);
begin
  if Column.FieldName='选择否' then
  begin
    DBGridEH1.SaveBookmark;
    ClientDataSet1.DisableControls;
    ClientDataSet1.First;
    try
      while not ClientDataSet1.Eof do
      begin
        ClientDataSet1.Edit;
        ClientDataSet1.FieldByName('选择否').AsBoolean := not ClientDataSet1.FieldByName('选择否').AsBoolean;
        ClientDataSet1.Post;
        ClientDataSet1.Next;
      end;
    finally
      DBGridEH1.RestoreBookmark;
      ClientDataSet1.EnableControls;
    end;
  end;
end;

procedure TKsList.edt1Change(Sender: TObject);
begin       
 // ClientDataSet1.Filtered := False;
 // ClientDataSet1.Filtered := (Length(edt1.Text)>=4) and chk1.Checked;
end;

procedure TKsList.ExportToExcel(const iType: Integer);
var
  sTitle,sFldList,sqlstr:string;
  fn,Ext,mfn,sMin,sMax,ykstr:string;
begin
  case iType of
    0:
    begin
      sTitle := '制卡';
      //sFldList := '流水号,省份,类别,考生号,身份证号,考生姓名,性别,报到校区,left(家庭地址,6) as 籍贯' ;
    end;
    1:
    begin
      sTitle := 'EMS';
      //sFldList := '流水号,省份,类别,考生号,考生姓名,收件人,邮政编码,家庭地址,联系电话' ;
    end;
    2:
    begin
      sTitle := '教务';
      //sFldList := '流水号,学历层次,省份,类别,科类,考生号,身份证号,考生姓名,性别,学历层次,录取专业规范名 as 专业,院系,报到校区,收件人,邮政编码,家庭地址,联系电话' ;
    end;
    3:
    begin
      sTitle := '';
      sFldList := '*' ;
    end;
  end;
  sFldList := vobj.GetExportFieldList(sTitle);
  if sFldList='' then sFldList := '*';

  sqlstr := 'select '+sFldList+' from 录取信息表 '+sWhereList.Text+' order by 流水号';

  cds_Export.XMLData := dm.OpenData(sqlstr);
  case cbb_yk.ItemIndex of
    0:
      ykstr := '';
    1:
      ykstr := '预科班';
    2:
      ykstr := '非预科';
  end;
  cds_Export.Last;
  sMax := cds_Export.FieldByName('流水号').AsString;
  cds_Export.First;
  sMin := cds_Export.FieldByName('流水号').AsString;

  fn := FormatDateTime('yyyy',Now)+cbb_Xlcc.Text+ykstr+sTitle+'信息【'+sMin+'~'+sMax+'】('+IntToStr(cds_Export.RecordCount)+'人).xls';
  dlgSave_1.FileName := fn;
  if dlgSave_1.Execute then
  begin
    if FileExists(dlgSave_1.FileName) then
      if MessageBox(Handle, PChar(sTitle+' Excel文件：'+dlgSave_1.FileName+'已存在，要覆盖它吗？　'), '文件已存在', MB_YESNO + MB_ICONWARNING +
        MB_DEFBUTTON2) = IDNO then
        Exit
      else
        DeleteFile(dlgSave_1.FileName);

    try
      Screen.Cursor := crHourGlass;
      fn := dlgSave_1.FileName;
      Ext := ExtractFileExt(fn);
      mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,DBGridEh_Export, fn,True);
    finally
      Screen.Cursor := crDefault;
      MessageBox(Handle, PChar(sTitle+'Excel文件导出完成！　'), '导出成功', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TKsList.cbb_CompareChange(Sender: TObject);
begin
  cbb_Value.Enabled := (cbb_Compare.ItemIndex<>7) and (cbb_Compare.ItemIndex<>8);
end;

procedure TKsList.cbb_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(cbb_Value.Text))+')';
  if (LeftStr(cbb_Value.Text,1)='B') or (LeftStr(cbb_Value.Text,1)='Z') then
  begin
    if Copy(cbb_Value.Text,2,1)>'9' then
    begin
      cbb_Field.Text := '流水号';
      if Length(cbb_Value.Text)=7 then btn_OK.Click;
    end else
    begin
      cbb_Field.Text := '通知书编号';
      if Length(cbb_Value.Text)=8 then btn_OK.Click;
    end;
  end
  else  if LeftStr(cbb_Value.Text,2)=Copy(FormatDateTime('yyyy',Now),3,2) then
    cbb_Field.Text := '考生号';
end;

procedure TKsList.cbb_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_OK.Click;
end;

function TKsList.GetFilterString: String;
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

function TKsList.GetMaxNo(const Sf, Lb: string): string;
var
  sKsh,sMsg,sqlstr:string;
  cds_Temp:TClientDataSet;
begin
  sqlstr := 'select max(通知书编号) from 录取信息表 where 省份='+quotedstr(Sf)+
            ' and 类别='+quotedstr(Lb);
  DBGridEH1.SaveBookmark;
  Screen.Cursor := crHourGlass;
  try
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      sKsh := ClientDataSet1.FieldByName('考生号').AsString;
      sMsg := '';
      if not vobj.UpdateLqtzsNo(sKsh,sMsg) then
      begin
        MessageBox(Handle, PChar('考生【'+sKsh+'】录取通知书号码编制失败！　'), '系统提示', MB_OK
          + MB_ICONSTOP + MB_TOPMOST);
        Exit;
      end;
      ClientDataSet1.Next;
    end;
    MessageBox(Handle, '当前所有考生的录取通知书号码编制成功！　', '系统提示', 
      MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    Open_Access_Table();  
  finally
    DBGridEH1.RestoreBookmark;
    Screen.Cursor := crDefault;
  end;
end;

function TKsList.GetXznxString: String;
begin
end;

procedure TKsList.mmi_ProcessSJRClick(Sender: TObject);
var
  sqlstr:string;
  updateCount:Integer;
begin
  if Application.MessageBox('真的要系统自动处理空白收件人吗？　　',
    '操作提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  sqlstr := 'update 录取信息表 set 收件人=考生姓名 '+GetXznxString+' and 收件人 is null';
  dm.ExecSql(sqlstr);
  Application.MessageBox(PChar('操作完成！　'), '系统提示', MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
end;

procedure TKsList.mni_FormatKLClick(Sender: TObject);
var
  sf,pc,kl:string;
//  bm:TBookmark;
begin
  sf := ClientDataSet1.FieldByName('省份').Asstring;
  pc := ClientDataSet1.FieldByName('批次').Asstring;
  kl := ClientDataSet1.FieldByName('科类名称').Asstring;
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

procedure TKsList.mni_SfClick(Sender: TObject);
begin
  if mni_Sf.Checked then
    cbb_sf.Text := ClientDataSet1.FieldByName('省份').AsString
  else
    cbb_Sf.Text := '全部';
end;

procedure TKsList.N9Click(Sender: TObject);
var
  sqlstr:string;
  updateCount:Integer;
begin
  if Application.MessageBox('真的要让系统自动处理录取结束日期吗？　　',
    '操作提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;
  sqlstr := 'update 录取信息表 set 录取结束日期=format(Action_Time,'+quotedstr('yyyy-mm-dd')+') where 录取结束日期 is null';
  dm.ExecSql(sqlstr);
  Application.MessageBox(PChar('操作完成！　　'), '系统提示', MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
end;

end.
