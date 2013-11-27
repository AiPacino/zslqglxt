unit uUserLoginLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBFieldComboBox, Buttons, DB, DBClient, ExtCtrls, GridsEh,
  DBGridEh, Menus, ComCtrls, StatusBarEx, pngimage, DBGridEhGrouping;

type
  TUserLoginLog = class(TForm)
    Panel1: TPanel;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    btn_Exit: TBitBtn;
    Edit1: TEdit;
    btn_Filter: TBitBtn;
    cbb_Field: TDBFieldComboBox;
    ClientDataSet1Field: TIntegerField;
    btn_Export: TBitBtn;
    btn_Delete: TBitBtn;
    ClientDataSet1ID: TAutoIncField;
    ClientDataSet1WideStringField: TWideStringField;
    ClientDataSet1DateTimeField: TDateTimeField;
    ClientDataSet1IP: TWideStringField;
    ClientDataSet1DateTimeField2: TDateTimeField;
    ClientDataSet1IP2: TWideStringField;
    ClientDataSet1SrvHost: TWideStringField;
    ClientDataSet1WideStringField2: TWideStringField;
    ClientDataSet1BooleanField: TBooleanField;
    DBGridEh1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    mi_Refresh: TMenuItem;
    N4: TMenuItem;
    mi_Export: TMenuItem;
    mi_Delete: TMenuItem;
    btn_Print: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    N1: TMenuItem;
    C1: TMenuItem;
    P1: TMenuItem;
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
    procedure btn_CzLogClick(Sender: TObject);
    procedure DBGridEh1DrawDataCell(Sender: TObject; const Rect: TRect;
      Field: TField; State: TGridDrawState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
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
uses uDM,DBGridEhImpExp,uSysLog, uVobj;
{$R *.dfm}

procedure TUserLoginLog.btn_CzLogClick(Sender: TObject);
begin
  TSysLog.Create(nil).ShowModal;
end;

procedure TUserLoginLog.btn_DeleteClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要清空所有的操作日志吗？　　', '系统提示', MB_YESNO
    + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    dm.ReleaseLoginLog(gb_Czy_ID);
    //DM.ExecSql('delete from 操作日志表');
    OpenTable('');
  end;
end;

procedure TUserLoginLog.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TUserLoginLog.btn_ExportClick(Sender: TObject);
begin
  DM.SaveDialog1.FileName := '操作员登录日志('+FormatDateTime('yyyy-mm-dd',Now)+').xls';
  if DM.Savedialog1.Execute then
  begin
    //DataSetExportExcel.ExportExcelFile(SaveDialog1.FileName,True,dxDBGrid1);
    SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,DBGridEh1,dm.SaveDialog1.FileName,True);
  end;
end;

procedure TUserLoginLog.btn_FilterClick(Sender: TObject);
var
  sSqlstr:string;
begin
  if Edit1.Text<>'' then
    sSqlstr := ' and '+cbb_Field.Text+' like '+quotedstr(edit1.Text+'%')
  else
    sSqlstr := '';
  OpenTable(sSqlstr);
end;

procedure TUserLoginLog.btn_PrintClick(Sender: TObject);
begin
  dm.PrintReport('操作员登录日志.fr3',ClientDataSet1.XMLData,1);
end;

procedure TUserLoginLog.ClientDataSet1CalcFields(DataSet: TDataSet);
begin
  if DataSet.RecordCount>0 then
    DataSet.FieldByName('编号').AsInteger := DataSet.RecNo;
end;

procedure TUserLoginLog.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  StatusBarEx1.Panels[1].Text := IntToStr(ClientDataSet1.RecNo)+'/'+IntToStr(ClientDataSet1.RecordCount);
end;

procedure TUserLoginLog.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if gdSelected in State then
    Exit;
  with DBGridEh1.Canvas do
    if ClientDataSet1.Fieldbyname('是否在线').AsBoolean then
    begin
      //Brush.Color := clRed;
      Font.Color := clBlue;
      Font.Style := Font.Style+[fsBold];
    end;
  DBGridEh1.DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);
end;

procedure TUserLoginLog.DBGridEh1DrawDataCell(Sender: TObject;
  const Rect: TRect; Field: TField; State: TGridDrawState);
begin
{
  if Field.DataSet.Fieldbyname('是否在线').AsBoolean then
    DBGridEh1.Canvas.Brush.Color := ClRed
  else
    DBGridEh1.Canvas.Brush.Color := clWindow;
  DBGridEh1.Canvas.FillRect(Rect);
  DBGridEh1.Canvas.TextOut(Rect.Left+2,Rect.Top+2,Field.AsString);
}
end;

procedure TUserLoginLog.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Filter.Click;
end;

procedure TUserLoginLog.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TUserLoginLog.FormCreate(Sender: TObject);
begin
  btn_Delete.Enabled := gb_Czy_Level='-1';
  mi_Delete.Enabled := btn_Delete.Enabled;
  OpenTable('');
end;

procedure TUserLoginLog.mi_RefreshClick(Sender: TObject);
begin
  btn_Filter.Click;
end;

procedure TUserLoginLog.OpenTable(const sWhere: string);
var
  sqlstr:string;
begin
  if gb_Czy_Level='-1' then
    sqlstr := ' where 1>0 '
  else
    sqlstr := ' where 操作员编号='+quotedstr(gb_Czy_ID);
  sqlstr := 'select * from 操作员登录表 '+sqlstr+sWhere+' order by 登录时间 desc';
  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
end;

end.
