unit uKsHmcBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ActnList, DB,StrUtils, DBGridEhImpExp,
  Menus, ImgList, frxClass, frxDBSet, frxDesgn, StdCtrls, Spin, DBCtrls,
  MyDBNavigator, StatusBarEx, GridsEh, DBGridEh, uStuInfo,uFormatKL,uFormatZy,
  DBFieldComboBox, StdActns, pngimage, DBClient, DBGridEhGrouping, frxpngimage,
  Mask, DBCtrlsEh;

type
  TKsHmcBrowse = class(TForm)
    pnl2: TPanel;
    lbl_Filter: TLabel;
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
    btn_Refresh: TBitBtn;
    btn_SqlWhere: TBitBtn;
    cbb_Compare: TDBComboBoxEh;
    img_Hint: TImage;
    lbl_Len: TLabel;
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
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
    procedure cbb_XlCcChange(Sender: TObject);
    procedure edt1Change(Sender: TObject);
    procedure mni_SfClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure DBGridEH1TitleClick(Column: TColumnEh);
    procedure btn_SqlWhereClick(Sender: TObject);
    procedure cbb_CompareChange(Sender: TObject);
    procedure cbb_ValueChange(Sender: TObject);
    procedure DBGridEH1DblClick(Sender: TObject);
  private
    { Private declarations }
    //FormatKL:TFormatKL;
    //FormatZy:TFormatZyMc;
    StuInfo:TStuInfo;
    vsorted :Boolean;
    repfn:string;
    sWhereList:Tstrings;
    procedure Open_Access_Table(const sWhere:string='');
    function  GetFilterString: String;
    function  GetOrderString:string;
    procedure GetWhereList;
  public
    { Public declarations }
  end;

var
  KsHmcBrowse: TKsHmcBrowse;

implementation

uses uDM, uMain,uSQLWhere;

{$R *.dfm}

procedure TKsHmcBrowse.mmi_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsHmcBrowse.mmi_ExcelClick(Sender: TObject);
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

procedure TKsHmcBrowse.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Access_Table;
  if Self.Showing then
    DBGridEH1.SetFocus;
end;

procedure TKsHmcBrowse.btn_OKClick(Sender: TObject);
begin
  Open_Access_Table;
  if cbb_Value.CanFocus then
    cbb_Value.SetFocus;
end;

procedure TKsHmcBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Access_Table();
end;

procedure TKsHmcBrowse.btn_SqlWhereClick(Sender: TObject);
begin
  if GetSqlWhere(ClientDataSet1,sWhereList) then
    Open_Access_Table(sWhereList.Text);
end;

procedure TKsHmcBrowse.FormCreate(Sender: TObject);
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

  dm.SetCzySfComboBox(cbb_XlCc.Items[cbb_XlCc.ItemIndex],cbb_Sf,True);
  dm.SetLbComboBox(cbb_Lb,True);

  dm.SetKlComboBox(cbb_KL,True);

  try
    StuInfo := TStuInfo.Create(Self);
    StuInfo.DataSource1.DataSet := ClientDataSet1;
    sWhereList := TStringList.Create;
    if cbb_Sf.Items.Count>1 then
      cbb_Sf.ItemIndex := 1;
    Open_Access_Table;
  finally
    sList.Free;
  end;
end;

procedure TKsHmcBrowse.FormDestroy(Sender: TObject);
begin
  FreeAndNil(StuInfo);
  FreeAndNil(sWhereList);
end;

procedure TKsHmcBrowse.Open_Access_Table(const sWhere:string='');
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
    ClientDataSet1.Filtered := False;
    Screen.Cursor := crDefault;
  end;
end;

procedure TKsHmcBrowse.ds_AccessDataChange(Sender: TObject; Field: TField);
begin
  lbl1.Caption := '记录：'+IntToStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount);
end;

procedure TKsHmcBrowse.chk_NotJxClick(Sender: TObject);
begin
  btn_OK.Click;
end;

procedure TKsHmcBrowse.chk_ZyNotSameClick(Sender: TObject);
begin
  //ClientDataSet1.Filtered := chk_ZyNotSame.Checked;
end;

procedure TKsHmcBrowse.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  RealseSortedIcon(DBGridEH1);
end;

procedure TKsHmcBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TKsHmcBrowse.mmi_PrnEMSClick(Sender: TObject);
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

procedure TKsHmcBrowse.rg2Click(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsHmcBrowse.pmi_RefreshClick(Sender: TObject);
begin
  Open_Access_Table;
end;

function TKsHmcBrowse.GetOrderString: string;
begin
end;

procedure TKsHmcBrowse.GetWhereList;
var
  sTemp :string;
begin
  sWhereList.Clear;
  sWhereList.Add('where 学历层次='+quotedstr(cbb_XlCc.Text));
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

procedure TKsHmcBrowse.DBGridEH1DblClick(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('考生号').IsNull then
  begin
    StuInfo.Show;
    StuInfo.DataSource1DataChange(Self,nil);
  end;
end;

procedure TKsHmcBrowse.DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if vsorted then
    Open_Access_Table;
  vsorted := False;
end;

procedure TKsHmcBrowse.DBGridEH1TitleClick(Column: TColumnEh);
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

procedure TKsHmcBrowse.edt1Change(Sender: TObject);
begin
 // ClientDataSet1.Filtered := False;
 // ClientDataSet1.Filtered := (Length(edt1.Text)>=4) and chk1.Checked;
end;

procedure TKsHmcBrowse.cbb_CompareChange(Sender: TObject);
begin
  cbb_Value.Enabled := (cbb_Compare.ItemIndex<>7) and (cbb_Compare.ItemIndex<>8);
end;

procedure TKsHmcBrowse.cbb_ValueChange(Sender: TObject);
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

procedure TKsHmcBrowse.cbb_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_OK.Click;
end;

function TKsHmcBrowse.GetFilterString: String;
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


procedure TKsHmcBrowse.mni_SfClick(Sender: TObject);
begin
  if mni_Sf.Checked then
    cbb_sf.Text := ClientDataSet1.FieldByName('省份').AsString
  else
    cbb_Sf.Text := '全部';
end;

end.
