unit uExportFieldListSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB,
  DBClient, Mask, DBCtrlsEh, DBCtrls;

type
  TExportFieldListSet = class(TForm)
    Panel1: TPanel;
    btn_Save: TBitBtn;
    btn_Close: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGridEh1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Memo1: TDBMemo;
    Label1: TLabel;
    DBEditEh1: TDBEditEh;
    lbl1: TLabel;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    lbl2: TLabel;
    DBEditEh2: TDBEditEh;
    chk_Edit: TCheckBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure chk_EditClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TExportFieldListSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TExportFieldListSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TExportFieldListSet.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TExportFieldListSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前配置记录吗？　', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
  end;
end;

procedure TExportFieldListSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from 导出信息配置表',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TExportFieldListSet.chk_EditClick(Sender: TObject);
begin
  DBEditEh1.ReadOnly := not chk_Edit.Checked;
  DBEditEh2.ReadOnly := not chk_Edit.Checked;
  Memo1.ReadOnly := not chk_Edit.Checked;
  btn_Add.Enabled := chk_Edit.Checked;
  btn_Cancel.Enabled := chk_Edit.Checked;
  btn_Del.Enabled := chk_Edit.Checked;
end;

procedure TExportFieldListSet.ClientDataSet1BeforePost(DataSet: TDataSet);
var
  sqlstr:string;
  i:integer;
begin
  sqlstr := '';
  for i := 0 to Memo1.Lines.Count - 1 do
    sqlstr := sqlstr+Memo1.Lines[i];
  if (sqlstr<>ClientDataSet1.FieldByName('内容').Asstring) then
  begin
    ClientDataSet1.FieldByName('内容').AsString := sqlstr;
  end;
end;

procedure TExportFieldListSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TExportFieldListSet.FormCreate(Sender: TObject);
begin
  ClientDataSet1.XMLData := DM.OpenData('select * from 导出信息配置表 order by Id');
end;

end.
