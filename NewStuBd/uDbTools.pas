unit uDbTools;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEhGrouping, RzShellDialogs, GridsEh, DBGridEh, StdCtrls,
  Buttons, Mask, DBCtrlsEh, CnButtonEdit, ExtCtrls, DB, DBTables, ADODB, Menus;

type
  TDbTools = class(TForm)
    grp1: TGroupBox;
    pnl1: TPanel;
    edt_File: TCnButtonEdit;
    cbb_DbType: TDBComboBoxEh;
    btn_Open: TBitBtn;
    DBGridEh1: TDBGridEh;
    dlgOpen_1: TOpenDialog;
    Con_BDE: TDatabase;
    qry_BDE: TQuery;
    qry_Temp: TQuery;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    lbl_Rec: TLabel;
    pnl_SqlEdit: TPanel;
    mmo_Sql: TMemo;
    btn_ExecSql: TBitBtn;
    chk_ShowSqlEdit: TCheckBox;
    cbb_TbName: TDBComboBoxEh;
    qry_Access: TADOQuery;
    Con_Access: TADOConnection;
    chk_Filter: TCheckBox;
    spl1: TSplitter;
    chk_Edit: TCheckBox;
    btn_OpenSql: TBitBtn;
    pm1: TPopupMenu;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure btn_OpenClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure qry_BDEAfterOpen(DataSet: TDataSet);
    procedure btn_ExecSqlClick(Sender: TObject);
    procedure chk_ShowSqlEditClick(Sender: TObject);
    procedure cbb_TbNameChange(Sender: TObject);
    procedure edt_FileButtonClick(Sender: TObject);
    procedure qry_AccessAfterOpen(DataSet: TDataSet);
    procedure chk_FilterClick(Sender: TObject);
    procedure chk_EditClick(Sender: TObject);
    procedure btn_OpenSqlClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
    function Init_Con_BDE(const sDir:string):Boolean;
    function Init_Con_Access(const sMdbfn:string):Boolean;
    procedure SetDbGridEH;
  public
    { Public declarations }
  end;

var
  DbTools: TDbTools;

implementation
uses uDM;
{$R *.dfm}

procedure TDbTools.btn_ExecSqlClick(Sender: TObject);
var
  sqlstr:string;
  i:integer;
begin
  //Init_Con_BDE(ExtractFileDir(edt_File.Text));
  if MessageBox(Handle, 
    '命令执行后其结果是无法逆转的！还要执行此Sql命令吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  if UpperCase(InputBox('操作确认','请输入【OK】字符以便确认！',''))<>'OK' then Exit;
  sqlstr := '';
  for i := 0 to mmo_Sql.Lines.Count - 1 do
    sqlstr := sqlstr+mmo_Sql.Lines[i];
  if (cbb_DbType.ItemIndex=0) or (cbb_DbType.ItemIndex=1) then
  begin
    DataSource1.DataSet := qry_BDE;
    qry_BDE.Close;
    qry_BDE.SQL.Text := sqlstr;
    qry_BDE.ExecSQL;
  end else
  begin
    DataSource1.DataSet := qry_Access;
    qry_Access.Close;
    qry_Access.SQL.Text := sqlstr;
    qry_Access.ExecSQL;
  end;
end;

procedure TDbTools.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TDbTools.btn_OpenClick(Sender: TObject);
begin
  mmo_Sql.Text := 'select * from '+cbb_TbName.Text;
  btn_OpenSqlClick(Self);
  if DBGridEh1.CanFocus then
    DBGridEh1.SetFocus;
end;

procedure TDbTools.btn_OpenSqlClick(Sender: TObject);
var
  sqlstr:string;
  i:integer;
begin
  //Init_Con_BDE(ExtractFileDir(edt_File.Text));
  sqlstr := '';
  for i := 0 to mmo_Sql.Lines.Count - 1 do
    sqlstr := sqlstr+mmo_Sql.Lines[i];
  if (cbb_DbType.ItemIndex=0) or (cbb_DbType.ItemIndex=1) then
  begin
    DataSource1.DataSet := qry_BDE;
    qry_BDE.Close;
    qry_BDE.SQL.Text := sqlstr;
    qry_BDE.Open;
  end else
  begin
    DataSource1.DataSet := qry_Access;
    qry_Access.Close;
    qry_Access.SQL.Text := sqlstr;
    qry_Access.Open;
  end;

end;

procedure TDbTools.cbb_TbNameChange(Sender: TObject);
begin
  btn_Open.Enabled := cbb_TbName.Text<>'';
end;

procedure TDbTools.chk_EditClick(Sender: TObject);
begin
  DBGridEh1.ReadOnly := not chk_Edit.Checked;
end;

procedure TDbTools.chk_FilterClick(Sender: TObject);
begin
  DBGridEH1.STFilter.Visible := chk_Filter.Checked;
end;

procedure TDbTools.chk_ShowSqlEditClick(Sender: TObject);
begin
  pnl_SqlEdit.Visible := TCheckBox(Sender).Checked;
end;

procedure TDbTools.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  lbl_Rec.Caption := '记录号：'+IntToStr(DataSource1.DataSet.RecNo)+'/'+IntToStr(DataSource1.DataSet.RecordCount);
end;

procedure TDbTools.edt_FileButtonClick(Sender: TObject);
var
  sDir,Extfn,fn:string;
begin
  cbb_TbName.Text := '';
  if cbb_DbType.ItemIndex<>-1 then
  begin
    dlgOpen_1.FilterIndex := cbb_DbType.ItemIndex+1;
    Extfn := cbb_DbType.KeyItems[cbb_DbType.ItemIndex];
  end else
    Extfn := '*.DB';
  dlgOpen_1.DefaultExt := Extfn;
  if dlgOpen_1.Execute then
  begin
    edt_File.Text := dlgOpen_1.FileName;

    sDir := ExtractFileDir(edt_File.Text);
    fn := ExtractFileName(edt_File.Text);
    Extfn := LowerCase(ExtractFileExt(fn));
    cbb_TbName.Items.Clear;

    if (Extfn = '.db') or (Extfn = '.dbf') then
    begin
      if not Init_Con_BDE(sDir) then Exit;
      Con_BDE.GetTableNames(cbb_TbName.Items);
      //cbb_TbName.ItemIndex := 0;
      cbb_TbName.Text := Copy(fn,1,Length(fn)-Length(Extfn));
    end
    else if Extfn = '.mdb' then
    begin
      if not Init_Con_Access(sdir+'\'+fn) then Exit;
      Con_Access.GetTableNames(cbb_TbName.Items);
      cbb_TbName.ItemIndex := 0;
    end;
    cbb_TbName.Enabled := cbb_TbName.Items.Count>0;
    if cbb_TbName.Text<>'' then
      btn_OpenClick(Self);
  end;
end;

procedure TDbTools.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qry_BDE.Close;
  Con_BDE.CloseDataSets;
  Con_BDE.Close;
  Con_BDE.Connected := False;

  qry_Access.Close;
  Con_Access.Close;
  
  Action := caFree;
end;

function TDbTools.Init_Con_Access(const sMdbfn: string): Boolean;
begin
  Con_Access.Close;
  Con_Access.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+sMdbfn+';Persist Security Info=False';
  Con_Access.Open;
  Result := Con_Access.Connected;
end;

function TDbTools.Init_Con_BDE(const sDir: string): Boolean;
begin
  Con_BDE.CloseDataSets;
  Con_BDE.Close;
  Con_BDE.Connected := False;
  Con_BDE.LoginPrompt := False;
  Con_BDE.DatabaseName := 'MyBDE';
  Con_BDE.DriverName := 'STANDARD';
  Con_BDE.Params.Values['DEFAULT DRIVER'] := 'PARADOX';
  Con_BDE.Params.Values['PATH'] := sDir;
  con_BDE.Open;
  Result := Con_BDE.Connected;
end;

procedure TDbTools.N2Click(Sender: TObject);
begin
  mmo_Sql.SelectAll;
end;

procedure TDbTools.qry_AccessAfterOpen(DataSet: TDataSet);
begin
  SetDbGridEH;
end;

procedure TDbTools.qry_BDEAfterOpen(DataSet: TDataSet);
begin
  SetDbGridEH;
end;

procedure TDbTools.SetDbGridEH;
var
  i: Integer;
begin
  if not DBGridEh1.DataSource.DataSet.Active then Exit;
  for i := 0 to DBGridEh1.Columns.Count - 1 do
  begin
    DBGridEh1.Columns[i].Title.TitleButton := (LowerCase(ExtractFileExt(edt_File.Text))='.db') or
                                              (LowerCase(ExtractFileExt(edt_File.Text))='.dbf');
    DBGridEh1.Columns[i].Title.SortMarker := smNoneEh;
    if DBGridEh1.Columns[i].Width>100 then
       DBGridEh1.Columns[i].Width := 100;
    if DBGridEh1.Columns[i].Width<30 then
       DBGridEh1.Columns[i].Width := 30;
  end;
end;

end.
