unit uXkKdSetConfirm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, Menus, DBGridEhGrouping;

type
  TXkKdSetConfirm = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    btn_Confirm: TBitBtn;
    ClientDataSet1Id: TAutoIncField;
    ClientDataSet1StringField: TStringField;
    ClientDataSet1StringField3: TStringField;
    ClientDataSet1DateTimeField: TDateTimeField;
    ClientDataSet1DateTimeField2: TDateTimeField;
    ClientDataSet1StringField4: TStringField;
    ClientDataSet1StringField5: TStringField;
    ClientDataSet1StringField6: TStringField;
    ClientDataSet1StringField7: TStringField;
    ClientDataSet1StringField8: TStringField;
    ClientDataSet1StringField9: TStringField;
    ClientDataSet1StringField10: TStringField;
    ClientDataSet1Field: TBooleanField;
    pm1: TPopupMenu;
    C1: TMenuItem;
    P1: TMenuItem;
    N2: TMenuItem;
    mi_CheckAll: TMenuItem;
    mi_UnCheckAll: TMenuItem;
    mi_UnCheck: TMenuItem;
    N1: TMenuItem;
    mi_Confirm: TMenuItem;
    mi_Export: TMenuItem;
    mi_Cancel: TMenuItem;
    btn_Cancel: TBitBtn;
    rg_State: TRadioGroup;
    ClientDataSet1DateTimeField3: TDateTimeField;
    ClientDataSet1DateTimeField4: TDateTimeField;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    ClientDataSet1StringField2: TStringField;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure mi_CheckAllClick(Sender: TObject);
    procedure mi_UnCheckAllClick(Sender: TObject);
    procedure mi_UnCheckClick(Sender: TObject);
    procedure mi_ConfirmClick(Sender: TObject);
    procedure mi_CancelClick(Sender: TObject);
    procedure btn_ConfirmClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure rg_StateClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
    procedure GetXkZyList;
    procedure SetcheckRecord(const iState:Integer);
    procedure SaveData;
  public
    { Public declarations }
  end;

var
  XkKdSetConfirm: TXkKdSetConfirm;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKdSetConfirm.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TXkKdSetConfirm.btn_CancelClick(Sender: TObject);
begin
  mi_Cancel.Click;
end;

procedure TXkKdSetConfirm.btn_ConfirmClick(Sender: TObject);
begin
  mi_Confirm.Click;
end;

procedure TXkKdSetConfirm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKdSetConfirm.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKdSetConfirm.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKdSetConfirm.ClientDataSet1BeforePost(DataSet: TDataSet);
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
end;

procedure TXkKdSetConfirm.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�п�Ժϵ').AsString := cbb_Yx.Text;
  DataSet.FieldByName('������ʼʱ��').AsDateTime := Date;
  DataSet.FieldByName('������ֹʱ��').AsDateTime := Date;
  DataSet.FieldByName('����Ա').AsString := gb_Czy_ID;
  DataSet.FieldByName('״̬').AsString := '�༭��';
end;

procedure TXkKdSetConfirm.DataSource1DataChange(Sender: TObject; Field: TField);
var
  bl:Boolean;
begin
  bl := ClientDataSet1.FieldByName('Id').IsNull;
  mi_Confirm.Enabled := not bl;
  mi_Cancel.Enabled := not bl;
  btn_Confirm.Enabled := not bl;
  btn_Cancel.Enabled := not bl;
end;

procedure TXkKdSetConfirm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKdSetConfirm.FormCreate(Sender: TObject);
begin
  dm.GetYxList(cbb_Yx);
  Open_Table;
  GetSfList;
end;

procedure TXkKdSetConfirm.GetSfList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select ������ from view_ʡ�ݱ�');
    DBGridEh1.Columns[0].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('������').AsString);
      cds_Temp.Next;
    end;
    DBGridEh1.Columns[0].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

function TXkKdSetConfirm.GetWhere: string;
var
  sWhere:string;
begin
  if rg_State.ItemIndex=0 then
    sWhere := ' where ״̬='+quotedstr('�����')
  else
    sWhere := ' where ״̬='+quotedstr('�����');

  if cbb_Yx.ItemIndex<>-1 then
    sWhere := sWhere+' and �п�Ժϵ='+quotedstr(cbb_Yx.Text);

  Result := sWhere;
end;

procedure TXkKdSetConfirm.GetXkZyList;
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

procedure TXkKdSetConfirm.mi_CheckAllClick(Sender: TObject);
begin
  SetcheckRecord(1);
end;

procedure TXkKdSetConfirm.mi_UnCheckAllClick(Sender: TObject);
begin
  SetcheckRecord(0);
end;

procedure TXkKdSetConfirm.mi_UnCheckClick(Sender: TObject);
begin
  SetcheckRecord(2);
end;

procedure TXkKdSetConfirm.N5Click(Sender: TObject);
begin
  btn_Refresh.Click;
end;

procedure TXkKdSetConfirm.mi_ConfirmClick(Sender: TObject);
//var
//  book:TBookmark;
begin
  if ClientDataSet1.FieldByName('��������').IsNull then Exit;
  
  if MessageBox(Handle, PChar('���Ҫ��˵�ǰ��¼�𣿡���'), 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  //book := ClientDataSet1.GetBookmark;
  try
    ClientDataSet1.Edit;
    ClientDataSet1.FieldByName('״̬').AsString := '�����';
    ClientDataSet1.Post;
    SaveData;
    btn_Refresh.Click;
  finally
    //ClientDataSet1.GotoBookmark(book);
  end;
end;

procedure TXkKdSetConfirm.mi_CancelClick(Sender: TObject);
//var
//  book:TBookmark;
begin
  if MessageBox(Handle, PChar('���Ҫ����ǰ��¼�𣿡���'), 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  //book := ClientDataSet1.GetBookmark;
  try
    ClientDataSet1.Edit;
    ClientDataSet1.FieldByName('״̬').AsString := '�༭��';
    ClientDataSet1.Post;
    SaveData;
    btn_Refresh.Click;
  finally
    //ClientDataSet1.GotoBookmark(book);
  end;
end;

procedure TXkKdSetConfirm.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from У���������ñ� '+GetWhere+' order by ʡ��,��������';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  ClientDataSet1.DisableControls;
  try
    while not ClientDataSet1.Eof do
    begin
      ClientDataSet1.Edit;
      ClientDataSet1.FieldByName('ѡ���').AsBoolean := False;
      ClientDataSet1.Next;
    end;
  finally
    ClientDataSet1.EnableControls;
  end;
end;

procedure TXkKdSetConfirm.rg_StateClick(Sender: TObject);
begin
  Open_Table;
  btn_Confirm.Enabled := rg_State.ItemIndex = 0;
end;

procedure TXkKdSetConfirm.SaveData;
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from У���������ñ� ',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkKdSetConfirm.SetcheckRecord(const iState: Integer);
begin
  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      ClientDataSet1.Edit;
      case iState of
        0:
          ClientDataSet1.FieldByName('ѡ���').AsBoolean := False;
        1:
          ClientDataSet1.FieldByName('ѡ���').AsBoolean := True;
        else
          ClientDataSet1.FieldByName('ѡ���').AsBoolean := not ClientDataSet1.FieldByName('ѡ���').AsBoolean;
      end;
      ClientDataSet1.Post;
      ClientDataSet1.Next;
    end;
  finally
    ClientDataSet1.EnableControls;
    Screen.Cursor := crDefault;
  end;

end;

end.
