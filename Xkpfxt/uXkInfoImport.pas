unit uXkInfoImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping, Menus,
  dxGDIPlusClasses;

type
  TXkInfoImport = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    ds_ksxx: TDataSource;
    cds_ksxx: TClientDataSet;
    Splitter1: TSplitter;
    btn_Import_ksxx: TBitBtn;
    btn_Empty: TBitBtn;
    DBGridEh1: TDBGridEh;
    pm1: TPopupMenu;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    mi_ZyFormat: TMenuItem;
    mi_DelMoreRecord: TMenuItem;
    btn_Import_bkxx: TBitBtn;
    pnl1: TPanel;
    grp1: TGroupBox;
    DBGridEh2: TDBGridEh;
    grp2: TGroupBox;
    DBGridEh3: TDBGridEh;
    ds_bkxx: TDataSource;
    cds_bkxx: TClientDataSet;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btn_Import_ksxxClick(Sender: TObject);
    procedure cds_ksxxNewRecord(DataSet: TDataSet);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_EmptyClick(Sender: TObject);
    procedure mi_DelMoreRecordClick(Sender: TObject);
    procedure mi_ZyFormatClick(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
    procedure ds_ksxxDataChange(Sender: TObject; Field: TField);
    procedure btn_Import_bkxxClick(Sender: TObject);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable(const ShowHint:Boolean=False);
    procedure Open_DeltaTable2;
    procedure GetSfList;
    procedure GetXkZyList;
    procedure SaveData;
  public
    { Public declarations }
  end;

var
  XkInfoImport: TXkInfoImport;

implementation
uses uDM,uXkDataImport,uFormatBkZy;
{$R *.dfm}

procedure TXkInfoImport.btn_Import_bkxxClick(Sender: TObject);
var
  sf,kd:string;
begin
  sf := ClientDataSet1.FieldByName('省份').asstring;
  kd := ClientDataSet1.FieldByName('考点名称').asstring;
  if MessageBox(Handle, PChar('确实要导入【'+kd+'】考点的考生报考信息吗？　　'), '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  with TXkDataImport.Create(nil) do
  begin
    Init_DescData(sf,kd,cbb_Yx.Text,'校考考生报考专业表',cds_bkxx.XMLData);
    ShowModal;
    Open_DeltaTable;
  end;
end;

procedure TXkInfoImport.btn_AddClick(Sender: TObject);
begin
  cds_ksxx.Append;
  DBGridEh2.SetFocus;
end;

procedure TXkInfoImport.btn_CancelClick(Sender: TObject);
begin
  cds_ksxx.Cancel;
end;

procedure TXkInfoImport.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　　', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  cds_ksxx.Delete;
end;

procedure TXkInfoImport.btn_EmptyClick(Sender: TObject);
var
  sqlstr,sf,yx,kd,sWhere:string;
begin
  sf := ClientDataSet1.FieldByName('省份').AsString;
  yx := ClientDataSet1.FieldByName('承考院系').Asstring;
  kd := ClientDataSet1.FieldByName('考点名称').Asstring;

  if MessageBox(Handle, '真的要清空当前考点下的所有考生报考信息吗？　' +
    #13#10#13#10 + '执行这一操作后已删除的数据将无法复原！' + #13#10 +
    #13#10 + '还要继续删除吗？', '系统提示', MB_YESNO + MB_ICONWARNING +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  if LowerCase(InputBox('删除确认','请输入[OK]两个字符：',''))<>'ok' then
    Exit;
  sWhere := ' where 承考院系='+quotedstr(yx)+' and 省份='+quotedstr(sf)+' and 考点名称='+quotedstr(kd);
  sqlstr := 'delete from 校考考生报考专业表 where 考生号 in (select 考生号 from 校考考生信息表 '+sWhere+')';
  dm.ExecSql(sqlstr);

  sqlstr := 'delete from 校考考生信息表 '+sWhere;
  dm.ExecSql(sqlstr);
  Open_DeltaTable;
end;

procedure TXkInfoImport.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkInfoImport.btn_Import_ksxxClick(Sender: TObject);
var
  sf,kd:string;
begin
  sf := ClientDataSet1.FieldByName('省份').asstring;
  kd := ClientDataSet1.FieldByName('考点名称').asstring;
  if MessageBox(Handle, PChar('确实要导入【'+kd+'】考点的考生基本信息吗？　　'), '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  with TXkDataImport.Create(nil) do
  begin
    Init_DescData(sf,kd,cbb_Yx.Text,'校考考生信息表',cds_ksxx.XMLData);
    ShowModal;
    Open_DeltaTable;
  end;
end;

procedure TXkInfoImport.btn_RefreshClick(Sender: TObject);
begin
  //SaveData;
  Open_Table;
end;

procedure TXkInfoImport.btn_SaveClick(Sender: TObject);
begin
  SaveData;
end;

procedure TXkInfoImport.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoImport.cds_ksxxNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('承考院系').AsString := cbb_Yx.Text;
  DataSet.FieldByName('省份').AsString := ClientDataSet1.FieldByName('省份').AsString;
  DataSet.FieldByName('考点名称').AsString := ClientDataSet1.FieldByName('考点名称').AsString;
end;

procedure TXkInfoImport.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable(ClientDataSet1.FieldByName('人数').AsInteger>3000);
end;

procedure TXkInfoImport.ds_ksxxDataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable2;
end;

procedure TXkInfoImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(cds_ksxx) then
  begin
    if MessageBox(Handle, '数据已更新但尚未保存！要保存吗？　', '系统提示', 
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
    begin
      SaveData;
    end;
  end;
  Action := caFree;
end;

procedure TXkInfoImport.FormCreate(Sender: TObject);
begin
  dm.GetYxList(cbb_Yx);
end;

procedure TXkInfoImport.GetSfList;
begin
end;

function TXkInfoImport.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where 状态='+quotedstr('已审核')+' and 承考院系='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 状态='+quotedstr('已审核');
  Result := sWhere;
end;

procedure TXkInfoImport.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select 考试科目 from 校考科目表 '+GetWhere);
    DBGridEh1.Columns[3].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('考试科目').AsString);
      cds_Temp.Next;
    end;
    DBGridEh1.Columns[3].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkInfoImport.mi_ZyFormatClick(Sender: TObject);
var
  vsf,vYx,vKd,vZy:string;
begin
  with TFormatBkZy.Create(nil) do
  begin
    vsf := cds_ksxx.FieldByName('省份').AsString;
    vYx := cbb_Yx.Text;//cds_ksxx.FieldByName('承考院系').AsString;
    vKd := cds_ksxx.FieldByName('考点名称').AsString;
    vZy := cds_ksxx.FieldByName('专业').AsString;
    FillData(vSf, vYx, vKd, vZy,cds_ksxx);
    ShowModal;
  end;
end;

procedure TXkInfoImport.mi_DelMoreRecordClick(Sender: TObject);
var
  sqlstr,where:string;
  sf,yx,kd:string;
begin
  sf := ClientDataSet1.FieldByName('省份').AsString;
  yx := ClientDataSet1.FieldByName('承考院系').Asstring;
  kd := ClientDataSet1.FieldByName('考点名称').Asstring;

  if MessageBox(Handle, '真的要删除重复的报考记录吗？这一操作执行后' + #13#10
    + '是无法撤消的，还要执行吗？', '系统提示', MB_YESNO + MB_ICONWARNING +
    MB_DEFBUTTON2 + MB_TOPMOST) <> IDYES then
  begin
    Exit;
  end;
  where := 'where 承考院系='+quotedstr(yx)+' and 省份='+quotedstr(sf)+' and 考点名称='+quotedstr(kd);
  sqlstr := 'delete from 校考考生报考专业表 where id in '+
            ' (select max(id) from 校考考生报考专业表 '+where+
            ' group by 考生号,准考证号,专业 having count(*)>1)';
  if dm.ExecSql(sqlstr) then
  begin
    MessageBox(Handle, '执行完成！当前考点的重复的报考记录已删除！', '系统提示',
      MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST);
    Open_DeltaTable(ClientDataSet1.FieldByName('人数').AsInteger>3000);
  end;
end;

procedure TXkInfoImport.Open_DeltaTable(const ShowHint:Boolean=False);
var
  sqlstr,sf,yx,kd:string;
begin
  sf := ClientDataSet1.FieldByName('省份').AsString;
  yx := ClientDataSet1.FieldByName('承考院系').Asstring;
  kd := ClientDataSet1.FieldByName('考点名称').Asstring;

  sqlstr := 'select * from 校考考生信息表 where 省份='+quotedstr(sf)+' and 考点名称='+quotedstr(kd)+
            ' and 承考院系='+quotedstr(yx);
  cds_ksxx.XMLData := dm.OpenData(sqlstr,ShowHint);
end;

procedure TXkInfoImport.Open_DeltaTable2;
var
  sqlstr,ksh:string;
begin
  ksh := cds_ksxx.FieldByName('考生号').AsString;

  sqlstr := 'select * from 校考考生报考专业表 where 考生号='+quotedstr(ksh);
  cds_bkxx.XMLData := dm.OpenData(sqlstr);
end;

procedure TXkInfoImport.Open_Table;
var
  sqlstr:string;
begin
  try
    ClientDataSet1.DisableControls;
    sqlstr := 'select * from view_校考考点设置表 '+GetWhere+' order by 省份,考点名称';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  finally
    ClientDataSet1.EnableControls;
  end;
end;

procedure TXkInfoImport.pm1Popup(Sender: TObject);
begin
  mi_ZyFormat.Enabled := not cds_ksxx.FieldByName('Id').IsNull;
  mi_DelMoreRecord.Enabled := mi_ZyFormat.Enabled;
end;

procedure TXkInfoImport.SaveData;
begin
  if DataSetNoSave(cds_ksxx) then
    if dm.UpdateData('Id','select top 0 * from 校考考生报考专业表 ',cds_ksxx.Delta) then
      cds_ksxx.MergeChangeLog;
end;

end.
