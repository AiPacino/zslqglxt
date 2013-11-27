unit uXkKmErrorCjInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, Pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping;

type
  TXkKmErrorCjInput = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    grp1: TGroupBox;
    cbb_Zy: TDBComboBoxEh;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    lbl_Len: TLabel;
    btn_Confirm: TBitBtn;
    DBGridEh1: TDBGridEh;
    chk_All: TCheckBox;
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
    procedure DataSource1StateChange(Sender: TObject);
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
  XkKmErrorCjInput: TXkKmErrorCjInput;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKmErrorCjInput.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TXkKmErrorCjInput.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKmErrorCjInput.btn_ConfirmClick(Sender: TObject);
var
  Id,sqlstr:string;
  sMsg:string;
  cj1,cj2,cj:Double;
begin
  if MessageBox(Handle,
    '���Ҫ�����ֹ�¼������ճɼ���', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('Id','select * from view_У������ɼ�У�Ա� where 1=0',ClientDataSet1.Delta,False) then
    begin
      MessageBox(Handle, '�ֹ�¼������ճɼ��ѱ��棡��', 'ϵͳ��ʾ', MB_OK +
        MB_ICONINFORMATION + MB_TOPMOST);
      ClientDataSet1.MergeChangeLog;
    end;
  end;
end;

procedure TXkKmErrorCjInput.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmErrorCjInput.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmErrorCjInput.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    //if dm.UpdateData('id','select top 1 * from view_У�����Ƴɼ���',ClientDataSet1.Delta,True) then

    //if dm.SaveCjData(fCjIndex,ClientDataSet1.Delta) then
    //  ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TXkKmErrorCjInput.btn_SearchClick(Sender: TObject);
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

procedure TXkKmErrorCjInput.cbb_YxChange(Sender: TObject);
begin
  GetXkZyList;
  GetSfList;
  Open_Table;
end;

procedure TXkKmErrorCjInput.cbb_ZyChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkKmErrorCjInput.chk_ALLClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmErrorCjInput.ClientDataSet1BeforePost(DataSet: TDataSet);
begin
  DataSet.FieldByName('�����').AsString := gb_Czy_ID;
end;

procedure TXkKmErrorCjInput.DataSource1StateChange(Sender: TObject);
begin
  btn_Confirm.Enabled := (ClientDataSet1.ChangeCount>0) or (ClientDataSet1.State in [dsEdit,dsInsert]); 
end;

procedure TXkKmErrorCjInput.DBGridEh1ColEnter(Sender: TObject);
begin
  DBGridEh1.SelectedIndex := 9;
end;

procedure TXkKmErrorCjInput.DBGridEh1DrawColumnCell(Sender: TObject;
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

procedure TXkKmErrorCjInput.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TXkKmErrorCjInput.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TXkKmErrorCjInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKmErrorCjInput.FormShow(Sender: TObject);
begin
  GetYxList;
  GetXkZyList;
  //Open_Table;
end;

procedure TXkKmErrorCjInput.GetSfList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select distinct ʡ�� from У���������ñ� where �п�Ժϵ= '+quotedstr(cbb_Yx.Text));
    //cbb_Sf.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('ʡ��').AsString);
      cds_Temp.Next;
    end;
    //cbb_Sf.Items.AddStrings(sList);
    //cbb_Sf.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

function TXkKmErrorCjInput.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where �п�Ժϵ='+quotedstr(cbb_Yx.Text)+' and ���Կ�Ŀ='+quotedstr(cbb_Zy.Text);
  if not chk_All.Checked then
    sWhere := sWhere+' and ���ճɼ� is null and (�ɼ�1<>�ɼ�2) ';

  Result := sWhere;
  //Result := ' where �п�Ժϵ='+quotedstr(fYx)+' and ʡ��='+quotedstr(fSf)+
  //          ' and ���Կ�Ŀ='+quotedstr(fKm);
end;

procedure TXkKmErrorCjInput.GetXkZyList;
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

procedure TXkKmErrorCjInput.GetYxList;
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

procedure TXkKmErrorCjInput.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from view_У������ɼ�У�Ա� '+GetWhere+' order by ������';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  if Self.Showing then
    DBGridEh1.SetFocus;
  btn_Confirm.Enabled := (ClientDataSet1.ChangeCount>0) or (ClientDataSet1.State in [dsInsert,dsEdit]);
end;

procedure TXkKmErrorCjInput.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
  fYx := Yx;
  fSf := Sf;
  fKm := Km;
end;

end.
