unit uZsjhAdjustBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, uCzyRightGroupSet,
  Buttons, DB, DBClient,ActnList, CheckLst, Menus, RzPanel, 
  GridsEh, DBGridEh, pngimage, frxpngimage, DBGridEhGrouping, Mask, DBCtrlsEh,
  DBCtrls, dxGDIPlusClasses;

type
  TZsjhAdjustBrowse = class(TForm)
    pnl1: TPanel;
    btn_Exit: TBitBtn;
    cds_Yx: TClientDataSet;
    ds_Yx: TDataSource;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    cds_Zy: TClientDataSet;
    ds_Zy: TDataSource;
    grp_Yx: TGroupBox;
    cbb_Xlcc: TDBComboBoxEh;
    RzGroupBox1: TRzGroupBox;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TRzGroupBox;
    chklst1: TCheckListBox;
    DBGridEh2: TDBGridEh;
    btn_print: TBitBtn;
    btn_Refresh: TBitBtn;
    GroupBox2: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    dbedt1: TDBEdit;
    dbedt2: TDBEdit;
    dbedt3: TDBEdit;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    dbedt4: TDBEdit;
    edt_Sf: TDBComboBoxEh;
    edt_Lx: TDBComboBoxEh;
    DBGridEh1: TDBGridEh;
    ClientDataSet1: TClientDataSet;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveItemClick(Sender: TObject);
    procedure btn_RightGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ds_YxDataChange(Sender: TObject; Field: TField);
    procedure rg_XlccClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure cbb_XlccChange(Sender: TObject);
    procedure btn_printClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
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

    function  InitMenuTable:Boolean;
    function  ItemInEnabled(const sItem:string):Boolean;
    function  ItemInVisabled(const sItem:string):Boolean;
    procedure GetXqList;
  public
    { Public declarations }
  end;

var
  ZsjhAdjustBrowse: TZsjhAdjustBrowse;

implementation
uses uDM,uMain,uZyselect;
{$R *.dfm}

procedure TZsjhAdjustBrowse.BitBtn2Click(Sender: TObject);
var
  sNo,sError:string;
begin
  sNo := vobj.GetAdjustJHNo;
  cds_Yx.Append;
  cds_Yx.FieldByName('Id').Value := sNo;
  cds_Yx.FieldByName('����ԭ��').Value := '���������ԭ��';
  cds_Yx.FieldByName('������').Value := gb_Czy_ID;
  cds_Yx.Post;
  DBGridEh1.SetFocus;
  DBGridEh1.SelectedIndex := 1;
end;

procedure TZsjhAdjustBrowse.BitBtn3Click(Sender: TObject);
var
  Id,sError:string;
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ���뵥�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    Id := cds_Zy.FieldByName('Id').AsString;
    vobj.DeleteJH(Id,gb_Czy_ID,sError);
  end;
end;

procedure TZsjhAdjustBrowse.btn_AddClick(Sender: TObject);
begin
  cds_Zy.Append;
end;

procedure TZsjhAdjustBrowse.btn_DelClick(Sender: TObject);
begin
  cds_Zy.Delete;
end;

procedure TZsjhAdjustBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TZsjhAdjustBrowse.btn_printClick(Sender: TObject);
var
  sId:string;
begin
  sId := cds_Yx.FieldByName('Id').AsString;
  ClientDataSet1.XMLData := dm.OpenData('select * from �ƻ������� where Id='+quotedstr(sId));
  dm.PrintReport('�ƻ����������.fr3',ClientDataSet1.XMLData,1);
end;

procedure TZsjhAdjustBrowse.btn_RefreshClick(Sender: TObject);
begin
  DBGridEh1.SaveBookmark;
  Open_YxTable;
  DBGridEh1.RestoreBookmark;
end;

procedure TZsjhAdjustBrowse.btn_RightGroupClick(Sender: TObject);
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

procedure TZsjhAdjustBrowse.btn_SaveItemClick(Sender: TObject);
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

procedure TZsjhAdjustBrowse.cbb_XlccChange(Sender: TObject);
begin
  Open_YxTable;
end;

procedure TZsjhAdjustBrowse.ds_YxDataChange(Sender: TObject; Field: TField);
begin
  Open_YxZyTable;
end;

function TZsjhAdjustBrowse.InitMenuTable:Boolean;
begin
end;

procedure TZsjhAdjustBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TZsjhAdjustBrowse.FormCreate(Sender: TObject);
var
  i:integer;
begin
  DBGridEh2.FieldColumns['������'].KeyList.Clear;
  DBGridEh2.FieldColumns['������'].PickList.Clear;
  for i := -20 to 20 do
  begin
    DBGridEh2.FieldColumns['������'].KeyList.Add(IntToStr(i));
    if i>0 then
      DBGridEh2.FieldColumns['������'].PickList.Add('+'+IntToStr(i))
    else
      DBGridEh2.FieldColumns['������'].PickList.Add(IntToStr(i));
  end;

  dm.SetXlCcComboBox(cbb_Xlcc);
  Open_YxTable;
end;

procedure TZsjhAdjustBrowse.FormDestroy(Sender: TObject);
begin
//  if Assigned(myform) then
//    FreeAndNil(myform);
end;

procedure TZsjhAdjustBrowse.GetXqList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetXqList(sList);
    DBGridEh1.Columns[5].PickList.Clear;
    DBGridEh1.Columns[5].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;

end;

procedure TZsjhAdjustBrowse.InitMenuItemCheckByCzy(const sCzyId: string);
begin
end;

procedure TZsjhAdjustBrowse.InitMenuItemCheckByGroup(const sId: string);
begin
end;

procedure TZsjhAdjustBrowse.InitRightGroup;
begin
end;

procedure TZsjhAdjustBrowse.InitRightTree;
begin
end;

function TZsjhAdjustBrowse.ItemInEnabled(const sItem: string): Boolean;
begin
end;

function TZsjhAdjustBrowse.ItemInVisabled(const sItem: string): Boolean;
begin
end;

procedure TZsjhAdjustBrowse.Open_YxTable;
var
  sWhere:string;
begin
  sWhere := ' where 1>0'+
            ' and ѧ�����='+quotedstr(cbb_Xlcc.Text)+
            ' and ״̬<>'+quotedstr('�༭��');

  cds_Yx.DisableControls;
  try
    cds_Yx.XMLData := DM.OpenData('select * from �ƻ������� '+sWhere+' order by Id');
  finally
    cds_Yx.EnableControls;
  end;
end;

procedure TZsjhAdjustBrowse.Open_YxZyTable;
var
  sWhere,sId:string;
  sqlstr:string;
begin
  sId := cds_Yx.FieldByName('Id').AsString;
  sWhere := ' where pid='+quotedstr(sId);

  try
    sqlstr := 'select * from view_�ƻ�������ϸ�� '+sWhere;
    cds_Zy.XMLData := DM.OpenData(sqlstr);
  finally
  end;
end;

procedure TZsjhAdjustBrowse.rg_XlccClick(Sender: TObject);
begin
  Open_YxTable;
end;


end.
