unit uZsjhSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping, RzLstBox;

type
  TZsjhSet = class(TForm)
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
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Xlcc: TDBComboBoxEh;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DBGridEh1: TDBGridEh;
    lst_Sf: TRzListBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure cbb_XlccChange(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure btn_PostClick(Sender: TObject);
    procedure lst_SfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
  public
    { Public declarations }
  end;

var
  ZsjhSet: TZsjhSet;

implementation
uses uDM;
{$R *.dfm}

procedure TZsjhSet.btn_AddClick(Sender: TObject);
var
  Sf,ZyId,Zy,sqlstr,sWhere:string;
  sList:TStrings;
  cds_Temp:TClientDataSet;
  i:Integer;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;

  Screen.Cursor := crHourGlass;
  DBGridEh1.SaveBookmark;
  try
    cds_Temp.XMLData := ClientDataSet1.XMLData;

    if dm.SelectZy(cbb_Xlcc.Text,'',sList) then
    begin
      Sf := lst_Sf.Items[lst_Sf.ItemIndex];
      for i:=0 to sList.Count-1 do
      begin
        ZyId := sList.Names[i];
        if not cds_Temp.Locate('Id',ZyId,[]) then
        begin
            sqlstr := 'Insert Into ��ʡרҵ�ƻ��� (ʡ��,רҵId,����,�ƻ���) Values('+
                      QuotedStr(Sf)+','+Zyid+',null,0)';
            dm.ExecSql(sqlstr);
        end;
      end;
      Open_Table;
    end;
  finally
    DBGridEh1.RestoreBookmark;
    sList.Free;
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TZsjhSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TZsjhSet.btn_DelClick(Sender: TObject);
var
  bl :Boolean;
begin
{
  bl := ClientDataSet1.FieldByName('״̬').IsNull or (ClientDataSet1.FieldByName('״̬').AsString='�༭��');
  if not bl then
  begin
    MessageBox(Handle, '�����ƻ����ύ�������ٽ����޸ģ���', 'ϵͳ��ʾ', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;
}
  if MessageBox(Handle, '���Ҫɾ����ǰ��¼�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    //if vobj.GetRecordCountBySql('select count(*) from У����������רҵ�� where ��������='+quotedstr(ClientDataSet1.FieldByName('��������').AsString))>0 then
    //  MessageBox(Handle, '��ǰ�����Ѵ��ڿ���������Ϣ�����㲻�ܱ�ɾ��������','ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST)
    //else
    begin
      ClientDataSet1.Delete;
      btn_Save.Click;
    end;
  end;
end;

procedure TZsjhSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TZsjhSet.btn_PostClick(Sender: TObject);
begin
  if MessageBox(Handle, '�����ύ�󽫲������޸��ˣ�ȷ��Ҫ�ύ�𣿡�', 
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDYES then
  begin
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      ClientDataSet1.Edit;
      ClientDataSet1.FieldByName('״̬').asstring := '�����';
      ClientDataSet1.Post;
      ClientDataSet1.Next;
    end;
    btn_Save.Click;
    btn_Refresh.Click;
  end;

end;

procedure TZsjhSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TZsjhSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from view_��ʡרҵ�ƻ��� ',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TZsjhSet.cbb_XlccChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TZsjhSet.ClientDataSet1BeforePost(DataSet: TDataSet);
  function FieldIsNull(const sField:string):Boolean;
  begin
    if DataSet.FieldByName(sField).AsString='' then
    begin
      MessageBox(Handle, PChar('�޷����棡��'+sField+'���ֶβ���Ϊ�գ���'), 'ϵͳ��ʾ',
        MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Abort;
      Result := True;
    end else
      Result := False;;
  end;
begin
  if FieldIsNull('רҵ') then Exit;
  if FieldIsNull('ʡ��') then Exit;
  if FieldIsNull('�ƻ���') then Exit;
end;

procedure TZsjhSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ʡ��').AsString := lst_Sf.Items[lst_sf.ItemIndex];
end;

procedure TZsjhSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TZsjhSet.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.SetXlCcComboBox(cbb_Xlcc);

    dm.GetSfList(sList);
    lst_Sf.Items.Assign(sList);
    lst_Sf.ItemIndex := 0;

    dm.GetKLList(sList);
    DBGridEh1.Columns[6].PickList.Assign(sList);
  finally
    sList.Free;
  end;
end;

procedure TZsjhSet.FormShow(Sender: TObject);
begin
  Open_Table;
end;

procedure TZsjhSet.GetSfList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  DM.GetSfList(sList);
  try
    DBGridEh1.Columns[0].PickList.Clear;
    DBGridEh1.Columns[0].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;
end;

function TZsjhSet.GetWhere: string;
begin
  if lst_Sf.ItemIndex<>-1 then
    Result := ' where ʡ��='+quotedstr(lst_Sf.Items[lst_Sf.ItemIndex])
  else
    Result := ' where 1>0';
  Result := Result+' and ѧ�����='+quotedstr(cbb_XlCc.Text);
end;

procedure TZsjhSet.lst_SfClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TZsjhSet.Open_Table;
var
  sqlstr:string;
begin
  if Self.Showing then
  begin
    sqlstr := 'select * from view_��ʡרҵ�ƻ��� '+GetWhere+' order by ʡ��,רҵ';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  end;
end;

end.
