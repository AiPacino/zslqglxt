unit uXkInfoInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,uXkKsxxInfoEdit,uXkBkxxInfoEdit,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping,
  dxGDIPlusClasses;

type
  TXkInfoInput = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    ds_kd: TDataSource;
    cds_kd: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    ds_ksxx: TDataSource;
    cds_ksxx: TClientDataSet;
    Splitter1: TSplitter;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Edit: TBitBtn;
    pnl1: TPanel;
    grp1: TGroupBox;
    DBGridEh2: TDBGridEh;
    grp2: TGroupBox;
    DBGridEh3: TDBGridEh;
    ds_bkxx: TDataSource;
    cds_bkxx: TClientDataSet;
    btn1: TBitBtn;
    btn2: TBitBtn;
    btn3: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ds_kdDataChange(Sender: TObject; Field: TField);
    procedure btn_ImportClick(Sender: TObject);
    procedure cds_ksxxNewRecord(DataSet: TDataSet);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_EditClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ds_ksxxDataChange(Sender: TObject; Field: TField);
    procedure cds_bkxxNewRecord(DataSet: TDataSet);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
  private
    { Private declarations }
    ksForm:TXkKsxxInfoEdit;
    bkForm:TXkBkxxInfoEdit;
    function  GetWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable;
    procedure Open_DeltaTable2;
    procedure GetSfList;
    procedure GetXkZyList;
    procedure ShowEditKsForm(const IsAdd:Boolean);
    procedure ShowEditBkForm(const IsAdd:Boolean);
    procedure SaveKsxx;
    procedure SaveBkxx;
  public
    { Public declarations }
  end;

var
  XkInfoInput: TXkInfoInput;

implementation
uses uDM,uXkDataImport;
{$R *.dfm}

procedure TXkInfoInput.btn1Click(Sender: TObject);
begin
  ShowEditKsForm(True);
end;

procedure TXkInfoInput.btn2Click(Sender: TObject);
begin
  ShowEditKsForm(False);
end;

procedure TXkInfoInput.btn3Click(Sender: TObject);
var
  sqlstr,ksh:string;
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ��¼�𣿡���', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  ksh := cds_ksxx.FieldByName('������').AsString;

  sqlstr := 'delete from У����������רҵ�� where ������='+quotedstr(ksh);
  dm.ExecSql(sqlstr);
  sqlstr := 'delete from У��������Ϣ�� where ������='+quotedstr(ksh);
  dm.ExecSql(sqlstr);
  
  Open_DeltaTable;
end;

procedure TXkInfoInput.btn_AddClick(Sender: TObject);
begin
  ShowEditBkForm(True);
end;

procedure TXkInfoInput.btn_CancelClick(Sender: TObject);
begin
  cds_ksxx.Cancel;
end;

procedure TXkInfoInput.btn_DelClick(Sender: TObject);
var
  sqlstr,ksh,zy:string;
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ��¼�𣿡���', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  ksh := cds_bkxx.FieldByName('������').AsString;
  zy := cds_bkxx.FieldByName('רҵ').AsString;

  sqlstr := 'delete from У����������רҵ�� where ������='+quotedstr(ksh)+' and רҵ='+quotedstr(zy);
  dm.ExecSql(sqlstr);
  Open_DeltaTable2;
end;

procedure TXkInfoInput.btn_EditClick(Sender: TObject);
begin
  ShowEditBkForm(False);
end;

procedure TXkInfoInput.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkInfoInput.btn_ImportClick(Sender: TObject);
var
  sf,kd:string;
begin
  sf := cds_kd.FieldByName('ʡ��').asstring;
  kd := cds_kd.FieldByName('��������').asstring;
  if MessageBox(Handle, PChar('ȷʵҪ���롾'+sf+' '+kd+'���Ŀ�����Ϣ�𣿡���'), 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  with TXkDataImport.Create(nil) do
  begin
    Init_DescData(sf,kd,cbb_Yx.Text,'У��������Ϣ��',cds_ksxx.XMLData);
    ShowModal;
    Open_DeltaTable;
  end;
end;

procedure TXkInfoInput.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoInput.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoInput.cds_bkxxNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�п�Ժϵ').AsString := cbb_Yx.Text;
  DataSet.FieldByName('������').AsString := cds_ksxx.FieldByName('������').AsString;
  DataSet.FieldByName('����ʱ��').AsDateTime := Now;
end;

procedure TXkInfoInput.cds_ksxxNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�п�Ժϵ').AsString := cbb_Yx.Text;
  DataSet.FieldByName('ʡ��').AsString := cds_kd.FieldByName('ʡ��').AsString;
  DataSet.FieldByName('��������').AsString := cds_kd.FieldByName('��������').AsString;
end;

procedure TXkInfoInput.ds_kdDataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable;
end;

procedure TXkInfoInput.ds_ksxxDataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable2;
end;

procedure TXkInfoInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkInfoInput.FormCreate(Sender: TObject);
begin
  ksForm := TXkKsxxInfoEdit.Create(Self);
  bkForm := TXkBkxxInfoEdit.Create(Self);
  dm.GetYxList(cbb_Yx);
  Open_Table;
end;

procedure TXkInfoInput.FormDestroy(Sender: TObject);
begin
  ksForm.Free;
  bkForm.Free;
end;

procedure TXkInfoInput.GetSfList;
begin
end;

function TXkInfoInput.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where ״̬='+quotedstr('�����')+' and �п�Ժϵ='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where ״̬='+quotedstr('�����');
  Result := sWhere;
end;

procedure TXkInfoInput.GetXkZyList;
begin
end;

procedure TXkInfoInput.Open_DeltaTable;
var
  sqlstr,sf,yx,kd:string;
begin
  sf := cds_kd.FieldByName('ʡ��').AsString;
  yx := cds_kd.FieldByName('�п�Ժϵ').Asstring;
  kd := cds_kd.FieldByName('��������').Asstring;

  sqlstr := 'select * from У��������Ϣ�� where �п�Ժϵ='+quotedstr(yx)+' and ʡ��='+quotedstr(sf)+' and ��������='+quotedstr(kd);
  cds_ksxx.XMLData := dm.OpenData(sqlstr);
end;

procedure TXkInfoInput.Open_DeltaTable2;
var
  sqlstr,ksh:string;
begin
  ksh := cds_ksxx.FieldByName('������').AsString;

  sqlstr := 'select * from У����������רҵ�� where ������='+quotedstr(ksh);
  cds_bkxx.XMLData := dm.OpenData(sqlstr);
end;

procedure TXkInfoInput.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from У���������ñ� '+GetWhere+' order by ʡ��,��������';
  cds_kd.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkInfoInput.SaveBkxx;
begin
  if DataSetNoSave(cds_bkxx) then
    if dm.UpdateData('Id','select top 0 * from У����������רҵ�� ',cds_bkxx.Delta) then
      cds_bkxx.MergeChangeLog;
end;

procedure TXkInfoInput.SaveKsxx;
begin
  if DataSetNoSave(cds_ksxx) then
    if dm.UpdateData('Id','select top 0 * from У��������Ϣ�� ',cds_ksxx.Delta) then
      cds_ksxx.MergeChangeLog;
end;

procedure TXkInfoInput.ShowEditBkForm(const IsAdd: Boolean);
var
  yx,sf,kdmc,Ksh:string;
begin
  yx := cbb_Yx.Text;
  sf := cds_ksxx.FieldByName('ʡ��').AsString;
  kdmc := cds_ksxx.FieldByName('��������').AsString;
  Ksh := cds_ksxx.FieldByName('������').AsString;

  bkForm.SetParam(yx,Ksh,IsAdd);
  bkForm.ShowModal;

end;

procedure TXkInfoInput.ShowEditKsForm(const IsAdd: Boolean);
var
  yx,sf,kdmc,Ksh:string;
begin
  yx := cbb_Yx.Text;
  sf := cds_ksxx.FieldByName('ʡ��').AsString;
  kdmc := cds_ksxx.FieldByName('��������').AsString;
  Ksh := cds_ksxx.FieldByName('������').AsString;
  ksForm.SetParam(Ksh,IsAdd);

  ksForm.ShowModal;
end;

end.
