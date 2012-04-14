unit uSysLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBFieldComboBox, Buttons, DB, DBClient, ExtCtrls, GridsEh,
  DBGridEh, Menus, ComCtrls, StatusBarEx, pngimage, DBGridEhGrouping;

type
  TSysLog = class(TForm)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    btn_Exit: TBitBtn;
    Edit1: TEdit;
    btn_Filter: TBitBtn;
    PopupMenu1: TPopupMenu;
    mi_Export: TMenuItem;
    mi_Delete: TMenuItem;
    cbb_Field: TDBFieldComboBox;
    ClientDataSet1Field: TIntegerField;
    mi_Refresh: TMenuItem;
    N4: TMenuItem;
    ClientDataSet1ID: TAutoIncField;
    ClientDataSet1WideStringField: TWideStringField;
    ClientDataSet1WideStringField2: TWideStringField;
    ClientDataSet1ActionTime: TDateTimeField;
    ClientDataSet1IP: TWideStringField;
    btn_Export: TBitBtn;
    btn_Delete: TBitBtn;
    btn_Print: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    C1: TMenuItem;
    P1: TMenuItem;
    N1: TMenuItem;
    StatusBarEx1: TStatusBarEx;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_FilterClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure ClientDataSet1CalcFields(DataSet: TDataSet);
    procedure btn_ExportClick(Sender: TObject);
    procedure mi_RefreshClick(Sender: TObject);
    procedure btn_PrintClick(Sender: TObject);
  private
    { Private declarations }
    procedure OpenTable(const sWhere:string);
  public
    { Public declarations }
  end;

//var
//  SysLog: TSysLog;

implementation
uses uDM,DBGridEhImpExp;
{$R *.dfm}

procedure TSysLog.btn_DeleteClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要清空所有的操作日志吗？　　', '系统提示', MB_YESNO
    + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    vobj.ReleaseLog(gb_Czy_ID);
    //DM.ExecSql('delete from 操作日志表');
    OpenTable('');
  end;
end;

procedure TSysLog.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TSysLog.btn_ExportClick(Sender: TObject);
begin
  DM.SaveDialog1.FileName := '操作日志('+FormatDateTime('yyyy-mm-dd',Now)+').xls';
  if DM.Savedialog1.Execute then
  begin
    //DataSetExportExcel.ExportExcelFile(SaveDialog1.FileName,True,dxDBGrid1);
    SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,DBGridEh1,dm.SaveDialog1.FileName,True);
  end;
end;

procedure TSysLog.btn_FilterClick(Sender: TObject);
var
  sSqlstr:string;
begin
  if Edit1.Text<>'' then
    sSqlstr := ' and '+cbb_Field.Text+' like '+quotedstr(edit1.Text+'%')
  else
    sSqlstr := '';
  OpenTable(sSqlstr);
end;

procedure TSysLog.btn_PrintClick(Sender: TObject);
begin
  dm.PrintReport('操作员操作日志.fr3',ClientDataSet1.XMLData,1);
end;

procedure TSysLog.ClientDataSet1CalcFields(DataSet: TDataSet);
begin
  if DataSet.RecordCount>0 then
    DataSet.FieldByName('编号').AsInteger := DataSet.RecNo;
end;

procedure TSysLog.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  StatusBarEx1.Panels[1].Text := IntToStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount);
end;

procedure TSysLog.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Filter.Click;
end;

procedure TSysLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TSysLog.FormCreate(Sender: TObject);
begin
  //btn_Delete.Enabled := gb_Czy_Level='-1';
  mi_Delete.Enabled := gb_Czy_Level='-1';
  OpenTable('');
end;

procedure TSysLog.mi_RefreshClick(Sender: TObject);
begin
  btn_Filter.Click;
end;

procedure TSysLog.OpenTable(const sWhere: string);
var
  sqlstr:string;
begin
  if gb_Czy_Level='-1' then
    sqlstr := ' where 1>0 '
  else
    sqlstr := ' where 用户='+quotedstr(gb_Czy_ID);
  sqlstr := 'select * from 操作日志表 '+sqlstr+sWhere+' order by ActionTime desc';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
