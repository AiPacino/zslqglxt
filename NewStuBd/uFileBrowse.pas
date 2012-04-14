unit uFileBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, DB, DBClient, StdCtrls, Mask, DBCtrlsEh, GridsEh,
  DBGridEh, ComCtrls, Buttons, ExtCtrls, DBCtrls;

type
  TFileBrowse = class(TForm)
    pnl1: TPanel;
    btn_Exit: TBitBtn;
    btn_SaveAs: TBitBtn;
    grp3: TGroupBox;
    pnl2: TPanel;
    grp2: TGroupBox;
    DBGridEh1: TDBGridEh;
    pnl3: TPanel;
    DBEditEh1: TDBEditEh;
    lbl1: TLabel;
    DBEditEh2: TDBEditEh;
    Label1: TLabel;
    btn_Open: TBitBtn;
    lbl2: TLabel;
    ClientDataSet1: TClientDataSet;
    DataSource1: TDataSource;
    btn_Save: TBitBtn;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    DBRichEdit1: TDBRichEdit;
    dlgSave1: TSaveDialog;
    dlgOpen1: TOpenDialog;
    procedure btn_AddClick(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure btn_OpenClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_SaveAsClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TFileBrowse.btn_SaveAsClick(Sender: TObject);
begin
  dlgSave1.FileName := DBEditEh2.Text;
  if dlgSave1.Execute then
  begin
    TBlobField(ClientDataSet1.FieldByName('文件内容')).SaveToFile(dlgSave1.FileName);
  end;
end;

procedure TFileBrowse.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select top 0 * from 录取规范文件表',ClientDataSet1.Delta,True) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TFileBrowse.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
end;

procedure TFileBrowse.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TFileBrowse.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前文件吗？　', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  ClientDataSet1.Delete;
end;

procedure TFileBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TFileBrowse.btn_OpenClick(Sender: TObject);
begin
  if dlgOpen1.Execute then
  begin
    ClientDataSet1.Edit;
    if DBEditEh1.Text='' then
      DBEditEh1.Text := '请输入文件标题';
    DBEditEh2.Text := ExtractFileName(dlgOpen1.FileName);
    TBlobField(ClientDataSet1.FieldByName('文件内容')).LoadFromFile(dlgOpen1.FileName);
  end;
end;

procedure TFileBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFileBrowse.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if DataSetNoSave(ClientDataSet1) then
    if MessageBox(Handle, '文件已修改但尚未保存，要保存当前的修改吗？　',
      '系统提示', MB_YESNO + MB_ICONQUESTION + MB_TOPMOST) = IDYES then
    begin
      btn_Save.Click;
    end;

end;

procedure TFileBrowse.FormCreate(Sender: TObject);
begin
  ClientDataSet1.XMLData := dm.OpenData('select * from 录取规范文件表');
end;

end.
