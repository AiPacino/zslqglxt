unit uZsjhAdjustEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, uCzyRightGroupSet, uAdjustJhInput,
  Buttons, DB, DBClient,ActnList, CheckLst, Menus, RzPanel, 
  GridsEh, DBGridEh, pngimage, frxpngimage, DBGridEhGrouping, DBCtrlsEh, Mask,
  DBCtrls, dxGDIPlusClasses;

type
  TZsjhAdjustEdit = class(TForm)
    pnl1: TPanel;
    pnl_Main: TPanel;
    pnl7: TPanel;
    cds_Master: TClientDataSet;
    ds_Master: TDataSource;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    cds_Delta: TClientDataSet;
    ds_Delta: TDataSource;
    RzGroupBox1: TRzGroupBox;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    btn_Post: TBitBtn;
    GroupBox1: TRzGroupBox;
    chklst1: TCheckListBox;
    DBGridEh2: TDBGridEh;
    GroupBox2: TGroupBox;
    lbl1: TLabel;
    dbedt1: TDBEdit;
    lbl2: TLabel;
    dbedt2: TDBEdit;
    lbl3: TLabel;
    dbedt3: TDBEdit;
    lbl4: TLabel;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    lbl5: TLabel;
    dbedt4: TDBEdit;
    grp_Xlcc: TGroupBox;
    cbb_Xlcc: TDBComboBoxEh;
    btn_Save: TBitBtn;
    ClientDataSet1: TClientDataSet;
    btn_Exit: TBitBtn;
    cds_DeltaId: TIntegerField;
    cds_DeltapId: TStringField;
    cds_DeltaId2: TIntegerField;
    cds_DeltaStringField5: TStringField;
    cds_DeltaSmallintField: TSmallintField;
    cds_DeltaField: TStringField;
    cds_DeltaField2: TStringField;
    cds_DeltaField3: TStringField;
    btn_Edit: TBitBtn;
    pm1: TPopupMenu;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    btn_Refresh: TBitBtn;
    lbl6: TLabel;
    lbl7: TLabel;
    edt_Sf: TDBComboBoxEh;
    edt_Lx: TDBComboBoxEh;
    cds_DeltaField4: TStringField;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_RightGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rg_XlccClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure cds_DeltaNewRecord(DataSet: TDataSet);
    procedure DBGridEh1Exit(Sender: TObject);
    procedure cbb_XlccChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure cds_DeltaCalcFields(DataSet: TDataSet);
    procedure N3Click(Sender: TObject);
    procedure cds_DeltaBeforeClose(DataSet: TDataSet);
    procedure btn_RefreshClick(Sender: TObject);
    procedure ds_MasterDataChange(Sender: TObject; Field: TField);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure dbedt1Change(Sender: TObject);
    procedure ds_DeltaDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    aForm:TAdjustJhInput;
    myform :TCzyRightGroupSet;
    Old_CzyId:string;
    procedure Open_MasterTable;
    procedure Open_DeltaTable;
    procedure InitRightGroup;
    procedure InitRightTree;
    procedure InitMenuItemCheckByGroup(const sId:string); //����Ȩ�޳�ʼ����
    procedure InitMenuItemCheckByCzy(const sCzyId:string);//�ò���ԱȨ�޳�ʼ����

    function  InitMenuTable:Boolean;
    function  ItemInEnabled(const sItem:string):Boolean;
    function  ItemInVisabled(const sItem:string):Boolean;
    procedure GetXqList;
    function  CheckDeltaData:Boolean;
    function  SaveDeltaData:Boolean;
  public
    { Public declarations }
  end;

var
  ZsjhAdjustEdit: TZsjhAdjustEdit;

implementation
uses uDM,uMain,uZyselect,uNewStuLqBdIntf,EncdDecdEx;
{$R *.dfm}

procedure TZsjhAdjustEdit.BitBtn2Click(Sender: TObject);
var
  sNo,sError:string;
begin
  sNo := vobj.GetAdjustJHNo;
  cds_Master.Append;
  cds_Master.FieldByName('Id').Value := sNo;
  cds_Master.FieldByName('ѧ�����').Value := cbb_Xlcc.Text;
  cds_Master.FieldByName('˵��').Value := '�����������������';
  cds_Master.FieldByName('������').Value := gb_Czy_ID;
  cds_Master.FieldByName('״̬').Value := '�༭��';
  cds_Master.FieldByName('����ʱ��').Value := Now;
  cds_Master.Post;
  edt_Sf.SetFocus;
end;

procedure TZsjhAdjustEdit.BitBtn3Click(Sender: TObject);
var
  Id,sError:string;
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ���뵥�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    Id := cds_Master.FieldByName('Id').AsString;
    if vobj.DeleteJH(Id,gb_Czy_ID,sError) then
    begin
      DBGridEh1.SaveBookmark;
      Open_MasterTable;
      if cds_Master.RecordCount>0 then
        DBGridEh1.RestoreBookmark;
    end;
  end;
end;

procedure TZsjhAdjustEdit.btn_AddClick(Sender: TObject);
begin
  aForm.FillData(0,cds_Master.FieldByName('Id').AsString,cbb_Xlcc.Text,edt_sf.Text,edt_Lx.Text,cds_Delta);
  aForm.ShowModal;
end;

procedure TZsjhAdjustEdit.btn_DelClick(Sender: TObject);
begin
  cds_Delta.Delete;
end;

procedure TZsjhAdjustEdit.btn_EditClick(Sender: TObject);
begin
  aForm.FillData(1,cds_Master.FieldByName('Id').AsString,cbb_Xlcc.Text,edt_Sf.Text,edt_Lx.Text,cds_Delta);
  aForm.ShowModal;
end;

procedure TZsjhAdjustEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TZsjhAdjustEdit.btn_PostClick(Sender: TObject);
var
  sId:string;
  sError:string;
begin
  if btn_Save.Enabled then
    btn_SaveClick(Self);
  if MessageBox(Handle, '�ύ�ɹ������ٶԱ����뵥�����޸ģ�ȷʵҪ�ύ�𣿡�' +
    #13#10, 'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 +
    MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  sId := cds_Master.FieldByName('Id').AsString;
  if vobj.PostJH(sId,gb_Czy_ID,sError) then
  begin
    MessageBox(Handle, PChar('�������ύ�ɹ�����ȴ��쵼��ˣ���'), 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION +
      MB_TOPMOST);
    if MessageBox(Handle, '�����ύ�ɹ���Ҫ��ӡ�ƻ��������뵥�𣿡�', 
      'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
      ClientDataSet1.XMLData := dm.OpenData('select * from View_�ƻ�����������ϸ�� where Id='+quotedstr(sId));
      dm.PrintReport('�ƻ����������.fr3',ClientDataSet1.XMLData,1);
    end;
    Open_MasterTable;
  end else
    MessageBox(Handle, PChar('�������ύʧ�ܣ�'+sError), 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP +
      MB_TOPMOST);
end;

procedure TZsjhAdjustEdit.btn_printClick(Sender: TObject);
var
  sId:string;
begin
  sId := cds_Master.FieldByName('Id').AsString;
  ClientDataSet1.XMLData := dm.OpenData('select * from view_�ƻ�������ϸ�� where Id='+quotedstr(sId));
  dm.PrintReport('�ƻ����������.fr3',ClientDataSet1.XMLData,1);
end;

procedure TZsjhAdjustEdit.btn_RefreshClick(Sender: TObject);
begin
  DBGridEh1.SaveBookmark;
  Open_MasterTable;
  DBGridEh1.RestoreBookmark;
end;

procedure TZsjhAdjustEdit.btn_RightGroupClick(Sender: TObject);
var
  t,l:Integer;
begin
  t := Self.Top;
  l := Self.Left;
  with TCzyRightGroupSet.Create(Self) do
  begin
    Top := t-50;
    Left := l+80;
    ShowModal;
  end;
end;

procedure TZsjhAdjustEdit.btn_SaveClick(Sender: TObject);
begin
  SaveDeltaData;
end;

procedure TZsjhAdjustEdit.cbb_XlccChange(Sender: TObject);
begin
  Open_MasterTable;
end;

procedure TZsjhAdjustEdit.cds_DeltaBeforeClose(DataSet: TDataSet);
begin
  if DataSetNoSave(cds_Delta) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�' + #13#10, 
      'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING + MB_TOPMOST) = IDYES then
    begin
      btn_SaveClick(Self);
    end else
    begin
      DBGridEh1.SaveBookmark;
      Open_MasterTable;
      DBGridEh1.RestoreBookmark;
    end;
end;

procedure TZsjhAdjustEdit.cds_DeltaCalcFields(DataSet: TDataSet);
var
  sqlstr,sZyId:string;
begin
  DataSet.FieldByName('ѧ�����').AsString := cbb_Xlcc.Text;
  sZyId := DataSet.FieldByName('רҵId').AsString;
  if sZyId='' then Exit;

  sqlstr := 'select * from רҵ��Ϣ�� where Id='+sZyId;
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);

  DataSet.FieldByName('���').AsString := ClientDataSet1.FieldByName('���').AsString;
  DataSet.FieldByName('רҵ').AsString := ClientDataSet1.FieldByName('רҵ').AsString;
end;

procedure TZsjhAdjustEdit.cds_DeltaNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('pid').Value := cds_Master.FieldByName('id').Value;
end;

function TZsjhAdjustEdit.CheckDeltaData: Boolean;
var
  s:Integer;
begin
  cds_Delta.DisableControls;
  DBGridEh2.SaveBookmark;
  try
    cds_Delta.First;
    s := 0;
    while not cds_Delta.Eof do
    begin
      s := s+cds_Delta.FieldByName('������').AsInteger;
      cds_Delta.Next;
    end;
    Result := (s=0);
    if not Result then
      Application.MessageBox('��������ƻ�����ƽ�⣬�޷�������ύ��',
        'ϵͳ��ʾ', MB_OK + MB_ICONWARNING + MB_TOPMOST);

  finally
    DBGridEh2.RestoreBookmark;
    cds_Delta.EnableControls;
  end;
end;

procedure TZsjhAdjustEdit.dbedt1Change(Sender: TObject);
var
  bl:Boolean;
begin
  bl := (dbedt1.Text<>'') and (dbedt2.Text<>'') and (dbedt3.Text<>'') and (dbedt4.Text<>'') and
        (edt_sf.Text<>'') and (edt_Lx.Text<>'') and (DBDateTimeEditEh1.Text<>'');
  btn_Add.Enabled := bl;
  btn_Post.Enabled := bl;
end;

procedure TZsjhAdjustEdit.DBGridEh1Exit(Sender: TObject);
begin
  if cds_Master.State in [dsInsert,dsEdit] then
    cds_Master.Post;
end;

procedure TZsjhAdjustEdit.ds_DeltaDataChange(Sender: TObject; Field: TField);
begin
  btn_Edit.Enabled := cds_Delta.RecordCount>0;
  btn_Save.Enabled := btn_Edit.Enabled;
  btn_Del.Enabled := btn_Edit.Enabled;
end;

procedure TZsjhAdjustEdit.ds_MasterDataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable;
end;

function TZsjhAdjustEdit.InitMenuTable:Boolean;
begin
end;

procedure TZsjhAdjustEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TZsjhAdjustEdit.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if DataSetNoSave(cds_Delta) then
    if Application.MessageBox('�������޸ĵ���δ���棡Ҫ������', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING) = IDNO then
    begin
      CanClose := True
    end else
    begin
      CanClose := False;
    end;
end;

procedure TZsjhAdjustEdit.FormCreate(Sender: TObject);
var
  sList:TStrings;
  i:integer;
begin
  DBGridEh2.FieldColumns['������'].KeyList.Clear;
  DBGridEh2.FieldColumns['������'].PickList.Clear;
  for i := -20 to 20 do
  begin
    DBGridEh2.FieldColumns['������'].KeyList.Add(IntToStr(i));
    if i>0 then
      DBGridEh2.FieldColumns['������'].PickList.Add('+'+IntToStr(i))
    else
      DBGridEh2.FieldColumns['������'].PickList.Add(IntToStr(i));
  end;

  aForm := TAdjustJhInput.Create(Self);
  dm.SetXlCcComboBox(cbb_Xlcc);
  sList := TStringList.Create;
  try
    dm.GetSfList(sList);
    edt_Sf.Items.Assign(sList);
    DBGridEh2.Columns[2].PickList.Assign(sList);

    DM.GetKLList(sList);
    DBGridEh2.Columns[4].PickList.Assign(sList);
    Open_MasterTable;
  finally
    sList.Free;
  end;
end;

procedure TZsjhAdjustEdit.FormDestroy(Sender: TObject);
begin
//  if Assigned(myform) then
//    FreeAndNil(myform);
  aForm.Free;
end;

procedure TZsjhAdjustEdit.GetXqList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetXqList(sList);
    DBGridEh1.Columns[5].PickList.Clear;
    DBGridEh1.Columns[5].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;

end;

procedure TZsjhAdjustEdit.InitMenuItemCheckByCzy(const sCzyId: string);
begin
end;

procedure TZsjhAdjustEdit.InitMenuItemCheckByGroup(const sId: string);
begin
end;

procedure TZsjhAdjustEdit.InitRightGroup;
begin
end;

procedure TZsjhAdjustEdit.InitRightTree;
begin
end;

function TZsjhAdjustEdit.ItemInEnabled(const sItem: string): Boolean;
begin
end;

function TZsjhAdjustEdit.ItemInVisabled(const sItem: string): Boolean;
begin
end;

procedure TZsjhAdjustEdit.N3Click(Sender: TObject);
begin
  Open_DeltaTable;
end;

procedure TZsjhAdjustEdit.Open_MasterTable;
var
  sWhere:string;
begin
  sWhere := ' where ������='+quotedstr(gb_Czy_ID)+
            ' and ѧ�����='+quotedstr(cbb_Xlcc.Text)+
            ' and ״̬='+quotedstr('�༭��');

  cds_Master.DisableControls;
  try
    cds_Master.XMLData := DM.OpenData('select * from �ƻ������� '+sWhere+' order by Id');
  finally
    cds_Master.EnableControls;
  end;
end;

procedure TZsjhAdjustEdit.Open_DeltaTable;
var
  sWhere,sId:string;
  sqlstr:string;
begin
  sId := cds_Master.FieldByName('Id').AsString;
  sWhere := ' where pid='+quotedstr(sId);

  cds_Delta.DisableControls;
  try
    sqlstr := 'select * from �ƻ�������ϸ�� '+sWhere;
    cds_Delta.XMLData := DM.OpenData(sqlstr);
  finally
    cds_Delta.EnableControls;
  end;
end;

procedure TZsjhAdjustEdit.rg_XlccClick(Sender: TObject);
begin
  Open_MasterTable;
end;


function TZsjhAdjustEdit.SaveDeltaData: Boolean;
var
  sId,Xlcc,Sf,Czlx,sWhy,sDelta:string;
  sError:string;
begin
  Result := False;
  sId := cds_Master.FieldByName('Id').AsString;
  Xlcc := cds_Master.FieldByName('ѧ�����').AsString;
  sWhy := cds_Master.FieldByName('˵��').AsString;
  Sf := cds_Master.FieldByName('ʡ��').AsString;
  Czlx := cds_Master.FieldByName('����').AsString;

  if DataSetNoSave(cds_Delta) then
  begin
    sDelta := cds_Delta.XMLData;
    if gb_Use_Zip then
    begin
      sDelta := dm.VCLZip1.ZLibCompressString(sDelta);
      sDelta := EncodeString(sDelta);
    end;
  end;
  if not CheckDeltaData then
  begin
    Exit;
  end;

  if vobj.AdjustJH(sId,Xlcc,Sf,Czlx,sWhy,gb_Czy_ID,sDelta,sError) then
  begin
    cds_Master.MergeChangeLog;
    cds_Delta.MergeChangeLog;
    Result := True;
  end else
    MessageBox(Handle, PChar('����������ʧ�ܣ�'+sError), 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP +
      MB_TOPMOST);
{
  if DataSetNoSave(cds_Master) then
    if DM.UpdateData('id','select top 0 * from �ƻ�������',cds_Master.Delta,False) then
      cds_Master.MergeChangeLog;

  if DataSetNoSave(cds_Delta) then
    if DM.UpdateData('id','select top 0 * from �ƻ�������ϸ��',cds_Delta.Delta,False) then
      cds_Delta.MergeChangeLog;
}
end;

end.
