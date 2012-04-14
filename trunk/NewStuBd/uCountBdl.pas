unit uCountBdl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls, DB,
  DBClient, GridsEh, DBGridEh, RzPanel, RzRadGrp, Menus, DBGridEhImpExp,
  DBGridEhGrouping;

type
  TCountBdl = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Excel: TBitBtn;
    RzRadioGroup1: TRzRadioGroup;
    btn_Refresh: TBitBtn;
    GroupBox1: TGroupBox;
    DBGridEH1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    L1: TMenuItem;
    N1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N2: TMenuItem;
    mi_Export: TMenuItem;
    btn_RefreshBdl: TBitBtn;
    mi_RefreshBdl: TMenuItem;
    btn_Print: TBitBtn;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure RzRadioGroup1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ExcelClick(Sender: TObject);
    procedure mi_RefreshBdlClick(Sender: TObject);
    procedure btn_RefreshBdlClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
  private
    { Private declarations }
    sqlList:TStrings;
    procedure Open_Table;
  public
    { Public declarations }
  end;

var
  CountBdl: TCountBdl;

implementation
uses uDM;
{$R *.dfm}

procedure TCountBdl.btn_ExcelClick(Sender: TObject);
begin
  dm.ExportDBEditEH(DBGridEH1);
end;

procedure TCountBdl.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCountBdl.btn_PrintClick(Sender: TObject);
begin
  PrintDBGridEH(DBGridEH1,Self,RzRadioGroup1.Items[RzRadioGroup1.ItemIndex]);
end;

procedure TCountBdl.btn_RefreshBdlClick(Sender: TObject);
begin
  mi_RefreshBdl.Click;
end;

procedure TCountBdl.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TCountBdl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCountBdl.FormCreate(Sender: TObject);
begin
  if gb_Czy_Level='2' then
    Caption := '【'+gb_Czy_Dept+'】'+'新生报到率统计';
  sqlList := TStringList.Create;
  RzRadioGroup1.Items.Clear;
  Open_Table;
end;

procedure TCountBdl.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sqlList);
end;

procedure TCountBdl.FormShow(Sender: TObject);
begin
  if RzRadioGroup1.Items.Count>0 then
    RzRadioGroup1.ItemIndex := 0;
end;

procedure TCountBdl.mi_RefreshBdlClick(Sender: TObject);
begin
  RzRadioGroup1.OnClick(Self);
end;

procedure TCountBdl.Open_Table;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select * from 统计项目表 where 模块='+quotedstr('报到')+' order by 编号');
    RzRadioGroup1.Items.Clear;
    sqlList.Clear;
    while not cds_Temp.Eof do
    begin
      RzRadioGroup1.Items.Add(cds_Temp.FieldByName('说明').AsString);
      sqlList.Add(cds_Temp.FieldByName('sqlText').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TCountBdl.RzRadioGroup1Click(Sender: TObject);
var
  i,ii,iTotal,iBaoDao: Integer;
  sqlstr:string;
begin
  i := RzRadioGroup1.ItemIndex;
  if i = -1 then Exit;
  if gb_Czy_Level='2' then
    Caption := '【'+gb_Czy_Dept+'】'+RzRadioGroup1.Items[i]
  else
    Caption := RzRadioGroup1.Items[i];
  try
    sqlstr := LowerCase(sqlList.Strings[i]);
    if gb_Czy_Level='2' then
    begin
      ii := Pos(' group ',sqlstr);
      if ii>0 then
        sqlstr := Copy(sqlstr,1,ii)+' and 院系='+quotedstr(gb_Czy_Dept)+
                  Copy(sqlstr,ii,Length(sqlstr));
    end;
    ClientDataSet1.XMLData := dm.OpenData(sqlstr);
    SetDBGridEHColumnWidth(DBGridEH1);
  except
    on e:Exception do
      MessageBox(Handle, PChar('SQL统计命令执行失败！请检查后重试！失败原因如下：　' +
        #13#10 + e.Message), '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
  end;
end;

end.
