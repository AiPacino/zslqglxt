unit uExportToAccess;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, CnButtonEdit, DB, ADODB, DBClient,
  ExtCtrls;

type
  TExportToAccess = class(TForm)
    btnedt_Path: TCnButtonEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    edt_Sql: TEdit;
    pb1: TProgressBar;
    dlgOpen1: TOpenDialog;
    qry_Access: TADOQuery;
    ADOConnection1: TADOConnection;
    cds_lqmd: TClientDataSet;
    chk_ReleaseAll: TCheckBox;
    pnl_1: TPanel;
    btn_Start: TBitBtn;
    btn_Exit: TBitBtn;
    bvl1: TBevel;
    lbl_Hint: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnedt_PathButtonClick(Sender: TObject);
    procedure btnedt_PathChange(Sender: TObject);
    procedure btn_StartClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure chk_ReleaseAllClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  ExportToAccess: TExportToAccess;

implementation
uses uDM;
{$R *.dfm}

procedure TExportToAccess.btnedt_PathButtonClick(Sender: TObject);
begin
  dlgOpen1.FileName := btnedt_Path.Text;
  if dlgOpen1.Execute then
  begin
    btnedt_Path.Text := dlgOpen1.FileName;
  end;
end;

procedure TExportToAccess.btnedt_PathChange(Sender: TObject);
begin
  btn_Start.Enabled := btnedt_Path.Text<>'';
  qry_Access.Close;
  qry_Access.ConnectionString := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+
                                  btnedt_Path.Text+';Persist Security Info=False';
end;

procedure TExportToAccess.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TExportToAccess.btn_StartClick(Sender: TObject);
  procedure InsertRecord;
  var
    i:Integer;
    fldName:string;
  begin
    for i := 0 to qry_Access.FieldCount - 1 do
    begin
      if qry_Access.Fields[i].DataType=ftAutoInc then Continue;
      fldName := qry_Access.Fields[i].FieldName;
      if cds_lqmd.FindField(fldName)<>nil then
      begin
        if not cds_lqmd.FieldByName(fldName).IsNull then
          qry_Access.FieldByName(fldName).Value := cds_lqmd.FieldByName(fldName).Value;
      end;
    end;
  end;
var
  iCount:integer;
begin
  if MessageBox(Handle, '���Ҫ��¼ȡ��Ϣ������ACCESS�ļ���ȥ�𣿡�',
    'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  btn_Start.Enabled := False;
  try
    cds_lqmd.XMLData := dm.OpenData(edt_Sql.Text);
    qry_Access.Close;
    if chk_ReleaseAll.Checked then
    begin
      lbl_Hint.Caption := '����ɾ��Access��¼....';
      qry_Access.SQL.Text := 'delete from lqmd';
      qry_Access.ExecSQL;
    end;
    qry_Access.SQL.Text := 'select * from lqmd';
    qry_Access.Open;
    pb1.Max := cds_lqmd.RecordCount;
    iCount := 0;
    while not cds_lqmd.Eof do
    begin
      lbl_Hint.Caption := '���ڵ���.... '+IntToStr(cds_lqmd.RecNo)+'/'+IntToStr(cds_lqmd.RecordCount);
      pb1.Position := cds_lqmd.RecNo;
      Application.ProcessMessages;
      if not qry_Access.Locate('������',cds_lqmd.FieldByName('������').AsString,[]) then
      begin
        qry_Access.Append;
        InsertRecord;
        try
          qry_Access.Post;
        except
          on e:Exception do
          begin
            MessageBox(Handle, PChar('���ݵ���ʧ�ܣ���������ԣ���'+#13+'������'+cds_lqmd.FieldByName('������').AsString+'��ʧ��ԭ��:'+#13+e.Message), 'ϵͳ��ʾ',
              MB_OK + MB_ICONSTOP);
            Exit;
          end;
        end;
        inc(iCount);
      end; //else
      //begin
      //  qry_Access.Edit
      //end;
      cds_lqmd.Next;
    end;
    lbl_Hint.Caption := '�������.... '+IntToStr(cds_lqmd.RecNo)+'/'+IntToStr(cds_lqmd.RecordCount);
    MessageBox(Handle, PChar('���ݵ����ɹ��������� '+inttostr(iCount)+' ����¼����'), 'ϵͳ��ʾ', MB_OK +
      MB_ICONINFORMATION);

  finally
    cds_lqmd.Close;
    qry_Access.Close;
    Screen.Cursor := crDefault;
    btn_Start.Enabled := True;
    btn_Exit.SetFocus;
  end;
end;

procedure TExportToAccess.chk_ReleaseAllClick(Sender: TObject);
var
  sValue:string;
begin
  if chk_ReleaseAll.Checked then
    if MessageBox(Handle,
      '���Ҫ���Access�е����м�¼����һ����һ��ִ�н��ǡ�' + #13#10 +
      '������ת�ģ�' + #13#10 + '��Ҫ������һ������' + #13#10, 'ϵͳ��ʾ',
      MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      chk_ReleaseAll.Checked := False;
      Exit;
    end;
  if chk_ReleaseAll.Checked then
  begin
    if InputQuery('����ȷ��','�����롾OK��ȷ��',sValue) then
      if UpperCase(sValue)<>'OK' then
      begin
        MessageBox(Handle, 'ȷ���ַ�������󣡲�����ȡ������', 'ϵͳ��ʾ',
          MB_OK + MB_ICONSTOP + MB_TOPMOST);
        chk_ReleaseAll.Checked := False;
        Exit;
      end;
  end;
end;

procedure TExportToAccess.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TExportToAccess.FormCreate(Sender: TObject);
begin
  dlgOpen1.InitialDir := ExtractFilePath(ParamStr(0));
  btnedt_Path.Text := ExtractFilePath(ParamStr(0))+'lqmd.mdb';
  dlgOpen1.FileName := btnedt_Path.Text;
end;

end.
