unit uXkDataImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, ADODB, DBClient, ComCtrls,
  StatusBarEx, DBGridEh, Grids, ValEdit;

type
  TXkDataImport = class(TForm)
    Panel3: TPanel;
    GroupBox2: TGroupBox;
    OpenDialog1: TOpenDialog;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    ADOConnection1: TADOConnection;
    cds_Temp: TClientDataSet;
    StatusBarEx1: TStatusBarEx;
    vl_Field: TValueListEditor;
    GroupBox1: TGroupBox;
    edt_Excel: TEdit;
    btn_Open: TBitBtn;
    cbb_Tb: TComboBox;
    Panel1: TPanel;
    btn_Auto: TBitBtn;
    btn_Import: TBitBtn;
    ProgressBar1: TProgressBar;
    btn_Stop: TBitBtn;
    cds_Delete: TClientDataSet;
    btn_Exit: TBitBtn;
    chk_Delete: TCheckBox;
    lbl_Hint: TLabel;
    procedure btn_OpenClick(Sender: TObject);
    procedure btn_ImportClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_AddClick(Sender: TObject);
    procedure vl_FieldGetPickList(Sender: TObject; const KeyName: string;
      Values: TStrings);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure btn_AutoClick(Sender: TObject);
    procedure cbb_TbClick(Sender: TObject);
    procedure edt_ExcelChange(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_StopClick(Sender: TObject);
    procedure cds_TempReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
  private
    { Private declarations }
    fSf,fKdmc,fYx:string;
    sField:TStrings;
    isStop :Boolean;
    procedure Init_Desc;
    procedure Init_Source;
    procedure DeleteKsRecord;
    function  GetRecordCount:Integer;
  public
    { Public declarations }
    procedure Init_DescData(const sf,kdmc,Yx,sData:string);
  end;

var
  XkDataImport: TXkDataImport;

implementation
uses uDM;
{$R *.dfm}

procedure TXkDataImport.btn_AddClick(Sender: TObject);
begin
//  vl_Field.Strings[vl_Field.]
end;

procedure TXkDataImport.btn_AutoClick(Sender: TObject);
var
  i,iCount: Integer;
  sTitle,sKey:String;
begin
  iCount := vl_Field.Strings.Count;
  for i := 0 to iCount do
  begin
    sKey := vl_Field.Keys[i];
    if (sField.IndexOf(sKey)<>-1) and (vl_Field.Values[sKey]<>'<����>') then
      vl_Field.Values[sKey] := sField.Strings[sField.IndexOf(sKey)]
    else
      vl_Field.Values[sKey] := '<����>';
  end;
  //vl_Field.Values['ʡ��'] := QuotedStr(fSf);
  //vl_Field.Values['��������'] := QuotedStr(fKdmc);
  //vl_Field.Values['�п�Ժϵ'] := QuotedStr(fYx);

  sTitle := vl_Field.TitleCaptions.Strings[0];
  if vl_Field.FindRow(sTitle,iCount) then
    vl_Field.DeleteRow(iCount);
end;

procedure TXkDataImport.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkDataImport.btn_ImportClick(Sender: TObject);
var
  i,ii,Total_Count:integer;
  sSql,sWhere,ss,dd,sError:string;
  sZd,s_kshField,s_ksh:string;//�����Ŷ�Ӧ��Դ�ֶ���
  function CheckField(const sField:string):Boolean;
  var
    sTemp:string;
  begin
    sTemp := vl_Field.Values[sField];
    if sTemp = '<����>' then
    begin
      Application.MessageBox(PChar('['+sField+']�ֶ�û��ƥ�䣡��ѡ��'+sField+'��Ӧ��Դ�ֶΣ�����'),
        'ϵͳ��ʾ', MB_OK + MB_ICONWARNING);
      Result := False;
    end else
      Result := True;
  end;
begin
  if (not AdoDataSet1.Active) or (not cds_Temp.Active) then
     Exit;

  s_kshField := vl_Field.Values['������'];

  if not CheckField('������') then Exit;
  if not CheckField('���֤��') then Exit;
  if not CheckField('����') then Exit;
  if not CheckField('�Ա�') then Exit;

  //if not CheckField('ʡ��') then Exit;
  //if not CheckField('��������') then Exit;
  //if not CheckField('�п�Ժϵ') then Exit;
  if not CheckField('רҵ') then Exit;

  btn_Import.Enabled := False;
  btn_Stop.Enabled := True;
  isStop := False;

  s_ksh := '';
  Total_Count := 0;

  Screen.Cursor := crHourGlass;
  try
    try
      //cds_Temp.Connection.BeginTrans;
      if chk_Delete.Checked then
      begin
        DeleteKsRecord;
        Screen.Cursor := crHourGlass;
      end;

      StatusBarEx1.Panels.Items[0].Text := '���ڵ���:';
      ProgressBar1.Max := GetRecordCount;
      ProgressBar1.Position := 1;
      AdoDataSet1.Close;
      //sSql := 'select top 1000 * from ['+cbb_Tb.Text+']'+sWhere+' order by '+s_kshField;
      sSql := 'select * from ['+cbb_Tb.Text+']'; // order by '+s_kshField;
      AdoDataSet1.CommandText := sSql;
      AdoDataSet1.Open;

      AdoDataSet1.First;
      while not AdoDataSet1.eof do
      begin
        Application.ProcessMessages;
        ProgressBar1.Position := Total_Count+AdoDataSet1.RecNo;
        lbl_Hint.Caption := Inttostr(ProgressBar1.Position)+'/'+IntToStr(ProgressBar1.Max);

        cds_Temp.Append;
        cds_Temp.FieldByName('ʡ��').AsString     := fSf;
        cds_Temp.FieldByName('��������').AsString := fKdmc;
        cds_Temp.FieldByName('�п�Ժϵ').AsString := fYx;

        for i:=1 to vl_Field.Strings.Count do
        begin
          dd := vl_Field.Keys[i];
          ss := vl_Field.Values[dd];
          if (ss<>'') and (ss<>'<����>') then //and (cds_Temp.FieldByName(dd).DataType<>ftAutoInc) then
          begin
            if (ss[1]='''') and (ss[Length(ss)]='''') then
              cds_Temp.FieldByName(dd).Value := Copy(ss,2,Length(ss)-2)
            else
              cds_Temp.FieldByName(dd).Value := AdoDataSet1.Fieldbyname(ss).Value;
          end;
        end;
        if cds_Temp.State in [dsInsert,dsEdit] then
          cds_Temp.Post;
        AdoDataSet1.Next;
      end;
      dm.CheckKsbmData(cds_Temp,sError); //��֤�����������ݣ�

      Total_Count := cds_Temp.RecordCount;//Total_Count + ADODataSet1.RecordCount;
      if dm.UpdateData('Id','select top 1 * from У����������רҵ��',cds_Temp.Delta,False) then
      begin
        Application.MessageBox(pchar('���ݵ�����ɣ�����'+IntToStr(Total_Count)+'����¼�ɹ����룡'),'���ݵ������',MB_OK+MB_ICONINFORMATION);
        ProgressBar1.Position := ProgressBar1.Max;
      end;
      if sError<>'' then
        MessageBox(Handle, PChar(sError),'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Except
      on e:Exception do//cds_Temp.Connection.RollbackTrans;
        Application.MessageBox(pchar('���ݵ���ʧ�ܣ�0����¼�����룡����'+#13+#13+e.Message),'���ݵ���ʧ��',MB_OK+MB_ICONERROR);
    end;
  finally
    Screen.Cursor := crDefault;
    isStop := True;
    btn_Stop.Enabled := False;
    btn_Import.Enabled := True;
  end;
end;

procedure TXkDataImport.btn_OpenClick(Sender: TObject);
var
  fn,extName,tbName,s:string;
begin
  if OpenDialog1.Execute then
  begin
    edt_Excel.Text:=Opendialog1.FileName;
  end else
    Exit;
  fn := LowerCase(edt_Excel.Text);
  extName := LowerCase(ExtractFileExt(fn));
  case OpenDialog1.FilterIndex of
    1: //dBase IV
    begin
      s := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ExtractFilePath(fn)+
           ';Extended Properties=dBASE IV;User ID=Admin;Password=;';
      tbName := ExtractFileName(fn);
      tbName := Copy(tbName,1,Pos(extName,tbName)-1);
    end;
    2: //dBase 5.0
    begin
      s := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+ ExtractFilePath(fn)+
           ';Extended Properties=dBase 5.0;Persist Security Info=False;';
      tbName := ExtractFileName(fn);
      tbName := Copy(tbName,1,Pos(extName,tbName)-1);
    end;
    3: //VFP
    begin
      s := 'Provider=MSDASQL.1;Driver=Microsoft Visual Foxpro Driver;SourceDB='+ExtractFilePath(fn)+';SourceType=DBF;';
      tbName := ExtractFileName(fn);
      tbName := Copy(tbName,1,Pos(extName,tbName)-1);
    end;
    4: //Excel 997/2000
    begin
      s := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+fn
           +';Extended Properties=Excel 8.0;Persist Security Info=False';
    end;
    5: //Access MDB
    begin
      s := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+fn+
           ';Persist Security Info=False;Jet OLEDB:Create System Database=True';
    end;
  end;

  AdoConnection1.Close;
  AdoConnection1.ConnectionString := s;

  if (edt_Excel.Text = '') then
     Exit;
     
  Screen.Cursor := crHourGlass;
  try
    try
      AdoConnection1.Connected := True;

      cbb_Tb.Items.Clear;
      ADOConnection1.GetTableNames(cbb_Tb.Items);

      if Pos('dbf',extName)>0 then
        cbb_Tb.ItemIndex := cbb_Tb.Items.IndexOf(tbName)
      else
        cbb_Tb.ItemIndex := 0;

      if (cbb_Tb.Text = '') then
      begin
        ADOConnection1.Close;
        Application.MessageBox(PChar(fn+'�ļ�����ʧ�ܣ���ȷ�ϴ��ļ���ʽ�Ƿ���ȷ����'),'����ʧ��',MB_OK+MB_ICONERROR);
        Exit;
      end;

      Init_Source;
      //Init_Desc;
      btn_Auto.Click;
      //Application.MessageBox('����Excel�ļ��ɹ���','���Գɹ�',MB_OK+MB_ICONINFORMATION);

    except
      Application.MessageBox('����Դ�ļ�ʱ����������ȷ�����ļ����ⲿû�б��κγ���ʹ�û�򿪣���������ԣ�','����ʧ��',MB_OK+MB_ICONERROR);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TXkDataImport.btn_StopClick(Sender: TObject);
begin
  if Application.MessageBox('���Ҫȡ�����ݵ�������𣿡���', 'ϵͳ��ʾ',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDYES then
  begin
    isStop := True;
  end;
end;

procedure TXkDataImport.cbb_TbClick(Sender: TObject);
begin
  if cbb_Tb.Text<>'' then
    Init_Source;
end;

procedure TXkDataImport.cds_TempReconcileError(
  DataSet: TCustomClientDataSet; E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  Application.MessageBox(PChar(e.Message),'�������',MB_OK+MB_Iconstop);
end;

procedure TXkDataImport.DeleteKsRecord;
//var
//  sID:string;
begin
  StatusBarEx1.Panels.Items[0].Text := '����ɾ��:';
  Screen.Cursor := crHourGlass;
  try
    ProgressBar1.Max := cds_Temp.RecordCount;
    //sID := '';
    Application.ProcessMessages;

    cds_Temp.Last;
    while not cds_Temp.Bof do
    begin
      Application.ProcessMessages;

      lbl_Hint.Caption := Inttostr(ProgressBar1.Position)+'/'+IntToStr(ProgressBar1.Max);
      ProgressBar1.Position := ProgressBar1.Position+1;
      cds_Temp.Delete;
    end;
  finally
    StatusBarEx1.Panels.Items[0].Text := 'ɾ����ɣ�';
    Screen.Cursor := crDefault;
  end;
end;

procedure TXkDataImport.edt_ExcelChange(Sender: TObject);
begin
  cbb_Tb.Enabled := edt_Excel.Text<>'';
end;

procedure TXkDataImport.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  AdoDataSet1.Close;
  cds_Temp.Close;
  AdoConnection1.Close;
  Action := caFree;
end;

procedure TXkDataImport.FormCreate(Sender: TObject);
begin
  sField := TStringList.Create;
end;

procedure TXkDataImport.FormDestroy(Sender: TObject);
begin
  sField.Free;
end;

function TXkDataImport.GetRecordCount: Integer;
begin
  Result := ADOConnection1.Execute('select count(*) from ['+cbb_Tb.Text+']').Fields[0].Value;
end;

procedure TXkDataImport.Init_Desc;
var
  i:integer;
begin
  with cds_Temp do
  begin
    //Close;
    //XMLData := dm.OpenData('select top 1 * from У����������רҵ��');
    //Open;
    vl_Field.Strings.Clear;
    for i:=0 to FieldCount-1 do
    begin
      if (cds_Temp.Fields[i].FieldName<>'ʡ��') and
       (cds_Temp.Fields[i].FieldName<>'�п�Ժϵ') and
       (cds_Temp.Fields[i].FieldName<>'��������') and
       (cds_Temp.Fields[i].FieldName<>'�ɼ�') and
       (cds_Temp.Fields[i].DataType<>ftAutoInc) then
      begin
        if cds_Temp.Fields[i].DataType=ftAutoInc then
           vl_Field.Strings.Add(Fields[i].FieldName+'=<����>')
        else
           vl_Field.Strings.Add(Fields[i].FieldName+'=');
      end;
    end;
  end;
end;

procedure TXkDataImport.Init_DescData(const sf,kdmc,Yx,sData: string);
begin
  fSf := sf;
  fKdmc := kdmc;
  fYx := Yx;
  Self.Caption := '��'+fSf+'|'+fKdmc+'����Ϣ����';
  cds_Temp.XMLData := sData;
  Init_Desc;
end;

procedure TXkDataImport.Init_Source;
var
  i:integer;
begin
  with AdoDataSet1 do
  begin
    Close;
    CommandText := 'select * from ['+cbb_Tb.Text+'] where 1=0';
    Open;
    sField.Clear;
    sField.Add('<����>');
    for i:=0 to FieldCount-1 do
    begin
      sField.Add(Fields[i].FieldName);
    end;
  end;
end;

procedure TXkDataImport.vl_FieldGetPickList(Sender: TObject;
  const KeyName: string; Values: TStrings);
begin
  if cds_Temp.FieldByName(KeyName).DataType<>ftAutoInc then
    Values.Assign(sField);
end;

end.
