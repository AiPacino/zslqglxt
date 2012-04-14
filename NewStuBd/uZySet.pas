unit uZySet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, DBCtrls,
  MyDBNavigator, StdCtrls, Buttons, pngimage, ExtCtrls,DBGridEhImpExp,
  frxpngimage, DBGridEhGrouping, Mask, DBCtrlsEh;

type
  TZySet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Close: TBitBtn;
    btn_Save: TBitBtn;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    btn_Export: TBitBtn;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_XlCc: TDBComboBoxEh;
    grp_Lb: TGroupBox;
    cbb_Lb: TDBComboBoxEh;
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure btn_SaveClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExportClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_XlCcChange(Sender: TObject);
  private
    { Private declarations }
    procedure Open_Table;
    procedure GetXqList;
  public
    { Public declarations }
  end;

var
  ZySet: TZySet;

implementation
uses uDM;
{$R *.dfm}

procedure TZySet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TZySet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TZySet.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TZySet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前操作员信息吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TZySet.btn_ExportClick(Sender: TObject);
begin
  DM.ExportDBEditEH(DBGridEh1);
end;

procedure TZySet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 1 * from 专业信息表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TZySet.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
  begin
    Open_Table;
    DBGridEh1.SetFocus;
  end;
end;

procedure TZySet.ClientDataSet1NewRecord(DataSet: TDataSet);
var
  cc,nx:string;
begin
  cc := cbb_XlCc.Text;
  if cc='专科' then nx:='3' else nx:='4';
  DataSet.FieldByName('学历层次').AsString := cc;
  if cbb_Lb.Text<>'全部' then
    DataSet.FieldByName('类别').AsString := cbb_Lb.Text
  else
    DataSet.FieldByName('类别').AsString := '';
  DataSet.FieldByName('学制年限').AsString := nx;
end;

procedure TZySet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TZySet.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.SetXlCcComboBox(cbb_XlCc);
    dm.SetLbComboBox(cbb_Lb,True);
    dm.GetLbList(sList);
    DBGridEh1.Columns[2].PickList.Clear;
    DBGridEh1.Columns[2].PickList.Assign(sList);
    Open_Table;
  finally
    sList.Free;
  end;
end;

procedure TZySet.GetXqList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetXqList(sList);
    DBGridEh1.Columns[10].PickList.Clear;
    DBGridEh1.Columns[10].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;
end;

procedure TZySet.Open_Table;
var
  sqlstr,sWhere :string;
begin
  sWhere := ' where 学历层次='+quotedstr(cbb_XlCc.Text);
  if cbb_Lb.Text<>'全部' then
    sWhere := sWhere+' and 类别='+quotedstr(cbb_Lb.Text);
  if Self.Showing then
    btn_Save.Click;
  sqlstr := 'select * from 专业信息表 '+sWhere;
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

procedure TZySet.RadioGroup1Click(Sender: TObject);
begin
  Open_Table;
end;

end.
