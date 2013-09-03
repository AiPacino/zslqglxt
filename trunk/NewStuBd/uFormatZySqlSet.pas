unit uFormatZySqlSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBGridEhGrouping, GridsEh, DBGridEh, DB,
  DBClient, Mask, DBCtrlsEh, DBCtrls;

type
  TFormatZySqlSet = class(TForm)
    Panel1: TPanel;
    btn_Save: TBitBtn;
    btn_Cancel: TBitBtn;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    DBGridEh1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    Memo1: TDBMemo;
    Label1: TLabel;
    DBEditEh1: TDBEditEh;
    lbl1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TFormatZySqlSet.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormatZySqlSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from 专业格式化SQL配置表',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TFormatZySqlSet.ClientDataSet1BeforePost(DataSet: TDataSet);
var
  sqlstr:string;
  i:integer;
begin
  sqlstr := '';
  for i := 0 to Memo1.Lines.Count - 1 do
    sqlstr := sqlstr+Memo1.Lines[i];
  if (sqlstr<>ClientDataSet1.FieldByName('SqlText').Asstring) then
  begin
    ClientDataSet1.FieldByName('SqlText').AsString := sqlstr;
  end;
end;

procedure TFormatZySqlSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  ClientDataSet1.FieldByName('模块').AsString := '录取';//gb_System_Mode;
  ClientDataSet1.FieldByName('类别').AsString := '专业格式化';
end;

procedure TFormatZySqlSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormatZySqlSet.FormCreate(Sender: TObject);
begin
  ClientDataSet1.XMLData := DM.OpenData('select * from 专业格式化SQL配置表');
end;

end.
