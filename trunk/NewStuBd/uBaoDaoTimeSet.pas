unit uBaoDaoTimeSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, DBGridEhGrouping;

type
  TBaoDaoTimeSet = class(TForm)
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
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  BaoDaoTimeSet: TBaoDaoTimeSet;

implementation
uses uDM;
{$R *.dfm}

procedure TBaoDaoTimeSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TBaoDaoTimeSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TBaoDaoTimeSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from 报到时间配置表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TBaoDaoTimeSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TBaoDaoTimeSet.FormCreate(Sender: TObject);
begin
  Open_Table;
end;

procedure TBaoDaoTimeSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 报到时间配置表';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
