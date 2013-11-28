unit uXkPwWorkSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TXkPwWorkSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Save: TBitBtn;
    btn_Refresh: TBitBtn;
    ds_Delta: TDataSource;
    cds_Delta: TClientDataSet;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    DBGridEh2: TDBGridEh;
    cds_Master: TClientDataSet;
    ds_Master: TDataSource;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    DBGridEh3: TDBGridEh;
    Splitter1: TSplitter;
    ds_Zy: TDataSource;
    cds_Zy: TClientDataSet;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure DBGridEh3CellClick(Column: TColumnEh);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable;
    procedure GetXkZyList;
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkPwWorkSet: TXkPwWorkSet;

implementation
uses uDM,uSelectZyKmPw;
{$R *.dfm}

procedure TXkPwWorkSet.btn_AddClick(Sender: TObject);
var
  yx,sf,kd,zy,km:string;
begin
  yx := cds_Master.FieldByName('承考院系').AsString;
  sf := cds_Master.FieldByName('省份').AsString;
  kd := cds_Master.FieldByName('考点名称').AsString;
  zy := cds_zy.FieldByName('专业').AsString;
  km := cds_zy.FieldByName('考试科目').AsString;
  with TSelectZyKmPw.Create(nil) do
  begin
    SetParam(yx,sf,kd,zy,km);
    ShowModal;
  end;
end;

procedure TXkPwWorkSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkPwWorkSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkPwWorkSet.cbb_YxChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkPwWorkSet.DBGridEh2CellClick(Column: TColumnEh);
begin
  Open_DeltaTable;
end;

procedure TXkPwWorkSet.DBGridEh3CellClick(Column: TColumnEh);
begin
  Open_DeltaTable;
end;

procedure TXkPwWorkSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkPwWorkSet.FormCreate(Sender: TObject);
begin
  GetYxList;
  Open_Table;
  //GetXkZyList;
  Open_DeltaTable;
end;

function TXkPwWorkSet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  Result := sWhere;
end;

procedure TXkPwWorkSet.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select 考试科目 from 校考科目表 '+GetWhere);
    DBGridEh1.Columns[3].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('考试科目').AsString);
      cds_Temp.Next;
    end;
    DBGridEh1.Columns[3].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkPwWorkSet.GetYxList;
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
      //sList.Add('不限院系');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkPwWorkSet.Open_DeltaTable;
var
  sWhere:string;
  sqlstr:string;
  yx,sf,kd,zy,km:string;
begin
  yx := cds_Master.FieldByName('承考院系').AsString;
  sf := cds_Master.FieldByName('省份').AsString;
  kd := cds_Master.FieldByName('考点名称').AsString;
  zy := cds_zy.FieldByName('专业').AsString;
  km := cds_zy.FieldByName('考试科目').AsString;

  sWhere := ' where 承考院系='+quotedstr(yx)+' and 省份='+quotedstr(sf)+' and 考点名称='+quotedstr(kd)+
            ' and 专业='+quotedstr(zy)+' and 科目='+quotedstr(km);
  sqlstr := 'select * from 校考考点评委表 '+sWhere+' order by Id';
  cds_Delta.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkPwWorkSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select 省份,考点名称,承考院系 from 校考考点设置表 '+GetWhere+' order by Id';
  cds_Master.XMLData := DM.OpenData(sqlstr);

  sqlstr := 'select 承考院系,专业,考试科目 from 校考专业科目表 '+GetWhere+' order by 专业,考试科目';
  cds_Zy.XMLData := DM.OpenData(sqlstr);
  //GetXkZyList;
end;

end.
