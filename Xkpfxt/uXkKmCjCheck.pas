unit uXkKmCjCheck;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, Pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, Menus,
  DBGridEhGrouping;

type
  TXkKmCjCheck = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    grp1: TGroupBox;
    cbb_Zy: TDBComboBoxEh;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    lbl_Len: TLabel;
    btn_Confirm: TBitBtn;
    chk_ALL: TCheckBox;
    PopupMenu1: TPopupMenu;
    L1: TMenuItem;
    C1: TMenuItem;
    P1: TMenuItem;
    P2: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_ZyChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1ColEnter(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ValueChange(Sender: TObject);
    procedure ClientDataSet1BeforePost(DataSet: TDataSet);
    procedure btn_SaveClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btn_ConfirmClick(Sender: TObject);
    procedure chk_ALLClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
    fCjIndex:Integer;
    fYx,fSf,fKm,fCjField,fCzyField:string;
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
    procedure GetXkZyList;
    procedure GetYxList;
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string);
  end;

var
  XkKmCjCheck: TXkKmCjCheck;

implementation
uses uDM,CnProgressFrm;
{$R *.dfm}

procedure TXkKmCjCheck.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TXkKmCjCheck.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKmCjCheck.btn_ConfirmClick(Sender: TObject);
var
  Id,sqlstr:string;
  sMsg:string;
  cj1,cj2,cj:Double;
  ii,iCount:Integer;
begin
  if MessageBox(Handle,
    '���Ҫ���ɾ������ճɼ��𣿡���', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  ShowProgress('����У��...',ClientDataSet1.RecordCount);
  TBitBtn(Sender).Enabled := False;
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.First;
    iCount := 0;
    ii := 0;
    while not ClientDataSet1.Eof do
    begin
      UpdateProgress(ClientDataSet1.RecNo);
      UpdateProgressTitle('����У��...['+InttoStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount)+']');
      if (not ClientDataSet1.FieldByName('�Ƿ����').AsBoolean) and (ClientDataSet1.FieldByName('�ɼ�1').AsFloat=ClientDataSet1.FieldByName('�ɼ�2').AsFloat)
         and (ClientDataSet1.FieldByName('���ճɼ�').Value <> ClientDataSet1.FieldByName('�ɼ�1').Value) then
      begin
        ClientDataSet1.Edit;
        ClientDataSet1.FieldByName('���ճɼ�').Value := ClientDataSet1.FieldByName('�ɼ�1').Value;
        ClientDataSet1.FieldByName('�����').Value := gb_Czy_ID;
        ClientDataSet1.FieldByName('���ʱ��').Value := now;
        ClientDataSet1.Post;
        iCount := iCount+1;
        ii := ii+1;
      end;
      if ii>1000 then
      begin
        ii := 0;
        UpdateProgressTitle('���ڸ�������...['+InttoStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount)+']');
        if DataSetNoSave(ClientDataSet1) then
          if dm.UpdateData('Id','select * from  view_У������ɼ�У�Ա� where 1=0',ClientDataSet1.Delta,False) then
          begin
            ClientDataSet1.MergeChangeLog;
          end else
            Exit;
      end;
  {
      Id := ClientDataSet1.FieldByName('Id').AsString;
      cj :=  ClientDataSet1.FieldByName('���ճɼ�').AsFloat;
      sqlstr := 'update У�����Ƴɼ��� set ���ճɼ�='+FloatToStr(cj)+',�����='+quotedstr(gb_Czy_Id)+
              ' where Id='+Id;
      if not dm.ExecSql(sqlstr) then Exit;
  }
      ClientDataSet1.Next;
    end;

    if DataSetNoSave(ClientDataSet1) and (ii>0) then
    begin
      UpdateProgressTitle('���ڸ�������...['+InttoStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount)+']');
      if dm.UpdateData('Id','select * from  view_У������ɼ�У�Ա� where 1=0',ClientDataSet1.Delta,False) then
      begin
        ClientDataSet1.MergeChangeLog;
      end else
        Exit;
    end;
    sMsg := '�������ճɼ�������ɣ����ι�������'+IntToStr(iCount)+'����¼����';
    MessageBox(Handle, PChar(sMsg), 'ϵͳ��ʾ', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);
  finally
    HideProgress;
    ClientDataSet1.EnableControls;
    TBitBtn(Sender).Enabled := True;
    DBGridEh1.SetFocus;
  end;
end;

procedure TXkKmCjCheck.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmCjCheck.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmCjCheck.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    //if dm.UpdateData('id','select top 1 * from view_У�����Ƴɼ���',ClientDataSet1.Delta,True) then

    //if dm.SaveCjData(fCjIndex,ClientDataSet1.Delta) then
    //  ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TXkKmCjCheck.btn_SearchClick(Sender: TObject);
begin
  if Trim(edt_Value.Text)='' then Exit;
  if ClientDataSet1.Locate(cbb_Field.Text,edt_Value.Text,[]) then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.SelectedIndex := 13;
  end else
    MessageBox(Handle, PChar('δ�ҵ�'+cbb_field.Text+'Ϊ��'+edt_Value.Text+'��'+'�Ŀ���������' + #13#10 + '��������²�ѯ��'),
      'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);

end;

procedure TXkKmCjCheck.cbb_YxChange(Sender: TObject);
begin
  GetXkZyList;
  //GetSfList;
  GetXkZyList;
  //Open_Table;
end;

procedure TXkKmCjCheck.cbb_ZyChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkKmCjCheck.chk_ALLClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmCjCheck.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('�����').AsString := gb_Czy_ID;
end;

procedure TXkKmCjCheck.DBGridEh1ColEnter(Sender: TObject);
begin
  DBGridEh1.SelectedIndex := 9;
end;

procedure TXkKmCjCheck.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  cj1,cj2:Double;
begin
{
  //if (ClientDataSet1.FieldByName('���ճɼ�').AsString='') or
  if (ClientDataSet1.FieldByName('�ɼ�1').IsNull) or
     (ClientDataSet1.FieldByName('�ɼ�2').IsNull) then
  begin
    Exit;
  end;

  if Column.FieldName='���ճɼ�' then
  begin
    cj1 := ClientDataSet1.FieldByName('�ɼ�1').AsFloat;
    cj2 := ClientDataSet1.FieldByName('�ɼ�2').AsFloat;
    if (ClientDataSet1.FieldByName('���ճɼ�').AsString='') and (cj1<>cj2) then
      Column.Color := clRed
    //else
    //  Column.Color := clGreen;
  end;
}
end;

procedure TXkKmCjCheck.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TXkKmCjCheck.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TXkKmCjCheck.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKmCjCheck.FormShow(Sender: TObject);
begin
  GetYxList;
  GetXkZyList;
  //Open_Table;
end;

procedure TXkKmCjCheck.GetSfList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
{  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select distinct ʡ�� from У���������ñ� where �п�Ժϵ= '+quotedstr(cbb_Yx.Text));
    cbb_Sf.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('ʡ��').AsString);
      cds_Temp.Next;
    end;
    //cbb_Sf.Items.Add('����ʡ��');
    cbb_Sf.Items.AddStrings(sList);
    cbb_Sf.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
}
end;

function TXkKmCjCheck.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where �п�Ժϵ='+quotedstr(cbb_Yx.Text)+' and ���Կ�Ŀ='+quotedstr(cbb_Zy.Text);

  if chk_ALL.Checked then
    sWhere := sWhere + ' and (�ɼ�1<>�ɼ�2 or �ɼ�1 is null or �ɼ�2 is null) ';
  //else
  //  sWhere := sWhere + ' and �ɼ�1=�ɼ�2';

  Result := sWhere;
  //Result := ' where �п�Ժϵ='+quotedstr(fYx)+' and ʡ��='+quotedstr(fSf)+
  //          ' and ���Կ�Ŀ='+quotedstr(fKm);
end;

procedure TXkKmCjCheck.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
  sqlstr:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    sqlstr := 'select distinct Id,���Կ�Ŀ from У����Ŀ�� where �п�Ժϵ='+quotedstr(cbb_Yx.Text)+
              ' order by Id';
    cds_Temp.XMLData := dm.OpenData(sqlstr);
    cbb_Zy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('���Կ�Ŀ').AsString);
      cds_Temp.Next;
    end;
    //cbb_Zy.Items.Add('���޿�Ŀ');
    cbb_Zy.Items.AddStrings(sList);
    cbb_Zy.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkKmCjCheck.GetYxList;
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

procedure TXkKmCjCheck.N3Click(Sender: TObject);
begin
  if not chk_ALL.Checked then chk_ALL.Checked := True;
  PrintDBGridEH(dbgrideh1,Self,'�ɼ�¼�����ݲ�һ���嵥');
end;

procedure TXkKmCjCheck.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from  view_У������ɼ�У�Ա� '+GetWhere+' order by ������';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  if Self.Showing then
    DBGridEh1.SetFocus;
  btn_Confirm.Enabled := (not chk_ALL.Checked) and (ClientDataSet1.RecordCount>0);
end;

procedure TXkKmCjCheck.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
  fYx := Yx;
  fSf := Sf;
  fKm := Km;
end;

end.
