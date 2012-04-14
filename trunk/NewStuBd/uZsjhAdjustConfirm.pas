unit uZsjhAdjustConfirm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, uCzyRightGroupSet,
  Buttons, DB, DBClient,ActnList, CheckLst, Menus, RzPanel, 
  GridsEh, DBGridEh, pngimage, frxpngimage, DBGridEhGrouping, Mask, DBCtrlsEh,
  DBCtrls;

type
  TZsjhAdjustConfirm = class(TForm)
    pnl1: TPanel;
    pnl_Main: TPanel;
    btn_Exit: TBitBtn;
    cds_Yx: TClientDataSet;
    ds_Yx: TDataSource;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    cds_Zy: TClientDataSet;
    ds_Zy: TDataSource;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Xlcc: TDBComboBoxEh;
    pnl7: TPanel;
    RzGroupBox1: TRzGroupBox;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    Panel3: TPanel;
    GroupBox1: TRzGroupBox;
    chklst1: TCheckListBox;
    DBGridEh2: TDBGridEh;
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
  ZsjhAdjustConfirm: TZsjhAdjustConfirm;

implementation
uses uDM,uMain,uZyselect;
{$R *.dfm}

procedure TZsjhAdjustConfirm.BitBtn2Click(Sender: TObject);
var
  sNo,sError:string;
begin
  if MessageBox(Handle, '���Ҫ���ͨ����ǰ�ƻ��������뵥�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    sNo := cds_Yx.FieldByName('Id').AsString;
    if vobj.ConfirmJH(sNo,gb_Czy_ID,sError) then
    begin
      DBGridEh1.SaveBookmark;
      Open_YxTable;
      DBGridEh1.RestoreBookmark;
    end else
      MessageBox(Handle, pchar('�ƻ���������˴���ʧ�ܣ�ԭ��Ϊ��'+sError��),
        'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
  end;
end;

procedure TZsjhAdjustConfirm.BitBtn3Click(Sender: TObject);
var
  Id,sError:string;
begin
  if MessageBox(Handle, '���Ҫȡ����ǰ�ƻ��������뵥�𣿡�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONERROR + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    Id := cds_Yx.FieldByName('Id').AsString;
    if vobj.CancelJH(Id,'�ܾ����μƻ�����',gb_Czy_ID,sError) then
    begin
      DBGridEh1.SaveBookmark;
      Open_YxTable;
      DBGridEh1.RestoreBookmark;
    end else
      MessageBox(Handle, pchar('ȡ����˴���ʧ�ܣ�ԭ��Ϊ��'+sError��), 
        'ϵͳ��ʾ', MB_OK + MB_ICONSTOP);
  end;
end;

procedure TZsjhAdjustConfirm.btn_AddClick(Sender: TObject);
begin
  cds_Zy.Append;
end;

procedure TZsjhAdjustConfirm.btn_DelClick(Sender: TObject);
begin
  cds_Zy.Delete;
end;

procedure TZsjhAdjustConfirm.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TZsjhAdjustConfirm.btn_RefreshClick(Sender: TObject);
begin
  DBGridEh1.SaveBookmark;
  Open_YxTable;
  DBGridEh1.RestoreBookmark;
end;

procedure TZsjhAdjustConfirm.btn_RightGroupClick(Sender: TObject);
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

procedure TZsjhAdjustConfirm.btn_SaveItemClick(Sender: TObject);
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

procedure TZsjhAdjustConfirm.cbb_XlccChange(Sender: TObject);
begin
  Open_YxTable;
end;

procedure TZsjhAdjustConfirm.ds_YxDataChange(Sender: TObject; Field: TField);
begin
  Open_YxZyTable;
end;

function TZsjhAdjustConfirm.InitMenuTable:Boolean;
begin
end;

procedure TZsjhAdjustConfirm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TZsjhAdjustConfirm.FormCreate(Sender: TObject);
begin
  dm.SetXlCcComboBox(cbb_Xlcc);
  Open_YxTable;
end;

procedure TZsjhAdjustConfirm.FormDestroy(Sender: TObject);
begin
//  if Assigned(myform) then
//    FreeAndNil(myform);
end;

procedure TZsjhAdjustConfirm.GetXqList;
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

procedure TZsjhAdjustConfirm.InitMenuItemCheckByCzy(const sCzyId: string);
begin
end;

procedure TZsjhAdjustConfirm.InitMenuItemCheckByGroup(const sId: string);
begin
end;

procedure TZsjhAdjustConfirm.InitRightGroup;
begin
end;

procedure TZsjhAdjustConfirm.InitRightTree;
begin
end;

function TZsjhAdjustConfirm.ItemInEnabled(const sItem: string): Boolean;
begin
end;

function TZsjhAdjustConfirm.ItemInVisabled(const sItem: string): Boolean;
begin
end;

procedure TZsjhAdjustConfirm.Open_YxTable;
var
  sWhere:string;
begin
  sWhere := ' where 1>0'+
            ' and ѧ�����='+quotedstr(cbb_Xlcc.Text)+
            ' and ״̬='+quotedstr('�����');

  cds_Yx.DisableControls;
  try
    cds_Yx.XMLData := DM.OpenData('select * from �ƻ������� '+sWhere+' order by Id');
  finally
    cds_Yx.EnableControls;
  end;
end;

procedure TZsjhAdjustConfirm.Open_YxZyTable;
var
  sWhere,sId:string;
  sqlstr:string;
begin
  sId := cds_Yx.FieldByName('Id').AsString;
  sWhere := ' where pid='+quotedstr(sId);

  cds_Zy.DisableControls;
  try
    sqlstr := 'select * from View_�ƻ�������ϸ�� '+sWhere;
    cds_Zy.XMLData := DM.OpenData(sqlstr);
  finally
    cds_Zy.EnableControls;
  end;
end;

procedure TZsjhAdjustConfirm.rg_XlccClick(Sender: TObject);
begin
  Open_YxTable;
end;


end.
