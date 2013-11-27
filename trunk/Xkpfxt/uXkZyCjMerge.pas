unit uXkZyCjMerge;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,uXkKsKmCjBrowse,
  DBGridEhGrouping;

type
  TXkZyCjMerge = class(TForm)
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
    btn_Merge: TBitBtn;
    grp1: TGroupBox;
    cbb_Zy: TDBComboBoxEh;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    cds_Source: TClientDataSet;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_ZyChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueChange(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure btn_MergeClick(Sender: TObject);
    procedure cds_SourceFilterRecord(DataSet: TDataSet; var Accept: Boolean);
  private
    { Private declarations }
    fDeltaForm:TXkKsKmcjBrowse;
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
    procedure GetXkZyList;
    procedure GetYxList;
    procedure Open_KmCj_Table;
  public
    { Public declarations }
  end;

var
  XkZyCjMerge: TXkZyCjMerge;

implementation
uses uDM,CnProgressFrm;
{$R *.dfm}

procedure TXkZyCjMerge.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TXkZyCjMerge.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkZyCjMerge.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkZyCjMerge.btn_MergeClick(Sender: TObject);
var
  ksh,yx,zy,km:string;
  cj:Double;
  ii,iCount,updateCound,cjbl,bl_temp:Integer;
  bl:Boolean;
begin
  if Application.MessageBox('真的要合成当前显示考生的专业成绩吗？　', '系统提示', MB_YESNO + MB_ICONQUESTION +
    MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  Open_KmCj_Table;
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
      zy := ClientDataSet1.FieldByName('专业').AsString;
      //km := ClientDataSet1.FieldByName('考试科目').AsString;
      cds_Source.Filtered := False;
      cds_Source.Filtered := True;

      iCount := cds_Source.RecordCount;
      //iCount := 0;
      cjbl := 0;
      cj := 0;
      cds_Source.First;
      while not cds_Source.Eof do
      begin
        bl_temp := cds_Source.FieldByName('成绩所占比例').AsInteger;
        cjbl := cjbl + bl_temp;
        if cds_Source.FieldByName('成绩').IsNull then
        begin
          cjbl := 0;
          Break;
        end;
        cj := cj+cds_Source.FieldByName('成绩').AsFloat*bl_temp/100;
        cds_Source.Next;
      end;

      if (iCount>0) and (cjbl=100) then
      begin
        cj := Trunc(cj*1000+0.5)/1000;
        if (cj<>ClientDataSet1.FieldByName('成绩').AsFloat) then
        begin
          ClientDataSet1.Edit;
          //ClientDataSet1.FieldByName('评委数').AsInteger := iCount;
          ClientDataSet1.FieldByName('成绩').AsFloat := cj;
          //ClientDataSet1.FieldByName('ActionTime').AsDateTime := Now;
          ClientDataSet1.Post;
          ii := ii+1;
          Inc(updateCound);
        end;
      end
      else if cjbl=0 then
      begin
        ClientDataSet1.Edit;
        //ClientDataSet1.FieldByName('评委数').Clear;
        ClientDataSet1.FieldByName('成绩').Clear;
        //ClientDataSet1.FieldByName('ActionTime').AsDateTime := Now;
        ClientDataSet1.Post;
        ii := ii+1;
        Inc(updateCound);
      end;

      if (ii>=1000) and DataSetNoSave(ClientDataSet1) then
      begin
        ii := 0;
        UpdateProgressTitle('正在更新数据...');
        bl := dm.UpdateData('Id','select * from view_校考专业成绩表 where 1=0',ClientDataSet1.Delta,False);//,True);
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
      bl := dm.UpdateData('Id','select * from view_校考专业成绩表 where 1=0',ClientDataSet1.Delta,False);//,True);
    end;

    if bl then
    begin
      MessageBox(Handle, PChar('专业成绩合成处理完成！本次共处理了'+IntToStr(updateCound)+'条记录！　'),
      '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
      ClientDataSet1.MergeChangeLog;
      //Open_Table;
    end else
    begin
      MessageBox(Handle, '专业成绩合成失败，请检查后重试！　',
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

procedure TXkZyCjMerge.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkZyCjMerge.btn_SearchClick(Sender: TObject);
begin
  if not ClientDataSet1.Locate(cbb_Field.Text,edt_Value.Text,[]) then
  begin
    Application.MessageBox('未找到符合查询条件的记录！请检查后重试！　',
      '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
    edt_Value.SetFocus;
  end else
    DBGridEh1.SetFocus;
end;

procedure TXkZyCjMerge.cbb_YxChange(Sender: TObject);
begin
  GetXkZyList;
end;

procedure TXkZyCjMerge.cbb_ZyChange(Sender: TObject);
begin
  if cbb_Zy.Text='' then Exit;

  if Self.Showing then
    Open_Table;
end;

procedure TXkZyCjMerge.cds_SourceFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  ksh,zy:string;
begin
  ksh := ClientDataSet1.FieldByName('考生号').AsString;
  zy := ClientDataSet1.FieldByName('专业').AsString;
  Accept := (DataSet.FieldByName('考生号').AsString=ksh) and
            (DataSet.FieldByName('专业').AsString=zy);
end;

procedure TXkZyCjMerge.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if Self.Showing and fDeltaForm.Showing then
  begin
    DBGridEh1DblClick(Self);
  end;
end;

procedure TXkZyCjMerge.DBGridEh1DblClick(Sender: TObject);
var
  yx,zy,ksh:string;
begin
  if not ClientDataSet1.FieldByName('考生号').IsNull then
  begin
    yx := ClientDataSet1.FieldByName('承考院系').AsString;
    zy := ClientDataSet1.FieldByName('专业').AsString;
    ksh := ClientDataSet1.FieldByName('考生号').AsString;
    fDeltaForm.Open_Table(yx,zy,ksh);
    if not fDeltaForm.Showing then
      fDeltaForm.Show;
  end;
end;

procedure TXkZyCjMerge.edt_ValueChange(Sender: TObject);
begin
  btn_Search.Click;
end;

procedure TXkZyCjMerge.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TXkZyCjMerge.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkZyCjMerge.FormCreate(Sender: TObject);
begin
  fDeltaForm := TXkKsKmcjBrowse.Create(nil);
  fDeltaForm.Left := Screen.Width-fDeltaform.Width-10;
  fDeltaForm.Top := 70;
end;

procedure TXkZyCjMerge.FormDestroy(Sender: TObject);
begin
  fDeltaForm.Free;
end;

procedure TXkZyCjMerge.FormShow(Sender: TObject);
begin
  GetYxList;
end;

procedure TXkZyCjMerge.GetSfList;
begin
end;

function TXkZyCjMerge.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text);
  sWhere := sWhere+' and 专业='+quotedstr(cbb_Zy.Text);
  Result := sWhere;
end;

procedure TXkZyCjMerge.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select distinct 专业 from 校考专业表 where 承考院系='+quotedstr(cbb_Yx.Text),True);
    cbb_Zy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('专业').AsString);
      cds_Temp.Next;
    end;
    cbb_Zy.Text := '';
    //cbb_Zy.Items.Add('不限专业');
    cbb_Zy.Items.AddStrings(sList);
    if cbb_Zy.Items.Count>0 then
      cbb_Zy.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkZyCjMerge.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    //if gb_Czy_Level<>'2' then
    begin
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
    end;// else
    //  sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkZyCjMerge.Open_KmCj_Table;
var
  sqlstr:string;
begin
  cds_Source.DisableControls;
  try
    sqlstr := 'select 考生号,承考院系,专业,考试科目,成绩,成绩所占比例,评委数 from view_校考单科成绩比例表 '+GetWhere+' order by 考生号,承考院系,专业,考试科目';
    cds_Source.XMLData := DM.OpenData(sqlstr,True);
    if Self.Showing then
      DBGridEh1.SetFocus;
  finally
    cds_Source.EnableControls;
  end;
end;

procedure TXkZyCjMerge.Open_Table;
var
  sqlstr:string;
begin
  ClientDataSet1.DisableControls;
  try
    sqlstr := 'select * from View_校考专业成绩表 '+GetWhere+' order by 考生号,专业';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr,True);
    if Self.Showing then
      DBGridEh1.SetFocus;
  finally
    ClientDataSet1.EnableControls;
  end;
end;

end.
