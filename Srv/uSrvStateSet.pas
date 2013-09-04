unit uSrvStateSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, DBCtrlsEh, DBCtrls, ADODB;

type
  TSrvStateSet = class(TForm)
    pnl1: TPanel;
    btn_Update: TBitBtn;
    btn_Exit: TBitBtn;
    ds1: TDataSource;
    grp1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dbchk1: TCheckBox;
    lbl_State: TLabel;
    qry1: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure qry1BeforePost(DataSet: TDataSet);
    procedure qry1NewRecord(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
    procedure GetSrvState;
  public
    { Public declarations }
  end;

var
  SrvStateSet: TSrvStateSet;

implementation
uses uDbConnect;
{$R *.dfm}

procedure TSrvStateSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSrvStateSet.btn_UpdateClick(Sender: TObject);
begin
  if dbchk1.Checked then
  begin
    qry1.Edit;
    qry1.FieldByName('是否启用').AsBoolean := not qry1.FieldByName('是否启用').AsBoolean;
    qry1.Post;
    GetSrvState;
  end;
end;

procedure TSrvStateSet.qry1BeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('ActionTime').AsDateTime := Now;
end;

procedure TSrvStateSet.qry1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ActionTime').Value := Now;
  DataSet.FieldByName('是否启用').Value := True;
end;

procedure TSrvStateSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qry1.Close;
  Action := caFree;
end;

procedure TSrvStateSet.FormCreate(Sender: TObject);
begin
  qry1.close;
  qry1.ConnectionString := uDbConnect.GetConnectString;
  qry1.CommandTimeout := 3;
  qry1.SQL.Text := ('select * from 服务器状态配置表');
  qry1.Open;
  GetSrvState;
end;

procedure TSrvStateSet.GetSrvState;
begin
  if qry1.FieldByName('是否启用').AsBoolean then
  begin
    lbl_State.Caption := '服务已启用';
    lbl_State.Font.Color := clBlue;
    dbchk1.Checked := False;
    dbchk1.Caption := '停止服务器';
  end else
  begin
    lbl_State.Caption := '服务已停用';
    lbl_State.Font.Color := clRed;
    dbchk1.Checked := False;
    dbchk1.Caption := '启用服务器';
  end;
end;

end.
