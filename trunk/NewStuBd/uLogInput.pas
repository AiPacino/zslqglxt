unit uLogInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, DBCtrls, uWorkInput,
  MyDBNavigator, StdCtrls, Buttons, pngimage, ExtCtrls,DBGridEhImpExp,
  frxpngimage, DBGridEhGrouping, Mask, DBCtrlsEh, RzLstBox;

type
  TLogInput = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Save: TBitBtn;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    pnl2: TPanel;
    DBMemo1: TDBMemo;
    DBEditEh1: TDBEditEh;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure cbb_XlccChange(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
  private
    { Private declarations }
    aForm :TWorkInput;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  LogInput: TLogInput;

implementation
uses uDM,uMain;
{$R *.dfm}

procedure TLogInput.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TLogInput.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TLogInput.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TLogInput.btn_EditClick(Sender: TObject);
begin
  ClientDataSet1.Edit;
end;

procedure TLogInput.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TLogInput.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from 录检员工作日志表',ClientDataSet1.Delta) then
    begin
      ClientDataSet1.MergeChangeLog;
      //Main.act_Win_WorkHintExecute(Self);
    end;
end;

procedure TLogInput.cbb_XlccChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TLogInput.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('创建时间').Value := FormatDateTime('yyyy-mm-dd',now);
  DataSet.FieldByName('操作员').Value := gb_Czy_ID;
end;

procedure TLogInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TLogInput.FormCreate(Sender: TObject);
begin
  Open_Table;
end;

procedure TLogInput.Open_Table;
var
  sqlstr,sWhere :string;
begin
  sWhere := 'where 操作员='+quotedstr(gb_Czy_ID)+
            ' and 创建时间='+quotedstr(FormatDateTime('yyyy-mm-dd',now));
  sqlstr := 'select * from 录检员工作日志表 '+sWhere;
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
