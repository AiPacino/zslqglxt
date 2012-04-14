unit uXkZsjhSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, uXkKdEdit, DBGridEhGrouping;

type
  TXkZsjhSet = class(TForm)
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
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkZsjhSet: TXkZsjhSet;

implementation
uses uDM;
{$R *.dfm}

procedure TXkZsjhSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
  DBGridEh1.SelectedIndex := 2;
end;

procedure TXkZsjhSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkZsjhSet.btn_DelClick(Sender: TObject);
var
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('״̬').IsNull or (ClientDataSet1.FieldByName('״̬').AsString='�༭��');
  if not bl then
  begin
    MessageBox(Handle, '�����ƻ����ύ�������ٽ����޸ģ���', 'ϵͳ��ʾ', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;

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

procedure TXkZsjhSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkZsjhSet.btn_PostClick(Sender: TObject);
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

procedure TXkZsjhSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkZsjhSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from �����������ƻ��걨�� ',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkZsjhSet.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkZsjhSet.ClientDataSet1BeforePost(DataSet: TDataSet);
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
  if FieldIsNull('����Ա') then Exit;
  if FieldIsNull('�ƻ���') then Exit;
end;

procedure TXkZsjhSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�걨Ժϵ').AsString := cbb_Yx.Text;
  DataSet.FieldByName('ActionTime').AsDateTime := Date;
  DataSet.FieldByName('����Ա').AsString := gb_Czy_ID;
  DataSet.FieldByName('״̬').AsString := '�༭��';
end;

procedure TXkZsjhSet.DataSource1DataChange(Sender: TObject; Field: TField);
var
  //state:string;
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('״̬').IsNull or (ClientDataSet1.FieldByName('״̬').AsString='�༭��');
  DBGridEh1.ReadOnly := not bl;
  //btn_Add.Enabled := bl;
  btn_Del.Enabled := bl;
  btn_Save.Enabled := bl;
  //btn_print.Enabled := bl;
end;

procedure TXkZsjhSet.DBGridEh1DblClick(Sender: TObject);
var
  bl :Boolean;
begin
  bl := ClientDataSet1.FieldByName('״̬').IsNull or (ClientDataSet1.FieldByName('״̬').AsString='�༭��');
  if not bl then
    MessageBox(Handle, '�����ƻ���Ϣ���ύ�������ٽ����޸ģ���', 'ϵͳ��ʾ', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
end;

procedure TXkZsjhSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkZsjhSet.FormCreate(Sender: TObject);
begin
  XkKdEdit := TXkKdEdit.Create(nil);
  XkKdEdit.DataSource1.DataSet := ClientDataSet1;
  GetYxList;
  GetSfList;
  GetXkZyList;
  Open_Table;
end;

procedure TXkZsjhSet.FormDestroy(Sender: TObject);
begin
  XkKdEdit.Free;
end;

procedure TXkZsjhSet.GetSfList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select ������ from view_ʡ�ݱ� ');
    DBGridEh1.Columns[2].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('������').AsString);
      cds_Temp.Next;
    end;
    DBGridEh1.Columns[2].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

function TXkZsjhSet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where ״̬<>'+quotedstr('�����')+' and �걨Ժϵ='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where ״̬<>'+quotedstr('�����');
  Result := sWhere;
end;

procedure TXkZsjhSet.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select רҵ from У��רҵ�� where �п�Ժϵ='+quotedstr(cbb_yx.text));
    DBGridEh1.Columns[3].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('רҵ').AsString);
      cds_Temp.Next;
    end;
    DBGridEh1.Columns[3].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkZsjhSet.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
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

procedure TXkZsjhSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from �����������ƻ��걨�� '+GetWhere+' order by Id';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
