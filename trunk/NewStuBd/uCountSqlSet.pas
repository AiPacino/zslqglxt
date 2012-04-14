unit uCountSqlSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, DB, DBClient, Buttons,StrUtils,
  ExtCtrls, GridsEh, DBGridEh, MyDBNavigator, DBCtrlsEh, DBGridEhGrouping, Menus;

type
  TCountSqlSet = class(TForm)
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    grp1: TGroupBox;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    cds_Temp: TClientDataSet;
    ds_Temp: TDataSource;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBMemo1: TDBMemo;
    btn_Save: TBitBtn;
    btn_Test: TBitBtn;
    btn_Refresh: TBitBtn;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    Label3: TLabel;
    edt_BH: TDBEdit;
    Panel3: TPanel;
    GroupBox1: TGroupBox;
    dxgrd_1: TDBGridEh;
    pnl1: TPanel;
    cbb_Mode: TDBComboBoxEh;
    lbl1: TLabel;
    Splitter1: TSplitter;
    pm1: TPopupMenu;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure btn_SaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure cbb_TypeChange(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure DBMemo1Change(Sender: TObject);
    procedure cbb_ModeChange(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  CountSqlSet: TCountSqlSet;

implementation
uses uDM;
{$R *.dfm}

procedure TCountSqlSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TCountSqlSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TCountSqlSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前统计项目吗？　', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;

end;

procedure TCountSqlSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCountSqlSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TCountSqlSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from 统计项目表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TCountSqlSet.btn_TestClick(Sender: TObject);
begin
  if Trim(DBMemo1.Text)='' then
  begin
    ClientDataSet1.Close;
    Exit;
  end;

  try
    cds_Temp.XMLData := dm.OpenData(DBMemo1.Text);
    SetDBGridEHColumnWidth(DBGridEH1);
  except
    on e:Exception do
    begin
      MessageBox(Handle, PChar('SQL统计命令执行失败！请检查后重试！失败原因如下：　' +
        #13#10 + e.Message), '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
      ClientDataSet1.Close;
    end;
  end;
end;

procedure TCountSqlSet.cbb_ModeChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TCountSqlSet.cbb_TypeChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TCountSqlSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  ClientDataSet1.FieldByName('模块').AsString := cbb_Mode.Text;//gb_System_Mode;
  ClientDataSet1.FieldByName('类别').AsString := '统计';
end;

procedure TCountSqlSet.DBMemo1Change(Sender: TObject);
begin
  btn_Test.Enabled := DBMemo1.Text<>'';
end;

procedure TCountSqlSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TCountSqlSet.FormCreate(Sender: TObject);
begin
  cbb_Mode.Text := gb_System_Mode;
  Open_Table;
end;

procedure TCountSqlSet.N2Click(Sender: TObject);
begin
  DBMemo1.SelectAll;
end;

procedure TCountSqlSet.Open_Table;
var
  sqlstr :string;
begin
  sqlstr := 'select * from 统计项目表 where 模块='+quotedstr(cbb_Mode.Text)+' order by 编号';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
