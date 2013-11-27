unit uXkKsInfoSelect;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, DBCtrls,
  Spin, DBGridEhGrouping, GridsEh;

type
  TXkKsInfoSelect = class(TForm)
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    GroupBox1: TGroupBox;
    DBGridEh1: TDBGridEh;
    GroupBox2: TGroupBox;
    edt_SjBH: TLabeledEdit;
    edt_Value: TEdit;
    lbl1: TLabel;
    lbl_Len: TLabel;
    btn_Save: TBitBtn;
    Bevel1: TBevel;
    pnl1: TPanel;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    DBEditEh3: TDBEditEh;
    DBEditEh4: TDBEditEh;
    DBEditEh5: TDBEditEh;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    DBEditEh7: TDBEditEh;
    lbl8: TLabel;
    bvl1: TBevel;
    pnl2: TPanel;
    lbl6: TLabel;
    edt_Len: TDBNumberEditEh;
    Panel2: TPanel;
    btn_Close: TBitBtn;
    cds_SjBHInfo: TClientDataSet;
    chk_CheckSjBH: TCheckBox;
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ValueChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure edt_CjKeyPress(Sender: TObject; var Key: Char);
    procedure edt_cj2KeyPress(Sender: TObject; var Key: Char);
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
    procedure edt_SjBHKeyPress(Sender: TObject; var Key: Char);
    procedure ClientDataSet1FilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure DBGridEh1KeyPress(Sender: TObject; var Key: Char);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure edt_ValueKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_CloseClick(Sender: TObject);
    procedure edt_LenChange(Sender: TObject);
    procedure edt_SjBHChange(Sender: TObject);
  private
    { Private declarations }
    fMaxValue:Integer;
    fKsh:string;
    fYx,fSf,fKm,fCjField,fCzyField:string;
    function  GetWhere:string;
    procedure GetXkZyList;
    procedure GetYxList;
    procedure SearchData;
    procedure Open_SjBH_Table;
  public
    { Public declarations }
    procedure Open_Table;
    procedure SetYxKm(const Yx,Km:string);
    procedure SetCloseMaxValue(const aValue:Integer);
    procedure SetDataSource(const aDataSet:TClientDataSet);
  end;

implementation
uses uDM,StrUtils, uXkKmSjInfoInput;
{$R *.dfm}


procedure TXkKsInfoSelect.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKsInfoSelect.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKsInfoSelect.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKsInfoSelect.btn_SaveClick(Sender: TObject);
var
  i,ii:Integer;
  Zy,Km,sqlstr,sWhere,sTime:string;
  bSucessed:Boolean;
  cds_Temp:TClientDataSet;
begin
  if chk_CheckSjBH.Checked then
  begin
    sWhere := 'where 试卷编号='+quotedstr(edt_SjBH.Text)+' and 承考院系='+quotedstr(fYx)+' and 考试科目='+quotedstr(fKm);
    if not vobj.RecordIsExists(sWhere,'校考卷面成绩明细表') then
    begin
      if MessageBox(Handle,
        PChar('成绩录入表中未找到试卷编号为【'+edt_sjbh.Text+'】的【'+fKm+'】成绩录入记录！　' + #13#10 +
        '要强行录入这一试卷信息吗？'), '系统提示', MB_YESNO + MB_ICONSTOP +
        MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      begin
        edt_Value.SetFocus;
        Exit;
      end;
    end;
  end;

  cds_Temp := TClientDataSet.Create(nil);
  try

    fKsh := ClientDataSet1.FieldByName('考生号').AsString;

    sWhere := 'where 试卷编号='+quotedstr(edt_SjBH.Text)+' and 承考院系='+quotedstr(fYx)+' and 科目='+quotedstr(fKm);
    if vobj.RecordIsExists(sWhere,'校考科目试卷编码表') then
    begin
      if MessageBox(Handle,
        PChar('编号为【'+edt_sjbh.Text+'】的【'+fKm+'】试卷编码信息已存在！确定要修改吗？　'), '系统提示', MB_YESNO + MB_ICONSTOP +
        MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      begin
        edt_Value.SetFocus;
        Exit;
      end else
      begin
        sqlstr := 'delete from 校考科目试卷编码表 '+sWhere;
        dm.ExecSql(sqlstr);
      end;
    end;

    //======================================================================================
    sqlstr := 'select 承考院系,专业,考试科目 from View_校考考生考试科目表 where 考生号='+quotedstr(fKsh)+
              ' and 承考院系='+quotedstr(fYx)+' and 考试科目='+quotedstr(fKm) ;

    cds_Temp.XMLData := dm.OpenData(sqlstr);// 获取考生的兼报专业

    sTime := FormatDateTime('YYYY-MM-DD HH:NN:SS',Now);
    //for i := 0 to DBGridEh1.SelectedRows.Count - 1 do
    while not cds_Temp.Eof do
    begin
      Zy := cds_Temp.FieldByName('专业').AsString;
      Km := cds_Temp.FieldByName('考试科目').AsString;

      sqlstr := 'Insert 校考科目试卷编码表 (试卷编号,考生号,承考院系,专业,科目,操作员,ActionTime) '+
                'Values('+quotedstr(edt_SjBH.Text)+','+quotedstr(fKsh)+','+quotedstr(fYx)+','+quotedstr(Zy)+
                ','+quotedstr(Km)+','+quotedstr(gb_Czy_Id)+','+quotedstr(sTime)+')';

      bSucessed := dm.ExecSql(sqlstr);
      if not bSucessed then
        break;
      cds_Temp.Next;
    end;
    //======================================================================================

    if bSucessed then
    begin
      TXkKmSjInfoInput(Self.Owner).Open_Table;
      TXkKmSjInfoInput(Self.Owner).ClientDataSet1.Locate('试卷编号',edt_SjBH.Text,[]);
      
      //MessageBox(Handle, PChar('【'+IntToStr(cds_Temp.RecordCount)+'】条试卷编码信息与考生数据配对成功！　'), '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);

      ii := StrToIntDef(RightStr(edt_SjBH.Text,2),0)+1;
      edt_SjBH.Text := GetNextSjBH(edt_SjBH.Text,edt_Len.Value);

      if ii>fMaxValue then
      begin
        //MessageBox(Handle, '请确认即将要输入的试卷编号，如果不正确请重新修改！　' +
        //  #13#10, '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
        
        edt_SjBH.Text := '';
        edt_Value.Text := '';
        //edt_SjBH.SetFocus;
        Self.Close;
      end else
      begin
        edt_SjBH.Enabled := False;
        edt_Value.Text := '';
        edt_Value.SetFocus;
      end;

    end;
    //edt_SjBH.SetFocus;
  finally
    cds_Temp.Free;
    DBGridEh1.SelectedRows.Clear;
    btn_Save.Enabled := False;
  end;
end;

procedure TXkKsInfoSelect.ClientDataSet1AfterOpen(DataSet: TDataSet);
begin
  btn_Save.Enabled := DataSet.RecordCount>0;
end;

procedure TXkKsInfoSelect.ClientDataSet1FilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  Accept := (Pos(edt_Value.Text,DataSet.FieldByName('考生号').AsString)=1) or
            (Pos(edt_Value.Text,DataSet.FieldByName('准考证号').AsString)=1) or
            (Pos(edt_Value.Text,DataSet.FieldByName('身份证号').AsString)=1) or
            (Pos(edt_Value.Text,DataSet.FieldByName('姓名').AsString)>0);

end;

procedure TXkKsInfoSelect.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  btn_Save.Enabled := not ClientDataSet1.FieldByName('考生号').IsNull;
end;

procedure TXkKsInfoSelect.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key<>VK_UP) and
     (Key<>VK_DOWN) and
     (Key<>VK_TAB) and
     (Key<>VK_RETURN) then
  begin
    edt_Value.SetFocus;
    edt_Value.SelLength := 0;
    edt_Value.SelStart := Length(edt_Value.Text);
  end;
end;

procedure TXkKsInfoSelect.DBGridEh1KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and (not ClientDataSet1.FieldByName('考生号').IsNull) then
  begin
    edt_Value.Text := ClientDataSet1.FieldByName('考生号').AsString;
    btn_Save.Click;
  end;
end;

procedure TXkKsInfoSelect.edt_cj2KeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and btn_Save.Enabled then
    btn_Save.SetFocus;
end;

procedure TXkKsInfoSelect.edt_CjKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and btn_Save.Enabled then
    btn_Save.SetFocus;
end;

procedure TXkKsInfoSelect.edt_LenChange(Sender: TObject);
begin
  edt_SjBH.MaxLength := edt_Len.Value;
end;

procedure TXkKsInfoSelect.edt_SjBHChange(Sender: TObject);
begin
  edt_Value.Enabled := Length(edt_SjBH.Text)=edt_Len.Value;
end;

procedure TXkKsInfoSelect.edt_SjBHKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and (edt_SjBH.Text<>'') then
    edt_Value.SetFocus;
end;

procedure TXkKsInfoSelect.edt_ValueChange(Sender: TObject);
begin
  ClientDataSet1.Filter := '';
  ClientDataSet1.Filtered := False;
  //if edt_Value.Text<>'' then
  ClientDataSet1.Filtered := True;
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TXkKsInfoSelect.edt_ValueKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  case Key of
    VK_UP :
    begin
      ClientDataSet1.Prior;
      DBGridEh1.SetFocus;
    end;
    VK_DOWN :
    begin
      ClientDataSet1.Next;
      DBGridEh1.SetFocus;
    end;
  end;
end;

procedure TXkKsInfoSelect.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and (edt_Value.Text<>'') then
  begin
    SearchData;
    if ClientDataSet1.RecordCount=1 then
    begin
      btn_Save.Enabled := True;
      btn_Save.SetFocus;
    end;
  end;
end;

procedure TXkKsInfoSelect.FormShow(Sender: TObject);
begin
  Caption := '【'+fYx+'】【'+fKm+'】试卷编码信息录入';
  if not ClientDataSet1.Active then
    Open_Table;
  edt_Len.OnChange(Self);
  edt_SjBH.Enabled := edt_SjBH.Text='';
end;

function TXkKsInfoSelect.GetWhere: string;
begin
  Result := ' where 承考院系='+quotedstr(fYx);
end;

procedure TXkKsInfoSelect.GetXkZyList;
begin
end;

procedure TXkKsInfoSelect.GetYxList;
begin
end;

procedure TXkKsInfoSelect.Open_SjBH_Table;
begin

end;

procedure TXkKsInfoSelect.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'SELECT 承考院系, 省份, 考生号, 准考证号, 身份证号, 姓名, 性别, 邮政编码, 联系电话, 通信地址 FROM 校考考生信息表 '+GetWhere+' order by 考生号';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr,True);
end;

procedure TXkKsInfoSelect.SearchData;
var
  sText,ksh,sqlstr:string;
begin
  fKsh := '';
{
  if Trim(edt_Value.Text)='' then Exit;
  sText := Trim(edt_Value.Text);
  sqlstr := 'select * from 校考考生信息表 '+
            ' where 考生号='+quotedstr(sText)+
            ' or 准考证号='+quotedstr(sText)+
            ' or 身份证号='+quotedstr(sText)+
            ' or 姓名='+quotedstr(sText);

  ClientDataSet1.XMLData := dm.OpenData(sqlstr);
}

  if ClientDataSet1.RecordCount=0 then
  begin
    MessageBox(Handle, PChar('考生号、准考证号、身份证号或姓名为【'+edt_Value.Text+'】'+'的考生不存在！　　' + #13#10 + '请检查后重新查询！'),
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  end else
  begin
    DBGridEh1.SetFocus;
  end;
end;

procedure TXkKsInfoSelect.SetCloseMaxValue(const aValue: Integer);
begin
  fMaxValue := aValue;
end;

procedure TXkKsInfoSelect.SetDataSource(const aDataSet: TClientDataSet);
begin
  cds_SjBHInfo := aDataSet;
end;

procedure TXkKsInfoSelect.SetYxKm(const Yx, Km: string);
begin
  fYx := Yx;
  fKm := Km;
end;

end.
