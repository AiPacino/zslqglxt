unit uXkPwSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, DBGridEhGrouping;

type
  TXkPwSet = class(TForm)
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
    grp1: TGroupBox;
    cbb_yx: TComboBox;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn1: TBitBtn;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure btn_DelClick(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure cbb_yxChange(Sender: TObject);
  private
    { Private declarations }
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  XkPwSet: TXkPwSet;

implementation
uses uDM;
{$R *.dfm}

procedure TXkPwSet.btn1Click(Sender: TObject);
begin
  if Application.MessageBox('真的要为所有评委生成唯一随机签到码吗？', '系统提示', 
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

end;

procedure TXkPwSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TXkPwSet.btn_DelClick(Sender: TObject);
begin
  if Application.MessageBox('真的要删除当前记录吗？', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_SaveClick(Self);
  end;
end;

procedure TXkPwSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkPwSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkPwSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from 校考评委名单表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkPwSet.cbb_yxChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkPwSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('承考院系').Value := cbb_yx.Text;
end;

procedure TXkPwSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkPwSet.FormCreate(Sender: TObject);
begin
  cbb_yx.Text := gb_Czy_Dept;
  cbb_yx.Enabled := gb_Czy_Level='-1';
  Open_Table;
end;

procedure TXkPwSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考评委名单表 where 承考院系='+quotedstr(cbb_yx.Text);
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
