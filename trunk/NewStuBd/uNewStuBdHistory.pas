unit uNewStuBdHistory;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, GridsEh, DBGridEh, ExtCtrls,StrUtils,
  Mask, DBCtrlsEh, Buttons, DB, ADODB, Menus,DBGridEhImpExp, DBClient, pngimage,
  frxClass, frxDBSet,uStuInfo, frxpngimage, DBGridEhGrouping;

type
  TNewStuBdHistory = class(TForm)
    Panel1: TPanel;
    cbb_Field: TDBComboBoxEh;
    cbb_Value: TEdit;
    btn_Search: TBitBtn;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    btn_Excel: TBitBtn;
    ClientDataSet1: TClientDataSet;
    btn_PrintNoBD: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    lbl_Title: TLabel;
    rg_BdState: TRadioGroup;
    fds_Master: TfrxDBDataset;
    frxReport1: TfrxReport;
    cds_Master: TClientDataSet;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    pnl1: TPanel;
    lbl1: TLabel;
    lbl_Total: TLabel;
    lbl2: TLabel;
    lbl_BaoDao: TLabel;
    lbl3: TLabel;
    lbl_NoBaoDao: TLabel;
    lbl5: TLabel;
    lbl_BaoDaoLi: TLabel;
    dxgrd_1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    L1: TMenuItem;
    N1: TMenuItem;
    T1: TMenuItem;
    T2: TMenuItem;
    P1: TMenuItem;
    N2: TMenuItem;
    E1: TMenuItem;
    mi_Refresh: TMenuItem;
    btn_Refresh: TBitBtn;
    mi_DisplayStuInfo: TMenuItem;
    lbl_RefreshHint: TLabel;
    Timer1: TTimer;
    lbl_RefreshHint2: TLabel;
    chk_AutoRefresh: TCheckBox;
    img_Hint: TImage;
    GroupBox1: TGroupBox;
    cbb_XlCc: TDBComboBoxEh;
    lbl_Len: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure dxgrd_1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btn_BaoDaoClick(Sender: TObject);
    procedure btn_NoBaoDaoClick(Sender: TObject);
    procedure btn_TcBaoDaoClick(Sender: TObject);
    procedure RadioButton2Click(Sender: TObject);
    procedure dxgrd_1DblClick(Sender: TObject);
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
    procedure mi_RefreshClick(Sender: TObject);
    procedure btn_ExcelClick(Sender: TObject);
    procedure mi_InitStateClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure mi_UpdateZyHistoryClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_PrintNoBDClick(Sender: TObject);
    procedure rg_BdStateClick(Sender: TObject);
    procedure rg_StuClick(Sender: TObject);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure frxReport1GetValue(const VarName: string; var Value: Variant);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure mi_DisplayNewStuInfoClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure R1Click(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure mi_DisplayStuInfoClick(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure chk_AutoRefreshClick(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure cbb_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure cbb_ValueChange(Sender: TObject);
  private
    { Private declarations }
    iSecound :Integer;
    StuInfo :TStuInfo;
    print_sqlstr:string;
    procedure GetYxList;
    function GetWhere:string;
    procedure Open_Table;
    procedure SetBDState(const sState:string);
    procedure SetCountState;

  public
    { Public declarations }
  end;

var
  NewStuBdHistory: TNewStuBdHistory;

implementation
uses uDM,uNoBaoDaoBz,uMain;
{$R *.dfm}

{ Tfrm_NewStuList }
function GetNoBaoDaoBz(var Value:string):Boolean;
var
  Form: TNoBaoDaoBz;
begin
  Result := False;
  Form := TNoBaoDaoBz.Create(Application);
  try
    if Form.ShowModal = mrOk then
    begin
      Value := Form.Memo1.Text;
      //if Form.RadioGroup1.ItemIndex=2 then
      //  Value := '';
      Result := True;
    end;
  finally
    Form.Free;
  end;
end;

procedure TNewStuBdHistory.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  SetCountState;
end;

procedure TNewStuBdHistory.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  case rg_BdState.ItemIndex of
    0:
      Accept := True;//sWhere := sWhere;
    1:
      Accept := DataSet.FieldByName('����״̬').AsString='�ѱ���';
    2:
      Accept := DataSet.FieldByName('����״̬').AsString<>'�ѱ���';
  end;

end;

procedure TNewStuBdHistory.btn_BaoDaoClick(Sender: TObject);
begin
  SetBDState('�ѱ���');
end;

procedure TNewStuBdHistory.btn_ExcelClick(Sender: TObject);
begin
  dm.ExportDBEditEH(dxgrd_1);
end;

procedure TNewStuBdHistory.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TNewStuBdHistory.btn_NoBaoDaoClick(Sender: TObject);
begin
  SetBDState('δ����');
end;

procedure TNewStuBdHistory.btn_PrintNoBDClick(Sender: TObject);
var
  fn:string;
begin
  if MessageBox(Handle, '���Ҫ��ӡδ�������������𣿡�',
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDNO then
  begin
    Exit;
  end;

  fn := ExtractFilePath(ParamStr(0))+'rep\δ������������.fr3';
  if not FileExists(fn) then
  begin
    MessageBox(Handle, PChar('�����ļ�δ�ҵ�����ӡʧ�ܣ������ļ�Ϊ����' + #13#10 +
      fn), 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;
  print_sqlstr := ' select * from ¼ȡ��Ϣ�� '+GetWhere+
                  ' and ����״̬='+quotedstr('δ����')+//' and δ����ԭ�� like '+quotedstr('%������ѧ�ʸ�%')+
                  ' order by Ժϵ,ѧ�����,δ����ԭ��';
  cds_Master.XMLData := dm.OpenData(print_sqlstr);//ClientDataSet1.XMLData;
  frxReport1.LoadFromFile(fn);
  frxReport1.ShowReport;
end;

procedure TNewStuBdHistory.btn_RefreshClick(Sender: TObject);
begin
  mi_Refresh.Click;
end;

procedure TNewStuBdHistory.btn_SearchClick(Sender: TObject);
var
  sField:string;
begin
  try
    sField := cbb_Field.KeyItems[cbb_Field.ItemIndex];
    if not ClientDataSet1.Locate(sField,vararrayof([cbb_Value.Text]),[]) then
    begin
      StuInfo.Close;
      MessageBox(Handle, PChar('��'+sField+'��Ϊ��'+cbb_Value.Text+'����������Ϣ�����ڣ���������ԣ���'),
        'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end
    else
    begin
      StuInfo.Show;
    end;
  finally
    Self.BringToFront;
    if sField='֪ͨ����' then
      cbb_Value.Text := '';
    cbb_Value.SetFocus;
  end;
end;

procedure TNewStuBdHistory.btn_TcBaoDaoClick(Sender: TObject);
begin
  SetBDState('�ӻ�����');
end;

procedure TNewStuBdHistory.cbb_YxChange(Sender: TObject);
begin
  if Self.Showing then
  begin
    Open_Table;
    cbb_Value.SetFocus;
  end;
end;

procedure TNewStuBdHistory.chk_AutoRefreshClick(Sender: TObject);
begin
  Timer1.Enabled := TCheckBox(Sender).Checked;
  lbl_RefreshHint.Enabled := TCheckBox(Sender).Checked;
  lbl_RefreshHint2.Enabled := TCheckBox(Sender).Checked;
end;

procedure TNewStuBdHistory.dxgrd_1DblClick(Sender: TObject);
begin
  StuInfo.Show;
  StuInfo.DataSource1DataChange(Self,nil);
end;

procedure TNewStuBdHistory.dxgrd_1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  sTemp:string;
begin
  //if (gdFocused in State) then Exit;
  //if DataCol=TDBGridEh(Sender).SelectedIndex then Exit;
  sTemp := ClientDataSet1.FieldByName('����״̬').AsString;
  if (Column.FieldName='����״̬') then
  begin
    //Column.Font.Style := Font.Style-[fsStrikeOut];
    if Pos('�ѱ���',sTemp)>0 then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := $00D392C1;
      //Column.Font.Color := clWhite;
      //Column.Font.Style := Font.Style+[fsBold];
    end else if sTemp='δ����' then
    begin
      TDBGridEh(Sender).Canvas.Brush.Color := clRed;
      //Column.Font.Color := clBlack;
      //Column.Font.Style := Font.Style+[fsStrikeOut];
      //Column.Font.Style := Font.Style-[fsBold];
    end;
  end;

  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);
end;

procedure TNewStuBdHistory.cbb_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(cbb_Value.Text))+')';
  if (LeftStr(cbb_Value.Text,1)='B') or (LeftStr(cbb_Value.Text,1)='Z') then
  begin
    if Copy(cbb_Value.Text,2,1)>'9' then
    begin
      cbb_Field.Text := '��ˮ��';
      if Length(cbb_Value.Text)=7 then btn_Search.Click;
    end else
    begin
      cbb_Field.Text := '֪ͨ����';
      if Length(cbb_Value.Text)=8 then btn_Search.Click;
    end;
  end
  else  if LeftStr(cbb_Value.Text,2)=Copy(FormatDateTime('yyyy',Now),3,2) then
    cbb_Field.Text := '������';
end;

procedure TNewStuBdHistory.cbb_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key = #13 then
    btn_Search.Click;
end;

procedure TNewStuBdHistory.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Timer1.Enabled := False;
  ClientDataSet1.Close;
  Action := caFree;
end;

procedure TNewStuBdHistory.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  //CanClose := gbCanClose;
end;

procedure TNewStuBdHistory.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
  iSecound := 30;
  StuInfo := TStuInfo.Create(Self);
  StuInfo.DataSource1.DataSet := ClientDataSet1;
  GetYxList;
  if StrToIntDef(gb_Czy_Level,2)=2 then
  begin
    cbb_Yx.Enabled := False;
    cbb_Yx.Text := gb_Czy_Dept;
  end else
  begin
    cbb_Yx.Enabled := True;
    cbb_Yx.ItemIndex := 1;
  end;
  dm.SetXlCcComboBox(cbb_XlCc,True);

  if gb_Czy_Level='2' then
  begin
    Self.Caption := '��'+gb_Czy_Dept+'����������������';
    lbl_Title.Caption := '��������������';
  end;
  Open_Table;
  finally
    sList.Free;
  end;
end;

procedure TNewStuBdHistory.FormDestroy(Sender: TObject);
begin
  StuInfo.Free;
end;

procedure TNewStuBdHistory.frxReport1GetValue(const VarName: string;
  var Value: Variant);
var
  Total_Rs,Bd_Rs,NoBd_Rs,Bd_Pre :string;
begin
  if VarName = 'Total_Rs' then
    Value := lbl_Total.Caption;
  if VarName = 'Bd_Rs' then
    Value := lbl_BaoDao.Caption;
  if VarName = 'NoBd_Rs' then
    Value := lbl_NoBaoDao.Caption;
  if VarName = 'Bd_Pre' then
    Value := lbl_BaoDaoLi.Caption; //������
end;

function TNewStuBdHistory.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>0 then
    sWhere := ' where Ժϵ='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  if cbb_XlCc.Text<>'ȫ��' then
    sWhere := sWhere + ' and ѧ�����='+quotedstr(cbb_XlCc.Text);
  Result := sWhere;
end;

procedure TNewStuBdHistory.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    cbb_Yx.Items.Add('����Ժϵ');
    dm.GetAllYxList(sList);
    cbb_Yx.Items.AddStrings(sList);
  finally
    sList.Free;
  end;
end;

procedure TNewStuBdHistory.mi_RefreshClick(Sender: TObject);
var
  bm:TBookmark;
begin
  bm := ClientDataSet1.GetBookmark;
  Open_Table;
  ClientDataSet1.GotoBookmark(bm);
end;

procedure TNewStuBdHistory.mi_UpdateZyHistoryClick(Sender: TObject);
begin
  Main.ShowUpdateZyHistory;
end;

procedure TNewStuBdHistory.N4Click(Sender: TObject);
var
  ksh,xm,jlMemo:string;
begin
  ksh := ClientDataSet1.FieldByName('������').AsString;
  xm := ClientDataSet1.FieldByName('��������').AsString;
  if MessageBox(Handle, PChar('ȷ��Ϊ������������У�ġ��ۺ������ࡱ�����𣿡�' +
    #13#10 + '�����ţ�'+ksh+'  ������'+xm), 'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if vobj.ApplyJLItem(gb_Czy_ID,ksh,jlMemo) then
    begin
      jlMemo := '���ۺ������ࡱ����������......';
      ClientDataSet1.Edit;
      ClientDataSet1.FieldByName('������').AsString := jlMemo;
      ClientDataSet1.Post;
      ClientDataSet1.MergeChangeLog;
    end;
  end;

end;

procedure TNewStuBdHistory.N6Click(Sender: TObject);
var
  ksh,xm:string;
begin
  ksh := ClientDataSet1.FieldByName('������').AsString;
  xm := ClientDataSet1.FieldByName('��������').AsString;
  if MessageBox(Handle, PChar('ȷ��ȡ���������ġ��ۺ������ࡱ���������𣿡�' +
    #13#10 + '�����ţ�'+ksh+'  ������'+xm), 'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    if vobj.CancelJLItem(gb_Czy_ID,ksh) then
    begin
      ClientDataSet1.Edit;
      ClientDataSet1.FieldByName('������').Clear;
      ClientDataSet1.Post;
      ClientDataSet1.MergeChangeLog;
    end;
  end;
end;

procedure TNewStuBdHistory.mi_DisplayNewStuInfoClick(Sender: TObject);
begin
  if not ClientDataSet1.FieldByName('������').IsNull then
  begin
    StuInfo.Show;
    StuInfo.DataSource1DataChange(Self,nil);
  end;
end;

procedure TNewStuBdHistory.mi_DisplayStuInfoClick(Sender: TObject);
begin
  StuInfo.Show;
  StuInfo.DataSource1DataChange(Self,nil);
end;

procedure TNewStuBdHistory.mi_InitStateClick(Sender: TObject);
var
  ksh,xm,bz:string;
begin
  xm := ClientDataSet1.FieldByName('��������').AsString;
  ksh := ClientDataSet1.FieldByName('������').AsString;

  if MessageBox(Handle, PChar('���Ҫ�ѣ�'+xm+'��'+ksh+'���ı���״̬����Ϊ��ʼ״̬�𣿡�'), 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  bz := '';
  if vobj.SetStuBdState(ksh,'',gb_Czy_ID,bz) then
  begin
    with ClientDataSet1 do
    begin
      Edit;
      FieldByName('����״̬').Clear;
      FieldByName('����Ա').AsString := gb_Czy_Id;
      FieldByName('��������').Clear;
      FieldByName('δ����ԭ��').Clear;
      Post;
    end;
    ClientDataSet1.MergeChangeLog;
    SetCountState;
    MessageBox(Handle, '������ɣ���������״̬��ʼ���ɹ�����', 'ϵͳ��ʾ', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TNewStuBdHistory.Open_Table;
var
  sqlstr,sWhere:string;
  //bm :TBookmark;
begin
  Screen.Cursor := crHourGlass;
  if StuInfo.Showing then
    StuInfo.Close;
  //bm := ClientDataSet1.GetBookmark;
  ClientDataSet1.DisableControls;
  Timer1.Enabled := False;
  try
    sWhere := GetWhere;
    sqlstr := 'select * from ¼ȡ��Ϣ�� '+sWhere+' order by ֪ͨ����';
    ClientDataSet1.XMLData := dm.OpenData(sqlstr);
  finally
    ClientDataSet1.EnableControls;
    iSecound := 30;
    Timer1.Enabled := chk_AutoRefresh.Checked;
    //ClientDataSet1.GotoBookmark(bm);
    Screen.Cursor := crDefault;
  end;
end;

procedure TNewStuBdHistory.R1Click(Sender: TObject);
var
  bm:TBookmark;
begin
  bm := ClientDataSet1.GetBookmark;
  Open_Table;
  ClientDataSet1.GotoBookmark(bm);
end;

procedure TNewStuBdHistory.RadioButton2Click(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TNewStuBdHistory.rg_BdStateClick(Sender: TObject);
begin
  ClientDataSet1.Filtered := False;
  ClientDataSet1.Filtered := rg_BdState.ItemIndex<>0;
  cbb_Value.SetFocus;
end;

procedure TNewStuBdHistory.rg_StuClick(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TNewStuBdHistory.SetBDState(const sState: string);
var
  ksh,xm,bz:string;
begin
  xm := ClientDataSet1.FieldByName('��������').AsString;
  ksh := ClientDataSet1.FieldByName('������').AsString;

  if MessageBox(Handle, PChar('���Ҫ�ѣ�'+xm+'��'+ksh+'������Ϊ��'+sState+'���𣿡�'), 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  bz := '';
  if sState='δ����' then
    if not GetNoBaoDaoBz(bz) then Exit;

  if vobj.SetStuBdState(ksh,sState,gb_Czy_ID,bz) then
  begin
    with ClientDataSet1 do
    begin
      Edit;
      FieldByName('����״̬').AsString := sState;
      FieldByName('����Ա').AsString := gb_Czy_Id;
      FieldByName('��������').AsDateTime := Now;
      FieldByName('δ����ԭ��').AsString := bz;
      Post;
    end;
    ClientDataSet1.MergeChangeLog;
    SetCountState;
    MessageBox(Handle, '������ɣ���������״̬���³ɹ�����', 'ϵͳ��ʾ', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TNewStuBdHistory.SetCountState;
  function GetCount(const sqlstr:string):Integer;
  begin
    Result := vobj.GetRecordCountBySql(sqlstr);
  end;
var
  sqlstr:string;
  iTotal,iBaoDao:Integer;
begin
  sqlstr := 'select count(*) from ¼ȡ��Ϣ�� '+GetWhere;
  iTotal := GetCount(sqlstr);
  sqlstr := 'select count(*) from ¼ȡ��Ϣ�� '+GetWhere+' and ����״̬='+quotedstr('�ѱ���');
  iBaoDao := GetCount(sqlstr);
  lbl_Total.Caption := IntToStr(iTotal);
  lbl_BaoDao.Caption := IntToStr(iBaoDao);
  lbl_NoBaoDao.Caption := IntToStr(iTotal-iBaoDao);
  if iTotal<>0 then
    lbl_BaoDaoLi.Caption := FormatFloat('0.00%',(iBaoDao/iTotal)*100)
  else
    lbl_BaoDaoLi.Caption := '0.00%';
end;

procedure TNewStuBdHistory.Timer1Timer(Sender: TObject);
begin
  lbl_RefreshHint.Caption := IntToStr(iSecound);
  Dec(iSecound);
  if iSecound<0 then
  begin
    iSecound := 30;
    mi_Refresh.Click;
    lbl_RefreshHint.Caption := IntToStr(iSecound);
  end;
end;

end.
