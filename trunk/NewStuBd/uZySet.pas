unit uZySet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, DBCtrls,
  MyDBNavigator, StdCtrls, Buttons, pngimage, ExtCtrls,DBGridEhImpExp,
  frxpngimage, DBGridEhGrouping, Mask, DBCtrlsEh;

type
  TZySet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Close: TBitBtn;
    btn_Save: TBitBtn;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    btn_Export: TBitBtn;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_XlCc: TDBComboBoxEh;
    grp_Lb: TGroupBox;
    cbb_Lb: TDBComboBoxEh;
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure btn_SaveClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExportClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_XlCcChange(Sender: TObject);
  private
    { Private declarations }
    procedure Open_Table;
    procedure GetXqList;
  public
    { Public declarations }
  end;

var
  ZySet: TZySet;

implementation
uses uDM;
{$R *.dfm}

procedure TZySet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TZySet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TZySet.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TZySet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ����Ա��Ϣ�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TZySet.btn_ExportClick(Sender: TObject);
begin
  DM.ExportDBEditEH(DBGridEh1);
end;

procedure TZySet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 1 * from רҵ��Ϣ��',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TZySet.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
  begin
    Open_Table;
    DBGridEh1.SetFocus;
  end;
end;

procedure TZySet.ClientDataSet1NewRecord(DataSet: TDataSet);
var
  cc,nx:string;
begin
  cc := cbb_XlCc.Text;
  if cc='ר��' then nx:='3' else nx:='4';
  DataSet.FieldByName('ѧ�����').AsString := cc;
  if cbb_Lb.Text<>'ȫ��' then
    DataSet.FieldByName('���').AsString := cbb_Lb.Text
  else
    DataSet.FieldByName('���').AsString := '';
  DataSet.FieldByName('ѧ������').AsString := nx;
end;

procedure TZySet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TZySet.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.SetXlCcComboBox(cbb_XlCc);
    dm.SetLbComboBox(cbb_Lb,True);
    dm.GetLbList(sList);
    DBGridEh1.Columns[2].PickList.Clear;
    DBGridEh1.Columns[2].PickList.Assign(sList);
    Open_Table;
  finally
    sList.Free;
  end;
end;

procedure TZySet.GetXqList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetXqList(sList);
    DBGridEh1.Columns[10].PickList.Clear;
    DBGridEh1.Columns[10].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;
end;

procedure TZySet.Open_Table;
var
  sqlstr,sWhere :string;
begin
  sWhere := ' where ѧ�����='+quotedstr(cbb_XlCc.Text);
  if cbb_Lb.Text<>'ȫ��' then
    sWhere := sWhere+' and ���='+quotedstr(cbb_Lb.Text);
  if Self.Showing then
    btn_Save.Click;
  sqlstr := 'select * from רҵ��Ϣ�� '+sWhere;
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

procedure TZySet.RadioGroup1Click(Sender: TObject);
begin
  Open_Table;
end;

end.
