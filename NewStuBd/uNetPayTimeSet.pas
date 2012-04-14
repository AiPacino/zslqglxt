unit uNetPayTimeSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, Mask, DBCtrlsEh, DBCtrls;

type
  TNetPayTimeSet = class(TForm)
    pnl1: TPanel;
    btn_Update: TBitBtn;
    btn_Exit: TBitBtn;
    cds_1: TClientDataSet;
    ds1: TDataSource;
    cds_1ID: TAutoIncField;
    cds_1DateTimeField: TDateTimeField;
    cds_1DateTimeField2: TDateTimeField;
    cds_1BooleanField: TBooleanField;
    cds_1WideStringField: TWideStringField;
    cds_1ActionTime: TDateTimeField;
    grp1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    dbchk1: TDBCheckBox;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    DBDateTimeEditEh2: TDBDateTimeEditEh;
    procedure FormCreate(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure cds_1BeforePost(DataSet: TDataSet);
    procedure cds_1NewRecord(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NetPayTimeSet: TNetPayTimeSet;

implementation
uses uDM;
{$R *.dfm}

procedure TNetPayTimeSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TNetPayTimeSet.btn_UpdateClick(Sender: TObject);
var
  sError :String;
begin
  if cds_1.State in [dsInsert,dsEdit] then
    cds_1.Post;
  if cds_1.ChangeCount>0 then
    if vobj_Admin.Update_Data('ID','select * from 网上支付设置表',cds_1.XMLData,sError) then
      cds_1.MergeChangeLog;
end;

procedure TNetPayTimeSet.cds_1BeforePost(DataSet: TDataSet);
begin
  if DataSet.FieldByName('操作员').AsString = '' then
    DataSet.FieldByName('操作员').Value := gb_Czy_ID;
end;

procedure TNetPayTimeSet.cds_1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('开始时间').Value := Now;
  DataSet.FieldByName('结束时间').Value := Now+30;
  DataSet.FieldByName('是否启用').Value := True;
end;

procedure TNetPayTimeSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TNetPayTimeSet.FormCreate(Sender: TObject);
var
  sData:String;
begin
  vobj_Admin.Query_Data('select * from 网上支付设置表',sData);
  cds_1.XMLData := sData;
end;

end.
