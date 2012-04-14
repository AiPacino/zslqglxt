unit uJwInfoImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, DBCtrlsEh, CnButtonEdit,
  DB, ADODB, DBClient;

type
  TJwInfoImport = class(TForm)
    edt_File: TCnButtonEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbb_Ksh: TDBComboBoxEh;
    cbb_XH: TDBComboBoxEh;
    pb1: TProgressBar;
    pnl1: TPanel;
    btn_Start: TBitBtn;
    btn_Exit: TBitBtn;
    lbl_Hint: TLabel;
    con_Excel: TADOConnection;
    qry_Excel: TADOQuery;
    dlgOpen1: TOpenDialog;
    lbl4: TLabel;
    cbb_Sheet: TDBComboBoxEh;
    cds_lqmd: TClientDataSet;
    chk_OverWrite: TCheckBox;
    bvl1: TBevel;
    lbl5: TLabel;
    cbb_BJ: TDBComboBoxEh;
    procedure edt_FileButtonClick(Sender: TObject);
    procedure con_ExcelAfterConnect(Sender: TObject);
    procedure cbb_SheetChange(Sender: TObject);
    procedure qry_ExcelAfterOpen(DataSet: TDataSet);
    procedure btn_StartClick(Sender: TObject);
    procedure cbb_KshChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TJwInfoImport.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TJwInfoImport.btn_StartClick(Sender: TObject);
var
  ksh,xh,bj:string;
  bl:Boolean;
begin
  if MessageBox(Handle, '真的要导入学号和班级等教务信息吗？　', '系统提示', MB_YESNO +
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  cds_lqmd.XMLData := dm.openData('select 考生号,学号,班级 from 录取信息表');
  btn_Start.Enabled := False;
  try
    qry_Excel.First;
    pb1.Max := qry_Excel.RecordCount;
    while not qry_Excel.Eof do
    begin
      pb1.Position := qry_Excel.RecNo;
      lbl_Hint.Caption := '处理过程：'+InttoStr(qry_Excel.RecNo)+'/'+IntToStr(qry_Excel.RecordCount);
      Application.ProcessMessages;
      ksh := qry_Excel.FieldByName(cbb_Ksh.Text).AsString;
      xh := qry_Excel.FieldByName(cbb_XH.Text).AsString;
      bj := qry_Excel.FieldByName(cbb_BJ.Text).AsString;
      if cds_lqmd.Locate('考生号',ksh,[]) then
      begin
        if (cds_lqmd.FieldByName('学号').AsString='') or
           (cds_lqmd.FieldByName('学号').AsString<>'') and (chk_OverWrite.Checked) then
        begin
          cds_lqmd.Edit;
          cds_lqmd.FieldByName('学号').AsString := xh;
          if bj<>'' then
            cds_lqmd.FieldByName('班级').AsString := bj;
          cds_lqmd.Post;
        end;
      end;
      qry_Excel.Next;
    end;
    pb1.Position := pb1.Max;
    Application.ProcessMessages;
    bl := True;
    if cds_lqmd.ChangeCount>0 then
      bl := dm.UpdateData('考生号','select 考生号,学号,班级 from 录取信息表',cds_lqmd.Delta);

    if bl then
      MessageBox(Handle, '操作完成！教务信息导入成功！　', '系统提示',
        MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST)
    else
      MessageBox(Handle, '教务信息导入失败！请检查后重试！　', '系统提示',
        MB_OK + MB_ICONSTOP + MB_TOPMOST);
  finally
    cds_lqmd.Close;
    btn_Start.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TJwInfoImport.cbb_KshChange(Sender: TObject);
begin
  btn_Start.Enabled := TDBComboBoxEh(Sender).Text <> '';
end;

procedure TJwInfoImport.cbb_SheetChange(Sender: TObject);
begin
  qry_Excel.Close;
  qry_Excel.SQL.Text := 'select * from ['+cbb_Sheet.Text+']';
  qry_Excel.Open;
end;

procedure TJwInfoImport.con_ExcelAfterConnect(Sender: TObject);
begin
  cbb_Sheet.Enabled := con_Excel.Connected;
  con_Excel.GetTableNames(cbb_Sheet.Items);
  cbb_Sheet.ItemIndex := 0;
end;

procedure TJwInfoImport.edt_FileButtonClick(Sender: TObject);
var
  fn:string;
begin
  if dlgOpen1.Execute then
  begin
    edt_File.Text := dlgOpen1.FileName;
    fn := edt_File.Text;
    con_Excel.Close;
    con_Excel.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+fn+';Extended Properties=Excel 8.0;Persist Security Info=False';
    con_Excel.Open;
  end;
end;

procedure TJwInfoImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qry_Excel.Close;
  con_Excel.Close;
  Action := caFree;
end;

procedure TJwInfoImport.qry_ExcelAfterOpen(DataSet: TDataSet);
begin
  cbb_Ksh.Enabled := True;
  cbb_XH.Enabled := True;
  cbb_BJ.Enabled := True;
  qry_Excel.GetFieldNames(cbb_Ksh.Items);
  cbb_Ksh.ItemIndex := cbb_Ksh.Items.IndexOf('考生号');
  cbb_XH.Items.Assign(cbb_Ksh.Items);
  cbb_BJ.Items.Assign(cbb_Ksh.Items);
  cbb_XH.ItemIndex := cbb_XH.Items.IndexOf('学号');
  cbb_BJ.ItemIndex := cbb_XH.Items.IndexOf('班级');
end;

end.
