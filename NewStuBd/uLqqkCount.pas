unit uLqqkCount;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, CheckLst, Buttons, ExtCtrls, DB, StrUtils,
  DBClient, GridsEh, DBGridEh, RzPanel, RzRadGrp, Menus, DBGridEhImpExp,
  DBGridEhGrouping;

type
  TLqqkCount = class(TForm)
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
    mni_L1: TMenuItem;
    N1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N2: TMenuItem;
    mni__Export: TMenuItem;
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

implementation
uses uDM;
{$R *.dfm}

procedure TLqqkCount.btn_ExcelClick(Sender: TObject);
begin
  dm.ExportDBEditEH(DBGridEH1);
end;

procedure TLqqkCount.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TLqqkCount.btn_PrintClick(Sender: TObject);
begin
  PrintDBGridEH(DBGridEH1,Self,RzRadioGroup1.Items[RzRadioGroup1.ItemIndex]);
end;

procedure TLqqkCount.btn_RefreshBdlClick(Sender: TObject);
begin
  mi_RefreshBdl.Click;
end;

procedure TLqqkCount.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TLqqkCount.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TLqqkCount.FormCreate(Sender: TObject);
begin
  sqlList := TStringList.Create;
  RzRadioGroup1.Items.Clear;
  Open_Table;
end;

procedure TLqqkCount.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sqlList);
end;

procedure TLqqkCount.FormShow(Sender: TObject);
begin
  if RzRadioGroup1.Items.Count>0 then
    RzRadioGroup1.ItemIndex := 0;
end;

procedure TLqqkCount.mi_RefreshBdlClick(Sender: TObject);
begin
  RzRadioGroup1.OnClick(Self);
end;

procedure TLqqkCount.Open_Table;
var
  cds_Temp:TClientDataSet;
var
  sqlstr :string;
begin
  sqlstr := 'select * from 统计项目表 where 模块='+quotedstr('录取')+' order by 编号';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData(sqlstr);
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

procedure TLqqkCount.RzRadioGroup1Click(Sender: TObject);
var
  i: Integer;
  sqlstr:string;
begin
  i := RzRadioGroup1.ItemIndex;
  if i = -1 then Exit;
  Caption := RzRadioGroup1.Items[i];
  try
    sqlstr := LowerCase(sqlList.Strings[i]);

    ClientDataSet1.XMLData := dm.OpenData(sqlstr);
    SetDBGridEHColumnWidth(DBGridEH1);
  except
    on e:Exception do
      MessageBox(Handle, PChar('SQL统计命令执行失败！请检查后重试！失败原因如下：　' +
        #13#10 + e.Message), '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
  end;
end;

end.
