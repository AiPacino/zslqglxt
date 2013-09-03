unit uZdmcSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, DBGridEhGrouping;

type
  TZdmcSet = class(TForm)
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
  private
    { Private declarations }
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  ZdmcSet: TZdmcSet;

implementation
uses uDM;
{$R *.dfm}

procedure TZdmcSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TZdmcSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TZdmcSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ������Ŀ�𣿡�', 'ϵͳ��ʾ', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TZdmcSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TZdmcSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TZdmcSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from �ֶ������ձ�',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TZdmcSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TZdmcSet.FormCreate(Sender: TObject);
begin
  Open_Table;
end;

procedure TZdmcSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from �ֶ������ձ�';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
