unit uKsInfoBrowse_All;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ActnList, DB,StrUtils, DBGridEhImpExp,
  Menus, ImgList, frxClass, frxDBSet, frxDesgn, StdCtrls, Spin, DBCtrls,
  MyDBNavigator, StatusBarEx, GridsEh, DBGridEh, uStuInfo,uFormatKL,uFormatZy,
  DBFieldComboBox, StdActns, pngimage, DBClient, DBGridEhGrouping, frxpngimage,
  Mask, DBCtrlsEh;

type
  TKsInfoBrowse_All = class(TForm)
    pnl2: TPanel;
    chk1: TLabel;
    cbb_Value: TEdit;
    frxDesigner1: TfrxDesigner;
    frxDBDataset1: TfrxDBDataset;
    il1: TImageList;
    pm1: TPopupMenu;
    pmi_Excel: TMenuItem;
    ds_Access: TDataSource;
    dlgSave_1: TSaveDialog;
    btn_OK: TBitBtn;
    btn_Adv: TBitBtn;
    N4: TMenuItem;
    pmi_Refresh: TMenuItem;
    frxReport1: TfrxReport;
    cbb_Field: TDBFieldComboBox;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    C1: TMenuItem;
    X1: TMenuItem;
    P1: TMenuItem;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    chk2: TCheckBox;
    lbl1: TLabel;
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
    lbl_Len: TLabel;
    pm_FormatZy: TMenuItem;
    cbb_Compare: TDBComboBoxEh;
    chk_Filter: TCheckBox;
    chk_ZyNoSame: TCheckBox;
    pmi_SetTd: TMenuItem;
    pmi_SetEnd: TMenuItem;
    pmi_SetNormal: TMenuItem;
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
    procedure pmi_RefreshClick(Sender: TObject);
    procedure mmi_BHClick(Sender: TObject);
    procedure DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mmi_ProcessSJRClick(Sender: TObject);
    procedure DBGridEH1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N9Click(Sender: TObject);
    procedure btn_AdvClick(Sender: TObject);
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
    procedure mni_SfClick(Sender: TObject);
    procedure cbb_ValueChange(Sender: TObject);
    procedure pm_FormatZyClick(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
    procedure chk_ZyNoSameClick(Sender: TObject);
    procedure ClientDataSet1CalcFields(DataSet: TDataSet);
    procedure cbb_CompareChange(Sender: TObject);
    procedure chk_FilterClick(Sender: TObject);
    procedure pmi_SetTdClick(Sender: TObject);
    procedure pmi_SetEndClick(Sender: TObject);
    procedure pmi_SetNormalClick(Sender: TObject);
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
  public
    { Public declarations }
  end;

var
  KsInfoBrowse_All: TKsInfoBrowse_All;

implementation

uses uDM, uMareData_BDE, uMain;//, uFormatZymc,
  //uSqlExecute,uBh,uPhotoProcess,uSQLWhere,uFormatKL;

{$R *.dfm}

procedure TKsInfoBrowse_All.RzGroup2Items0Click(Sender: TObject);
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

procedure TKsInfoBrowse_All.RzGroup4Items1Click(Sender: TObject);
begin
  Close;
end;

procedure TKsInfoBrowse_All.RzGroup3Items0Click(Sender: TObject);
begin
  //frm_PrintLqtzs.ShowModal;
end;

procedure TKsInfoBrowse_All.mmi_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsInfoBrowse_All.mmi_PrnLQTZSClick(Sender: TObject);
begin
  Print_LQTZS();
end;

procedure TKsInfoBrowse_All.mmi_PrnLQKSMDClick(Sender: TObject);
begin
{
  dxgrd_1.Columns[1].Title.SortIndex := 1;  //省份
  dxgrd_1.Columns[1].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[2].Title.SortIndex := 2;  //FindColumnByName('批次').
  dxgrd_1.Columns[2].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[3].Title.SortIndex := 3;  //FindColumnByName('科类').
  dxgrd_1.Columns[3].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[8].Title.SortIndex := 4; //FindColumnByName('录取专业规范名').
  dxgrd_1.Columns[8].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[13].Title.SortIndex := 5; //FindColumnByName('投档成绩').
  dxgrd_1.Columns[13].Title.SortMarker := smDownEh;
}
  if Application.MessageBox('打印前请先确认考生数据已经按照省份↑、批次↑、科类↑、　' +
    #13#10 + '录取专业规范名↑、投档成绩↓进行了排序！' + #13#10#13#10 +
    '要继续操作吗？', '系统提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2)
    = IDYES then

  begin
    Print_LQKSMD();
  end;
end;

procedure TKsInfoBrowse_All.mmi_ExcelClick(Sender: TObject);
var
  fn,Ext,mfn:string;
begin
  dlgSave_1.FileName := '考生数据.xls';
  if dlgSave_1.Execute then
  begin
    if FileExists(dlgSave_1.FileName) then
      if MessageBox(Handle, PChar('Excel文件：'+dlgSave_1.FileName+'已存在，要覆盖它吗？　　'), '文件已存在', MB_YESNO + MB_ICONWARNING +
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
      MessageBox(Handle, 'Excel文件导出完成！　　', '导出成功', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TKsInfoBrowse_All.mmi_FormatZymcClick(Sender: TObject);
var
  xlcc,sf,pc,lb,kl,zydm,zy:string;
//  bm:TBookmark;
begin
  xlcc := ClientDataSet1.FieldByName('学历层次').Asstring;
  sf := ClientDataSet1.FieldByName('省份').Asstring;
  pc := ClientDataSet1.FieldByName('批次名称').Asstring;
  lb := ClientDataSet1.FieldByName('类别').Asstring;//
  kl := ClientDataSet1.FieldByName('科类名称').Asstring;
  zydm := ClientDataSet1.FieldByName('录取代码').Asstring;
  zy := ClientDataSet1.FieldByName('录取专业').Asstring;

  with TFormatZy.Create(Application) do
  begin
    FillData(xlcc,sf,pc,lb,kl,zydm,zy,ClientDataSet1,'在阅考生信息表');
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

procedure TKsInfoBrowse_All.mmi_ExecSQLClick(Sender: TObject);
begin
  //Tfrm_SqlExecute.Create(Application).Show;
end;

procedure TKsInfoBrowse_All.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Access_Table;
  if Self.Showing then
    DBGridEH1.SetFocus;
end;

procedure TKsInfoBrowse_All.btn_AdvClick(Sender: TObject);
begin
{
  if GetSqlWhere(sWhereList) then
  begin
    Open_Access_Table;
  end;
}
end;

procedure TKsInfoBrowse_All.btn_OKClick(Sender: TObject);
begin
  Open_Access_Table;
  if cbb_Value.CanFocus then
    cbb_Value.SetFocus;
end;

procedure TKsInfoBrowse_All.FormCreate(Sender: TObject);
var
  path,fn :string;
  ii:Integer;
begin
  Self.Left := Trunc((Main.Width - Self.Width)/2);
  //Self.Top := Trunc((Main.Height - Self.Height)/2);
  Self.Top := 15;
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
    StuInfo := TStuInfo.Create(Self);
    StuInfo.DataSource1.DataSet := ClientDataSet1;
    sWhereList := TStringList.Create;
    Open_Access_Table;
  finally
  end;
end;

procedure TKsInfoBrowse_All.FormDestroy(Sender: TObject);
begin
  FreeAndNil(StuInfo);
  FreeAndNil(sWhereList);
end;

procedure TKsInfoBrowse_All.Open_Access_Table(const sWhere:string='');
var
  vxzstr,vfilterstr,vordstr:string;
  sqlStr:string;
begin
  Repfn := ExtractFilePath(Application.ExeName)+'Rep\'+cbb_xlcc.Text+'录取通知书.fr3';

  GetWhereList;

  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    sqlStr := 'select * from lqmd '+sWhereList.Text+sWhere+' order by 学历层次,省份,考生号';
    ClientDataSet1.XMLData := dm.OpenData(sqlStr);
  finally
    ClientDataSet1.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TKsInfoBrowse_All.ds_AccessDataChange(Sender: TObject; Field: TField);
begin
  lbl1.Caption := '记录：'+IntToStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount);
end;

procedure TKsInfoBrowse_All.chk_FilterClick(Sender: TObject);
begin
  DBGridEH1.STFilter.Visible := chk_Filter.Checked;
end;

procedure TKsInfoBrowse_All.chk_NotJxClick(Sender: TObject);
begin
  btn_OK.Click;
end;

procedure TKsInfoBrowse_All.chk_ZyNoSameClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := chk_ZyNoSame.Checked;
end;

procedure TKsInfoBrowse_All.chk_ZyNotSameClick(Sender: TObject);
begin
  //ClientDataSet1.Filtered := chk_ZyNotSame.Checked;
end;

procedure TKsInfoBrowse_All.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  RealseSortedIcon(DBGridEH1);
end;

procedure TKsInfoBrowse_All.ClientDataSet1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('_录取专业').AsString := DataSet.FieldByName('录取专业').AsString;
  Case DataSet.FieldByName('考生状态').AsInteger of
    0: //专业未定
    begin
      DataSet.FieldByName('_录取专业').AsString := '专业未定';
    end;
    1: //已拟录专业
    begin
      DataSet.FieldByName('_录取专业').AsString := DataSet.FieldByName('录取专业').AsString;
    end;
    2: //预退考生
    begin
      DataSet.FieldByName('_录取专业').AsString := '拟退档';
    end;
    3: //已退档考生
    begin
      DataSet.FieldByName('_录取专业').AsString := '已退档';
    end;
    5: //录取专业已确定且已结束的考生
    begin
      DataSet.FieldByName('_录取专业').AsString := DataSet.FieldByName('录取专业').AsString;
    end;
  End;
end;

procedure TKsInfoBrowse_All.ClientDataSet1FilterRecord(DataSet: TDataSet;
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

procedure TKsInfoBrowse_All.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TKsInfoBrowse_All.mmi_PrnEMSClick(Sender: TObject);
begin
  Print_EMS();
end;

procedure TKsInfoBrowse_All.rg1Click(Sender: TObject);
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

procedure TKsInfoBrowse_All.UpDownNumEdit1Change(Sender: TObject);
begin
  //frxDBDataset1.RangeEndCount := UpDownNumEdit1.Value;
end;

procedure TKsInfoBrowse_All.rg2Click(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsInfoBrowse_All.Print_EMS(const designed: Boolean);
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'\rep\ems.fr3';
  if not FileExists(fn) then
  begin
    MessageBox(Handle, PChar('报表文件：'+fn+' 不存在！    '), '报表文件不存在', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  frxReport1.LoadFromFile(fn);
  if designed then
    frxReport1.DesignReport
  else
    frxReport1.ShowReport;
end;

procedure TKsInfoBrowse_All.Print_LQKSMD(const designed: Boolean);
var
  repfn:String;
begin

  repfn := ExtractFilePath(Application.ExeName)+'Rep\专业分类录取名单.fr3';
  frxReport1.LoadFromFile(repfn);
  if designed then
    frxReport1.DesignReport
  else
    frxReport1.ShowReport;
end;

procedure TKsInfoBrowse_All.Print_LQTZS(const designed: Boolean);
begin
  if not FileExists(repfn) then
  begin
    MessageBox(Handle, PChar('报表文件：'+repfn+' 不存在！    '), '报表文件不存在', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  frxReport1.LoadFromFile(repfn);
  if designed then
    frxReport1.DesignReport
  else
    frxReport1.ShowReport;
end;

procedure TKsInfoBrowse_All.mmi_DesEMSClick(Sender: TObject);
begin
  Print_EMS(True);
end;

procedure TKsInfoBrowse_All.mmi_DesLQTZSClick(Sender: TObject);
begin
  Print_LQTZS(True);
end;

procedure TKsInfoBrowse_All.mmi_DesLQKSMDClick(Sender: TObject);
begin
  Print_LQKSMD(True);
end;

procedure TKsInfoBrowse_All.mi_FormatKLClick(Sender: TObject);
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

procedure TKsInfoBrowse_All.pm1Popup(Sender: TObject);
var
  zy:string;
begin
  zy := ClientDataSet1.FieldByName('录取专业').Asstring;
  pm_FormatZy.Enabled := zy<>'';
  pmi_SetNormal.Visible := gb_Czy_Level='-1';
  pmi_SetTd.Visible := gb_Czy_Level='-1';
  pmi_SetEnd.Visible := gb_Czy_Level='-1';
end;

procedure TKsInfoBrowse_All.pmi_RefreshClick(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsInfoBrowse_All.pmi_SetEndClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '真的要为当前考生作录取结束处理吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if UpperCase(InputBox('操作确认','请输入【OK】字符以便确认！',''))<>'OK' then Exit;
    sqlstr := 'update lqmd set 考生状态='+quotedstr('5')+
              'where 考生号='+quotedstr(ClientDataSet1.FieldByName('考生号').AsString);
    if dm.ExecSql(sqlstr) then
      MessageBox(Handle, '操作完成！已为当前考生作了录取结束处理！　', '系统提示',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TKsInfoBrowse_All.pmi_SetNormalClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '真的要把当前考生设置为阅档录检状态吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if UpperCase(InputBox('操作确认','请输入【OK】字符以便确认！',''))<>'OK' then Exit;
    sqlstr := 'update lqmd set 考生状态='+quotedstr('1')+',录取代码=NULL,录取专业=NULL,录取专业规范名=NULL,'+
              '院系=NULL,报到校区=NULL,类别=NULL,科类=NULL '+
              'where 考生号='+quotedstr(ClientDataSet1.FieldByName('考生号').AsString);
    if dm.ExecSql(sqlstr) then
      MessageBox(Handle, '操作完成！已把当前考生设置为阅档录检状态了！　', '系统提示',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TKsInfoBrowse_All.pmi_SetTdClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '真的要为当前考生作退档处理吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if UpperCase(InputBox('操作确认','请输入【OK】字符以便确认！',''))<>'OK' then Exit;
    sqlstr := 'update lqmd set 考生状态='+quotedstr('3')+',录取代码=NULL,录取专业=NULL,录取专业规范名=NULL,'+
              '院系=NULL,报到校区=NULL,类别=NULL,科类=NULL '+
              'where 考生号='+quotedstr(ClientDataSet1.FieldByName('考生号').AsString);
    if dm.ExecSql(sqlstr) then
      MessageBox(Handle, '操作完成！已为当前考生作了退档处理！　', '系统提示',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TKsInfoBrowse_All.mmi_BHClick(Sender: TObject);
begin
{
  with Tfrm_bh.Create(Application) do
  begin
    if rg2.itemindex=0 then
      cbb_Value.Text := 'B'
    else if rg2.itemindex=1 then
      cbb_Value.Text := 'Y'
    else
      cbb_Value.Text := 'Z';

    ShowModal;
    Free;
  end;
}
end;

procedure TKsInfoBrowse_All.dxDBMemo1DblClick(Sender: TObject);
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

procedure TKsInfoBrowse_All.DBGridEH1DblClick(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('考生号').IsNull then
  begin
    StuInfo.Show;
    StuInfo.DataSource1DataChange(Self,nil);
  end;
end;

procedure TKsInfoBrowse_All.DBGridEH1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  zy1,zy2:string;
  iLen,iKszt:Integer;
begin
  if (Column.FieldName='备注') then
  begin
    if Column.Field.AsString<>'' then
    begin
      Column.Font.Color := clWhite;
      TDBGridEh(Sender).Canvas.Brush.Color := clRed;
    end;
  end;
  if (Column.FieldName='考生状态') then
  begin
    if not ClientDataSet1.FieldByName('考生状态').IsNull then
    begin
      if ClientDataSet1.FieldByName('考生状态').AsString<>'' then
        iKszt := ClientDataSet1.FieldByName('考生状态').AsInteger
      else
        iKszt := 0;
    end else
      iKszt := 0;
    Case iKszt of
      0: //专业未定
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := $008DB48D;
        //Column.Field.Text := '专业未定';
      end;
      1: //已拟录专业
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := $008DB48D;
        //
      end;
      2: //拟退档考生
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := $00FF80FF;
      end;
      3: //已退档考生
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := clRed;
      end;
      5: //录取专业已确定且已结束的考生
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := clOlive;
      end;
    End;
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

function TKsInfoBrowse_All.GetOrderString: string;
begin
end;

procedure TKsInfoBrowse_All.GetWhereList;
var
  sTemp :string;
begin
  sWhereList.Clear;
  sWhereList.Add(' where 学历层次='+quotedstr(cbb_XlCc.Text));
  if cbb_Lb.Text<>'全部' then
    sWhereList.Add(' and 类别='+quotedstr(cbb_Lb.Text));
  if cbb_KL.Text<>'全部' then
    sWhereList.Add(' and 科类='+quotedstr(cbb_KL.Text));

  if cbb_Sf.Text<>'全部' then
    sWhereList.Add(' and 省份='+quotedstr(cbb_Sf.Text));
  if not dm.IsDisplayJiangXi then
    sWhereList.Add(' and 省份<>'+quotedstr('江西'));

  sTemp := GetFilterString;
  if sTemp<>'' then
    sWhereList.Add(sTemp);
end;

procedure TKsInfoBrowse_All.DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if vsorted then
    Open_Access_Table;
  vsorted := False;
end;

procedure TKsInfoBrowse_All.cbb_CompareChange(Sender: TObject);
begin
  cbb_Value.Enabled := (cbb_Compare.ItemIndex<>7) and (cbb_Compare.ItemIndex<>8);
end;

procedure TKsInfoBrowse_All.cbb_ValueChange(Sender: TObject);
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

procedure TKsInfoBrowse_All.cbb_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_OK.Click;
end;

function TKsInfoBrowse_All.GetFilterString: String;
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

function TKsInfoBrowse_All.GetXznxString: String;
begin
end;

procedure TKsInfoBrowse_All.mmi_ProcessSJRClick(Sender: TObject);
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

procedure TKsInfoBrowse_All.mni_FormatKLClick(Sender: TObject);
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

procedure TKsInfoBrowse_All.mni_SfClick(Sender: TObject);
begin
  if mni_Sf.Checked then
    cbb_sf.Text := ClientDataSet1.FieldByName('省份').AsString
  else
    cbb_Sf.Text := '全部';
end;

procedure TKsInfoBrowse_All.pm_FormatZyClick(Sender: TObject);
var
  xlcc,sf,pc,lb,kl,zydm,zy:string;
//  bm:TBookmark;
begin
  xlcc := ClientDataSet1.FieldByName('学历层次').Asstring;
  sf := ClientDataSet1.FieldByName('省份').Asstring;
  pc := ClientDataSet1.FieldByName('批次名称').Asstring;
  lb := ClientDataSet1.FieldByName('类别').Asstring;//
  kl := ClientDataSet1.FieldByName('科类名称').Asstring;
  zydm := ClientDataSet1.FieldByName('录取代码').Asstring;
  zy := ClientDataSet1.FieldByName('录取专业').Asstring;
  with TFormatZy.Create(Application) do
  begin
    FillData(xlcc,sf,pc,lb,kl,zydm,zy,ClientDataSet1,'在阅考生信息表');
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

procedure TKsInfoBrowse_All.N9Click(Sender: TObject);
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
