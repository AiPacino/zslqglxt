unit uXkKmCjEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, DBCtrls,
  Spin;

type
  TXkKmCjEdit = class(TForm)
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    DBEdit1: TDBEditEh;
    Label2: TLabel;
    DBEdit2: TDBEditEh;
    Label3: TLabel;
    DBEdit3: TDBEditEh;
    Label7: TLabel;
    DBEdit7: TDBEditEh;
    Label8: TLabel;
    DBEdit8: TDBEditEh;
    btn_Save: TBitBtn;
    cds_Sjfzb: TClientDataSet;
    lbl_Cj: TLabel;
    edt_Cj: TDBNumberEditEh;
    Label4: TLabel;
    DBEditEh1: TDBEditEh;
    lbl_pw: TLabel;
    edt_pw: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl_Len: TLabel;
    cbb_Field: TDBComboBoxEh;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    Bevel1: TBevel;
    edt_Length: TDBNumberEditEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_ZyChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ValueChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure edt_CjKeyPress(Sender: TObject; var Key: Char);
    procedure edt_CjChange(Sender: TObject);
    procedure ClientDataSet1AfterOpen(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    fKsh:string;
    fCjIndex:Integer;
    fYx,fSf,fKm,fPw:string;
    function  GetWhere:string;
    procedure Open_Table;
    procedure SetDBEditStatus;
    procedure LoadInfoFromIni;
    procedure SaveInfoToIni;
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string;const CjIndex:Integer;const Pw:string);
  end;

implementation
uses uDM,uXkSelectCjInputSf,IniFiles;
{$R *.dfm}


procedure TXkKmCjEdit.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKmCjEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmCjEdit.btn_PostClick(Sender: TObject);
begin
  if MessageBox(Handle, '提交上传本科目的成绩后，将不能再进行修改！　' +
    #13#10 + '还要上传吗？', '系统提示', MB_YESNO + MB_ICONWARNING +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;
  if vobj.PostCj(fCjIndex,fyx,fSf,fKm) then
  begin
    MessageBox(Handle, '成绩数据上传成功，该科目成绩不能再进行修改了！　',
      '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
    Close;
  end else
  begin
    MessageBox(Handle, '成绩数据上传失败，请检查是否漏录了考生成绩！　',
      '系统提示', MB_OK + MB_ICONERROR + MB_TOPMOST);
  end;
end;

procedure TXkKmCjEdit.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmCjEdit.btn_SaveClick(Sender: TObject);
var
  sError:string;
  iLen:Integer;
begin
  if (edt_Cj.Text='') or (edt_pw.Text='') then
  begin
    Application.MessageBox('评委和成绩内容不能为空！　', '系统提示', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  try
    if not vobj.SaveInputCj(fksh,fkm,fyx,fPw,fCjIndex,edt_Cj.Value,gb_Czy_ID,sError) then      //保存考生成绩数据到成绩录入明细表
       MessageBox(0, PChar('成绩保存失败！原因为：'+sError), '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
  finally
    btn_Save.Enabled := False;
    iLen := edt_Length.Value;
    edt_Value.Text := Copy(edt_Value.Text,1,iLen);
    edt_Value.SelStart := edt_Length.Value;
    edt_Value.SelLength := 0;
    //edt_Value.Text := '';
    edt_Value.SetFocus;
  end;
end;

procedure TXkKmCjEdit.btn_SearchClick(Sender: TObject);
var
  bl:Boolean;
  sText,ksh,sError:string;
begin
  fKsh := '';
  if Trim(edt_Value.Text)='' then Exit;
  sText := Trim(edt_Value.Text);
  if cbb_Field.Text='模糊查询' then
  begin
     ksh := sText;
     bl := vobj.KsIsExists(sText,sError);
     if not bl then
     begin
       ksh := dm.GetKshByZkzh(sText);
       bl := vobj.KsIsExists(ksh,sError);
     end;
     if not bl then
     begin
       ksh := dm.GetKshBySfzh(sText);
       bl := vobj.KsIsExists(ksh,sError);
     end;
  end else
  begin
    if cbb_Field.Text='考生号' then
       ksh := sText;
    if cbb_Field.Text='准考证号' then
       ksh := dm.GetKshByZkzh(sText)
    else if cbb_Field.Text='身份证号' then
       ksh := dm.GetKshBySfzh(sText);
    bl := vobj.KsIsExists(ksh,sError);
  end;

  if not bl then
  begin
    SetDBEditStatus;
    MessageBox(Handle, PChar('该考生信息不存在，请检查后重新试！　'),
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt_Value.SetFocus;
    Exit;
  end else
  begin

    fKsh := ksh;
    vobj.CopyKsInfoToCjB(ksh,fKm,fYx,sError);
    Open_Table;
    if ClientDataSet1.FieldByName('省份').AsString<>fSf then
    begin
      MessageBox(Handle, PChar('该考生不是【'+fSf+'】的考生，请检查后重新试！　'),
        '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
      ClientDataSet1.Close;
      edt_Value.SetFocus;
      Exit;
    end;
    
    if cds_Sjfzb.FieldByName('是否提交').AsBoolean then
    begin
      Application.MessageBox('该考生成绩已上传，无法进行修改！　', '系统提示',
        MB_OK + MB_ICONWARNING);
      ClientDataSet1.Close;
      btn_Save.Enabled := False;
      edt_Value.SetFocus;
      Exit;
    end;

    SetDBEditStatus;
    edt_Cj.SetFocus;
  end;
end;

procedure TXkKmCjEdit.cbb_ZyChange(Sender: TObject);
begin
  if Self.Showing then
    Open_Table;
end;

procedure TXkKmCjEdit.ClientDataSet1AfterOpen(DataSet: TDataSet);
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考卷面成绩录入表 '+GetWhere;
  cds_Sjfzb.XMLData := dm.OpenData(sqlstr);
  if cds_Sjfzb.RecordCount>0 then
  begin
    edt_pw.Text := cds_Sjfzb.FieldByName('评委').AsString;
    edt_Cj.Text := cds_Sjfzb.FieldByName('成绩').AsString;
  end else
  begin
    edt_pw.Text := fPw;
    edt_Cj.Text := '';
  end;
end;

procedure TXkKmCjEdit.edt_CjChange(Sender: TObject);
begin
  btn_Save.Enabled := (edt_Cj.Text<>'') and (edt_pw.Text<>'');
end;

procedure TXkKmCjEdit.edt_CjKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and btn_Save.Enabled then
    btn_Save.SetFocus;
end;

procedure TXkKmCjEdit.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TXkKmCjEdit.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TXkKmCjEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveInfoToIni;
end;

procedure TXkKmCjEdit.FormShow(Sender: TObject);
begin
  Self.Caption :='【'+fSf+ '】【'+fKm+'】第'+IntTostr(fCjIndex)+'组成绩录入';
  SetDBEditStatus;
  if edt_Value.Text='' then
    LoadInfoFromIni;
  edt_Value.SetFocus;
end;

function TXkKmCjEdit.GetWhere: string;
//var
//  sWhere:string;
begin
  //Result := ' where '+cbb_Field.Text+'='+quotedstr(edt_Value.Text)+' and 考试科目='+quotedstr(fKm);
  Result := ' where 考生号='+quotedstr(fKsh)+' and 考试科目='+quotedstr(fKm)+' and 录入分组='+IntToStr(fCjIndex)+' and 评委='+quotedstr(fPw);
end;


procedure TXkKmCjEdit.LoadInfoFromIni;
var
  fn,str:string;
  iLen:Integer;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  if not FileExists(fn) then Exit;
  with TIniFile.Create(fn) do
  begin
    str := ReadString(Self.Name,'保留查询值','');
    edt_Length.Value := ReadInteger(Self.Name,'保留位数',0);
    iLen := edt_Length.Value;
    edt_Value.Text := Copy(str,1,iLen);
    edt_Value.SelStart := edt_Length.Value;
    edt_Value.SelLength := 0;
    Free;
  end;
end;

procedure TXkKmCjEdit.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考考生信息表 where 考生号='+quotedstr(fKsh);//+' and 省份='+quotedstr(fSf);
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkKmCjEdit.SaveInfoToIni;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  if not FileExists(fn) then Exit;
  with TIniFile.Create(fn) do
  begin
    WriteString(Self.Name,'保留查询值',edt_Value.Text);
    WriteInteger(Self.Name,'保留位数',edt_Length.Value);
    Free;
  end;
end;

procedure TXkKmCjEdit.SetDBEditStatus;
begin
  edt_pw.Text := fPw;
end;

procedure TXkKmCjEdit.SetYxSfKmValue(const Yx, Sf, Km: string;const CjIndex:Integer;const Pw:string);
begin
  fYx := Yx;
  fSf := Sf;
  fKm := Km;
  fCjIndex := CjIndex;
  fPw := Pw;
end;

end.

