unit uSrvStateSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, DBClient, StdCtrls, Buttons, ExtCtrls, DBCtrlsEh, DBCtrls;

type
  TSrvStateSet = class(TForm)
    pnl1: TPanel;
    btn_Update: TBitBtn;
    btn_Exit: TBitBtn;
    cds_1: TClientDataSet;
    ds1: TDataSource;
    grp1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    dbchk1: TCheckBox;
    lbl_State: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btn_UpdateClick(Sender: TObject);
    procedure cds_1BeforePost(DataSet: TDataSet);
    procedure cds_1NewRecord(DataSet: TDataSet);
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
uses uDM;
{$R *.dfm}

procedure TSrvStateSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSrvStateSet.btn_UpdateClick(Sender: TObject);
begin
  if dbchk1.Checked then
  begin
    cds_1.Edit;
    cds_1.FieldByName('�Ƿ�����').AsBoolean := not cds_1.FieldByName('�Ƿ�����').AsBoolean;
    cds_1.Post;
    if cds_1.ChangeCount>0 then
      if dm.UpdateData('ID','select * from ������״̬���ñ�',cds_1.Delta) then
      begin
        GetSrvState;
        cds_1.MergeChangeLog;
      end;
  end;
end;

procedure TSrvStateSet.cds_1BeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('ActionTime').AsDateTime := Now;
end;

procedure TSrvStateSet.cds_1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ActionTime').Value := Now;
  DataSet.FieldByName('�Ƿ�����').Value := True;
end;

procedure TSrvStateSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSrvStateSet.FormCreate(Sender: TObject);
begin
  cds_1.XMLData := DM.OpenData('select * from ������״̬���ñ�');
  GetSrvState;
end;

procedure TSrvStateSet.GetSrvState;
begin
  if cds_1.FieldByName('�Ƿ�����').AsBoolean then
  begin
    lbl_State.Caption := '����������';
    lbl_State.Font.Color := clBlue;
    dbchk1.Checked := False;
    dbchk1.Caption := 'ֹͣ������';
  end else
  begin
    lbl_State.Caption := '������ͣ��';
    lbl_State.Font.Color := clRed;
    dbchk1.Checked := False;
    dbchk1.Caption := '���÷�����';
  end;
end;

end.
