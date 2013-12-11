unit uXkZySet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping,
  dxGDIPlusClasses;

type
  TXkZySet = class(TForm)
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
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  XkZySet: TXkZySet;

implementation
uses uDM;
{$R *.dfm}

procedure TXkZySet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TXkZySet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkZySet.btn_DelClick(Sender: TObject);
var
  yx,km,sqlstr:string;
begin
  if MessageBox(Handle, '���Ҫɾ����ǰרҵ�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    yx := clientDataSet1.FieldByName('�п�Ժϵ').AsString;
    km := clientDataSet1.FieldByName('רҵ').AsString;
    sqlstr := 'delete from У��רҵ��Ŀ���ñ� where �п�Ժϵ='+quotedstr(yx)+' and רҵ='+quotedstr(km);
    if dm.ExecSql(sqlstr) then
    begin
      ClientDataSet1.Delete;
      btn_Save.Click;
    end;
  end;
end;

procedure TXkZySet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkZySet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkZySet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from У��רҵ��',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkZySet.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkZySet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  //if cbb_Yx.Text<>'����Ժϵ' then
  DataSet.FieldByName('�п�Ժϵ').AsString := cbb_Yx.Text;
  DataSet.FieldByName('���').AsString := '����';
end;

procedure TXkZySet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkZySet.FormCreate(Sender: TObject);
begin
  dm.GetYxList(cbb_Yx);
  Open_Table;
end;

function TXkZySet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where �п�Ժϵ='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  Result := sWhere;
end;

procedure TXkZySet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from У��רҵ�� '+GetWhere+' order by Id';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
