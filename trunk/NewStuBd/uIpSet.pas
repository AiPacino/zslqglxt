unit uIpSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, Buttons, DBCtrls, ExtCtrls, DBClient,
  GridsEh, DBGridEh, MyDBNavigator, pngimage, DBGridEhGrouping;

type
  TIpSet = class(TForm)
    DataSource1: TDataSource;
    Panel1: TPanel;
    btn_Save: TBitBtn;
    btn_Exit: TBitBtn;
    ClientDataSet1: TClientDataSet;
    MyDBNavigator1: TMyDBNavigator;
    btn_Print: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    DBGridEh1: TDBGridEh;
    pnl1: TPanel;
    Label1: TLabel;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1StateChange(Sender: TObject);
    procedure ClientDataSet1BeforeDelete(DataSet: TDataSet);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure btn_PrintClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  IpSet: TIpSet;

implementation
uses uDM,Net;
{$R *.dfm}

procedure TIpSet.btn_PrintClick(Sender: TObject);
begin
  dm.PrintReport('客户端IP设置表',ClientDataSet1.XMLData,1);
end;

procedure TIpSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('ID','select * from 客户端IP表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TIpSet.ClientDataSet1BeforeDelete(DataSet: TDataSet);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　　', '系统提示', MB_YESNO
    + MB_ICONQUESTION + MB_DEFBUTTON3 + MB_TOPMOST) = IDNO then
    begin
      Abort;
    end else
    begin
      btn_Save.Enabled := True;
    end;
end;

procedure TIpSet.ClientDataSet1BeforePost(DataSet: TDataSet);
var
  sIP :string;
begin
  sIP := DataSet.FieldByName('开始IP').AsString;
  if sIP<>'' then
    DataSet.FieldByName('开始IP').AsString := FormatIP(sIP);

  sIP := DataSet.FieldByName('结束IP').AsString;
  if sIP<>'' then
    DataSet.FieldByName('结束IP').AsString := FormatIP(sIP);
end;

procedure TIpSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  ClientDataSet1.FieldByName('允许否').Value := True;
end;

procedure TIpSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TIpSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TIpSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前IP记录吗？　', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TIpSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TIpSet.FormCreate(Sender: TObject);
var
  sData:String;
begin
  sData := dm.OpenData('select * from 客户端IP表 order by 开始IP');
  ClientDataSet1.XMLData := sData;
end;

procedure TIpSet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TIpSet.DataSource1StateChange(Sender: TObject);
begin
  btn_Save.Enabled := (ClientDataSet1.ChangeCount>0) or (ClientDataSet1.State in [dsInsert,dsEdit]);
end;

end.
