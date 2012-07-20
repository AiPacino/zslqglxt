unit uEMSNumberImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Mask, DBCtrlsEh, CnButtonEdit,
  DB, ADODB, DBClient;

type
  TEMSNumberImport = class(TForm)
    edt_File: TCnButtonEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    cbb_Ksh: TDBComboBoxEh;
    cbb_EMSDH: TDBComboBoxEh;
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

procedure TEMSNumberImport.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TEMSNumberImport.btn_StartClick(Sender: TObject);
var
  ksh,dh:string;
  bl:Boolean;
begin
  if MessageBox(Handle, '���Ҫ����EMS�ʼĵ����𣿡�', 'ϵͳ��ʾ', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  cds_lqmd.XMLData := dm.openData('select ��ˮ��,EMS���� from ¼ȡ��Ϣ��');
  btn_Start.Enabled := False;
  try
    qry_Excel.First;
    pb1.Max := qry_Excel.RecordCount;
    while not qry_Excel.Eof do
    begin
      pb1.Position := qry_Excel.RecNo;
      lbl_Hint.Caption := '������̣�'+InttoStr(qry_Excel.RecNo)+'/'+IntToStr(qry_Excel.RecordCount);
      Application.ProcessMessages;
      ksh := qry_Excel.FieldByName(cbb_Ksh.Text).AsString;
      dh := qry_Excel.FieldByName(cbb_EMSDH.Text).AsString;
      if cds_lqmd.Locate('��ˮ��',ksh,[]) then
      begin
        if (cds_lqmd.FieldByName('EMS����').AsString='') or
           (cds_lqmd.FieldByName('EMS����').AsString<>'') and (chk_OverWrite.Checked) then
        begin
          cds_lqmd.Edit;
          cds_lqmd.FieldByName('EMS����').AsString := dh;
          cds_lqmd.Post;
        end;
      end;
      qry_Excel.Next;
    end;
    pb1.Position := pb1.Max;
    Application.ProcessMessages;
    bl := True;
    if cds_lqmd.ChangeCount>0 then
      bl := dm.UpdateData('��ˮ��','select ��ˮ��,EMS���� from ¼ȡ��Ϣ��',cds_lqmd.Delta);

    if bl then
      MessageBox(Handle, '������ɣ�EMS�ʼĵ��ŵ���ɹ�����', 'ϵͳ��ʾ',
        MB_OK + MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST)
    else
      MessageBox(Handle, 'EMS�ʼĵ��ŵ���ʧ�ܣ���������ԣ���', 'ϵͳ��ʾ',
        MB_OK + MB_ICONSTOP + MB_TOPMOST);
  finally
    cds_lqmd.Close;
    btn_Start.Enabled := True;
    Screen.Cursor := crDefault;
  end;
end;

procedure TEMSNumberImport.cbb_KshChange(Sender: TObject);
begin
  btn_Start.Enabled := TDBComboBoxEh(Sender).Text <> '';
end;

procedure TEMSNumberImport.cbb_SheetChange(Sender: TObject);
begin
  qry_Excel.Close;
  qry_Excel.SQL.Text := 'select * from ['+cbb_Sheet.Text+']';
  qry_Excel.Open;
end;

procedure TEMSNumberImport.con_ExcelAfterConnect(Sender: TObject);
begin
  cbb_Sheet.Enabled := con_Excel.Connected;
  con_Excel.GetTableNames(cbb_Sheet.Items);
  cbb_Sheet.ItemIndex := 0;
end;

procedure TEMSNumberImport.edt_FileButtonClick(Sender: TObject);
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

procedure TEMSNumberImport.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  qry_Excel.Close;
  con_Excel.Close;
  Action := caFree;
end;

procedure TEMSNumberImport.qry_ExcelAfterOpen(DataSet: TDataSet);
begin
  cbb_Ksh.Enabled := True;
  cbb_EMSDH.Enabled := True;
  qry_Excel.GetFieldNames(cbb_Ksh.Items);
  cbb_Ksh.ItemIndex := cbb_Ksh.Items.IndexOf('��ˮ��');
  cbb_EMSDH.Items.Assign(cbb_Ksh.Items);
  cbb_EMSDH.ItemIndex := cbb_EMSDH.Items.IndexOf('EMS����');
end;

end.
