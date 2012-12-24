unit uXkInfoInput;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,uXkInfoEdit,
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
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    DataSource2: TDataSource;
    ClientDataSet2: TClientDataSet;
    DBGridEh2: TDBGridEh;
    Splitter1: TSplitter;
    btn_Save: TBitBtn;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
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
  private
    { Private declarations }
    aForm:TXkInfoEdit;
    function  GetWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable;
    procedure GetSfList;
    procedure GetXkZyList;
    procedure GetYxList;
    procedure ShowEditForm(const IsAdd:Boolean);
  public
    { Public declarations }
  end;

var
  XkInfoInput: TXkInfoInput;

implementation
uses uDM,uXkDataImport;
{$R *.dfm}

procedure TXkInfoInput.btn_AddClick(Sender: TObject);
begin
  ShowEditForm(True);
end;

procedure TXkInfoInput.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet2.Cancel;
end;

procedure TXkInfoInput.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ��¼�𣿡���', 'ϵͳ��ʾ', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  ClientDataSet2.Delete;
end;

procedure TXkInfoInput.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkInfoInput.btn_ImportClick(Sender: TObject);
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

procedure TXkInfoInput.btn_RefreshClick(Sender: TObject);
begin
  btn_Save.Click;
  Open_Table;
end;

procedure TXkInfoInput.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet2) then
    if dm.UpdateData('Id','select top 1 * from У����������רҵ�� ',ClientDataSet2.Delta) then
      ClientDataSet2.MergeChangeLog;
end;

procedure TXkInfoInput.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkInfoInput.ClientDataSet2NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('�п�Ժϵ').AsString := cbb_Yx.Text;
  DataSet.FieldByName('ʡ��').AsString := ClientDataSet1.FieldByName('ʡ��').AsString;
  DataSet.FieldByName('��������').AsString := ClientDataSet1.FieldByName('��������').AsString;
end;

procedure TXkInfoInput.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  Open_DeltaTable;
end;

procedure TXkInfoInput.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  btn_Save.Click;
  Action := caFree;
end;

procedure TXkInfoInput.FormCreate(Sender: TObject);
begin
  GetYxList;
  Open_Table;
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

procedure TXkInfoInput.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    //if gb_Czy_Level<>'2' then
    begin
      sList.Add('�������ѧԺ');
      sList.Add('����ѧԺ');
    end;// else
    //  sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkInfoInput.Open_DeltaTable;
var
  sqlstr,sf,yx,kd:string;
begin
  sf := ClientDataSet1.FieldByName('ʡ��').AsString;
  yx := ClientDataSet1.FieldByName('�п�Ժϵ').Asstring;
  kd := ClientDataSet1.FieldByName('��������').Asstring;

  sqlstr := 'select * from У����������רҵ�� where �п�Ժϵ='+quotedstr(yx)+' and ʡ��='+quotedstr(sf)+' and ��������='+quotedstr(kd);
  ClientDataSet2.XMLData := dm.OpenData(sqlstr);
end;

procedure TXkInfoInput.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from У���������ñ� '+GetWhere+' order by ʡ��,��������';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkInfoInput.ShowEditForm(const IsAdd: Boolean);
var
  bm:TBookmark;
  yx,sf,kdmc:string;
begin
  yx := cbb_Yx.Text;
  sf := ClientDataSet1.FieldByName('ʡ��').AsString;
  kdmc := ClientDataSet1.FieldByName('��������').AsString;
  if IsAdd then
  begin
    aForm.SetYxSfKdValue(fYx,fSf,fKm,fCjIndex,fPw);
    ClientDataSet1.Last;
    aForm.edt_Value.Text := '';
  end else
  begin
    fSf := ClientDataSet1.FieldByName('ʡ��').AsString;
    fPw := ClientDataSet1.FieldByName('��ί').AsString;
    aForm.SetYxSfKmValue(fYx,fSf,fKm,fCjIndex,fPw);
    aForm.edt_Value.Text := ClientDataSet1.FieldByName('������').AsString;
  end;

  aForm.ShowModal;

  //if DataSetNoSave(ClientDataSet1) then
  //  UpLoadCj;
  bm := ClientDataSet1.GetBookmark;
  try
    Open_Table;
  finally
    ClientDataSet1.GotoBookmark(bm);
  end;
end;

end.
