unit uWorkSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, DBCtrls, uWorkInput,
  MyDBNavigator, StdCtrls, Buttons, pngimage, ExtCtrls,DBGridEhImpExp,
  frxpngimage, DBGridEhGrouping, Mask, DBCtrlsEh, RzLstBox;

type
  TWorkSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Close: TBitBtn;
    btn_Save: TBitBtn;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    btn_Export: TBitBtn;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Edit: TBitBtn;
    GroupBox2: TGroupBox;
    lst_Sf: TRzListBox;
    btn_Refresh: TBitBtn;
    chk_Edit: TCheckBox;
    pnl2: TPanel;
    pnl3: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    DBGridEh1: TDBGridEh;
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExportClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure cbb_SfChange(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure cbb_XlccChange(Sender: TObject);
    procedure lst_SfClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure chk_EditClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
    aForm :TWorkInput;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  WorkSet: TWorkSet;

implementation
uses uDM;
{$R *.dfm}

procedure TWorkSet.btn_AddClick(Sender: TObject);
//var
//  vXlCc,vSf:string;
begin
{  vXlCc := cbb_Xlcc.Text;
  if lst_Sf.ItemIndex>0 then
    vSf := lst_Sf.Items[lst_Sf.ItemIndex];
  aForm.FillData(vXlcc,vSf,ClientDataSet1,0);
  aForm.ShowModal;
}
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TWorkSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TWorkSet.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TWorkSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TWorkSet.btn_EditClick(Sender: TObject);
//var
//  vXlCc,vSf:string;
begin
{
  vXlCc := cbb_Xlcc.Text;
  vSf := ClientDataSet1.FieldByName('省份').AsString;
  aForm.FillData(vXlcc,vSf,ClientDataSet1,1);
  aForm.ShowModal;
}
  ClientDataSet1.Edit;
  DBGridEh1.SetFocus;
end;

procedure TWorkSet.btn_ExportClick(Sender: TObject);
begin
  DM.ExportDBEditEH(DBGridEh1);
end;

procedure TWorkSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TWorkSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from 工作安排表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TWorkSet.cbb_SfChange(Sender: TObject);
begin
  if Self.Showing then
  begin
    Open_Table;
    DBGridEh1.SetFocus;
  end;
end;

procedure TWorkSet.cbb_XlccChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TWorkSet.chk_EditClick(Sender: TObject);
begin
  DBGridEh1.ReadOnly := not chk_Edit.Checked;
  DBEditEh1.ReadOnly := not chk_Edit.Checked;
  DBEditEh2.ReadOnly := not chk_Edit.Checked;

  btn_Add.Enabled := chk_Edit.Checked;
  btn_Edit.Enabled := chk_Edit.Checked;
  btn_Del.Enabled := chk_Edit.Checked;
end;

procedure TWorkSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  if lst_Sf.ItemIndex>0 then
    DataSet.FieldByName('省份').Value := lst_Sf.Items[lst_Sf.ItemIndex];
  DataSet.FieldByName('开始日期').Value := FormatDateTime('yyyy-mm-dd',now);
  DataSet.FieldByName('省控线类型').Value := '文化线';
  DataSet.FieldByName('联系方式').Value := '';
end;

procedure TWorkSet.DBGridEh1DblClick(Sender: TObject);
begin
  btn_Edit.Click;
end;

procedure TWorkSet.DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  if gdFocused in State then Exit;
  if Column.FieldName<>'状态' then Exit;

  if ClientDataSet1.FieldByName('状态').AsString='已结束' then
      TDBGridEh(Sender).Canvas.Brush.Color := clYellow
  else if ClientDataSet1.FieldByName('状态').AsString='征集中' then
      TDBGridEh(Sender).Canvas.Brush.Color := $00D392C1
  else if ClientDataSet1.FieldByName('状态').AsString='录取中' then
      TDBGridEh(Sender).Canvas.Brush.Color := clGreen;

  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);
end;

procedure TWorkSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TWorkSet.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    aForm := TWorkInput.Create(nil);
    dm.GetSfList(sList);
    DBGridEh1.Columns[1].PickList.Assign(sList);

    dm.GetXlCcList(sList);
    DBGridEh1.Columns[2].PickList.Assign(sList);

    dm.GetLbList(sList);
    DBGridEh1.Columns[5].PickList.Assign(sList);

    dm.GetSfList(sList,True);
    lst_Sf.Items.Assign(sList);
    lst_sf.ItemIndex := 0;
    Open_Table;
  finally
    sList.Free;
  end;
end;

procedure TWorkSet.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure TWorkSet.lst_SfClick(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TWorkSet.Open_Table;
var
  sqlstr,sWhere :string;
begin
  sWhere := 'where 1>0';
  if lst_Sf.ItemIndex>0 then
    sWhere := sWhere+' and 省份='+quotedstr(lst_Sf.Items[lst_Sf.ItemIndex]);
  sqlstr := 'select * from 工作安排表 '+sWhere+' order by 省份,学历层次';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
