unit uZsjhAdjustEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, uCzyRightGroupSet, uAdjustJhInput,
  Buttons, DB, DBClient,ActnList, CheckLst, Menus, RzPanel, 
  GridsEh, DBGridEh, pngimage, frxpngimage, DBGridEhGrouping, DBCtrlsEh, Mask,
  DBCtrls, dxGDIPlusClasses;

type
  TZsjhAdjustEdit = class(TForm)
    pnl1: TPanel;
    pnl_Main: TPanel;
    pnl7: TPanel;
    cds_Master: TClientDataSet;
    ds_Master: TDataSource;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    cds_Delta: TClientDataSet;
    ds_Delta: TDataSource;
    RzGroupBox1: TRzGroupBox;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btn_Post: TBitBtn;
    GroupBox1: TRzGroupBox;
    chklst1: TCheckListBox;
    DBGridEh2: TDBGridEh;
    GroupBox2: TGroupBox;
    lbl1: TLabel;
    dbedt1: TDBEdit;
    lbl2: TLabel;
    dbedt2: TDBEdit;
    lbl3: TLabel;
    dbedt3: TDBEdit;
    lbl4: TLabel;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    lbl5: TLabel;
    dbedt4: TDBEdit;
    grp_Xlcc: TGroupBox;
    cbb_Xlcc: TDBComboBoxEh;
    btn_Save: TBitBtn;
    ClientDataSet1: TClientDataSet;
    btn_Exit: TBitBtn;
    cds_DeltaId: TIntegerField;
    cds_DeltapId: TStringField;
    cds_DeltaId2: TIntegerField;
    cds_DeltaStringField5: TStringField;
    cds_DeltaSmallintField: TSmallintField;
    cds_DeltaField: TStringField;
    cds_DeltaField2: TStringField;
    cds_DeltaField3: TStringField;
    btn_Edit: TBitBtn;
    pm1: TPopupMenu;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    btn_Refresh: TBitBtn;
    lbl6: TLabel;
    lbl7: TLabel;
    edt_Sf: TDBComboBoxEh;
    edt_Lx: TDBComboBoxEh;
    cds_DeltaField4: TStringField;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_RightGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rg_XlccClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure cds_DeltaNewRecord(DataSet: TDataSet);
    procedure DBGridEh1Exit(Sender: TObject);
    procedure cbb_XlccChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure cds_DeltaCalcFields(DataSet: TDataSet);
    procedure N3Click(Sender: TObject);
    procedure cds_DeltaBeforeClose(DataSet: TDataSet);
    procedure btn_RefreshClick(Sender: TObject);
    procedure ds_MasterDataChange(Sender: TObject; Field: TField);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbedt1Change(Sender: TObject);
    procedure ds_DeltaDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    aForm:TAdjustJhInput;
    myform :TCzyRightGroupSet;
    Old_CzyId:string;
    procedure Open_MasterTable;
    procedure Open_DeltaTable;
    procedure InitRightGroup;
    procedure InitRightTree;
    procedure InitMenuItemCheckByGroup(const sId:string); //用组权限初始化树
    procedure InitMenuItemCheckByCzy(const sCzyId:string);//用操作员权限初始化树

    function  InitMenuTable:Boolean;
    function  ItemInEnabled(const sItem:string):Boolean;
    function  ItemInVisabled(const sItem:string):Boolean;
    procedure GetXqList;
    function  CheckDeltaData:Boolean;
    function  SaveDeltaData:Boolean;
  public
    { Public declarations }
  end;

var
  ZsjhAdjustEdit: TZsjhAdjustEdit;

implementation
uses uDM,uMain,uZyselect,uNewStuLqBdIntf,EncdDecdEx;
{$R *.dfm}

procedure TZsjhAdjustEdit.BitBtn2Click(Sender: TObject);
var
  sNo,sError:string;
begin
  sNo := vobj.GetAdjustJHNo;
  cds_Master.Append;
  cds_Master.FieldByName('Id').Value := sNo;
  cds_Master.FieldByName('学历层次').Value := cbb_Xlcc.Text;
  cds_Master.FieldByName('说明').Value := '请输入调整内容描述';
  cds_Master.FieldByName('申请人').Value := gb_Czy_ID;
  cds_Master.FieldByName('状态').Value := '编辑中';
  cds_Master.FieldByName('申请时间').Value := Now;
  cds_Master.Post;
  edt_Sf.SetFocus;
end;

procedure TZsjhAdjustEdit.BitBtn3Click(Sender: TObject);
var
  Id,sError:string;
begin
  if MessageBox(Handle, '真的要删除当前申请单吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    Id := cds_Master.FieldByName('Id').AsString;
    if vobj.DeleteJH(Id,gb_Czy_ID,sError) then
    begin
      DBGridEh1.SaveBookmark;
      Open_MasterTable;
      if cds_Master.RecordCount>0 then
        DBGridEh1.RestoreBookmark;
    end;
  end;
end;

procedure TZsjhAdjustEdit.btn_AddClick(Sender: TObject);
begin
  aForm.FillData(0,cds_Master.FieldByName('Id').AsString,cbb_Xlcc.Text,edt_sf.Text,edt_Lx.Text,cds_Delta);
  aForm.ShowModal;
end;

procedure TZsjhAdjustEdit.btn_DelClick(Sender: TObject);
begin
  cds_Delta.Delete;
end;

procedure TZsjhAdjustEdit.btn_EditClick(Sender: TObject);
begin
  aForm.FillData(1,cds_Master.FieldByName('Id').AsString,cbb_Xlcc.Text,edt_Sf.Text,edt_Lx.Text,cds_Delta);
  aForm.ShowModal;
end;

procedure TZsjhAdjustEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TZsjhAdjustEdit.btn_PostClick(Sender: TObject);
var
  sId:string;
  sError:string;
begin
  if btn_Save.Enabled then
    btn_SaveClick(Self);
  if MessageBox(Handle, '提交成功不能再对本申请单进行修改，确实要提交吗？　' +
    #13#10, '系统提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 +
    MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  sId := cds_Master.FieldByName('Id').AsString;
  if vobj.PostJH(sId,gb_Czy_ID,sError) then
  begin
    MessageBox(Handle, PChar('调整单提交成功！请等待领导审核！　'), '系统提示', MB_OK + MB_ICONINFORMATION +
      MB_TOPMOST);
    if MessageBox(Handle, '数据提交成功！要打印计划调整申请单吗？　', 
      '系统提示', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
      ClientDataSet1.XMLData := dm.OpenData('select * from View_计划调整主从明细表 where Id='+quotedstr(sId));
      dm.PrintReport('计划调整申请表.fr3',ClientDataSet1.XMLData,1);
    end;
    Open_MasterTable;
  end else
    MessageBox(Handle, PChar('调整单提交失败！'+sError), '系统提示', MB_OK + MB_ICONSTOP +
      MB_TOPMOST);
end;

procedure TZsjhAdjustEdit.btn_printClick(Sender: TObject);
var
  sId:string;
begin
  sId := cds_Master.FieldByName('Id').AsString;
  ClientDataSet1.XMLData := dm.OpenData('select * from view_计划调整明细表 where Id='+quotedstr(sId));
  dm.PrintReport('计划调整申请表.fr3',ClientDataSet1.XMLData,1);
end;

procedure TZsjhAdjustEdit.btn_RefreshClick(Sender: TObject);
begin
  DBGridEh1.SaveBookmark;
  Open_MasterTable;
  DBGridEh1.RestoreBookmark;
end;

procedure TZsjhAdjustEdit.btn_RightGroupClick(Sender: TObject);
var
  t,l:Integer;
begin
  t := Self.Top;
  l := Self.Left;
  with TCzyRightGroupSet.Create(Self) do
  begin
    Top := t-50;
    Left := l+80;
    ShowModal;
  end;
end;

procedure TZsjhAdjustEdit.btn_SaveClick(Sender: TObject);
begin
  SaveDeltaData;
end;

procedure TZsjhAdjustEdit.cbb_XlccChange(Sender: TObject);
begin
  Open_MasterTable;
end;

procedure TZsjhAdjustEdit.cds_DeltaBeforeClose(DataSet: TDataSet);
begin
  if DataSetNoSave(cds_Delta) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　' + #13#10, 
      '系统提示', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
    begin
      btn_SaveClick(Self);
    end else
    begin
      DBGridEh1.SaveBookmark;
      Open_MasterTable;
      DBGridEh1.RestoreBookmark;
    end;
end;

procedure TZsjhAdjustEdit.cds_DeltaCalcFields(DataSet: TDataSet);
var
  sqlstr,sZyId:string;
begin
  DataSet.FieldByName('学历层次').AsString := cbb_Xlcc.Text;
  sZyId := DataSet.FieldByName('专业Id').AsString;
  if sZyId='' then Exit;

  sqlstr := 'select * from 专业信息表 where Id='+sZyId;
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);

  DataSet.FieldByName('类别').AsString := ClientDataSet1.FieldByName('类别').AsString;
  DataSet.FieldByName('专业').AsString := ClientDataSet1.FieldByName('专业').AsString;
end;

procedure TZsjhAdjustEdit.cds_DeltaNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('pid').Value := cds_Master.FieldByName('id').Value;
end;

function TZsjhAdjustEdit.CheckDeltaData: Boolean;
var
  s:Integer;
begin
  cds_Delta.DisableControls;
  DBGridEh2.SaveBookmark;
  try
    cds_Delta.First;
    s := 0;
    while not cds_Delta.Eof do
    begin
      s := s+cds_Delta.FieldByName('增减数').AsInteger;
      cds_Delta.Next;
    end;
    Result := (s=0);
    if not Result then
      Application.MessageBox('调入调出计划数不平衡，无法保存或提交！',
        '系统提示', MB_OK + MB_ICONWARNING + MB_TOPMOST);

  finally
    DBGridEh2.RestoreBookmark;
    cds_Delta.EnableControls;
  end;
end;

procedure TZsjhAdjustEdit.dbedt1Change(Sender: TObject);
var
  bl:Boolean;
begin
  bl := (dbedt1.Text<>'') and (dbedt2.Text<>'') and (dbedt3.Text<>'') and (dbedt4.Text<>'') and
        (edt_sf.Text<>'') and (edt_Lx.Text<>'') and (DBDateTimeEditEh1.Text<>'');
  btn_Add.Enabled := bl;
  btn_Post.Enabled := bl;
end;

procedure TZsjhAdjustEdit.DBGridEh1Exit(Sender: TObject);
begin
  if cds_Master.State in [dsInsert,dsEdit] then
    cds_Master.Post;
end;

procedure TZsjhAdjustEdit.ds_DeltaDataChange(Sender: TObject; Field: TField);
begin
  btn_Edit.Enabled := cds_Delta.RecordCount>0;
  btn_Save.Enabled := btn_Edit.Enabled;
  btn_Del.Enabled := btn_Edit.Enabled;
end;

procedure TZsjhAdjustEdit.ds_MasterDataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable;
end;

function TZsjhAdjustEdit.InitMenuTable:Boolean;
begin
end;

procedure TZsjhAdjustEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TZsjhAdjustEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if DataSetNoSave(cds_Delta) then
    if Application.MessageBox('数据已修改但尚未保存！要保存吗？', '系统提示',
      MB_YESNO + MB_ICONWARNING) = IDNO then
    begin
      CanClose := True
    end else
    begin
      CanClose := False;
    end;
end;

procedure TZsjhAdjustEdit.FormCreate(Sender: TObject);
var
  sList:TStrings;
  i:integer;
begin
  DBGridEh2.FieldColumns['增减数'].KeyList.Clear;
  DBGridEh2.FieldColumns['增减数'].PickList.Clear;
  for i := -20 to 20 do
  begin
    DBGridEh2.FieldColumns['增减数'].KeyList.Add(IntToStr(i));
    if i>0 then
      DBGridEh2.FieldColumns['增减数'].PickList.Add('+'+IntToStr(i))
    else
      DBGridEh2.FieldColumns['增减数'].PickList.Add(IntToStr(i));
  end;

  aForm := TAdjustJhInput.Create(Self);
  dm.SetXlCcComboBox(cbb_Xlcc);
  sList := TStringList.Create;
  try
    dm.GetSfList(sList);
    edt_Sf.Items.Assign(sList);
    DBGridEh2.Columns[2].PickList.Assign(sList);

    DM.GetKLList(sList);
    DBGridEh2.Columns[4].PickList.Assign(sList);
    Open_MasterTable;
  finally
    sList.Free;
  end;
end;

procedure TZsjhAdjustEdit.FormDestroy(Sender: TObject);
begin
//  if Assigned(myform) then
//    FreeAndNil(myform);
  aForm.Free;
end;

procedure TZsjhAdjustEdit.GetXqList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetXqList(sList);
    DBGridEh1.Columns[5].PickList.Clear;
    DBGridEh1.Columns[5].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;

end;

procedure TZsjhAdjustEdit.InitMenuItemCheckByCzy(const sCzyId: string);
begin
end;

procedure TZsjhAdjustEdit.InitMenuItemCheckByGroup(const sId: string);
begin
end;

procedure TZsjhAdjustEdit.InitRightGroup;
begin
end;

procedure TZsjhAdjustEdit.InitRightTree;
begin
end;

function TZsjhAdjustEdit.ItemInEnabled(const sItem: string): Boolean;
begin
end;

function TZsjhAdjustEdit.ItemInVisabled(const sItem: string): Boolean;
begin
end;

procedure TZsjhAdjustEdit.N3Click(Sender: TObject);
begin
  Open_DeltaTable;
end;

procedure TZsjhAdjustEdit.Open_MasterTable;
var
  sWhere:string;
begin
  sWhere := ' where 申请人='+quotedstr(gb_Czy_ID)+
            ' and 学历层次='+quotedstr(cbb_Xlcc.Text)+
            ' and 状态='+quotedstr('编辑中');

  cds_Master.DisableControls;
  try
    cds_Master.XMLData := DM.OpenData('select * from 计划调整表 '+sWhere+' order by Id');
  finally
    cds_Master.EnableControls;
  end;
end;

procedure TZsjhAdjustEdit.Open_DeltaTable;
var
  sWhere,sId:string;
  sqlstr:string;
begin
  sId := cds_Master.FieldByName('Id').AsString;
  sWhere := ' where pid='+quotedstr(sId);

  cds_Delta.DisableControls;
  try
    sqlstr := 'select * from 计划调整明细表 '+sWhere;
    cds_Delta.XMLData := DM.OpenData(sqlstr);
  finally
    cds_Delta.EnableControls;
  end;
end;

procedure TZsjhAdjustEdit.rg_XlccClick(Sender: TObject);
begin
  Open_MasterTable;
end;


function TZsjhAdjustEdit.SaveDeltaData: Boolean;
var
  sId,Xlcc,Sf,Czlx,sWhy,sDelta:string;
  sError:string;
begin
  Result := False;
  sId := cds_Master.FieldByName('Id').AsString;
  Xlcc := cds_Master.FieldByName('学历层次').AsString;
  sWhy := cds_Master.FieldByName('说明').AsString;
  Sf := cds_Master.FieldByName('省份').AsString;
  Czlx := cds_Master.FieldByName('类型').AsString;

  if DataSetNoSave(cds_Delta) then
  begin
    sDelta := cds_Delta.XMLData;
    if gb_Use_Zip then
    begin
      sDelta := dm.VCLZip1.ZLibCompressString(sDelta);
      sDelta := EncodeString(sDelta);
    end;
  end;
  if not CheckDeltaData then
  begin
    Exit;
  end;

  if vobj.AdjustJH(sId,Xlcc,Sf,Czlx,sWhy,gb_Czy_ID,sDelta,sError) then
  begin
    cds_Master.MergeChangeLog;
    cds_Delta.MergeChangeLog;
    Result := True;
  end else
    MessageBox(Handle, PChar('调整单保存失败！'+sError), '系统提示', MB_OK + MB_ICONSTOP +
      MB_TOPMOST);
{
  if DataSetNoSave(cds_Master) then
    if DM.UpdateData('id','select top 0 * from 计划调整表',cds_Master.Delta,False) then
      cds_Master.MergeChangeLog;

  if DataSetNoSave(cds_Delta) then
    if DM.UpdateData('id','select top 0 * from 计划调整明细表',cds_Delta.Delta,False) then
      cds_Delta.MergeChangeLog;
}
end;

end.
