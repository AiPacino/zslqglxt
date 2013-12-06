unit uXkKdSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, uXkKdEdit, DBGridEhGrouping;

type
  TXkKdSet = class(TForm)
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
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    btn_print: TBitBtn;
    btn_Post: TBitBtn;
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
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btn_PostClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    { Private declarations }
    XkKdEdit: TXkKdEdit;
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
    procedure GetXkZyList;
  public
    { Public declarations }
  end;

var
  XkKdSet: TXkKdSet;

implementation
uses uDM, uVobj;
{$R *.dfm}

procedure TXkKdSet.btn_AddClick(Sender: TObject);
begin
  XkKdEdit.SetEditType(0);
  XkKdEdit.ShowModal;
end;

procedure TXkKdSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKdSet.btn_DelClick(Sender: TObject);
var
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('状态').IsNull or (ClientDataSet1.FieldByName('状态').AsString='编辑中');
  if not bl then
  begin
    MessageBox(Handle, '考点信息已提交，不能再进行修改！　', '系统提示', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;

  if MessageBox(Handle, '真的要删除当前考点吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if dm.GetRecordCountBySql('select count(*) from 校考考生报考专业表 where 考点名称='+quotedstr(ClientDataSet1.FieldByName('考点名称').AsString))>0 then
      MessageBox(Handle, '当前考点已存在考生报考信息，考点不能被删除！　　','系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST)
    else
    begin
      ClientDataSet1.Delete;
      btn_Save.Click;
    end;
  end;
end;

procedure TXkKdSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKdSet.btn_PostClick(Sender: TObject);
begin
  if MessageBox(Handle, '数据提交后将不能再修改了！确定要提交吗？　', 
    '系统提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDYES then
  begin
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      if ClientDataSet1.FieldByName('状态').asstring = '编辑中' then
      begin
        ClientDataSet1.Edit;
        ClientDataSet1.FieldByName('状态').asstring := '审核中';
        ClientDataSet1.Post;
      end;
      ClientDataSet1.Next;
    end;
    btn_Save.Click;
    btn_Refresh.Click;
  end;

end;

procedure TXkKdSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKdSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from 校考考点设置表 ',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkKdSet.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKdSet.ClientDataSet1BeforePost(DataSet: TDataSet);
  function FieldIsNull(const sField:string):Boolean;
  begin
    if DataSet.FieldByName(sField).AsString='' then
    begin
      MessageBox(Handle, PChar('无法保存！【'+sField+'】字段不能为空！　'), '系统提示',
        MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Abort;
      Result := True;
    end else
      Result := False;;
  end;
begin
  if FieldIsNull('考点名称') then Exit;
  if FieldIsNull('报考开始时间') then Exit;
  if FieldIsNull('报考截止时间') then Exit;
  if FieldIsNull('联系人') then Exit;
  if FieldIsNull('联系电话') then Exit;
  DataSet.FieldByName('报考开始时间').AsString := FormatDateTime('yyyy-mm-dd 00:00',DataSet.FieldByName('报考开始时间').AsDateTime);
  DataSet.FieldByName('报考截止时间').AsString := FormatDateTime('yyyy-mm-dd 23:59',DataSet.FieldByName('报考截止时间').AsDateTime);
  DataSet.FieldByName('考试开始时间').AsString := FormatDateTime('yyyy-mm-dd 00:00',DataSet.FieldByName('考试开始时间').AsDateTime);
  DataSet.FieldByName('考试截止时间').AsString := FormatDateTime('yyyy-mm-dd 23:59',DataSet.FieldByName('考试截止时间').AsDateTime);
end;

procedure TXkKdSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('承考院系').AsString := cbb_Yx.Text;
  DataSet.FieldByName('报考开始时间').AsDateTime := Date;
  DataSet.FieldByName('报考截止时间').AsDateTime := Date;
  DataSet.FieldByName('考试开始时间').AsDateTime := Date;
  DataSet.FieldByName('考试截止时间').AsDateTime := Date;
  DataSet.FieldByName('操作员').AsString := gb_Czy_ID;
  DataSet.FieldByName('状态').AsString := '编辑中';
end;

procedure TXkKdSet.DataSource1DataChange(Sender: TObject; Field: TField);
var
  //state:string;
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('状态').IsNull or (ClientDataSet1.FieldByName('状态').AsString='编辑中');
  DBGridEh1.ReadOnly := True;//not bl;
  //btn_Add.Enabled := bl;
  btn_Del.Enabled := bl;
  btn_Save.Enabled := bl;
  //btn_print.Enabled := bl;
end;

procedure TXkKdSet.DBGridEh1DblClick(Sender: TObject);
var
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('状态').IsNull or (ClientDataSet1.FieldByName('状态').AsString='编辑中');
  if not bl then
    MessageBox(Handle, '考点信息已提交，不能再进行修改！　', '系统提示', MB_OK
      + MB_ICONSTOP + MB_TOPMOST)
  else
  begin
    XkKdEdit.SetEditType(1);
    XkKdEdit.ShowModal;
  end;
end;

procedure TXkKdSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkKdSet.FormCreate(Sender: TObject);
begin
  XkKdEdit := TXkKdEdit.Create(nil);
  XkKdEdit.DataSource1.DataSet := ClientDataSet1;
  dm.GetYxList(cbb_Yx);
  Open_Table;
  GetSfList;
end;

procedure TXkKdSet.FormDestroy(Sender: TObject);
begin
  XkKdEdit.Free;
end;

procedure TXkKdSet.GetSfList;
begin
end;

function TXkKdSet.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text);//+' and 状态<>'+quotedstr('已审核')
  Result := sWhere;
end;

procedure TXkKdSet.GetXkZyList;
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

procedure TXkKdSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考考点设置表 '+GetWhere+' order by 省份,考点名称';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
