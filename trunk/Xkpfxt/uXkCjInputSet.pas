unit uXkCjInputSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TXkCjInputSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Save: TBitBtn;
    btn_Refresh: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    DBGridEh2: TDBGridEh;
    cds_Km: TClientDataSet;
    ds_Km: TDataSource;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure ds_KmDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    function  GetWhere:string;
    function  GetCzyWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable;
    procedure GetXkZyList;
    procedure GetCzyList;
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkCjInputSet: TXkCjInputSet;

implementation
uses uDM;
{$R *.dfm}

procedure TXkCjInputSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TXkCjInputSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkCjInputSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TXkCjInputSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkCjInputSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkCjInputSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from 成绩录入设置表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkCjInputSet.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkCjInputSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('录入院系').AsString := cds_Km.FieldByName('承考院系').AsString;
  DataSet.FieldByName('录入科目').AsString := cds_Km.FieldByName('考试科目').AsString;
  DataSet.FieldByName('录入顺序').AsInteger := 1;
  DataSet.FieldByName('录入状态').AsString := '未提交';
end;

procedure TXkCjInputSet.ds_KmDataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable;
end;

procedure TXkCjInputSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkCjInputSet.FormCreate(Sender: TObject);
begin
  GetYxList;
  Open_Table;
  //GetXkZyList;
end;

procedure TXkCjInputSet.GetCzyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select 操作员编号,操作员姓名 from 操作员表 '+GetCzyWhere);
    DBGridEh1.Columns[3].PickList.Clear;
    DBGridEh1.Columns[3].KeyList.Clear;
    while not cds_Temp.Eof do
    begin
      //sList.Add(cds_Temp.FieldByName('操作员编号').AsString);
      DBGridEh1.Columns[3].PickList.Add(cds_Temp.FieldByName('操作员姓名').AsString+'('+cds_Temp.FieldByName('操作员编号').AsString+')');
      DBGridEh1.Columns[3].KeyList.Add(cds_Temp.FieldByName('操作员编号').AsString);
      cds_Temp.Next;
    end;
    //DBGridEh1.Columns[3].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

function TXkCjInputSet.GetCzyWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where 院系='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  Result := sWhere;
end;

function TXkCjInputSet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  Result := sWhere;
end;

procedure TXkCjInputSet.GetXkZyList;
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

procedure TXkCjInputSet.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      //dm.GetAllYxList(sList);
      //cbb_Yx.Items.Add('不限院系');
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
      //sList.Add('不限院系');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkCjInputSet.Open_DeltaTable;
var
  sWhere:string;
  sqlstr:string;
begin
  sWhere := ' where 录入院系='+quotedstr(cds_Km.FieldByName('承考院系').AsString)+
            ' and 录入科目='+quotedstr(cds_Km.FieldByName('考试科目').AsString);
  sqlstr := 'select * from 成绩录入设置表 '+sWhere+' order by Id';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkCjInputSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考科目表 '+GetWhere+' order by Id';
  cds_Km.XMLData := DM.OpenData(sqlstr);
  GetCzyList;
end;

end.
