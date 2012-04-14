unit uYxSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, DBCtrls,
  MyDBNavigator, StdCtrls, Buttons, pngimage, ExtCtrls,DBGridEhImpExp,
  frxpngimage, DBGridEhGrouping;

type
  TYxSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Close: TBitBtn;
    MyDBNavigator1: TMyDBNavigator;
    btn_Save: TBitBtn;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    btn_Export: TBitBtn;
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExportClick(Sender: TObject);
  private
    { Private declarations }
    procedure Open_Table;
    procedure GetDeptList;
    procedure GetXqList;
  public
    { Public declarations }
  end;

var
  YxSet: TYxSet;

implementation
uses uDM;
{$R *.dfm}

procedure TYxSet.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TYxSet.btn_ExportClick(Sender: TObject);
begin
  DM.ExportDBEditEH(DBGridEh1);
end;

procedure TYxSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 1 * from 院系信息表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TYxSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TYxSet.FormCreate(Sender: TObject);
begin
  Open_Table;
  GetxqList;
end;

procedure TYxSet.GetDeptList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    with DBGridEh1.Columns[1] do
    begin
      PickList.Clear;
      dm.GetDeptList(sList);
      PickList.AddStrings(sList);
    end;
  finally
    sList.Free;
  end;
end;

procedure TYxSet.GetXqList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetXqList(sList);
    DBGridEh1.Columns[5].PickList.Clear;
    DBGridEh1.Columns[5].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;
end;

procedure TYxSet.Open_Table;
var
  sqlstr :string;
begin
  sqlstr := 'select * from 院系信息表 order by Id';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
