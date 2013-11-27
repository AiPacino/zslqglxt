unit uCzyEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, GridsEh, DBGridEh, DB,
  DBClient, Buttons, DBCtrls, MyDBNavigator, pngimage, 
  frxpngimage, DBGridEhGrouping;

type
  TCzyEdit = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    edt1: TEdit;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    DBGridEh1: TDBGridEh;
    pnl1: TPanel;
    btn_Close: TBitBtn;
    btn_Save: TBitBtn;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    procedure btn_CloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_RightSetClick(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
  private
    { Private declarations }
    sSqlStr:String;
  public
    { Public declarations }
  end;

var
  CzyEdit: TCzyEdit;

implementation
uses uDM;//,uCzyRightSet;
{$R *.dfm}

procedure TCzyEdit.btn_RightSetClick(Sender: TObject);
var
  t,l:Integer;
begin
  t := Self.Top;
  l := Self.Left;
  //with TCzyRightSet.Create(Self) do
  begin
    Top := t-50;
    Left := l-80;
    ShowModal;
  end;
end;

procedure TCzyEdit.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('����Ա���',sSqlStr,ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TCzyEdit.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('ע������').Asstring := FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
end;

procedure TCzyEdit.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TCzyEdit.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TCzyEdit.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCzyEdit.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '���Ҫɾ����ǰ����Ա��Ϣ�𣿡�', 'ϵͳ��ʾ', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    ClientDataSet1.Delete;
    btn_Save.Click;
  end;
end;

procedure TCzyEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '�������޸ĵ���δ���棬Ҫ�����𣿡�', 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TCzyEdit.FormCreate(Sender: TObject);
var
  sData:String;
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetDeptList(sList);
    DBGridEh1.Columns[2].PickList.Clear;
    DBGridEh1.Columns[2].PickList.AddStrings(sList);
  finally
    sList.Free;
  end;
  if gb_Czy_Level='-1' then
    sSqlStr := 'select * from ����Ա��'
  else if gb_Czy_Level='0' then
    sSqlStr := 'select * from ����Ա�� where ����Ա���='+quotedstr(gb_Czy_ID)+' OR ����Ա�ȼ�>'+gb_Czy_Level
  else
    sSqlStr := 'select * from ����Ա�� where ����Ա���='+quotedstr(gb_Czy_ID);

  //btn_RightSet.Enabled := gb_Czy_Level='-1';
  sData := dm.OpenData(sSqlStr);
  ClientDataSet1.XMLData := sData;
end;

end.
