unit uXkKmCjInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping,uXkKmCjEdit, Menus;

type
  TXkKmCjInput = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    btn_Refresh: TBitBtn;
    rg_UpLoad: TRadioGroup;
    pm1: TPopupMenu;
    L1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    mi_Delete: TMenuItem;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Edit: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    grp1: TGroupBox;
    cbb_Km: TDBComboBoxEh;
    lbl1: TLabel;
    edt_Max: TDBNumberEditEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1ColEnter(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure rg_UpLoadClick(Sender: TObject);
    procedure mi_DeleteClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
  private
    { Private declarations }
    //aForm: TXkKmCjEdit;
    aForm: TXkKmCjEdit;
    fCjIndex,fBL_1,fBL_2:Integer;
    fYx,fSf,fKm,fPw:string;
    function  GetWhere:string;
    procedure Open_Table;
    procedure CheckData;
    procedure UpLoadCj;
    procedure ShowEditForm(const IsAdd:Boolean);
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string);
    procedure SetFieldValue(const iCjIndex:Integer;const sCjField,sCzyField:string);
  end;

var
  XkKmCjInput: TXkKmCjInput;

implementation
uses uDM,uXkSelectCjInputSf;
{$R *.dfm}

procedure TXkKmCjInput.btn_AddClick(Sender: TObject);
begin
  ShowEditForm(True);
end;

procedure TXkKmCjInput.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKmCjInput.btn_DelClick(Sender: TObject);
begin
  mi_Delete.Click;
end;

procedure TXkKmCjInput.btn_EditClick(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('�Ƿ��ύ').AsBoolean then
    ShowEditForm(False)
  else
    MessageBox(Handle, '�ÿ����ɼ����ύ�޷��޸ģ���', 'ϵͳ��ʾ', MB_OK + 
      MB_ICONWARNING + MB_TOPMOST);
end;

procedure TXkKmCjInput.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmCjInput.btn_PostClick(Sender: TObject);
begin
  if MessageBox(Handle, '��¼��ɼ��ϴ��󽫲����ٽ����޸ģ���' +
    #13#10 + 'ȷ��Ҫ�ϴ���', 'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  ClientDataSet1.First;
  while not ClientDataSet1.Eof do
  begin
    ClientDataSet1.Edit;
    ClientDataSet1.FieldByName('�Ƿ��ύ').AsBoolean := True;
    ClientDataSet1.FieldByName('�ύʱ��').Value := Now;
    ClientDataSet1.Post;
    ClientDataSet1.Next;
  end;
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('Id','select * from view_У������ɼ�¼��� where 1=0',ClientDataSet1.Delta,False) then
    begin
      MessageBox(Handle, '�ɼ������ϴ��ɹ����ÿ�Ŀ�ɼ������ٽ����޸��ˣ���',
      'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
      //ClientDataSet1.MergeChangeLog;
      Open_Table;
    end else
    begin
      MessageBox(Handle, '�ɼ������ϴ�ʧ�ܣ���������ԣ���',
        'ϵͳ��ʾ', MB_OK + MB_ICONERROR + MB_TOPMOST);
    end;
  end;
end;

procedure TXkKmCjInput.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmCjInput.CheckData;
begin
  ClientDataSet1.Last;
  while not ClientDataSet1.Bof do
  begin
    if ClientDataSet1.FieldByName('��Ŀ1��ֵ').IsNull then
      ClientDataSet1.Delete;
    ClientDataSet1.Prior;
  end;
end;

procedure TXkKmCjInput.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('¼�����').AsInteger := fCjIndex;
  DataSet.FieldByName('¼��Ա').AsString := gb_Czy_ID;
  DataSet.FieldByName('¼��ʱ��').AsDateTime := Now;
  DataSet.FieldByName('�п�Ժϵ').AsString := fYx;//gb_Czy_Dept;
  DataSet.FieldByName('���Կ�Ŀ').AsString := fKm;
  DataSet.FieldByName('�Ƿ��ύ').AsBoolean := False;
  DataSet.FieldByName('�Ƿ����').AsBoolean := False;
  DataSet.FieldByName('�Ƿ�ϳ�').AsBoolean := False;
end;

procedure TXkKmCjInput.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  mi_Delete.Enabled := (rg_UpLoad.ItemIndex=0) and (ClientDataSet1.RecordCount>0);

  //btn_Post.Enabled := (rg_UpLoad.ItemIndex=0);
  btn_Edit.Enabled := mi_Delete.Enabled;
  btn_Del.Enabled := mi_Delete.Enabled;

  btn_Add.Enabled := (rg_UpLoad.ItemIndex=0) and (ClientDataSet1.RecordCount<edt_Max.Value);

end;

procedure TXkKmCjInput.DBGridEh1ColEnter(Sender: TObject);
begin
  DBGridEh1.SelectedIndex := 7;
end;

procedure TXkKmCjInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKmCjInput.FormCreate(Sender: TObject);
begin
  aForm := TXkKmCjEdit.Create(Self);
end;

procedure TXkKmCjInput.FormDestroy(Sender: TObject);
begin
  aForm.Free;
end;

procedure TXkKmCjInput.FormShow(Sender: TObject);
begin
  fYx := gb_Czy_Dept;
  if not vobj.GetCjInputInfo(gb_Czy_ID,fYx,fKm,fCjIndex) then
  begin
    MessageBox(Handle, '�����ǳɼ�¼��Ա������ɼ�¼��������Ϣ�� ', 'ϵͳ��ʾ', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
  end else
  begin
    Self.Caption := fYx+'��'+fKm+'����'+IntTostr(fCjIndex)+'��ɼ�¼��';
    if gb_Czy_Dept='����ѧԺ' then
    begin
      fBL_1 := 80;
      fBL_2 := 20;
    end else
    begin
      fBL_1 := 100;
      fBL_2 := 0;
    end;

    dm.SetXkYxComboBox(cbb_Yx);
    cbb_Km.Text := fKm;
    Open_Table;
  end;
end;

function TXkKmCjInput.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where �п�Ժϵ='+quotedstr(gb_Czy_Dept)+' and ¼��Ա='+quotedstr(gb_Czy_ID)+
            //' and ¼�����='+IntToStr(fCjIndex)+
            ' and �Ƿ��ύ='+IntToStr(rg_UpLoad.ItemIndex);
  Result := sWhere;
end;

procedure TXkKmCjInput.mi_DeleteClick(Sender: TObject);
var
  sqlstr:string;
begin
  if Application.MessageBox('���Ҫɾ����ǰ�ɼ���¼�𣿡�', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  if not ClientDataSet1.FieldByName('�Ƿ��ύ').AsBoolean then
  begin
    sqlstr := 'delete from У������ɼ�¼��� where Id='+ClientDataSet1.FieldByName('Id').AsString;
    if dm.ExecSql(sqlstr) then
    begin
      ClientDataSet1.Delete;
      ClientDataSet1.MergeChangeLog;
    end;
    //UpLoadCj;
  end;
end;

procedure TXkKmCjInput.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from view_У������ɼ�¼��� '+GetWhere+' order by ������';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  if Self.Showing then
    DBGridEh1.SetFocus;
end;

procedure TXkKmCjInput.rg_UpLoadClick(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkKmCjInput.SetFieldValue(const iCjIndex:Integer;const sCjField, sCzyField: string);
begin
end;

procedure TXkKmCjInput.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
  fYx := Yx;
  fSf := Sf;
  fKm := Km;
end;

procedure TXkKmCjInput.ShowEditForm(const IsAdd: Boolean);
var
  bm:TBookmark;
begin
  if IsAdd then
  begin
    if not SelectCjInputSf(fYx,fKm,fSf,fPw) then Exit;
    aForm.SetYxSfKmValue(fYx,fSf,fKm,fCjIndex,fPw);
    ClientDataSet1.Last;
    aForm.edt_Value.Text := '';
  end else
  begin
    fSf := ClientDataSet1.FieldByName('ʡ��').AsString;
    fPw := ClientDataSet1.FieldByName('��ί').AsString;
    aForm.SetYxSfKmValue(fYx,fSf,fKm,fCjIndex,fPw);
    aForm.edt_Value.Text := ClientDataSet1.FieldByName('������').AsString;
  end;

  aForm.ShowModal;

  //if DataSetNoSave(ClientDataSet1) then
  //  UpLoadCj;
  bm := ClientDataSet1.GetBookmark;
  try
    Open_Table;
  finally
    ClientDataSet1.GotoBookmark(bm);
  end;
end;

procedure TXkKmCjInput.UpLoadCj;
begin
  CheckData;
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('Id','select * from У������ɼ�¼��� where 1=0',ClientDataSet1.Delta,False) then
    begin
      //ClientDataSet1.MergeChangeLog;
      Open_Table;
    end;
  end;
end;

end.
