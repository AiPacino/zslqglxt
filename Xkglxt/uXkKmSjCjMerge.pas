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
    PChar('审核操作将对两组录入员已录入的成绩进行一致性检查，　　'+#13+'现在真的要开始审核吗？　　'), '系统提示',
    MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  iCount := 0;
  sqlstr1 := 'select * from 校考卷面成绩明细表 '+GetWhere+' and 录入分组=1 order by 试卷编号';
  sqlstr2 := 'select * from 校考卷面成绩明细表 '+GetWhere+' and 录入分组=2 order by 试卷编号';
  cds_1 := TClientDataSet.Create(nil);
  cds_2 := TClientDataSet.Create(nil);
  cds_1.XMLData := DM.OpenData(sqlstr1);

  ShowProgress('正在审核...',cds_1.RecordCount);

  cds_2.XMLData := DM.OpenData(sqlstr2);

  try
    cds_1.First;
    while not Cds_1.Eof do
    begin
      UpdateProgress(cds_1.RecNo);
      sjBH := cds_1.FieldByName('试卷编号').AsString;

      //cj1 := cds_1.FieldByName('项目1成绩').AsFloat;
      //cj2 := cds_1.FieldByName('项目2成绩').AsFloat;

      if cds_2.Locate('试卷编号',sjBH,[]) then
      begin
        if (cds_2.FieldByName('项目1分值').Value = cds_1.FieldByName('项目1分值').Value) and
           (cds_2.FieldByName('项目2分值').Value = cds_1.FieldByName('项目2分值').Value) then
        begin
          iCount := iCount+1;
          cds_2.Edit;
          cds_2.FieldByName('是否审核').AsBoolean := True;
          cds_2.FieldByName('审核时间').Value := Now;
          cds_2.FieldByName('审核员').Value := gb_Czy_ID;
          cds_2.Post;

          cds_1.Edit;
          cds_1.FieldByName('是否审核').AsBoolean := True;
          cds_1.FieldByName('审核时间').Value := Now;
          cds_1.FieldByName('审核员').Value := gb_Czy_ID;
          cds_1.Post;
        end else
        begin
          cds_2.Edit;
          cds_2.FieldByName('是否审核').AsBoolean := False;
          cds_2.FieldByName('审核时间').Value := null;
          cds_2.FieldByName('审核员').Value := null;
          cds_2.Post;

          cds_1.Edit;
          cds_1.FieldByName('是否审核').AsBoolean := False;
          cds_1.FieldByName('审核时间').Value := null;
          cds_1.FieldByName('审核员').Value := null;
          cds_1.Post;
        end;
      end else
      begin
        cds_1.Edit;
        cds_1.FieldByName('是否审核').AsBoolean := False;
        cds_1.FieldByName('审核时间').Value := null;
        cds_1.FieldByName('审核员').Value := null;
        cds_1.Post;
      end;

      cds_1.Next;
    end;

    if cds_1.ChangeCount>0 then
      bl1 := dm.UpdateData('Id','select * from 校考卷面成绩明细表 where 1=0',cds_1.Delta,False);
    if cds_2.ChangeCount>0 then
      bl2 := dm.UpdateData('Id','select * from 校考卷面成绩明细表 where 1=0',cds_2.Delta,False);

    MessageBox(Handle, PChar('处理完成！'+InttoStr(iCount)+'条记录已审核通过，请查看审核结果！　'), '系统提示', MB_OK +
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
  if Application.MessageBox('真的要合成当前显示考生的单科成绩吗？　', '系统提示', MB_YESNO + MB_ICONQUESTION +
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
    ShowProgress('正在合成...',ClientDataSet1.RecordCount);
    ClientDataSet1.DisableControls;
    ii := 0;
    updateCound := 0;
    bl := True;
    while not ClientDataSet1.Eof do
    begin
      UpdateProgress(ClientDataSet1.RecNo);
      UpdateProgressTitle('正在合成...['+InttoStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount)+']');
      ksh := ClientDataSet1.FieldByName('考生号').AsString;
      yx := ClientDataSet1.FieldByName('承考院系').AsString;
      km := ClientDataSet1.FieldByName('考试科目').AsString;
      cds_Source.Filtered := False;
      cds_Source.Filtered := True;

      iCount := cds_Source.RecordCount;
      //iCount := 0;
      cj := 0;
      sumcj := 0;
      cds_Source.First;
      maxcj := cds_Source.FieldByName('成绩').AsFloat;
      mincj := cds_Source.FieldByName('成绩').AsFloat;
      while not cds_Source.Eof do
      begin
        cj := cds_Source.FieldByName('成绩').AsFloat;
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
        if (cj<>ClientDataSet1.FieldByName('成绩').AsFloat) then
        begin
          ClientDataSet1.Edit;
          ClientDataSet1.FieldByName('评委数').AsInteger := iCount;
          ClientDataSet1.FieldByName('成绩').AsFloat := cj;
          ClientDataSet1.FieldByName('ActionTime').AsDateTime := Now;
          ClientDataSet1.Post;
          ii := ii+1;
          Inc(updateCound);
        end;
      end
      else if not ClientDataSet1.FieldByName('成绩').IsNull then
      begin
        ClientDataSet1.Edit;
         ClientDataSet1.FieldByName('评委数').Clear;
        ClientDataSet1.FieldByName('成绩').Clear;
        ClientDataSet1.FieldByName('ActionTime').AsDateTime := Now;
        ClientDataSet1.Post;
        ii := ii+1;
        Inc(updateCound);
      end;

      if (ii>=1000) and DataSetNoSave(ClientDataSet1) then
      begin
        ii := 0;
        UpdateProgressTitle('正在更新数据...');
        bl := dm.UpdateData('Id','select * from 校考单科成绩表 where 1=0',ClientDataSet1.Delta,False);//,True);
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
      UpdateProgressTitle('正在更新数据...');
      bl := dm.UpdateData('Id','select * from 校考单科成绩表 where 1=0',ClientDataSet1.Delta,False);//,True);
    end;

    if bl then
    begin
      MessageBox(Handle, PChar('成绩合成处理完成！本次共处理了'+IntToStr(updateCound)+'条记录！　'),
      '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
      ClientDataSet1.MergeChangeLog;
      //Open_Table;
    end else
    begin
      MessageBox(Handle, '单科成绩合成失败，请检查后重试！　',
        '系统提示', MB_OK + MB_ICONERROR + MB_TOPMOST);
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
    //if dm.UpdateData('id','select top 1 * from view_校考单科成绩表',ClientDataSet1.Delta,True) then

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
  ksh := ClientDataSet1.FieldByName('考生号').AsString;
  Accept := DataSet.FieldByName('考生号').AsString=ksh;
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
  sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text)+' and 考试科目='+quotedstr(cbb_Zy.Text);
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

procedure TXkKmSjCjMerge.Open_CjCheck_Table;
var
  sqlstr:string;
begin
  cds_Source.DisableControls;
  try
    sqlstr := 'select 考生号,承考院系,考试科目,最终成绩 as 成绩 from view_校考卷面成绩校对表 '+GetWhere+' and 最终成绩 is not null '+
              'order by 承考院系,考试科目,考生号,最终成绩';
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
  sqlstr := 'insert into 校考单科成绩表 (考生号,承考院系,考试科目) '+
            'select distinct 考生号,承考院系,考试科目 from view_校考卷面成绩校对表 '+GetWhere+' and 最终成绩 is not null '+
            'and 考生号+承考院系+考试科目 not in (select 考生号+承考院系+考试科目 from 校考单科成绩表) '+
            'order by 考生号,承考院系,考试科目';
  Result := dm.ExecSql(sqlstr);
end;

procedure TXkKmSjCjMerge.Open_Table;
var
  sqlstr:string;
begin
  ClientDataSet1.DisableControls;
  try
    sqlstr := 'select * from view_校考单科成绩表 '+GetWhere+' order by 承考院系,考试科目,考生号';
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
    ShowProgress('正对核对...',cds_Temp.RecordCount);
    ClientDataSet1.First;
    ii := 0;
    while not ClientDataSet1.eof do
    begin
      ii := ii+1;
      UpdateProgress(ii);
      UpdateProgressTitle('正对核对['+IntToStr(ii)+'/'+IntToStr(cds_Temp.RecordCount)+']...');
      sjBH := ClientDataSet1.FieldByName('试卷编号').AsString;
      if ClientDataSet1.FieldByName('录入分组').AsInteger=1 then
      begin
        CjIndex := 2;
      end else
      begin
        CjIndex := 1;
      end;
      bFound := False;
      if cds_Temp.Locate('试卷编号;录入分组',varArrayOf([sjBH,CjIndex]),[]) then
      begin
        bFound := (ClientDataSet1.FieldByName('项目1分值').Value=cds_Temp.FieldByName('项目1分值').Value) and
           (ClientDataSet1.FieldByName('项目2分值').Value=cds_Temp.FieldByName('项目2分值').Value);
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
