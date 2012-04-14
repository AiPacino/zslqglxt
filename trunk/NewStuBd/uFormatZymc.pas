unit uFormatZymc;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, CheckLst, DB, ADODB, Grids, DBGrids,
  Menus, DBClient, StrUtils, DBGridEhGrouping, GridsEh, DBGridEh;

type
  TFormatZymc = class(TForm)
    ds_Sql: TDataSource;
    cds_Sql: TClientDataSet;
    pm1: TPopupMenu;
    mmi_replace: TMenuItem;
    mmi_Del: TMenuItem;
    grp1: TGroupBox;
    dbgrd1: TDBGridEh;
    Panel1: TPanel;
    btn_Rep: TBitBtn;
    btn_All: TBitBtn;
    btn_Cancel: TBitBtn;
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure btn_AllClick(Sender: TObject);
    procedure mmi_replaceClick(Sender: TObject);
    procedure mmi_DelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function Format_zymc:Integer;
    procedure btn_RepClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    aDataSet:TClientDataSet;
  public
    { Public declarations }
  end;

var
  FormatZymc: TFormatZymc;

implementation

uses uMareData_BDE, uDM;

{$R *.dfm}

procedure TFormatZymc.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormatZymc.btn_OKClick(Sender: TObject);
var
  iCount:integer;
begin
  if MessageBox(Handle, '真的要开始替换吗？　　　　', '替换确认', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO    then
    Exit;

  iCount := Format_Zymc;
  MessageBox(Handle, PChar('替换操作完成！共有'+inttostr(iCount)+'处字符被替换！　　'), '替换完成', MB_OK + MB_ICONINFORMATION);
end;

procedure TFormatZymc.btn_AllClick(Sender: TObject);
var
  ii:Integer;
begin
  if MessageBox(Handle, '真的要开始执行所有的自定义替换项目吗？　', '替换确认', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO    then
    Exit;

  cds_Sql.First;
  ii := 0;
  while not cds_Sql.Eof do
  begin
    ii := ii+ Format_Zymc;
    cds_Sql.Next;
  end;
  MessageBox(Handle, PChar('替换操作完成！共有'+inttostr(ii)+'处字符被替换！　　'), '替换完成', MB_OK + MB_ICONINFORMATION);
end;

procedure TFormatZymc.mmi_replaceClick(Sender: TObject);
var
  iCount :Integer;
  s,d:string;
begin
  if MessageBox(Handle, '真的要执行当前替换操作吗？　　　　', '替换确认', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO    then
    Exit;

  if cds_Sql.Recordcount=0 then
     exit;
  s := cds_Sql.Fieldbyname('原字符串').Asstring;
  d := cds_Sql.Fieldbyname('新字符串').Asstring;
  iCount := Format_Zymc;
  MessageBox(Handle, PChar('替换操作完成！共有'+inttostr(iCount)+'处字符被替换！　　'), '替换完成', MB_OK + MB_ICONINFORMATION);
end;

procedure TFormatZymc.mmi_DelClick(Sender: TObject);
begin
  btn_All.Click;
end;

procedure TFormatZymc.FormShow(Sender: TObject);
begin
  cds_Sql.XMLData := dm.OpenData('select * from 专业格式化SQL配置表');
end;

function TFormatZymc.Format_Zymc: Integer;
var
  iCount :Integer;
begin
  try
    Screen.Cursor := crHourGlass;
    dm.ExecSql(cds_Sql.FieldByName('SqlText').AsString);
    Result := iCount;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFormatZymc.btn_RepClick(Sender: TObject);
begin
  mmi_replace.Click;
end;

procedure TFormatZymc.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  Action := caFree;
end;

end.
