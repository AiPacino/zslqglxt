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
    '真的要生成卷面最终成绩吗？　　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  ShowProgress('正在校对...',ClientDataSet1.RecordCount);
  TBitBtn(Sender).Enabled := False;
  ClientDataSet1.DisableControls;
  try
    ClientDataSet1.First;
    iCount := 0;
    ii := 0;
    while not ClientDataSet1.Eof do
    begin
      UpdateProgress(ClientDataSet1.RecNo);
      UpdateProgressTitle('正在校对...['+InttoStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount)+']');
      if (not ClientDataSet1.FieldByName('是否审核').AsBoolean) and (ClientDataSet1.FieldByName('成绩1').AsFloat=ClientDataSet1.FieldByName('成绩2').AsFloat)
         and (ClientDataSet1.FieldByName('最终成绩').Value <> ClientDataSet1.FieldByName('成绩1').Value) then
      begin
        ClientDataSet1.Edit;
        ClientDataSet1.FieldByName('最终成绩').Value := ClientDataSet1.FieldByName('成绩1').Value;
        ClientDataSet1.FieldByName('审核人').Value := gb_Czy_ID;
        ClientDataSet1.FieldByName('审核时间').Value := now;
        ClientDataSet1.Post;
        iCount := iCount+1;
        ii := ii+1;
      end;
      if ii>1000 then
      begin
        ii := 0;
        UpdateProgressTitle('正在更新数据...['+InttoStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount)+']');
        if DataSetNoSave(ClientDataSet1) then
          if dm.UpdateData('Id','select * from  view_校考卷面成绩校对表 where 1=0',ClientDataSet1.Delta,False) then
          begin
            ClientDataSet1.MergeChangeLog;
          end else
            Exit;
      end;
  {
      Id := ClientDataSet1.FieldByName('Id').AsString;
      cj :=  ClientDataSet1.FieldByName('最终成绩').AsFloat;
      sqlstr := 'update 校考单科成绩表 set 最终成绩='+FloatToStr(cj)+',审核人='+quotedstr(gb_Czy_Id)+
              ' where Id='+Id;
      if not dm.ExecSql(sqlstr) then Exit;
  }
      ClientDataSet1.Next;
    end;

    if DataSetNoSave(ClientDataSet1) and (ii>0) then
    begin
      UpdateProgressTitle('正在更新数据...['+InttoStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount)+']');
      if dm.UpdateData('Id','select * from  view_校考卷面成绩校对表 where 1=0',ClientDataSet1.Delta,False) then
      begin
        ClientDataSet1.MergeChangeLog;
      end else
        Exit;
    end;
    sMsg := '卷面最终成绩处理完成！本次共处理了'+IntToStr(iCount)+'条记录！　';
    MessageBox(Handle, PChar(sMsg), '系统提示', MB_OK +
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
    //if dm.UpdateData('id','select top 1 * from view_校考单科成绩表',ClientDataSet1.Delta,True) then

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
    MessageBox(Handle, PChar('未找到'+cbb_field.Text+'为【'+edt_Value.Text+'】'+'的考生！　　' + #13#10 + '请检查后重新查询！'),
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);

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
  DataSet.FieldByName('审核人').AsString := gb_Czy_ID;
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
    cds_Temp.XMLData := dm.OpenData('select distinct 省份 from 校考考点设置表 where 承考院系= '+quotedstr(cbb_Yx.Text));
    cbb_Sf.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('省份').AsString);
      cds_Temp.Next;
    end;
    //cbb_Sf.Items.Add('不限省份');
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
  sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text)+' and 考试科目='+quotedstr(cbb_Zy.Text);

  if chk_ALL.Checked then
    sWhere := sWhere + ' and (成绩1<>成绩2 or 成绩1 is null or 成绩2 is null) ';
  //else
  //  sWhere := sWhere + ' and 成绩1=成绩2';

  Result := sWhere;
  //Result := ' where 承考院系='+quotedstr(fYx)+' and 省份='+quotedstr(fSf)+
  //          ' and 考试科目='+quotedstr(fKm);
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

procedure TXkKmCjCheck.GetYxList;
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

procedure TXkKmCjCheck.N3Click(Sender: TObject);
begin
  if not chk_ALL.Checked then chk_ALL.Checked := True;
  PrintDBGridEH(dbgrideh1,Self,'成绩录入数据不一致清单');
end;

procedure TXkKmCjCheck.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from  view_校考卷面成绩校对表 '+GetWhere+' order by 考生号';
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
