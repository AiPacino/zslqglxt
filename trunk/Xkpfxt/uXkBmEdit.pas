unit uXkBmEdit;
//校考编码录入

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, DBCtrls,
  Spin;

type
  TXkBmEdit = class(TForm)
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
    Label4: TLabel;
    DBEditEh1: TDBEditEh;
    lbl_pw: TLabel;
    edt_xkbh: TEdit;
    lbl1: TLabel;
    lbl_Len: TLabel;
    cbb_Field: TDBComboBoxEh;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    Bevel1: TBevel;
    edt_Length: TDBNumberEditEh;
    lbl2: TLabel;
    DBEditEh2: TDBEditEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ValueChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure edt_CjKeyPress(Sender: TObject; var Key: Char);
    procedure edt_CjChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_xkbhChange(Sender: TObject);
  private
    { Private declarations }
    fKsh,fId:string;
    fBh:Integer;
    function  GetWhere:string;
    procedure Open_Table;
    procedure SetDBEditStatus;
    procedure LoadInfoFromIni;
    procedure SaveInfoToIni;
  public
    { Public declarations }
  end;

implementation
uses uDM,IniFiles;
{$R *.dfm}


procedure TXkBmEdit.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkBmEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkBmEdit.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkBmEdit.btn_SaveClick(Sender: TObject);
var
  sId,sqlstr,sError:string;
  iLen:Integer;
begin
  if (edt_xkbh.Text='') then
  begin
    Application.MessageBox('校考编号不能为空！　', '系统提示', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  sId := ClientDataSet1.FieldByName('Id').AsString;
  sqlstr := 'update 校考考生报考专业表 set 校考编号='+quotedstr(edt_xkbh.Text)+' where id='+sId;
  if dm.ExecSql(sqlstr) then      //保存考生成绩数据到成绩录入明细表
  begin
    btn_Save.Enabled := False;
    iLen := edt_Length.Value;
    edt_Value.Text := Copy(edt_Value.Text,1,iLen);
    edt_Value.SelStart := edt_Length.Value;
    edt_Value.SelLength := 0;
    fBh := fBh+1;
    edt_Value.SetFocus;
  end else
    edt_xkbh.SetFocus;
end;

procedure TXkBmEdit.btn_SearchClick(Sender: TObject);
var
  bl:Boolean;
  sText,ksh,sError:string;
begin
  if Trim(edt_Value.Text)='' then Exit;
  sText := Trim(edt_Value.Text);
{
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
}
  begin
    if cbb_Field.Text='准考证号' then
      fId := dm.GetIdByZkzh(sText)
    else if cbb_Field.Text='考生号' then
      fId := dm.GetIdByKsh(sText)
    else if cbb_Field.Text='身份证号' then
      fId := dm.GetIdBySfzh(sText);
    bl := fId<>'';
  end;

  if not bl then
  begin
    ClientDataSet1.Close;
    edt_xkbh.Text := '';
    MessageBox(Handle, PChar('该考生信息不存在，请检查后重新试！　'),
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt_Value.SetFocus;
    Exit;
  end else
  begin
    Open_Table;
    edt_xkbh.Text := ClientDataSet1.FieldByName('校考编号').AsString;
    //if ClientDataSet1.FieldByName('校考编号').AsString<>'' then
    //  edt_xkbh.Text := Format('%.3d',[fBh]);
    edt_xkbh.SetFocus;
  end;
end;

procedure TXkBmEdit.edt_CjChange(Sender: TObject);
begin
  btn_Save.Enabled := (edt_xkbh.Text<>'');
end;

procedure TXkBmEdit.edt_CjKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and btn_Save.Enabled then
    btn_Save.SetFocus;
end;

procedure TXkBmEdit.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TXkBmEdit.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TXkBmEdit.edt_xkbhChange(Sender: TObject);
begin
  btn_Save.Enabled := edt_xkbh.Text<>'';
end;

procedure TXkBmEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveInfoToIni;
  Action := caFree;
end;

procedure TXkBmEdit.FormShow(Sender: TObject);
begin
  if edt_Value.Text='' then
    LoadInfoFromIni;
  edt_Value.SetFocus;
end;

function TXkBmEdit.GetWhere: string;
begin
end;


procedure TXkBmEdit.LoadInfoFromIni;
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

procedure TXkBmEdit.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from 校考考生报考专业表 where Id='+fId;
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkBmEdit.SaveInfoToIni;
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

procedure TXkBmEdit.SetDBEditStatus;
begin
  edt_xkbh.Text := '';
end;

end.

