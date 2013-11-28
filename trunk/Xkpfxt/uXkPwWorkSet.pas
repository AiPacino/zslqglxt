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
  yx := cds_Master.FieldByName('�п�Ժϵ').AsString;
  sf := cds_Master.FieldByName('ʡ��').AsString;
  kd := cds_Master.FieldByName('��������').AsString;
  zy := cds_zy.FieldByName('רҵ').AsString;
  km := cds_zy.FieldByName('���Կ�Ŀ').AsString;
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
    sWhere := ' where �п�Ժϵ='+quotedstr(cbb_Yx.Text)
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
      //cbb_Yx.Items.Add('����Ժϵ');
      sList.Add('�������ѧԺ');
      sList.Add('����ѧԺ');
      //sList.Add('����Ժϵ');
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
  yx := cds_Master.FieldByName('�п�Ժϵ').AsString;
  sf := cds_Master.FieldByName('ʡ��').AsString;
  kd := cds_Master.FieldByName('��������').AsString;
  zy := cds_zy.FieldByName('רҵ').AsString;
  km := cds_zy.FieldByName('���Կ�Ŀ').AsString;

  sWhere := ' where �п�Ժϵ='+quotedstr(yx)+' and ʡ��='+quotedstr(sf)+' and ��������='+quotedstr(kd)+
            ' and רҵ='+quotedstr(zy)+' and ��Ŀ='+quotedstr(km);
  sqlstr := 'select * from У��������ί�� '+sWhere+' order by Id';
  cds_Delta.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkPwWorkSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select ʡ��,��������,�п�Ժϵ from У���������ñ� '+GetWhere+' order by Id';
  cds_Master.XMLData := DM.OpenData(sqlstr);

  sqlstr := 'select �п�Ժϵ,רҵ,���Կ�Ŀ from У��רҵ��Ŀ�� '+GetWhere+' order by רҵ,���Կ�Ŀ';
  cds_Zy.XMLData := DM.OpenData(sqlstr);
  //GetXkZyList;
end;

end.
