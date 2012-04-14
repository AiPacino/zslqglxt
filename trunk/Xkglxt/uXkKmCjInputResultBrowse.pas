unit uXkKmCjInputResultBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons, CnProgressFrm,
  ExtCtrls, Pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, Menus,
  DBGridEhGrouping;

type
  TXkKmCjInputResultBrowse = class(TForm)
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
    PopupMenu1: TPopupMenu;
    L1: TMenuItem;
    C1: TMenuItem;
    P1: TMenuItem;
    P2: TMenuItem;
    E1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    rg_Confirm: TRadioGroup;
    DBGridEh1: TDBGridEh;
    chk_ShowFilter: TCheckBox;
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
    procedure btn_SaveClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btn_ConfirmClick(Sender: TObject);
    procedure rg_ConfirmClick(Sender: TObject);
    procedure chk_ShowFilterClick(Sender: TObject);
  private
    { Private declarations }
    fCjIndex:Integer;
    fYx,fSf,fKm,fCjField,fCzyField:string;
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetXkZyList;
    procedure GetYxList;
    procedure ShowErrorRecord;
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string);
  end;

var
  XkKmCjInputResultBrowse: TXkKmCjInputResultBrowse;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKmCjInputResultBrowse.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TXkKmCjInputResultBrowse.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKmCjInputResultBrowse.btn_ConfirmClick(Sender: TObject);
var
  sjBH,Id,sqlstr1,sqlstr2:string;
  cds_1,cds_2:TClientDataSet;
  bFound,bl1,bl2:Boolean;
  iCount:Integer;
begin

  if MessageBox(Handle,
    PChar('提交操作将对两组录入员已录入的成绩进行一致性检查，　　'+#13+'现在真的要开始提交吗？　　'), '系统提示',
    MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  iCount := 0;
  sqlstr1 := 'select * from view_校考卷面成绩录入表 '+GetWhere+' and 录入分组=1 order by 考生号';
  sqlstr2 := 'select * from view_校考卷面成绩录入表 '+GetWhere+' and 录入分组=2 order by 考生号';
  cds_1 := TClientDataSet.Create(nil);
  cds_2 := TClientDataSet.Create(nil);
  cds_1.XMLData := DM.OpenData(sqlstr1);

  ShowProgress('正在提交...',cds_1.RecordCount);

  cds_2.XMLData := DM.OpenData(sqlstr2);

  try
    cds_1.First;
    while not Cds_1.Eof do
    begin
      UpdateProgress(cds_1.RecNo);
      sjBH := cds_1.FieldByName('考生号').AsString;

      //cj1 := cds_1.FieldByName('项目1成绩').AsFloat;
      //cj2 := cds_1.FieldByName('项目2成绩').AsFloat;

      if cds_2.Locate('考生号',sjBH,[]) then
      begin
        if (cds_2.FieldByName('成绩').Value = cds_1.FieldByName('成绩').Value) then
        begin
          iCount := iCount+1;
          cds_2.Edit;
          cds_2.FieldByName('是否提交').AsBoolean := True;
          cds_2.FieldByName('提交时间').Value := Now;
          cds_2.FieldByName('提交员').Value := gb_Czy_ID;
          cds_2.Post;

          cds_1.Edit;
          cds_1.FieldByName('是否提交').AsBoolean := True;
          cds_1.FieldByName('提交时间').Value := Now;
          cds_1.FieldByName('提交员').Value := gb_Czy_ID;
          cds_1.Post;
        end else
        begin
          cds_2.Edit;
          cds_2.FieldByName('是否提交').AsBoolean := False;
          cds_2.FieldByName('提交时间').Value := null;
          cds_2.FieldByName('提交员').Value := null;
          cds_2.Post;

          cds_1.Edit;
          cds_1.FieldByName('是否提交').AsBoolean := False;
          cds_1.FieldByName('提交时间').Value := null;
          cds_1.FieldByName('提交员').Value := null;
          cds_1.Post;
        end;
      end else
      begin
        cds_1.Edit;
        cds_1.FieldByName('是否提交').AsBoolean := False;
        cds_1.FieldByName('提交时间').Value := null;
        cds_1.FieldByName('提交员').Value := null;
        cds_1.Post;
      end;

      cds_1.Next;
    end;

    if cds_1.ChangeCount>0 then
      bl1 := dm.UpdateData('Id','select * from view_校考卷面成绩录入表 where 1=0',cds_1.Delta,False);
    if cds_2.ChangeCount>0 then
      bl2 := dm.UpdateData('Id','select * from view_校考卷面成绩录入表 where 1=0',cds_2.Delta,False);

    MessageBox(Handle, PChar('处理完成！'+InttoStr(iCount)+'条记录已提交通过，请查看提交结果！　'), '系统提示', MB_OK +
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

procedure TXkKmCjInputResultBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmCjInputResultBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmCjInputResultBrowse.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    //if dm.UpdateData('id','select top 1 * from view_校考单科成绩表',ClientDataSet1.Delta,True) then

    //if dm.SaveCjData(fCjIndex,ClientDataSet1.Delta) then
    //  ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TXkKmCjInputResultBrowse.btn_SearchClick(Sender: TObject);
begin
  if Trim(edt_Value.Text)='' then Exit;
  if ClientDataSet1.Locate(cbb_Field.Text,edt_Value.Text,[]) then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.SelectedIndex := 13;
  end else
    MessageBox(Handle, PChar('未找到'+cbb_field.Text+'为【'+edt_Value.Text+'】'+'的考生！　　' + #13#10 + '请检查后重新查询！'),
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);

end;

procedure TXkKmCjInputResultBrowse.cbb_YxChange(Sender: TObject);
begin
  GetXkZyList;
  //Open_Table;
end;

procedure TXkKmCjInputResultBrowse.cbb_ZyChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkKmCjInputResultBrowse.chk_ShowFilterClick(Sender: TObject);
begin
  DBGridEh1.STFilter.Visible := chk_ShowFilter.Checked;
end;

procedure TXkKmCjInputResultBrowse.DBGridEh1ColEnter(Sender: TObject);
begin
  DBGridEh1.SelectedIndex := 9;
end;

procedure TXkKmCjInputResultBrowse.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  cj1,cj2:Double;
begin
{
  //if (ClientDataSet1.FieldByName('最终成绩').AsString='') or
  if (ClientDataSet1.FieldByName('成绩1').IsNull) or
     (ClientDataSet1.FieldByName('成绩2').IsNull) then
  begin
    Exit;
  end;

  if Column.FieldName='最终成绩' then
  begin
    cj1 := ClientDataSet1.FieldByName('成绩1').AsFloat;
    cj2 := ClientDataSet1.FieldByName('成绩2').AsFloat;
    if (ClientDataSet1.FieldByName('最终成绩').AsString='') and (cj1<>cj2) then
      Column.Color := clRed
    //else
    //  Column.Color := clGreen;
  end;
}
end;

procedure TXkKmCjInputResultBrowse.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TXkKmCjInputResultBrowse.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TXkKmCjInputResultBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKmCjInputResultBrowse.FormShow(Sender: TObject);
begin
  GetYxList;
end;

function TXkKmCjInputResultBrowse.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text)+' and 考试科目='+quotedstr(cbb_Zy.Text);
  if rg_Confirm.ItemIndex=0 then
    sWhere := sWhere +' and 是否提交=1 '
  else
    sWhere := sWhere +' and 是否提交=0 ';
{
  if chk_ALL.Checked then
    sWhere := sWhere + ' and (成绩1<>成绩2) '
  else
    sWhere := sWhere + ' and 成绩1=成绩2';
}
  Result := sWhere;
  //Result := ' where 承考院系='+quotedstr(fYx)+' and 省份='+quotedstr(fSf)+
  //          ' and 考试科目='+quotedstr(fKm);
end;

procedure TXkKmCjInputResultBrowse.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
  sqlstr:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    sqlstr := 'select distinct Id,考试科目 from 校考科目表 where 承考院系='+quotedstr(cbb_Yx.Text)+
              ' order by Id';
    cds_Temp.XMLData := dm.OpenData(sqlstr);
    cbb_Zy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('考试科目').AsString);
      cds_Temp.Next;
    end;
    //cbb_Zy.Items.Add('不限科目');
    cbb_Zy.Items.AddStrings(sList);
    cbb_Zy.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkKmCjInputResultBrowse.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkKmCjInputResultBrowse.Open_Table;
var
  sqlstr:string;
begin
  ClientDataSet1.DisableControls;
  try
    sqlstr := 'select * from view_校考卷面成绩录入表 '+GetWhere+' order by 考生号,评委,录入分组';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr,True);
    if Self.Showing then
      DBGridEh1.SetFocus;
  finally
    ClientDataSet1.EnableControls;
  end;
end;

procedure TXkKmCjInputResultBrowse.rg_ConfirmClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmCjInputResultBrowse.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
  fYx := Yx;
  fSf := Sf;
  fKm := Km;
end;

procedure TXkKmCjInputResultBrowse.ShowErrorRecord;
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
    ShowProgress('正对核对...',cds_Temp.RecordCount);
    ClientDataSet1.First;
    ii := 0;
    while not ClientDataSet1.eof do
    begin
      ii := ii+1;
      UpdateProgress(ii);
      UpdateProgressTitle('正对核对['+IntToStr(ii)+'/'+IntToStr(cds_Temp.RecordCount)+']...');
      sjBH := ClientDataSet1.FieldByName('考生号').AsString;
      if ClientDataSet1.FieldByName('录入分组').AsInteger=1 then
      begin
        CjIndex := 2;
      end else
      begin
        CjIndex := 1;
      end;
      bFound := False;
      if cds_Temp.Locate('考生号;录入分组',varArrayOf([sjBH,CjIndex]),[]) then
      begin
        bFound := (ClientDataSet1.FieldByName('成绩').Value=cds_Temp.FieldByName('成绩').Value);
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
