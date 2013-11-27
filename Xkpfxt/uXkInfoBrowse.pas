unit uXkInfoBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh,CnProgressFrm,
  DBGridEhGrouping, dxGDIPlusClasses;

type
  TXkInfoBrowse = class(TForm)
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
    DataSource2: TDataSource;
    ClientDataSet2: TClientDataSet;
    DBGridEh2: TDBGridEh;
    Splitter1: TSplitter;
    btn_Export: TButton;
    DBGridEh_Export: TDBGridEh;
    ds_Export: TDataSource;
    cds_Export: TClientDataSet;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure btn_ImportClick(Sender: TObject);
    procedure ClientDataSet2NewRecord(DataSet: TDataSet);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_ExportClick(Sender: TObject);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable(const ShowHint:Boolean=False);
    procedure GetSfList;
    procedure GetXkZyList;
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkInfoBrowse: TXkInfoBrowse;

implementation
uses uDM,uXkDataImport;
{$R *.dfm}

procedure TXkInfoBrowse.btn_AddClick(Sender: TObject);
begin
  ClientDataSet2.Append;
  DBGridEh2.SetFocus;
end;

procedure TXkInfoBrowse.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet2.Cancel;
end;

procedure TXkInfoBrowse.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ��¼�𣿡���', 'ϵͳ��ʾ', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  ClientDataSet2.Delete;
end;

procedure TXkInfoBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkInfoBrowse.btn_ExportClick(Sender: TObject);
var
  sqlstr:string;
begin
  if MessageBox(Handle, '���Ҫ������Ժϵ���еĿ���������Ϣ�𣿡�', 
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
    IDNO then
  begin
    Exit;
  end;

  sqlstr := 'select * from У����������רҵ�� order by �п�Ժϵ,ʡ��,��������,רҵ';
  cds_Export.XMLData := dm.OpenData(sqlstr,True);
  if dm.ExportDBEditEH(DBGridEh_Export) then
    MessageBox(Handle, pchar('������ɣ�����'+Inttostr(cds_export.RecordCount)+'����¼����������'), 'ϵͳ��ʾ',
      MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
end;

procedure TXkInfoBrowse.btn_ImportClick(Sender: TObject);
var
  sf,kd:string;
begin
  sf := ClientDataSet1.FieldByName('ʡ��').asstring;
  kd := ClientDataSet1.FieldByName('��������').asstring;
  if MessageBox(Handle, PChar('ȷʵҪ���롾'+sf+' '+kd+'���Ŀ�����Ϣ�𣿡���'), 'ϵͳ��ʾ', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  with TXkDataImport.Create(nil) do
  begin
    Init_DescData(sf,kd,cbb_Yx.Text,ClientDataSet2.XMLData);
    ShowModal;
    Open_DeltaTable;
  end;
end;

procedure TXkInfoBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoBrowse.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet2) then
    if dm.UpdateData('Id','select top 1 * from У����������רҵ�� ',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkInfoBrowse.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoBrowse.ClientDataSet2NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�п�Ժϵ').AsString := cbb_Yx.Text;
  DataSet.FieldByName('ʡ��').AsString := ClientDataSet1.FieldByName('ʡ��').AsString;
  DataSet.FieldByName('��������').AsString := ClientDataSet1.FieldByName('��������').AsString;
end;

procedure TXkInfoBrowse.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  ClientDataSet2.Close;
  ClientDataSet2.XMLData := '';//.Close;
  Open_DeltaTable(ClientDataSet1.FieldByName('����').AsInteger>3000);
end;

procedure TXkInfoBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkInfoBrowse.FormCreate(Sender: TObject);
begin
  GetYxList;
  //Open_Table;
end;

procedure TXkInfoBrowse.GetSfList;
begin
end;

function TXkInfoBrowse.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where ״̬='+quotedstr('�����')+' and �п�Ժϵ='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where ״̬='+quotedstr('�����');
  Result := sWhere;
end;

procedure TXkInfoBrowse.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select ���Կ�Ŀ from У����Ŀ�� '+GetWhere);
    DBGridEh1.Columns[3].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('���Կ�Ŀ').AsString);
      cds_Temp.Next;
    end;
    DBGridEh1.Columns[3].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkInfoBrowse.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      sList.Add('�������ѧԺ');
      sList.Add('����ѧԺ');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkInfoBrowse.Open_DeltaTable(const ShowHint:Boolean=False);
var
  sqlstr,sf,yx,kd:string;
begin
  sf := ClientDataSet1.FieldByName('ʡ��').AsString;
  yx := ClientDataSet1.FieldByName('�п�Ժϵ').Asstring;
  kd := ClientDataSet1.FieldByName('��������').Asstring;

  sqlstr := 'select * from У����������רҵ�� where �п�Ժϵ='+quotedstr(yx)+
            ' and ʡ��='+quotedstr(sf)+' and ��������='+quotedstr(kd);
  ClientDataSet2.XMLData := dm.OpenData(sqlstr,ShowHint);//,True);
end;

procedure TXkInfoBrowse.Open_Table;
var
  sqlstr:string;
begin
  try
    ClientDataSet1.DisableControls;
    sqlstr := 'select * from view_У���������ñ� '+GetWhere+' order by ʡ��,��������';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  finally
    ClientDataSet1.EnableControls;
  end;
end;

end.
