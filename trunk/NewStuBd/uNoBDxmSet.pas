unit uNoBDxmSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, DBGridEhGrouping;

type
  TNoBDxmSet = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  NoBDxmSet: TNoBDxmSet;

implementation
uses uDM;
{$R *.dfm}

procedure TNoBDxmSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TNoBDxmSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TNoBDxmSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前项目吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TNoBDxmSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TNoBDxmSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TNoBDxmSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from 未报到原因项目表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TNoBDxmSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('显示顺序').AsInteger := DataSet.RecordCount+1;
end;

procedure TNoBDxmSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TNoBDxmSet.FormCreate(Sender: TObject);
begin
  Open_Table;
end;

procedure TNoBDxmSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 未报到原因项目表';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
