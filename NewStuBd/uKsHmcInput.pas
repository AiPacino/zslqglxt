unit uKsHmcInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ActnList, DB,StrUtils, DBGridEhImpExp,uKsHmcEdit,
  Menus, ImgList, frxClass, frxDBSet, frxDesgn, StdCtrls, Spin, DBCtrls,
  MyDBNavigator, StatusBarEx, GridsEh, DBGridEh, uStuInfo,uFormatKL,uFormatZy,
  DBFieldComboBox, StdActns, pngimage, DBClient, DBGridEhGrouping, frxpngimage,
  Mask, DBCtrlsEh;

type
  TKsHmcInput = class(TForm)
    pnl2: TPanel;
    cbb_Value: TEdit;
    il1: TImageList;
    pm1: TPopupMenu;
    MenuItem3: TMenuItem;
    pmi_Excel: TMenuItem;
    ds_Access: TDataSource;
    dlgSave_1: TSaveDialog;
    btn_OK: TBitBtn;
    btn_Adv: TBitBtn;
    pmi_Refresh: TMenuItem;
    cbb_Field: TDBFieldComboBox;
    C1: TMenuItem;
    X1: TMenuItem;
    P1: TMenuItem;
    pnl_Title: TPanel;
    img_Title: TImage;
    lbl_Title: TLabel;
    lbl1: TLabel;
    DBGridEH1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    grp_Yx: TGroupBox;
    cbb_XlCc: TDBComboBoxEh;
    GroupBox1: TGroupBox;
    cbb_KL: TDBComboBoxEh;
    grp_Sf: TGroupBox;
    cbb_Sf: TDBComboBoxEh;
    grp_Lb: TGroupBox;
    cbb_Lb: TDBComboBoxEh;
    N1: TMenuItem;
    mni_Sf: TMenuItem;
    btn_SqlWhere: TBitBtn;
    cbb_Compare: TDBComboBoxEh;
    img_Hint: TImage;
    lbl_Len: TLabel;
    btn_Edit: TBitBtn;
    lbl_Filter: TLabel;
    mniN2: TMenuItem;
    N2: TMenuItem;
    procedure mmi_ExitClick(Sender: TObject);
    procedure mmi_ExcelClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ds_AccessDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmi_PrnEMSClick(Sender: TObject);
    procedure rg2Click(Sender: TObject);
    procedure pmi_RefreshClick(Sender: TObject);
    procedure DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure chk_NotJxClick(Sender: TObject);
    procedure cbb_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure chk_ZyNotSameClick(Sender: TObject);
    procedure DBGridEH1DblClick(Sender: TObject);
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
    procedure cbb_XlCcChange(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure mni_SfClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure DBGridEH1TitleClick(Column: TColumnEh);
    procedure btn_SqlWhereClick(Sender: TObject);
    procedure cbb_CompareChange(Sender: TObject);
    procedure cbb_ValueChange(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure mniN2Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    //FormatKL:TFormatKL;
    //FormatZy:TFormatZyMc;
    aForm:TKsHmcEdit;
    StuInfo:TStuInfo;
    vsorted :Boolean;
    repfn:string;
    sWhereList:Tstrings;
    procedure Open_Access_Table(const sWhere:string='');
    function  GetFilterString: String;
    function  GetOrderString:string;
    procedure GetWhereList;
    procedure ShowEditForm(const ksh:string);
    procedure SaveData;
  public
    { Public declarations }
  end;

var
  KsHmcInput: TKsHmcInput;

implementation

uses uDM, uMain,uSQLWhere;

{$R *.dfm}

procedure TKsHmcInput.mmi_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsHmcInput.mmi_ExcelClick(Sender: TObject);
var
  fn,Ext,mfn:string;
begin
  dlgSave_1.FileName := '考生花名册录入情况表.xls';
  if dlgSave_1.Execute then
  begin
    if FileExists(dlgSave_1.FileName) then
      if MessageBox(Handle, PChar('Excel文件：'+dlgSave_1.FileName+'已存在，要覆盖它吗？　　'), '文件已存在', MB_YESNO + MB_ICONWARNING +
        MB_DEFBUTTON2) = IDNO then
        Exit
      else
        DeleteFile(dlgSave_1.FileName);

    try
      Screen.Cursor := crHourGlass;
      fn := dlgSave_1.FileName;
      Ext := ExtractFileExt(fn);
      mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
      SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,DBGridEH1, fn,True);
      DBGridEH1.SetFocus;
    finally
      Screen.Cursor := crDefault;
      MessageBox(Handle, 'Excel文件导出完成！　　', '导出成功', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TKsHmcInput.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Access_Table;
  if Self.Showing then
    DBGridEH1.SetFocus;
end;

procedure TKsHmcInput.btn_EditClick(Sender: TObject);
begin
{
  if DM.ExecSql('alter table lqmd add 花名册行号 INT') then
    ShowMessage('ok')
  else
    ShowMessage('error');
}
  ShowEditForm('');
end;

procedure TKsHmcInput.btn_OKClick(Sender: TObject);
begin
  Open_Access_Table;
  if cbb_Value.CanFocus then
    cbb_Value.SetFocus;
end;

procedure TKsHmcInput.btn_RefreshClick(Sender: TObject);
begin
  Open_Access_Table();
end;

procedure TKsHmcInput.btn_SqlWhereClick(Sender: TObject);
begin
  if GetSqlWhere(ClientDataSet1,sWhereList) then
    Open_Access_Table(sWhereList.Text);
end;

procedure TKsHmcInput.FormCreate(Sender: TObject);
var
  path,fn :string;
  sList:TStrings;
  ii:Integer;
begin
  Self.Left := Trunc((Main.Width - Self.Width)/2);
  //Self.Top := Trunc((Main.Height - Self.Height)/2);
  Self.Top := 15;
  sList := TStringList.Create;
  dm.SetXlCcComboBox(cbb_XlCc);

  dm.SetCzySfComboBox(cbb_XlCc.Items[cbb_XlCc.ItemIndex],cbb_Sf,False);
  dm.SetLbComboBox(cbb_Lb,True);

  dm.SetKlComboBox(cbb_KL,True);

  try
    aForm := TKsHmcEdit.Create(Self);
    StuInfo := TStuInfo.Create(Self);
    StuInfo.DataSource1.DataSet := ClientDataSet1;
    sWhereList := TStringList.Create;
    Open_Access_Table;
  finally
    sList.Free;
  end;
end;

procedure TKsHmcInput.FormDestroy(Sender: TObject);
begin
  FreeAndNil(StuInfo);
  FreeAndNil(aForm);
  FreeAndNil(sWhereList);
end;

procedure TKsHmcInput.Open_Access_Table(const sWhere:string='');
var
  vxzstr,vfilterstr,vordstr:string;
  sqlStr:string;
begin
  Repfn := ExtractFilePath(Application.ExeName)+'Rep\'+cbb_xlcc.Text+'考生花名册录入情况表.fr3';

  if sWhere='' then
    GetWhereList
  else
    sWhereList.Text := sWhere;

  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    sqlStr := 'select * from 录取信息表 '+sWhereList.Text+' order by 省份,批次名称,科类名称,投档成绩 desc';
    ClientDataSet1.XMLData := dm.OpenData(sqlStr);
  finally
    ClientDataSet1.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TKsHmcInput.ds_AccessDataChange(Sender: TObject; Field: TField);
begin
  lbl1.Caption := '记录：'+IntToStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount);
end;

procedure TKsHmcInput.chk_NotJxClick(Sender: TObject);
begin
  btn_OK.Click;
end;

procedure TKsHmcInput.chk_ZyNotSameClick(Sender: TObject);
begin
  //ClientDataSet1.Filtered := chk_ZyNotSame.Checked;
end;

procedure TKsHmcInput.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  RealseSortedIcon(DBGridEH1);
end;

procedure TKsHmcInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TKsHmcInput.mmi_PrnEMSClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select * from 录取信息表 '+sWhereList.Text+' order by 流水号');
    //Print_LQTZS(True);
    dm.PrintReport('EMS.fr3',cds_Temp.XMLData,1);
  finally
    cds_Temp.Free;
  end;
end;

procedure TKsHmcInput.rg2Click(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsHmcInput.SaveData;
begin
  if DataSetNoSave(ClientDataSet1) then
  begin
    if DM.UpdateData('考生号','select top 0 * from 录取信息表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
  end;
end;

procedure TKsHmcInput.ShowEditForm(const ksh: string);
var
  bm:TBookmark;
begin
  //ClientDataSet1.DisableControls;
  bm := ClientDataSet1.GetBookmark;
  try
    aForm.SetData(ksh,ClientDataSet1);
    aForm.ShowModal;
    Self.SaveData;
  finally
    ClientDataSet1.GotoBookmark(bm);
    //ClientDataSet1.EnableControls;
  end;

end;

procedure TKsHmcInput.pmi_RefreshClick(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsHmcInput.DBGridEH1DblClick(Sender: TObject);
begin
  ShowEditForm(ClientDataSet1.FieldByName('考生号').AsString);
end;


function TKsHmcInput.GetOrderString: string;
begin
end;

procedure TKsHmcInput.GetWhereList;
var
  sTemp :string;
begin
  sWhereList.Clear;
  sWhereList.Add('where 学历层次='+quotedstr(cbb_XlCc.Text));
  sWhereList.Add('and 考生状态='+quotedstr('5'));
  if cbb_Lb.Text<>'全部' then
    sWhereList.Add(' and 类别='+quotedstr(cbb_Lb.Text));
  if cbb_KL.Text<>'全部' then
    sWhereList.Add(' and 科类='+quotedstr(cbb_KL.Text));

  if cbb_Sf.Text<>'全部' then
    sWhereList.Add(' and 省份='+quotedstr(cbb_Sf.Text));
  if not dm.IsDisplayJiangXi then
    sWhereList.Add(' and 省份<>'+quotedstr('江西'));

  sTemp := GetFilterString;
  
  if sTemp<>'' then
    sWhereList.Add(sTemp);
end;

procedure TKsHmcInput.DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if vsorted then
    Open_Access_Table;
  vsorted := False;
end;

procedure TKsHmcInput.DBGridEH1TitleClick(Column: TColumnEh);
begin
  if Column.FieldName='选择否' then
  begin
    DBGridEH1.SaveBookmark;
    ClientDataSet1.DisableControls;
    ClientDataSet1.First;
    try
      while not ClientDataSet1.Eof do
      begin
        ClientDataSet1.Edit;
        ClientDataSet1.FieldByName('选择否').AsBoolean := not ClientDataSet1.FieldByName('选择否').AsBoolean;
        ClientDataSet1.Post;
        ClientDataSet1.Next;
      end;
    finally
      DBGridEH1.RestoreBookmark;
      ClientDataSet1.EnableControls;
    end;
  end;
end;

procedure TKsHmcInput.edt1Change(Sender: TObject);
begin
 // ClientDataSet1.Filtered := False;
 // ClientDataSet1.Filtered := (Length(edt1.Text)>=4) and chk1.Checked;
end;

procedure TKsHmcInput.cbb_CompareChange(Sender: TObject);
begin
  cbb_Value.Enabled := (cbb_Compare.ItemIndex<>7) and (cbb_Compare.ItemIndex<>8);
end;

procedure TKsHmcInput.cbb_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(cbb_Value.Text))+')';
  if (LeftStr(cbb_Value.Text,1)='B') or (LeftStr(cbb_Value.Text,1)='Z') then
  begin
    if Copy(cbb_Value.Text,2,1)>'9' then
    begin
      cbb_Field.Text := '流水号';
      if Length(cbb_Value.Text)=7 then btn_OK.Click;
    end else
    begin
      cbb_Field.Text := '通知书编号';
      if Length(cbb_Value.Text)=8 then btn_OK.Click;
    end;
  end
  else  if LeftStr(cbb_Value.Text,2)=Copy(FormatDateTime('yyyy',Now),3,2) then
    cbb_Field.Text := '考生号';
end;

procedure TKsHmcInput.cbb_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_OK.Click;
end;

function TKsHmcInput.GetFilterString: String;
var
  sWhere,sValue:string;
begin
  sWhere := '';
  if (not ClientDataSet1.Active) then Exit;
  if cbb_Value.Enabled and (cbb_Value.Text='') then Exit;

  if cbb_Compare.KeyItems[cbb_Compare.ItemIndex]='Like' then
    sValue := '%'+cbb_Value.Text+'%'
  else
    sValue := cbb_Value.Text;

  if cbb_Value.Enabled then
    sWhere := 'and ('+cbb_Field.GetField+' '+cbb_Compare.KeyItems[cbb_Compare.ItemIndex]+' '+quotedstr(sValue)+')'
  else
    sWhere := 'and ('+cbb_Field.GetField+' '+cbb_Compare.KeyItems[cbb_Compare.ItemIndex]+')';

  Result := sWhere;
end;


procedure TKsHmcInput.mniN2Click(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('考生号').IsNull then
  begin
    StuInfo.Show;
    StuInfo.DataSource1DataChange(Self,nil);
  end;
end;

procedure TKsHmcInput.mni_SfClick(Sender: TObject);
begin
  if mni_Sf.Checked then
    cbb_sf.Text := ClientDataSet1.FieldByName('省份').AsString
  else
    cbb_Sf.Text := '全部';
end;

procedure TKsHmcInput.N2Click(Sender: TObject);
begin
  if Application.MessageBox('真的要清除当前考生的花名册信息吗？ ', '系统提示', 
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  with ClientDataSet1 do
  begin
    Edit;
    FieldByName('花名册页码').Clear;
    FieldByName('花名册行号').Clear;
    Post;
  end;
  SaveData;
end;

end.
