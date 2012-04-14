unit uXkKmCjBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, Pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping;

type
  TXkKmCjBrowse = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    cbb_Field: TDBFieldComboBox;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    lbl_Len: TLabel;
    grp2: TGroupBox;
    cbb_Km: TDBComboBoxEh;
    DBGridEh1: TDBGridEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ValueChange(Sender: TObject);
    procedure cbb_KmChange(Sender: TObject);
  private
    { Private declarations }
    fCjIndex:Integer;
    fYx,fSf,fKm,fCjField,fCzyField:string;
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetYxList;
    procedure GetXkZyList;
    procedure GetXkKmList;
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string);
  end;

var
  XkKmCjBrowse: TXkKmCjBrowse;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKmCjBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmCjBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmCjBrowse.btn_SearchClick(Sender: TObject);
begin
  if Trim(edt_Value.Text)='' then Exit;
  if ClientDataSet1.Locate(cbb_Field.Text,edt_Value.Text,[]) then
  begin
    DBGridEh1.SetFocus;
    DBGridEh1.SelectedIndex := 13;
  end else
    MessageBox(Handle, PChar('未找到'+cbb_field.Text+'为【'+edt_Value.Text+'】'+'的考生！　　' + #13#10 + '请检查后重新查询！'),
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);

end;

procedure TXkKmCjBrowse.cbb_KmChange(Sender: TObject);
begin
  if cbb_Km.Text='' then Exit;
  if Self.Showing then
    Open_Table;
end;

procedure TXkKmCjBrowse.cbb_YxChange(Sender: TObject);
begin
  if cbb_Yx.Text='' then Exit;
  GetXkKmList;
end;

procedure TXkKmCjBrowse.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TXkKmCjBrowse.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TXkKmCjBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKmCjBrowse.FormShow(Sender: TObject);
begin
  GetYxList;
end;

procedure TXkKmCjBrowse.GetXkKmList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select distinct 考试科目 from 校考科目表 where 承考院系='+quotedstr(cbb_Yx.Text));
    cbb_Km.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('考试科目').AsString);
      cds_Temp.Next;
    end;
    //cbb_Km.Items.Add('不限科目');
    cbb_Km.Text := '';
    cbb_Km.Items.AddStrings(sList);
    cbb_Km.ItemIndex := 0;
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

function TXkKmCjBrowse.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text);
  sWhere := sWhere+' and 考试科目='+quotedstr(cbb_Km.Text);

  Result := sWhere;
end;

procedure TXkKmCjBrowse.GetXkZyList;
begin
end;

procedure TXkKmCjBrowse.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
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

procedure TXkKmCjBrowse.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from view_校考单科成绩表 '+GetWhere+' order by 考生号';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr,True);
  if Self.Showing then
    DBGridEh1.SetFocus;
end;

procedure TXkKmCjBrowse.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
  fYx := Yx;
  fSf := Sf;
  fKm := Km;
end;

end.
