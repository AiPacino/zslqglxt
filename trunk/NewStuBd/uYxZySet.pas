unit uYxZySet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, uCzyRightGroupSet,
  Buttons, DB, DBClient,ActnList, CheckLst, Menus, RzPanel, 
  GridsEh, DBGridEh, pngimage, frxpngimage, DBGridEhGrouping, Mask, DBCtrlsEh;

type
  TYxZySet = class(TForm)
    pnl1: TPanel;
    pnl_Main: TPanel;
    btn_Exit: TBitBtn;
    pnl2: TPanel;
    pnl7: TPanel;
    GroupBox1: TRzGroupBox;
    chklst1: TCheckListBox;
    RzGroupBox1: TRzGroupBox;
    DBGridEh1: TDBGridEh;
    cds_Yx: TClientDataSet;
    ds_Yx: TDataSource;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    DBGridEh2: TDBGridEh;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    cds_Zy: TClientDataSet;
    ds_Zy: TDataSource;
    btn_YxSet: TBitBtn;
    btn_ZySet: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Xlcc: TDBComboBoxEh;
    btn_Save: TBitBtn;
    grp_Lb: TGroupBox;
    cbb_Lb: TDBComboBoxEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveItemClick(Sender: TObject);
    procedure btn_RightGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ds_YxDataChange(Sender: TObject; Field: TField);
    procedure N1Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure cbb_XlccChange(Sender: TObject);
  private
    { Private declarations }
    myform :TCzyRightGroupSet;
    Old_CzyId:string;
    procedure Open_YxTable;
    procedure Open_YxZyTable;
    procedure InitRightGroup;
    procedure InitRightTree;
    procedure InitMenuItemCheckByGroup(const sId:string); //����Ȩ�޳�ʼ����
    procedure InitMenuItemCheckByCzy(const sCzyId:string);//�ò���ԱȨ�޳�ʼ����

    procedure SetChecked(const CheckType:Integer);
    function  InitMenuTable:Boolean;
    function  ItemInEnabled(const sItem:string):Boolean;
    function  ItemInVisabled(const sItem:string):Boolean;
    function  UpdateCzyRight(const sCzyId:string):Boolean;
    procedure GetXqList;
  public
    { Public declarations }
  end;

var
  YxZySet: TYxZySet;

implementation
uses uDM,uMain,uZyselect;
{$R *.dfm}

procedure TYxZySet.btn_AddClick(Sender: TObject);
var
  YxId,Xq,Yx,ZyId,Zy,sqlstr,sWhere:string;
  sList:TStrings;
  cds_Temp:TClientDataSet;
  i:Integer;
begin
  YxId := cds_Yx.FieldByName('Id').AsString;
  Xq := cds_Yx.FieldByName('Ĭ��У��').AsString;

  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;

  Screen.Cursor := crHourGlass;
  cds_Zy.DisableControls;
  try
    cds_Temp.XMLData := cds_Zy.XMLData;
    while not cds_Temp.Eof do
    begin
      ZyId := cds_Temp.FieldByName('Id').AsString;
      zy := cds_Temp.FieldByName('רҵ').AsString;
      sList.Add(ZyId+'='+Zy);
      cds_Temp.Next;
    end;

    if dm.SelectZy(cbb_Xlcc.Text,'',sList) then
    begin
      for i:=0 to sList.Count-1 do
      begin
        ZyId := sList.Names[i];
        sqlstr := 'Insert Into Ժϵרҵ�� (ԺϵId,רҵId,У��) Values(+'+Yxid+','+Zyid+','+quotedstr(Xq)+')';
        dm.ExecSql(sqlstr);
      end;
      Open_YxZyTable;
    end;
  finally
    sList.Free;
    cds_Temp.Free;
    cds_Zy.EnableControls;
    Screen.Cursor := crDefault;
  end;
end;

procedure TYxZySet.btn_DelClick(Sender: TObject);
var
  Id,sqlstr:string;
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ��רҵ��Ϣ�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    Id := cds_Zy.FieldByName('Id').AsString;
    sqlstr := 'delete from Ժϵרҵ�� where Id='+Id;
    dm.ExecSql(sqlstr);
    Open_YxZyTable;
  end;
end;

procedure TYxZySet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TYxZySet.btn_RightGroupClick(Sender: TObject);
var
  t,l:Integer;
begin
  t := Self.Top;
  l := Self.Left;
  with TCzyRightGroupSet.Create(Self) do
  begin
    Top := t-50;
    Left := l+80;
    ShowModal;
  end;
end;

procedure TYxZySet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(cds_Zy) then
    if dm.UpdateData('Id','select top 0 * from view_Ժϵרҵ��',cds_Zy.Delta,True) then
      cds_Zy.MergeChangeLog;
end;

procedure TYxZySet.btn_SaveItemClick(Sender: TObject);
var
  sPwd:string;
begin
  if MessageBox(Handle, '���ò��������ؽ����в˵���Ŀ�����ȫ���û�Ȩ�ޣ�����' 
    + #13#10 + '��Ҫ����ִ����һ������', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  if InputQuery('������֤','��������֤����:',sPwd) then
  begin
    if sPwd<>'xlinuxx' then
    begin
      Application.MessageBox('�������������������룡����', 'ϵͳ��ʾ',
        MB_OK + MB_ICONSTOP);
      Exit;
    end;
  end else
    Exit;
  if InitMenuTable then
  begin
    Application.MessageBox('������ɣ�ϵͳ�˵����óɹ�������', 'ϵͳ��ʾ',MB_OK + MB_ICONINFORMATION);
    Self.OnCreate(Self);
  end else
    Application.MessageBox('ϵͳ�˵�����ʧ�ܣ�������ִ�����ò���������', 'ϵͳ��ʾ',MB_OK + MB_ICONSTOP);

end;

procedure TYxZySet.cbb_XlccChange(Sender: TObject);
begin
  if Self.Showing then
    Open_YxTable;
end;

procedure TYxZySet.ds_YxDataChange(Sender: TObject; Field: TField);
begin
  Open_YxZyTable;
end;

function TYxZySet.InitMenuTable:Boolean;
begin
end;

procedure TYxZySet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TYxZySet.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  GetXqList;
  sList := TStringList.Create;
  try
    dm.SetXlCcComboBox(cbb_Xlcc);
    dm.SetLbComboBox(cbb_Lb,True);
    Open_YxTable;
  finally
    sList.Free;
  end;
end;

procedure TYxZySet.FormDestroy(Sender: TObject);
begin
//  if Assigned(myform) then
//    FreeAndNil(myform);
end;

procedure TYxZySet.GetXqList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetXqList(sList);
    DBGridEh2.Columns[9].PickList.Clear;
    DBGridEh2.Columns[9].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;

end;

procedure TYxZySet.InitMenuItemCheckByCzy(const sCzyId: string);
begin
end;

procedure TYxZySet.InitMenuItemCheckByGroup(const sId: string);
begin
end;

procedure TYxZySet.InitRightGroup;
begin
end;

procedure TYxZySet.InitRightTree;
begin
end;

function TYxZySet.ItemInEnabled(const sItem: string): Boolean;
begin
end;

function TYxZySet.ItemInVisabled(const sItem: string): Boolean;
begin
end;

procedure TYxZySet.N1Click(Sender: TObject);
begin
  SetChecked(TMenuItem(Sender).Tag);
end;

procedure TYxZySet.Open_YxTable;
var
  sWhere :string;
begin
  if Pos('����',cbb_Xlcc.Text)>0 then
    sWhere := ' and ���ƽ�ѧ=1'
  else if Pos('ר��',cbb_Xlcc.Text)>0 then
    sWhere := ' and ר�ƽ�ѧ=1';

  cds_Yx.DisableControls;
  try
    cds_Yx.XMLData := DM.OpenData('select Id,Ժϵ,Ĭ��У�� from Ժϵ��Ϣ�� where ��ѧ��λ=1 '+sWhere+' order by Id');
  finally
    cds_Yx.EnableControls;
  end;
end;

procedure TYxZySet.Open_YxZyTable;
var
  xlcc,sWhere:string;
  sqlstr:string;
begin
  sWhere := 'where ѧ�����='+quotedstr(cbb_Xlcc.Text);
  sWhere := sWhere+' and ԺϵId='+cds_Yx.FieldByName('Id').AsString;
  if cbb_Lb.Text<>'ȫ��' then
    sWhere := sWhere + ' and ���='+quotedstr(cbb_Lb.Text);


  cds_Zy.DisableControls;
  try
    sqlstr := 'select * from view_Ժϵרҵ�� '+sWhere+' order by Ժϵ,רҵ';
    cds_Zy.XMLData := DM.OpenData(sqlstr);
    if Self.Showing then
      DBGridEh2.SetFocus;
  finally
    cds_Zy.EnableControls;
  end;
end;

procedure TYxZySet.RadioGroup1Click(Sender: TObject);
begin
  Open_YxTable;
end;

procedure TYxZySet.SetChecked(const CheckType: Integer);
begin
end;

function TYxZySet.UpdateCzyRight(const sCzyId:string):Boolean;
begin
end;

end.
