unit uXkInfoInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,uXkInfoEdit,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping,
  dxGDIPlusClasses;

type
  TXkInfoInput = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    DataSource2: TDataSource;
    ClientDataSet2: TClientDataSet;
    DBGridEh2: TDBGridEh;
    Splitter1: TSplitter;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Edit: TBitBtn;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btn_ImportClick(Sender: TObject);
    procedure ClientDataSet2NewRecord(DataSet: TDataSet);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    aForm:TXkInfoEdit;
    function  GetWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable;
    procedure GetSfList;
    procedure GetXkZyList;
    procedure GetYxList;
    procedure ShowEditForm(const IsAdd:Boolean);
  public
    { Public declarations }
  end;

var
  XkInfoInput: TXkInfoInput;

implementation
uses uDM,uXkDataImport;
{$R *.dfm}

procedure TXkInfoInput.btn_AddClick(Sender: TObject);
begin
  ShowEditForm(True);
end;

procedure TXkInfoInput.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet2.Cancel;
end;

procedure TXkInfoInput.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　　', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  ClientDataSet2.Delete;
  btn_SaveClick(Self);
end;

procedure TXkInfoInput.btn_EditClick(Sender: TObject);
begin
  ShowEditForm(False);
end;

procedure TXkInfoInput.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkInfoInput.btn_ImportClick(Sender: TObject);
var
  sf,kd:string;
begin
  sf := ClientDataSet1.FieldByName('省份').asstring;
  kd := ClientDataSet1.FieldByName('考点名称').asstring;
  if MessageBox(Handle, PChar('确实要导入【'+sf+' '+kd+'】的考生信息吗？　　'), '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  with TXkDataImport.Create(nil) do
  begin
    Init_DescData(sf,kd,cbb_Yx.Text,ClientDataSet2.XMLData);
    ShowModal;
    Open_DeltaTable;
  end;
end;

procedure TXkInfoInput.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoInput.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet2) then
    if dm.UpdateData('Id','select top 1 * from 校考考生报考专业表 ',ClientDataSet2.Delta) then
      ClientDataSet2.MergeChangeLog;
end;

procedure TXkInfoInput.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoInput.ClientDataSet2NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('承考院系').AsString := cbb_Yx.Text;
  DataSet.FieldByName('省份').AsString := ClientDataSet1.FieldByName('省份').AsString;
  DataSet.FieldByName('考点名称').AsString := ClientDataSet1.FieldByName('考点名称').AsString;
end;

procedure TXkInfoInput.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable;
end;

procedure TXkInfoInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkInfoInput.FormCreate(Sender: TObject);
begin
  aForm := TXkInfoEdit.Create(Self);
  GetYxList;
  Open_Table;
end;

procedure TXkInfoInput.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure TXkInfoInput.GetSfList;
begin
end;

function TXkInfoInput.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where 状态='+quotedstr('已审核')+' and 承考院系='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 状态='+quotedstr('已审核');
  Result := sWhere;
end;

procedure TXkInfoInput.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select 专业 from 校考专业表 where 承考院系='+quotedstr(cbb_Yx.Text)+' order by id');
    aForm.edt_zy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
    aForm.edt_zy.Items.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkInfoInput.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    //if gb_Czy_Level<>'2' then
    begin
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
    end;// else
    //  sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkInfoInput.Open_DeltaTable;
var
  sqlstr,sf,yx,kd:string;
begin
  sf := ClientDataSet1.FieldByName('省份').AsString;
  yx := ClientDataSet1.FieldByName('承考院系').Asstring;
  kd := ClientDataSet1.FieldByName('考点名称').Asstring;

  sqlstr := 'select * from 校考考生报考专业表 where 承考院系='+quotedstr(yx)+' and 省份='+quotedstr(sf)+' and 考点名称='+quotedstr(kd);
  ClientDataSet2.XMLData := dm.OpenData(sqlstr);
end;

procedure TXkInfoInput.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考考点设置表 '+GetWhere+' order by 省份,考点名称';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkInfoInput.ShowEditForm(const IsAdd: Boolean);
var
  yx,sf,kdmc,zkzh:string;
begin
  yx := cbb_Yx.Text;
  sf := ClientDataSet2.FieldByName('省份').AsString;
  kdmc := ClientDataSet2.FieldByName('考点名称').AsString;
  zkzh := ClientDataSet2.FieldByName('准考证号').AsString;
  GetXkZyList;
  aForm.SetParam(zkzh,IsAdd);

  aForm.ShowModal;

end;

end.
