unit uXkZyKmSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TXkZyKmSet = class(TForm)
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
    cds_Zy: TClientDataSet;
    ds_Zy: TDataSource;
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
    procedure ds_ZyDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable;
    procedure GetXkZyList;
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkZyKmSet: TXkZyKmSet;

implementation
uses uDM;
{$R *.dfm}

procedure TXkZyKmSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TXkZyKmSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkZyKmSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前科目吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TXkZyKmSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkZyKmSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkZyKmSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from 校考专业科目设置表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkZyKmSet.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkZyKmSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('承考院系').AsString := cds_Zy.FieldByName('承考院系').AsString;
  DataSet.FieldByName('专业').AsString := cds_Zy.FieldByName('专业').AsString;
  DataSet.FieldByName('成绩所占比例').AsInteger := 100;
end;

procedure TXkZyKmSet.ds_ZyDataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable;
end;

procedure TXkZyKmSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkZyKmSet.FormCreate(Sender: TObject);
begin
  GetYxList;
  Open_Table;
  //GetXkZyList;
end;

function TXkZyKmSet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  Result := sWhere;
end;

procedure TXkZyKmSet.GetXkZyList;
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

procedure TXkZyKmSet.GetYxList;
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

procedure TXkZyKmSet.Open_DeltaTable;
var
  sWhere:string;
  sqlstr:string;
begin
  sWhere := ' where 承考院系='+quotedstr(cds_Zy.FieldByName('承考院系').AsString)+
            ' and 专业='+quotedstr(cds_Zy.FieldByName('专业').AsString);
  sqlstr := 'select * from 校考专业科目设置表 '+sWhere+' order by Id';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkZyKmSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考专业表 '+GetWhere+' order by Id';
  cds_Zy.XMLData := DM.OpenData(sqlstr);
  GetXkZyList;
end;

end.
