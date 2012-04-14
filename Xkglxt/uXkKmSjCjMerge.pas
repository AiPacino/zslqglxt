unit uXkKmSjCjMerge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons, CnProgressFrm,
  ExtCtrls, Pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, Menus,
  DBGridEhGrouping;

type
  TXkKmSjCjMerge = class(TForm)
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
    btn_Merge: TBitBtn;
    lbl3: TLabel;
    cds_Source: TClientDataSet;
    chk_DeleteMaxMinCj: TCheckBox;
    cds_Source_Master: TClientDataSet;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1ColEnter(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ConfirmClick(Sender: TObject);
    procedure cbb_ZyChange(Sender: TObject);
    procedure btn_MergeClick(Sender: TObject);
    procedure rg_UpLoadClick(Sender: TObject);
    procedure cds_SourceFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    fCjIndex:Integer;
    fYx,fSf,fKm,fCjField,fCzyField:string;
    function  GetWhere:string;
    function  InsertKsInfoToKmCjb:Boolean;
    procedure Open_CjCheck_Table;
    procedure Open_Table;
    procedure GetXkZyList;
    procedure GetYxList;
    procedure GetCzyList;
    procedure ShowErrorRecord;
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string);
  end;

var
  XkKmSjCjMerge: TXkKmSjCjMerge;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKmSjCjMerge.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TXkKmSjCjMerge.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKmSjCjMerge.btn_ConfirmClick(Sender: TObject);
var
  sjBH,Id,sqlstr1,sqlstr2:string;
  cds_1,cds_2:TClientDataSet;
  bFound,bl1,bl2:Boolean;
  iCount:Integer;
begin

  if MessageBox(Handle,
    PChar('��˲�����������¼��Ա��¼��ĳɼ�����һ���Լ�飬����'+#13+'�������Ҫ��ʼ����𣿡���'), 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  iCount := 0;
  sqlstr1 := 'select * from У������ɼ���ϸ�� '+GetWhere+' and ¼�����=1 order by �Ծ���';
  sqlstr2 := 'select * from У������ɼ���ϸ�� '+GetWhere+' and ¼�����=2 order by �Ծ���';
  cds_1 := TClientDataSet.Create(nil);
  cds_2 := TClientDataSet.Create(nil);
  cds_1.XMLData := DM.OpenData(sqlstr1);

  ShowProgress('�������...',cds_1.RecordCount);

  cds_2.XMLData := DM.OpenData(sqlstr2);

  try
    cds_1.First;
    while not Cds_1.Eof do
    begin
      UpdateProgress(cds_1.RecNo);
      sjBH := cds_1.FieldByName('�Ծ���').AsString;

      //cj1 := cds_1.FieldByName('��Ŀ1�ɼ�').AsFloat;
      //cj2 := cds_1.FieldByName('��Ŀ2�ɼ�').AsFloat;

      if cds_2.Locate('�Ծ���',sjBH,[]) then
      begin
        if (cds_2.FieldByName('��Ŀ1��ֵ').Value = cds_1.FieldByName('��Ŀ1��ֵ').Value) and
           (cds_2.FieldByName('��Ŀ2��ֵ').Value = cds_1.FieldByName('��Ŀ2��ֵ').Value) then
        begin
          iCount := iCount+1;
          cds_2.Edit;
          cds_2.FieldByName('�Ƿ����').AsBoolean := True;
          cds_2.FieldByName('���ʱ��').Value := Now;
          cds_2.FieldByName('���Ա').Value := gb_Czy_ID;
          cds_2.Post;

          cds_1.Edit;
          cds_1.FieldByName('�Ƿ����').AsBoolean := True;
          cds_1.FieldByName('���ʱ��').Value := Now;
          cds_1.FieldByName('���Ա').Value := gb_Czy_ID;
          cds_1.Post;
        end else
        begin
          cds_2.Edit;
          cds_2.FieldByName('�Ƿ����').AsBoolean := False;
          cds_2.FieldByName('���ʱ��').Value := null;
          cds_2.FieldByName('���Ա').Value := null;
          cds_2.Post;

          cds_1.Edit;
          cds_1.FieldByName('�Ƿ����').AsBoolean := False;
          cds_1.FieldByName('���ʱ��').Value := null;
          cds_1.FieldByName('���Ա').Value := null;
          cds_1.Post;
        end;
      end else
      begin
        cds_1.Edit;
        cds_1.FieldByName('�Ƿ����').AsBoolean := False;
        cds_1.FieldByName('���ʱ��').Value := null;
        cds_1.FieldByName('���Ա').Value := null;
        cds_1.Post;
      end;

      cds_1.Next;
    end;

    if cds_1.ChangeCount>0 then
      bl1 := dm.UpdateData('Id','select * from У������ɼ���ϸ�� where 1=0',cds_1.Delta,False);
    if cds_2.ChangeCount>0 then
      bl2 := dm.UpdateData('Id','select * from У������ɼ���ϸ�� where 1=0',cds_2.Delta,False);

    MessageBox(Handle, PChar('������ɣ�'+InttoStr(iCount)+'����¼�����ͨ������鿴��˽������'), 'ϵͳ��ʾ', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);
    if bl1 or bl2 then
    begin
      cds_1.MergeChangeLog;
      cds_2.MergeChangeLog;
      Open_Table;
    end;
  finally
    HideProgress;
    cds_1.Free;
    cds_2.Free;
  end;
end;

procedure TXkKmSjCjMerge.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmSjCjMerge.btn_MergeClick(Sender: TObject);
var
  ksh,yx,km:string;
  maxcj,mincj,cj,sumcj:Double;
  ii,iCount,updateCound:Integer;
  bl:Boolean;
begin
  if Application.MessageBox('���Ҫ�ϳɵ�ǰ��ʾ�����ĵ��Ƴɼ��𣿡�', 'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION +
    MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  if not InsertKsInfoToKmCjb then Exit;
  Open_CjCheck_Table;
  Open_Table;

  TBitBtn(Sender).Enabled := False;
  try
    ClientDataSet1.First;
    ShowProgress('���ںϳ�...',ClientDataSet1.RecordCount);
    ClientDataSet1.DisableControls;
    ii := 0;
    updateCound := 0;
    bl := True;
    while not ClientDataSet1.Eof do
    begin
      UpdateProgress(ClientDataSet1.RecNo);
      UpdateProgressTitle('���ںϳ�...['+InttoStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount)+']');
      ksh := ClientDataSet1.FieldByName('������').AsString;
      yx := ClientDataSet1.FieldByName('�п�Ժϵ').AsString;
      km := ClientDataSet1.FieldByName('���Կ�Ŀ').AsString;
      cds_Source.Filtered := False;
      cds_Source.Filtered := True;

      iCount := cds_Source.RecordCount;
      //iCount := 0;
      cj := 0;
      sumcj := 0;
      cds_Source.First;
      maxcj := cds_Source.FieldByName('�ɼ�').AsFloat;
      mincj := cds_Source.FieldByName('�ɼ�').AsFloat;
      while not cds_Source.Eof do
      begin
        cj := cds_Source.FieldByName('�ɼ�').AsFloat;
        if cj>maxcj then maxcj := cj;
        if cj<mincj then mincj := cj;
        sumcj := sumcj+cj;
        cds_Source.Next;
      end;

      if iCount>0 then
      begin
        if chk_DeleteMaxMinCj.Checked and (iCount>=3) then
          cj := (sumcj-maxcj-mincj)/(iCount-2)
        else
          cj := sumcj/iCount;
        cj := Trunc(cj*1000+0.5)/1000;
        if (cj<>ClientDataSet1.FieldByName('�ɼ�').AsFloat) then
        begin
          ClientDataSet1.Edit;
          ClientDataSet1.FieldByName('��ί��').AsInteger := iCount;
          ClientDataSet1.FieldByName('�ɼ�').AsFloat := cj;
          ClientDataSet1.FieldByName('ActionTime').AsDateTime := Now;
          ClientDataSet1.Post;
          ii := ii+1;
          Inc(updateCound);
        end;
      end
      else if not ClientDataSet1.FieldByName('�ɼ�').IsNull then
      begin
        ClientDataSet1.Edit;
         ClientDataSet1.FieldByName('��ί��').Clear;
        ClientDataSet1.FieldByName('�ɼ�').Clear;
        ClientDataSet1.FieldByName('ActionTime').AsDateTime := Now;
        ClientDataSet1.Post;
        ii := ii+1;
        Inc(updateCound);
      end;

      if (ii>=1000) and DataSetNoSave(ClientDataSet1) then
      begin
        ii := 0;
        UpdateProgressTitle('���ڸ�������...');
        bl := dm.UpdateData('Id','select * from У�����Ƴɼ��� where 1=0',ClientDataSet1.Delta,False);//,True);
        if not bl then
          Break
        else
          ClientDataSet1.MergeChangeLog;
        //ShowMessage(IntToStr(ClientDataSet1.RecNo)+IntTostr(ii));
      end;
      ClientDataSet1.Next;
    end;

    if DataSetNoSave(ClientDataSet1) and (ii>0) then
    begin
      UpdateProgressTitle('���ڸ�������...');
      bl := dm.UpdateData('Id','select * from У�����Ƴɼ��� where 1=0',ClientDataSet1.Delta,False);//,True);
    end;

    if bl then
    begin
      MessageBox(Handle, PChar('�ɼ��ϳɴ�����ɣ����ι�������'+IntToStr(updateCound)+'����¼����'),
      'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
      ClientDataSet1.MergeChangeLog;
      //Open_Table;
    end else
    begin
      MessageBox(Handle, '���Ƴɼ��ϳ�ʧ�ܣ���������ԣ���',
        'ϵͳ��ʾ', MB_OK + MB_ICONERROR + MB_TOPMOST);
    end;

  finally
    HideProgress;
    cds_Source.Filtered := False;
    //DBGridEh1.SetFocus;
    ClientDataSet1.EnableControls;
    Open_Table;
    TBitBtn(Sender).Enabled := True;
  end;
end;

procedure TXkKmSjCjMerge.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmSjCjMerge.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    //if dm.UpdateData('id','select top 1 * from view_У�����Ƴɼ���',ClientDataSet1.Delta,True) then

    //if dm.SaveCjData(fCjIndex,ClientDataSet1.Delta) then
    //  ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TXkKmSjCjMerge.cbb_YxChange(Sender: TObject);
begin
  GetXkZyList;
end;

procedure TXkKmSjCjMerge.cbb_ZyChange(Sender: TObject);
begin
  if Self.Showing then
   Open_Table;
end;

procedure TXkKmSjCjMerge.cds_SourceFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  ksh:string;
begin
  ksh := ClientDataSet1.FieldByName('������').AsString;
  Accept := DataSet.FieldByName('������').AsString=ksh;
end;

procedure TXkKmSjCjMerge.DBGridEh1ColEnter(Sender: TObject);
begin
  DBGridEh1.SelectedIndex := 9;
end;

procedure TXkKmSjCjMerge.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKmSjCjMerge.FormShow(Sender: TObject);
begin
  GetYxList;
end;

procedure TXkKmSjCjMerge.GetCzyList;
begin
end;

function TXkKmSjCjMerge.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where �п�Ժϵ='+quotedstr(cbb_Yx.Text)+' and ���Կ�Ŀ='+quotedstr(cbb_Zy.Text);
  Result := sWhere;
end;

procedure TXkKmSjCjMerge.GetXkZyList;
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
    cbb_Zy.Text := '';
    cbb_Zy.Items.AddStrings(sList);
    cbb_Zy.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkKmSjCjMerge.GetYxList;
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

procedure TXkKmSjCjMerge.Open_CjCheck_Table;
var
  sqlstr:string;
begin
  cds_Source.DisableControls;
  try
    sqlstr := 'select ������,�п�Ժϵ,���Կ�Ŀ,���ճɼ� as �ɼ� from view_У������ɼ�У�Ա� '+GetWhere+' and ���ճɼ� is not null '+
              'order by �п�Ժϵ,���Կ�Ŀ,������,���ճɼ�';
    cds_Source.XMLData := DM.OpenData(sqlstr,True);
    if Self.Showing then
      DBGridEh1.SetFocus;
  finally
    cds_Source.EnableControls;
  end;
end;

function TXkKmSjCjMerge.InsertKsInfoToKmCjb:Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'insert into У�����Ƴɼ��� (������,�п�Ժϵ,���Կ�Ŀ) '+
            'select distinct ������,�п�Ժϵ,���Կ�Ŀ from view_У������ɼ�У�Ա� '+GetWhere+' and ���ճɼ� is not null '+
            'and ������+�п�Ժϵ+���Կ�Ŀ not in (select ������+�п�Ժϵ+���Կ�Ŀ from У�����Ƴɼ���) '+
            'order by ������,�п�Ժϵ,���Կ�Ŀ';
  Result := dm.ExecSql(sqlstr);
end;

procedure TXkKmSjCjMerge.Open_Table;
var
  sqlstr:string;
begin
  ClientDataSet1.DisableControls;
  try
    sqlstr := 'select * from view_У�����Ƴɼ��� '+GetWhere+' order by �п�Ժϵ,���Կ�Ŀ,������';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr,True);
    if Self.Showing then
      DBGridEh1.SetFocus;
  finally
    ClientDataSet1.EnableControls;
  end;
end;

procedure TXkKmSjCjMerge.rg_UpLoadClick(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkKmSjCjMerge.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
  fYx := Yx;
  fSf := Sf;
  fKm := Km;
end;

procedure TXkKmSjCjMerge.ShowErrorRecord;
var
  cds_Temp:TClientDataSet;
  sjBH:String;
  bFound:Boolean;
  CjIndex:Integer;
  ii:Integer;
begin
  cds_Temp := TClientDataSet.Create(nil);
  ClientDataSet1.DisableControls;
  try
    cds_Temp.XMLData := ClientDataSet1.XMLData;
    ShowProgress('���Ժ˶�...',cds_Temp.RecordCount);
    ClientDataSet1.First;
    ii := 0;
    while not ClientDataSet1.eof do
    begin
      ii := ii+1;
      UpdateProgress(ii);
      UpdateProgressTitle('���Ժ˶�['+IntToStr(ii)+'/'+IntToStr(cds_Temp.RecordCount)+']...');
      sjBH := ClientDataSet1.FieldByName('�Ծ���').AsString;
      if ClientDataSet1.FieldByName('¼�����').AsInteger=1 then
      begin
        CjIndex := 2;
      end else
      begin
        CjIndex := 1;
      end;
      bFound := False;
      if cds_Temp.Locate('�Ծ���;¼�����',varArrayOf([sjBH,CjIndex]),[]) then
      begin
        bFound := (ClientDataSet1.FieldByName('��Ŀ1��ֵ').Value=cds_Temp.FieldByName('��Ŀ1��ֵ').Value) and
           (ClientDataSet1.FieldByName('��Ŀ2��ֵ').Value=cds_Temp.FieldByName('��Ŀ2��ֵ').Value);
      end;
      if bFound then
        ClientDataSet1.Delete
      else
        ClientDataSet1.Next;
    end;
    ClientDataSet1.MergeChangeLog;
  finally
    cds_Temp.Free;
    ClientDataSet1.EnableControls;
    HideProgress;
  end;
end;

end.
