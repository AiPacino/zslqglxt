unit uXkKmSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TXkKmSet = class(TForm)
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
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkKmSet: TXkKmSet;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKmSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TXkKmSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKmSet.btn_DelClick(Sender: TObject);
var
  yx,km,sqlstr,sqlstr1:string;
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ��Ŀ�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    yx := clientDataSet1.FieldByName('�п�Ժϵ').AsString;
    km := clientDataSet1.FieldByName('���Կ�Ŀ').AsString;
    sqlstr := 'delete from �ɼ�¼�����ñ� where ¼��Ժϵ='+quotedstr(yx)+' and ¼���Ŀ='+quotedstr(km);
    sqlstr1 := 'delete from У��רҵ��Ŀ���ñ� where �п�Ժϵ='+quotedstr(yx)+' and ���Կ�Ŀ='+quotedstr(km);
    if dm.ExecSql(sqlstr) and dm.Execsql(sqlstr1) then
    begin
      ClientDataSet1.Delete;
      btn_Save.Click;
    end;
  end;
end;

procedure TXkKmSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from У����Ŀ��',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkKmSet.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�п�Ժϵ').AsString := cbb_Yx.Text;
end;

procedure TXkKmSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkKmSet.FormCreate(Sender: TObject);
begin
  GetYxList;
  Open_Table;
end;

function TXkKmSet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where �п�Ժϵ='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  Result := sWhere;
end;

procedure TXkKmSet.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      //dm.GetAllYxList(sList);
      //cbb_Yx.Items.Add('����Ժϵ');
      sList.Add('�������ѧԺ');
      sList.Add('����ѧԺ');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkKmSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from У����Ŀ�� '+GetWhere+' order by Id';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
