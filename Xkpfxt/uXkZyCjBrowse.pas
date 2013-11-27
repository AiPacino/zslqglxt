unit uXkZyCjBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,uXkKsKmCjBrowse,
  DBGridEhGrouping;

type
  TXkZyCjBrowse = class(TForm)
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
    btn_print: TBitBtn;
    grp1: TGroupBox;
    cbb_Zy: TDBComboBoxEh;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_ZyChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueChange(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    fDeltaForm:TXkKsKmcjBrowse;
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
    procedure GetXkZyList;
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkZyCjBrowse: TXkZyCjBrowse;

implementation
uses uDM;
{$R *.dfm}

procedure TXkZyCjBrowse.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TXkZyCjBrowse.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkZyCjBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkZyCjBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkZyCjBrowse.btn_SearchClick(Sender: TObject);
begin
  if not ClientDataSet1.Locate(cbb_Field.Text,edt_Value.Text,[]) then
  begin
    Application.MessageBox('未找到符合查询条件的记录！请检查后重试！　',
      '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2);
    edt_Value.SetFocus;
  end else
    DBGridEh1.SetFocus;
end;

procedure TXkZyCjBrowse.cbb_YxChange(Sender: TObject);
begin
  GetXkZyList;
end;

procedure TXkZyCjBrowse.cbb_ZyChange(Sender: TObject);
begin
  if cbb_Zy.Text='' then Exit;

  if Self.Showing then
    Open_Table;
end;

procedure TXkZyCjBrowse.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  if Self.Showing and fDeltaForm.Showing then
  begin
    DBGridEh1DblClick(Self);
  end;
end;

procedure TXkZyCjBrowse.DBGridEh1DblClick(Sender: TObject);
var
  yx,zy,ksh:string;
begin
  if not ClientDataSet1.FieldByName('考生号').IsNull then
  begin
    yx := ClientDataSet1.FieldByName('承考院系').AsString;
    zy := ClientDataSet1.FieldByName('专业').AsString;
    ksh := ClientDataSet1.FieldByName('考生号').AsString;
    fDeltaForm.Open_Table(yx,zy,ksh);
    if not fDeltaForm.Showing then
      fDeltaForm.Show;
  end;
end;

procedure TXkZyCjBrowse.edt_ValueChange(Sender: TObject);
begin
  btn_Search.Click;
end;

procedure TXkZyCjBrowse.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TXkZyCjBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkZyCjBrowse.FormCreate(Sender: TObject);
begin
  fDeltaForm := TXkKsKmcjBrowse.Create(nil);
  fDeltaForm.Left := Screen.Width-fDeltaform.Width-10;
  fDeltaForm.Top := 70;
end;

procedure TXkZyCjBrowse.FormDestroy(Sender: TObject);
begin
  fDeltaForm.Free;
end;

procedure TXkZyCjBrowse.FormShow(Sender: TObject);
begin
  GetYxList;
end;

procedure TXkZyCjBrowse.GetSfList;
begin
end;

function TXkZyCjBrowse.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text);
  if cbb_Zy.ItemIndex<>0 then
    sWhere := sWhere+' and 专业='+quotedstr(cbb_Zy.Text);
  Result := sWhere;
end;

procedure TXkZyCjBrowse.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select distinct 专业 from 校考专业表 where 承考院系='+quotedstr(cbb_Yx.Text),True);
    cbb_Zy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('专业').AsString);
      cds_Temp.Next;
    end;
    cbb_Zy.Text := '';
    cbb_Zy.Items.Add('不限专业');
    cbb_Zy.Items.AddStrings(sList);
    cbb_Zy.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkZyCjBrowse.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    //if gb_Czy_Level<>'2' then
    begin
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
    end;// else
    //  sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkZyCjBrowse.Open_Table;
var
  sqlstr:string;
begin
  ClientDataSet1.DisableControls;
  try
    sqlstr := 'select * from View_校考专业成绩表 '+GetWhere+' order by Id';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr,True);
    if Self.Showing then
      DBGridEh1.SetFocus;
  finally
    ClientDataSet1.EnableControls;
  end;
end;

end.
