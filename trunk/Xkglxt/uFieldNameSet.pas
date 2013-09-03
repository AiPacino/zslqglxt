unit uXkKmPwRsSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TXkKmPwRsSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Save: TBitBtn;
    btn_Refresh: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure ClientDataSet1NewRecord(DataSet: TDataSet);
    procedure DBGridEh1Enter(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkKmPwRsSet: TXkKmPwRsSet;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKmPwRsSet.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TXkKmPwRsSet.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKmPwRsSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前记录吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
      ClientDataSet1.Delete;
      btn_Save.Click;
  end;
end;

procedure TXkKmPwRsSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmPwRsSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmPwRsSet.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from 校考科目评委人数表 where 1=0',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkKmPwRsSet.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmPwRsSet.ClientDataSet1NewRecord(DataSet: TDataSet);
begin
  //if cbb_Yx.Text<>'不限院系' then
  DataSet.FieldByName('承考院系').AsString := cbb_Yx.Text;
  DataSet.FieldByName('评委数').AsInteger := 1;
end;

procedure TXkKmPwRsSet.DBGridEh1Enter(Sender: TObject);
begin
  DBGridEh1.SelectedIndex := 2;
end;

procedure TXkKmPwRsSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '数据已修改但尚未保存，要保存吗？　', '系统提示',
      MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=mrYes then
      btn_Save.Click;
  Action := caFree;
end;

procedure TXkKmPwRsSet.FormShow(Sender: TObject);
begin
  GetYxList;
end;

function TXkKmPwRsSet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  Result := sWhere;
end;

procedure TXkKmPwRsSet.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      //dm.GetAllYxList(sList);
      //cbb_Yx.Items.Add('不限院系');
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkKmPwRsSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考科目评委人数表 '+GetWhere+' order by Id';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  if self.Showing then
    DBGridEh1.SetFocus;
end;

end.
