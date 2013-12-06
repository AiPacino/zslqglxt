unit uXkKdSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, uXkKdEdit, DBGridEhGrouping;

type
  TXkKdSet = class(TForm)
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
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    btn_print: TBitBtn;
    btn_Post: TBitBtn;
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
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btn_PostClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    { Private declarations }
    XkKdEdit: TXkKdEdit;
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
    procedure GetXkZyList;
  public
    { Public declarations }
  end;

var
  XkKdSet: TXkKdSet;

implementation
uses uDM, uVobj;
{$R *.dfm}

procedure TXkKdSet.btn_AddClick(Sender: TObject);
begin
  XkKdEdit.SetEditType(0);
  XkKdEdit.ShowModal;
end;

procedure TXkKdSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKdSet.btn_DelClick(Sender: TObject);
var
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('״̬').IsNull or (ClientDataSet1.FieldByName('״̬').AsString='�༭��');
  if not bl then
  begin
    MessageBox(Handle, '������Ϣ���ύ�������ٽ����޸ģ���', 'ϵͳ��ʾ', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;

  if MessageBox(Handle, '���Ҫɾ����ǰ�����𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if dm.GetRecordCountBySql('select count(*) from У����������רҵ�� where ��������='+quotedstr(ClientDataSet1.FieldByName('��������').AsString))>0 then
      MessageBox(Handle, '��ǰ�����Ѵ��ڿ���������Ϣ�����㲻�ܱ�ɾ��������','ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST)
    else
    begin
      ClientDataSet1.Delete;
      btn_Save.Click;
    end;
  end;
end;

procedure TXkKdSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKdSet.btn_PostClick(Sender: TObject);
begin
  if MessageBox(Handle, '�����ύ�󽫲������޸��ˣ�ȷ��Ҫ�ύ�𣿡�', 
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDYES then
  begin
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      if ClientDataSet1.FieldByName('״̬').asstring = '�༭��' then
      begin
        ClientDataSet1.Edit;
        ClientDataSet1.FieldByName('״̬').asstring := '�����';
        ClientDataSet1.Post;
      end;
      ClientDataSet1.Next;
    end;
    btn_Save.Click;
    btn_Refresh.Click;
  end;

end;

procedure TXkKdSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKdSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from У���������ñ� ',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkKdSet.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKdSet.ClientDataSet1BeforePost(DataSet: TDataSet);
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
  if FieldIsNull('��������') then Exit;
  if FieldIsNull('������ʼʱ��') then Exit;
  if FieldIsNull('������ֹʱ��') then Exit;
  if FieldIsNull('��ϵ��') then Exit;
  if FieldIsNull('��ϵ�绰') then Exit;
  DataSet.FieldByName('������ʼʱ��').AsString := FormatDateTime('yyyy-mm-dd 00:00',DataSet.FieldByName('������ʼʱ��').AsDateTime);
  DataSet.FieldByName('������ֹʱ��').AsString := FormatDateTime('yyyy-mm-dd 23:59',DataSet.FieldByName('������ֹʱ��').AsDateTime);
  DataSet.FieldByName('���Կ�ʼʱ��').AsString := FormatDateTime('yyyy-mm-dd 00:00',DataSet.FieldByName('���Կ�ʼʱ��').AsDateTime);
  DataSet.FieldByName('���Խ�ֹʱ��').AsString := FormatDateTime('yyyy-mm-dd 23:59',DataSet.FieldByName('���Խ�ֹʱ��').AsDateTime);
end;

procedure TXkKdSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�п�Ժϵ').AsString := cbb_Yx.Text;
  DataSet.FieldByName('������ʼʱ��').AsDateTime := Date;
  DataSet.FieldByName('������ֹʱ��').AsDateTime := Date;
  DataSet.FieldByName('���Կ�ʼʱ��').AsDateTime := Date;
  DataSet.FieldByName('���Խ�ֹʱ��').AsDateTime := Date;
  DataSet.FieldByName('����Ա').AsString := gb_Czy_ID;
  DataSet.FieldByName('״̬').AsString := '�༭��';
end;

procedure TXkKdSet.DataSource1DataChange(Sender: TObject; Field: TField);
var
  //state:string;
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('״̬').IsNull or (ClientDataSet1.FieldByName('״̬').AsString='�༭��');
  DBGridEh1.ReadOnly := True;//not bl;
  //btn_Add.Enabled := bl;
  btn_Del.Enabled := bl;
  btn_Save.Enabled := bl;
  //btn_print.Enabled := bl;
end;

procedure TXkKdSet.DBGridEh1DblClick(Sender: TObject);
var
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('״̬').IsNull or (ClientDataSet1.FieldByName('״̬').AsString='�༭��');
  if not bl then
    MessageBox(Handle, '������Ϣ���ύ�������ٽ����޸ģ���', 'ϵͳ��ʾ', MB_OK
      + MB_ICONSTOP + MB_TOPMOST)
  else
  begin
    XkKdEdit.SetEditType(1);
    XkKdEdit.ShowModal;
  end;
end;

procedure TXkKdSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkKdSet.FormCreate(Sender: TObject);
begin
  XkKdEdit := TXkKdEdit.Create(nil);
  XkKdEdit.DataSource1.DataSet := ClientDataSet1;
  dm.GetYxList(cbb_Yx);
  Open_Table;
  GetSfList;
end;

procedure TXkKdSet.FormDestroy(Sender: TObject);
begin
  XkKdEdit.Free;
end;

procedure TXkKdSet.GetSfList;
begin
end;

function TXkKdSet.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where �п�Ժϵ='+quotedstr(cbb_Yx.Text);//+' and ״̬<>'+quotedstr('�����')
  Result := sWhere;
end;

procedure TXkKdSet.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select ���Կ�Ŀ from У����Ŀ�� '+GetWhere);
    DBGridEh1.Columns[3].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('���Կ�Ŀ').AsString);
      cds_Temp.Next;
    end;
    DBGridEh1.Columns[3].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkKdSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from У���������ñ� '+GetWhere+' order by ʡ��,��������';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
