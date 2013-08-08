unit uKsInfoBrowse_All;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ActnList, DB,StrUtils, DBGridEhImpExp,
  Menus, ImgList, frxClass, frxDBSet, frxDesgn, StdCtrls, Spin, DBCtrls,
  MyDBNavigator, StatusBarEx, GridsEh, DBGridEh, uStuInfo,uFormatKL,uFormatZy,
  DBFieldComboBox, StdActns, pngimage, DBClient, DBGridEhGrouping, frxpngimage,
  Mask, DBCtrlsEh;

type
  TKsInfoBrowse_All = class(TForm)
    pnl2: TPanel;
    chk1: TLabel;
    cbb_Value: TEdit;
    frxDesigner1: TfrxDesigner;
    frxDBDataset1: TfrxDBDataset;
    il1: TImageList;
    pm1: TPopupMenu;
    pmi_Excel: TMenuItem;
    ds_Access: TDataSource;
    dlgSave_1: TSaveDialog;
    btn_OK: TBitBtn;
    btn_Adv: TBitBtn;
    N4: TMenuItem;
    pmi_Refresh: TMenuItem;
    frxReport1: TfrxReport;
    cbb_Field: TDBFieldComboBox;
    ActionList1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    C1: TMenuItem;
    X1: TMenuItem;
    P1: TMenuItem;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    chk2: TCheckBox;
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
    lbl_Len: TLabel;
    pm_FormatZy: TMenuItem;
    cbb_Compare: TDBComboBoxEh;
    chk_Filter: TCheckBox;
    chk_ZyNoSame: TCheckBox;
    pmi_SetTd: TMenuItem;
    pmi_SetEnd: TMenuItem;
    pmi_SetNormal: TMenuItem;
    procedure RzGroup2Items0Click(Sender: TObject);
    procedure RzGroup4Items1Click(Sender: TObject);
    procedure RzGroup3Items0Click(Sender: TObject);
    procedure mmi_ExitClick(Sender: TObject);
    procedure mmi_PrnLQTZSClick(Sender: TObject);
    procedure mmi_PrnLQKSMDClick(Sender: TObject);
    procedure mmi_ExcelClick(Sender: TObject);
    procedure mmi_FormatZymcClick(Sender: TObject);
    procedure mmi_ExecSQLClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ds_AccessDataChange(Sender: TObject; Field: TField);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure mmi_PrnEMSClick(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure UpDownNumEdit1Change(Sender: TObject);
    procedure rg2Click(Sender: TObject);
    procedure mmi_DesEMSClick(Sender: TObject);
    procedure mmi_DesLQTZSClick(Sender: TObject);
    procedure mmi_DesLQKSMDClick(Sender: TObject);
    procedure pmi_RefreshClick(Sender: TObject);
    procedure mmi_BHClick(Sender: TObject);
    procedure DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure mmi_ProcessSJRClick(Sender: TObject);
    procedure DBGridEH1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N9Click(Sender: TObject);
    procedure btn_AdvClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure chk_NotJxClick(Sender: TObject);
    procedure cbb_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure chk_ZyNotSameClick(Sender: TObject);
    procedure dxDBMemo1DblClick(Sender: TObject);
    procedure mi_FormatKLClick(Sender: TObject);
    procedure DBGridEH1DblClick(Sender: TObject);
    procedure mni_FormatKLClick(Sender: TObject);
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
    procedure cbb_XlCcChange(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure mni_SfClick(Sender: TObject);
    procedure cbb_ValueChange(Sender: TObject);
    procedure pm_FormatZyClick(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
    procedure chk_ZyNoSameClick(Sender: TObject);
    procedure ClientDataSet1CalcFields(DataSet: TDataSet);
    procedure cbb_CompareChange(Sender: TObject);
    procedure chk_FilterClick(Sender: TObject);
    procedure pmi_SetTdClick(Sender: TObject);
    procedure pmi_SetEndClick(Sender: TObject);
    procedure pmi_SetNormalClick(Sender: TObject);
  private
    { Private declarations }
    //FormatKL:TFormatKL;
    //FormatZy:TFormatZyMc;
    StuInfo:TStuInfo;
    vsorted :Boolean;
    repfn:string;
    sWhereList:Tstrings;
    procedure Open_Access_Table(const sWhere:string='');
    procedure Print_EMS(const designed:Boolean = False);
    procedure Print_LQTZS(const designed:Boolean = False);
    procedure Print_LQKSMD(const designed:Boolean = False);
    function  GetOrderString:string;
    function  GetFilterString:String;
    function  GetXznxString:String;
    procedure GetWhereList;
  public
    { Public declarations }
  end;

var
  KsInfoBrowse_All: TKsInfoBrowse_All;

implementation

uses uDM, uMareData_BDE, uMain;//, uFormatZymc,
  //uSqlExecute,uBh,uPhotoProcess,uSQLWhere,uFormatKL;

{$R *.dfm}

procedure TKsInfoBrowse_All.RzGroup2Items0Click(Sender: TObject);
var
  path,fn :string;
begin
{
  path := ExtractFileDir(Application.ExeName);
  fn := path+'\lqmd.mdb';
  if not FileExists(fn) then
  begin
    MessageBox(Handle, PChar('���ݿ��ļ���'+fn+' �����ڣ�����'), '���ݿⲻ����', MB_OK +
      MB_ICONWARNING);
    exit;
  end;

  Connect_Access(path);

  ClientDataSet1.Close;
  ClientDataSet1.Open;
  //frm_Ksxt.show;
}
end;

procedure TKsInfoBrowse_All.RzGroup4Items1Click(Sender: TObject);
begin
  Close;
end;

procedure TKsInfoBrowse_All.RzGroup3Items0Click(Sender: TObject);
begin
  //frm_PrintLqtzs.ShowModal;
end;

procedure TKsInfoBrowse_All.mmi_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsInfoBrowse_All.mmi_PrnLQTZSClick(Sender: TObject);
begin
  Print_LQTZS();
end;

procedure TKsInfoBrowse_All.mmi_PrnLQKSMDClick(Sender: TObject);
begin
{
  dxgrd_1.Columns[1].Title.SortIndex := 1;  //ʡ��
  dxgrd_1.Columns[1].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[2].Title.SortIndex := 2;  //FindColumnByName('����').
  dxgrd_1.Columns[2].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[3].Title.SortIndex := 3;  //FindColumnByName('����').
  dxgrd_1.Columns[3].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[8].Title.SortIndex := 4; //FindColumnByName('¼ȡרҵ�淶��').
  dxgrd_1.Columns[8].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[13].Title.SortIndex := 5; //FindColumnByName('Ͷ���ɼ�').
  dxgrd_1.Columns[13].Title.SortMarker := smDownEh;
}
  if Application.MessageBox('��ӡǰ����ȷ�Ͽ��������Ѿ�����ʡ�ݡ������Ρ������������' +
    #13#10 + '¼ȡרҵ�淶������Ͷ���ɼ�������������' + #13#10#13#10 +
    'Ҫ����������', 'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2)
    = IDYES then

  begin
    Print_LQKSMD();
  end;
end;

procedure TKsInfoBrowse_All.mmi_ExcelClick(Sender: TObject);
var
  fn,Ext,mfn:string;
begin
  dlgSave_1.FileName := '��������.xls';
  if dlgSave_1.Execute then
  begin
    if FileExists(dlgSave_1.FileName) then
      if MessageBox(Handle, PChar('Excel�ļ���'+dlgSave_1.FileName+'�Ѵ��ڣ�Ҫ�������𣿡���'), '�ļ��Ѵ���', MB_YESNO + MB_ICONWARNING +
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
      MessageBox(Handle, 'Excel�ļ�������ɣ�����', '�����ɹ�', MB_OK + MB_ICONINFORMATION);
    end;
  end;
end;

procedure TKsInfoBrowse_All.mmi_FormatZymcClick(Sender: TObject);
var
  xlcc,sf,pc,lb,kl,zydm,zy:string;
//  bm:TBookmark;
begin
  xlcc := ClientDataSet1.FieldByName('ѧ�����').Asstring;
  sf := ClientDataSet1.FieldByName('ʡ��').Asstring;
  pc := ClientDataSet1.FieldByName('��������').Asstring;
  lb := ClientDataSet1.FieldByName('���').Asstring;//
  kl := ClientDataSet1.FieldByName('��������').Asstring;
  zydm := ClientDataSet1.FieldByName('¼ȡ����').Asstring;
  zy := ClientDataSet1.FieldByName('¼ȡרҵ').Asstring;

  with TFormatZy.Create(Application) do
  begin
    FillData(xlcc,sf,pc,lb,kl,zydm,zy,ClientDataSet1,'���Ŀ�����Ϣ��');
    if ShowModal=mrOk then
    try
      DBGridEH1.SaveBookmark;
//      bm := ClientDataSet1.GetBookmark;
      Open_Access_Table;
    finally
      DBGridEH1.RestoreBookmark;
//      ClientDataSet1.GotoBookmark(bm);
    end;
  end;
end;

procedure TKsInfoBrowse_All.mmi_ExecSQLClick(Sender: TObject);
begin
  //Tfrm_SqlExecute.Create(Application).Show;
end;

procedure TKsInfoBrowse_All.cbb_XlCcChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Access_Table;
  if Self.Showing then
    DBGridEH1.SetFocus;
end;

procedure TKsInfoBrowse_All.btn_AdvClick(Sender: TObject);
begin
{
  if GetSqlWhere(sWhereList) then
  begin
    Open_Access_Table;
  end;
}
end;

procedure TKsInfoBrowse_All.btn_OKClick(Sender: TObject);
begin
  Open_Access_Table;
  if cbb_Value.CanFocus then
    cbb_Value.SetFocus;
end;

procedure TKsInfoBrowse_All.FormCreate(Sender: TObject);
var
  path,fn :string;
  ii:Integer;
begin
  Self.Left := Trunc((Main.Width - Self.Width)/2);
  //Self.Top := Trunc((Main.Height - Self.Height)/2);
  Self.Top := 15;
  dm.SetXlCcComboBox(cbb_XlCc);

  dm.SetCzySfComboBox(cbb_XlCc.Items[cbb_XlCc.ItemIndex],cbb_Sf,True);
{
  dm.SetSfComboBox(cbb_Sf,True);
  ii := cbb_Sf.Items.IndexOf('����');
  if (ii>=0) and (not dm.IsDisplayJiangXi) then
    cbb_Sf.Items.Delete(ii);
}

  dm.SetLbComboBox(cbb_Lb,True);

  dm.SetKlComboBox(cbb_KL,True);
  try
    StuInfo := TStuInfo.Create(Self);
    StuInfo.DataSource1.DataSet := ClientDataSet1;
    sWhereList := TStringList.Create;
    Open_Access_Table;
  finally
  end;
end;

procedure TKsInfoBrowse_All.FormDestroy(Sender: TObject);
begin
  FreeAndNil(StuInfo);
  FreeAndNil(sWhereList);
end;

procedure TKsInfoBrowse_All.Open_Access_Table(const sWhere:string='');
var
  vxzstr,vfilterstr,vordstr:string;
  sqlStr:string;
begin
  Repfn := ExtractFilePath(Application.ExeName)+'Rep\'+cbb_xlcc.Text+'¼ȡ֪ͨ��.fr3';

  GetWhereList;

  Screen.Cursor := crHourGlass;
  ClientDataSet1.DisableControls;
  try
    sqlStr := 'select * from lqmd '+sWhereList.Text+sWhere+' order by ѧ�����,ʡ��,������';
    ClientDataSet1.XMLData := dm.OpenData(sqlStr);
  finally
    ClientDataSet1.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TKsInfoBrowse_All.ds_AccessDataChange(Sender: TObject; Field: TField);
begin
  lbl1.Caption := '��¼��'+IntToStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount);
end;

procedure TKsInfoBrowse_All.chk_FilterClick(Sender: TObject);
begin
  DBGridEH1.STFilter.Visible := chk_Filter.Checked;
end;

procedure TKsInfoBrowse_All.chk_NotJxClick(Sender: TObject);
begin
  btn_OK.Click;
end;

procedure TKsInfoBrowse_All.chk_ZyNoSameClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := chk_ZyNoSame.Checked;
end;

procedure TKsInfoBrowse_All.chk_ZyNotSameClick(Sender: TObject);
begin
  //ClientDataSet1.Filtered := chk_ZyNotSame.Checked;
end;

procedure TKsInfoBrowse_All.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  RealseSortedIcon(DBGridEH1);
end;

procedure TKsInfoBrowse_All.ClientDataSet1CalcFields(DataSet: TDataSet);
begin
  DataSet.FieldByName('_¼ȡרҵ').AsString := DataSet.FieldByName('¼ȡרҵ').AsString;
  Case DataSet.FieldByName('����״̬').AsInteger of
    0: //רҵδ��
    begin
      DataSet.FieldByName('_¼ȡרҵ').AsString := 'רҵδ��';
    end;
    1: //����¼רҵ
    begin
      DataSet.FieldByName('_¼ȡרҵ').AsString := DataSet.FieldByName('¼ȡרҵ').AsString;
    end;
    2: //Ԥ�˿���
    begin
      DataSet.FieldByName('_¼ȡרҵ').AsString := '���˵�';
    end;
    3: //���˵�����
    begin
      DataSet.FieldByName('_¼ȡרҵ').AsString := '���˵�';
    end;
    5: //¼ȡרҵ��ȷ�����ѽ����Ŀ���
    begin
      DataSet.FieldByName('_¼ȡרҵ').AsString := DataSet.FieldByName('¼ȡרҵ').AsString;
    end;
  End;
end;

procedure TKsInfoBrowse_All.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if not DataSet.Active then Exit;
  if not chk_ZyNoSame.Checked then Exit;

  if (chk_ZyNoSame.Checked)  then
  begin
    Accept := not ZyIsEqual(ClientDataSet1.FieldByName('¼ȡרҵ').AsString,ClientDataSet1.FieldByName('¼ȡרҵ�淶��').AsString);
  end else
    Accept := True;
end;

procedure TKsInfoBrowse_All.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TKsInfoBrowse_All.mmi_PrnEMSClick(Sender: TObject);
begin
  Print_EMS();
end;

procedure TKsInfoBrowse_All.rg1Click(Sender: TObject);
begin
{
  if rg1.ItemIndex=0 then
  begin
    frxDBDataSet1.RangeBegin := rbFirst;
    frxDBDataset1.RangeEnd := reLast;
  end else if rg1.ItemIndex=1 then
  begin
    frxDBDataSet1.RangeBegin := rbCurrent;
    frxDBDataset1.RangeEnd := reCurrent;
  end else if rg1.ItemIndex=2 then
  begin
    frxDBDataSet1.RangeBegin := rbCurrent;
    frxDBDataset1.RangeEnd := reLast;
  end else
  begin
    frxDBDataSet1.RangeBegin := rbCurrent;
    frxDBDataset1.RangeEnd := reCount;
    frxDBDataset1.RangeEndCount := UpDownNumEdit1.Value;
  end;
}
end;

procedure TKsInfoBrowse_All.UpDownNumEdit1Change(Sender: TObject);
begin
  //frxDBDataset1.RangeEndCount := UpDownNumEdit1.Value;
end;

procedure TKsInfoBrowse_All.rg2Click(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsInfoBrowse_All.Print_EMS(const designed: Boolean);
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'\rep\ems.fr3';
  if not FileExists(fn) then
  begin
    MessageBox(Handle, PChar('�����ļ���'+fn+' �����ڣ�    '), '�����ļ�������', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  frxReport1.LoadFromFile(fn);
  if designed then
    frxReport1.DesignReport
  else
    frxReport1.ShowReport;
end;

procedure TKsInfoBrowse_All.Print_LQKSMD(const designed: Boolean);
var
  repfn:String;
begin

  repfn := ExtractFilePath(Application.ExeName)+'Rep\רҵ����¼ȡ����.fr3';
  frxReport1.LoadFromFile(repfn);
  if designed then
    frxReport1.DesignReport
  else
    frxReport1.ShowReport;
end;

procedure TKsInfoBrowse_All.Print_LQTZS(const designed: Boolean);
begin
  if not FileExists(repfn) then
  begin
    MessageBox(Handle, PChar('�����ļ���'+repfn+' �����ڣ�    '), '�����ļ�������', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  frxReport1.LoadFromFile(repfn);
  if designed then
    frxReport1.DesignReport
  else
    frxReport1.ShowReport;
end;

procedure TKsInfoBrowse_All.mmi_DesEMSClick(Sender: TObject);
begin
  Print_EMS(True);
end;

procedure TKsInfoBrowse_All.mmi_DesLQTZSClick(Sender: TObject);
begin
  Print_LQTZS(True);
end;

procedure TKsInfoBrowse_All.mmi_DesLQKSMDClick(Sender: TObject);
begin
  Print_LQKSMD(True);
end;

procedure TKsInfoBrowse_All.mi_FormatKLClick(Sender: TObject);
var
  sf,pc,kl,sqlstr:string;
begin
{
  sf := Trim(ClientDataSet1.FieldByName('ʡ��').AsString);
  pc := Trim(ClientDataSet1.FieldByName('����').AsString);
  kl := Trim(ClientDataSet1.FieldByName('����').AsString);
  with Tfrm_FormatKL.Create(nil) do
  begin
    lbledt_sf.Text := sf;
    lbledt_pc.Text := pc;
    lbledt_KL.Text := kl;
    ShowModal;
    //Open_Access_Table;
  end;
}
end;

procedure TKsInfoBrowse_All.pm1Popup(Sender: TObject);
var
  zy:string;
begin
  zy := ClientDataSet1.FieldByName('¼ȡרҵ').Asstring;
  pm_FormatZy.Enabled := zy<>'';
  pmi_SetNormal.Visible := gb_Czy_Level='-1';
  pmi_SetTd.Visible := gb_Czy_Level='-1';
  pmi_SetEnd.Visible := gb_Czy_Level='-1';
end;

procedure TKsInfoBrowse_All.pmi_RefreshClick(Sender: TObject);
begin
  Open_Access_Table;
end;

procedure TKsInfoBrowse_All.pmi_SetEndClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '���ҪΪ��ǰ������¼ȡ���������𣿡�', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if UpperCase(InputBox('����ȷ��','�����롾OK���ַ��Ա�ȷ�ϣ�',''))<>'OK' then Exit;
    sqlstr := 'update lqmd set ����״̬='+quotedstr('5')+
              'where ������='+quotedstr(ClientDataSet1.FieldByName('������').AsString);
    if dm.ExecSql(sqlstr) then
      MessageBox(Handle, '������ɣ���Ϊ��ǰ��������¼ȡ����������', 'ϵͳ��ʾ',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TKsInfoBrowse_All.pmi_SetNormalClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '���Ҫ�ѵ�ǰ��������Ϊ�ĵ�¼��״̬�𣿡�', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if UpperCase(InputBox('����ȷ��','�����롾OK���ַ��Ա�ȷ�ϣ�',''))<>'OK' then Exit;
    sqlstr := 'update lqmd set ����״̬='+quotedstr('1')+',¼ȡ����=NULL,¼ȡרҵ=NULL,¼ȡרҵ�淶��=NULL,'+
              'Ժϵ=NULL,����У��=NULL,���=NULL,����=NULL '+
              'where ������='+quotedstr(ClientDataSet1.FieldByName('������').AsString);
    if dm.ExecSql(sqlstr) then
      MessageBox(Handle, '������ɣ��Ѱѵ�ǰ��������Ϊ�ĵ�¼��״̬�ˣ���', 'ϵͳ��ʾ',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TKsInfoBrowse_All.pmi_SetTdClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '���ҪΪ��ǰ�������˵������𣿡�', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if UpperCase(InputBox('����ȷ��','�����롾OK���ַ��Ա�ȷ�ϣ�',''))<>'OK' then Exit;
    sqlstr := 'update lqmd set ����״̬='+quotedstr('3')+',¼ȡ����=NULL,¼ȡרҵ=NULL,¼ȡרҵ�淶��=NULL,'+
              'Ժϵ=NULL,����У��=NULL,���=NULL,����=NULL '+
              'where ������='+quotedstr(ClientDataSet1.FieldByName('������').AsString);
    if dm.ExecSql(sqlstr) then
      MessageBox(Handle, '������ɣ���Ϊ��ǰ���������˵�������', 'ϵͳ��ʾ',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TKsInfoBrowse_All.mmi_BHClick(Sender: TObject);
begin
{
  with Tfrm_bh.Create(Application) do
  begin
    if rg2.itemindex=0 then
      cbb_Value.Text := 'B'
    else if rg2.itemindex=1 then
      cbb_Value.Text := 'Y'
    else
      cbb_Value.Text := 'Z';

    ShowModal;
    Free;
  end;
}
end;

procedure TKsInfoBrowse_All.dxDBMemo1DblClick(Sender: TObject);
begin
{
  if (ClientDataSet1.FieldByName('¼ȡרҵ').AsString<>ClientDataSet1.FieldByName('¼ȡרҵ�淶��').AsString)
     and mmi_AllowEdit.Checked then
  begin
    ClientDataSet1.Edit;
    dxDBMemo1.Text := FormatDateTime('yyyy-mm-dd',Date)+' '+ClientDataSet1.FieldByName('¼ȡרҵ').AsString+'->'+
                      ClientDataSet1.FieldByName('¼ȡרҵ�淶��').AsString+' ί���ˣ�';
    ClientDataSet1.Post;
  end;
}
end;

procedure TKsInfoBrowse_All.DBGridEH1DblClick(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('������').IsNull then
  begin
    StuInfo.Show;
    StuInfo.DataSource1DataChange(Self,nil);
  end;
end;

procedure TKsInfoBrowse_All.DBGridEH1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
var
  zy1,zy2:string;
  iLen,iKszt:Integer;
begin
  if (Column.FieldName='��ע') then
  begin
    if Column.Field.AsString<>'' then
    begin
      Column.Font.Color := clWhite;
      TDBGridEh(Sender).Canvas.Brush.Color := clRed;
    end;
  end;
  if (Column.FieldName='����״̬') then
  begin
    if not ClientDataSet1.FieldByName('����״̬').IsNull then
    begin
      if ClientDataSet1.FieldByName('����״̬').AsString<>'' then
        iKszt := ClientDataSet1.FieldByName('����״̬').AsInteger
      else
        iKszt := 0;
    end else
      iKszt := 0;
    Case iKszt of
      0: //רҵδ��
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := $008DB48D;
        //Column.Field.Text := 'רҵδ��';
      end;
      1: //����¼רҵ
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := $008DB48D;
        //
      end;
      2: //���˵�����
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := $00FF80FF;
      end;
      3: //���˵�����
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := clRed;
      end;
      5: //¼ȡרҵ��ȷ�����ѽ����Ŀ���
      begin
        TDBGridEh(Sender).Canvas.Brush.Color := clOlive;
      end;
    End;
  end;

  if (Column.FieldName='¼ȡרҵ�淶��') then
  begin
    //Column.Font.Style := Font.Style-[fsStrikeOut];
    if Pos('�˵�',Column.Field.AsString)>0 then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clRed;
      //Column.Font.Color := clRed;
      //Column.Font.Style := Font.Style+[fsStrikeOut];
    end else
    zy1 := ClientDataSet1.FieldByName('¼ȡרҵ').Asstring;
    zy2 := ClientDataSet1.FieldByName('¼ȡרҵ�淶��').Asstring;
    if not ZyIsEqual(zy1,zy2) then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := $00D392C1;//$007D332D;//clMaroon;
      //Column.Font.Color := clWhite;
    end else
      Column.Font.Color := clBlack;
  end;

  if (Column.FieldName='ID') then
  begin
    if Trim(Column.Field.AsString) = '��' then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clYellow;
      Column.Font.Color := clNavy;
    end;
  end;

  if (Column.FieldName='��ӡ״̬') then
  begin
    if Trim(Column.Field.AsString) = '' then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clYellow;
      Column.Font.Color := clNavy;
    end;
  end;
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);

end;

function TKsInfoBrowse_All.GetOrderString: string;
begin
end;

procedure TKsInfoBrowse_All.GetWhereList;
var
  sTemp :string;
begin
  sWhereList.Clear;
  sWhereList.Add(' where ѧ�����='+quotedstr(cbb_XlCc.Text));
  if cbb_Lb.Text<>'ȫ��' then
    sWhereList.Add(' and ���='+quotedstr(cbb_Lb.Text));
  if cbb_KL.Text<>'ȫ��' then
    sWhereList.Add(' and ����='+quotedstr(cbb_KL.Text));

  if cbb_Sf.Text<>'ȫ��' then
    sWhereList.Add(' and ʡ��='+quotedstr(cbb_Sf.Text));
  if not dm.IsDisplayJiangXi then
    sWhereList.Add(' and ʡ��<>'+quotedstr('����'));

  sTemp := GetFilterString;
  if sTemp<>'' then
    sWhereList.Add(sTemp);
end;

procedure TKsInfoBrowse_All.DBGridEH1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if vsorted then
    Open_Access_Table;
  vsorted := False;
end;

procedure TKsInfoBrowse_All.cbb_CompareChange(Sender: TObject);
begin
  cbb_Value.Enabled := (cbb_Compare.ItemIndex<>7) and (cbb_Compare.ItemIndex<>8);
end;

procedure TKsInfoBrowse_All.cbb_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(cbb_Value.Text))+')';
  if (LeftStr(cbb_Value.Text,1)='B') or (LeftStr(cbb_Value.Text,1)='Z') then
  begin
    if Copy(cbb_Value.Text,2,1)>'9' then
    begin
      cbb_Field.Text := '��ˮ��';
      if Length(cbb_Value.Text)=7 then btn_OK.Click;
    end else
    begin
      cbb_Field.Text := '֪ͨ����';
      if Length(cbb_Value.Text)=8 then btn_OK.Click;
    end;
  end
  else  if LeftStr(cbb_Value.Text,2)=Copy(FormatDateTime('yyyy',Now),3,2) then
    cbb_Field.Text := '������';
end;

procedure TKsInfoBrowse_All.cbb_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_OK.Click;
end;

function TKsInfoBrowse_All.GetFilterString: String;
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

function TKsInfoBrowse_All.GetXznxString: String;
begin
end;

procedure TKsInfoBrowse_All.mmi_ProcessSJRClick(Sender: TObject);
var
  sqlstr:string;
  updateCount:Integer;
begin
  if Application.MessageBox('���Ҫϵͳ�Զ�����հ��ռ����𣿡���',
    '������ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  sqlstr := 'update ¼ȡ��Ϣ�� set �ռ���=�������� '+GetXznxString+' and �ռ��� is null';
  dm.ExecSql(sqlstr);
  Application.MessageBox(PChar('������ɣ���'), 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
end;

procedure TKsInfoBrowse_All.mni_FormatKLClick(Sender: TObject);
var
  sf,pc,kl:string;
//  bm:TBookmark;
begin
  sf := ClientDataSet1.FieldByName('ʡ��').Asstring;
  pc := ClientDataSet1.FieldByName('����').Asstring;
  kl := ClientDataSet1.FieldByName('��������').Asstring;
  with TFormatKL.Create(Application) do
  begin
    FillData(sf,pc,kl,ClientDataSet1);
    if ShowModal=mrOk then
    try
      DBGridEH1.SaveBookmark;
//      bm := ClientDataSet1.GetBookmark;
      Open_Access_Table;
    finally
      DBGridEH1.RestoreBookmark;
//      ClientDataSet1.GotoBookmark(bm);
    end;
  end;
end;

procedure TKsInfoBrowse_All.mni_SfClick(Sender: TObject);
begin
  if mni_Sf.Checked then
    cbb_sf.Text := ClientDataSet1.FieldByName('ʡ��').AsString
  else
    cbb_Sf.Text := 'ȫ��';
end;

procedure TKsInfoBrowse_All.pm_FormatZyClick(Sender: TObject);
var
  xlcc,sf,pc,lb,kl,zydm,zy:string;
//  bm:TBookmark;
begin
  xlcc := ClientDataSet1.FieldByName('ѧ�����').Asstring;
  sf := ClientDataSet1.FieldByName('ʡ��').Asstring;
  pc := ClientDataSet1.FieldByName('��������').Asstring;
  lb := ClientDataSet1.FieldByName('���').Asstring;//
  kl := ClientDataSet1.FieldByName('��������').Asstring;
  zydm := ClientDataSet1.FieldByName('¼ȡ����').Asstring;
  zy := ClientDataSet1.FieldByName('¼ȡרҵ').Asstring;
  with TFormatZy.Create(Application) do
  begin
    FillData(xlcc,sf,pc,lb,kl,zydm,zy,ClientDataSet1,'���Ŀ�����Ϣ��');
    if ShowModal=mrOk then
    try
      DBGridEH1.SaveBookmark;
//      bm := ClientDataSet1.GetBookmark;
      Open_Access_Table;
    finally
      DBGridEH1.RestoreBookmark;
//      ClientDataSet1.GotoBookmark(bm);
    end;
  end;
end;

procedure TKsInfoBrowse_All.N9Click(Sender: TObject);
var
  sqlstr:string;
  updateCount:Integer;
begin
  if Application.MessageBox('���Ҫ��ϵͳ�Զ�����¼ȡ���������𣿡���',
    '������ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;
  sqlstr := 'update ¼ȡ��Ϣ�� set ¼ȡ��������=format(Action_Time,'+quotedstr('yyyy-mm-dd')+') where ¼ȡ�������� is null';
  dm.ExecSql(sqlstr);
  Application.MessageBox(PChar('������ɣ�����'), 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2);
end;

end.
