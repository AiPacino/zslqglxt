unit uYxZyList;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, DBCtrls,
  MyDBNavigator, StdCtrls, Buttons, pngimage, ExtCtrls,DBGridEhImpExp,
  frxpngimage, DBGridEhGrouping;

type
  TYxZyList = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    pnl1: TPanel;
    btn_Close: TBitBtn;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    btn_Export: TBitBtn;
    btn_YxSet: TBitBtn;
    btn_ZySet: TBitBtn;
    RadioGroup1: TRadioGroup;
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_CloseClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExportClick(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
    procedure Open_Table;
    procedure GetDeptList;
    procedure GetXqList;
  public
    { Public declarations }
  end;

var
  YxZyList: TYxZyList;

implementation
uses uDM,uMain;
{$R *.dfm}

procedure TYxZyList.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TYxZyList.btn_ExportClick(Sender: TObject);
begin
  dm.ExportDBEditEH(DBGridEh1);
end;

procedure TYxZyList.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 1 * from view_院系专业表',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TYxZyList.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TYxZyList.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetXlCcList(sList,True);
    RadioGroup1.Items.Assign(sList);
    Open_Table;
  finally
    sList.Free;
  end;
end;

procedure TYxZyList.GetDeptList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    with DBGridEh1.Columns[1] do
    begin
      PickList.Clear;
      dm.GetDeptList(sList);
      PickList.AddStrings(sList);
    end;
  finally
    sList.Free;
  end;
end;

procedure TYxZyList.GetXqList;
var
  xq:string;
  sList:TStrings;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select * from 校区信息表');
    DBGridEh1.Columns[5].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      xq := cds_Temp.FieldByName('校区').AsString+'：'+cds_Temp.FieldByName('地址').AsString;
      DBGridEh1.Columns[5].PickList.Add(xq);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
    sList.Free;
  end;
end;

procedure TYxZyList.Open_Table;
var
  sqlstr :string;
  sWhere :string;
  ii : Integer;
begin
  ii := RadioGroup1.ItemIndex;
  if RadioGroup1.ItemIndex>0 then
    sWhere := ' where 学历层次='+quotedstr(RadioGroup1.Items[RadioGroup1.ItemIndex]);
  sqlstr := 'select * from view_院系专业表 '+sWhere+' order by 院系';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

procedure TYxZyList.RadioGroup1Click(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

end.
