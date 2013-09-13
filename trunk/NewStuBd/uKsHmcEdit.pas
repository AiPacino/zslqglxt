unit uKsHmcEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, DBCtrls,
  Spin;

type
  TKsHmcEdit = class(TForm)
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edt_ksh: TDBEditEh;
    Label2: TLabel;
    edt_xm: TDBEditEh;
    Label3: TLabel;
    edt_xb: TDBEditEh;
    Label7: TLabel;
    edt_sf: TDBEditEh;
    Label8: TLabel;
    edt_lqzy: TDBEditEh;
    btn_Save: TBitBtn;
    lbl_Cj: TLabel;
    edt_RowNo: TDBNumberEditEh;
    Label4: TLabel;
    edt_zkzh: TDBEditEh;
    lbl_pw: TLabel;
    edt_PageNo: TDBNumberEditEh;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl_Len: TLabel;
    cbb_Field: TDBComboBoxEh;
    edt_Value: TEdit;
    btn_Search: TBitBtn;
    Bevel1: TBevel;
    edt_Length: TDBNumberEditEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SearchClick(Sender: TObject);
    procedure edt_ValueKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ValueChange(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure edt_RowNoKeyPress(Sender: TObject; var Key: Char);
    procedure edt_RowNoChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_PageNoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    aDataSet:TClientDataSet;
    procedure LoadInfoFromIni;
    procedure SaveInfoToIni;
    procedure SetDBEditStatus(const bFound:Boolean);
    procedure SaveData;
  public
    { Public declarations }
    procedure SetData(const ksh:string;DataSet:TClientDataSet);
  end;

implementation
uses uDM,IniFiles;
{$R *.dfm}


procedure TKsHmcEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TKsHmcEdit.btn_SaveClick(Sender: TObject);
var
  sError:string;
  iLen:Integer;
begin
  if (edt_RowNo.Text='') or (edt_PageNo.Text='') then
  begin
    Application.MessageBox('ҳ����к����ݲ���Ϊ�գ���', 'ϵͳ��ʾ', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  SaveData;
  edt_RowNo.Text := IntToStr(StrToIntDef(edt_RowNo.Text,0)+1);
  btn_Save.Enabled := False;
  iLen := edt_Length.Value;
  edt_Value.Text := Copy(edt_Value.Text,1,iLen);
  edt_Value.SelStart := edt_Length.Value;
  edt_Value.SelLength := 0;
  edt_Value.SetFocus;
end;

procedure TKsHmcEdit.btn_SearchClick(Sender: TObject);
var
  bl:Boolean;
  sText,ksh,sError:string;
begin
  if Trim(edt_Value.Text)='' then Exit;
  sText := Trim(edt_Value.Text);
  bl := aDataSet.Locate(cbb_Field.Text,VarArrayOf([sText]),[]);
  SetDBEditStatus(bl);
  if not bl then
  begin
    MessageBox(Handle, PChar('�ÿ�����Ϣ�����ڣ�����������ԣ���'),
      'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    edt_Value.SetFocus;
    Exit;
  end else
  begin
    if edt_PageNo.Text='' then
      edt_PageNo.SetFocus
    else
    begin
      edt_RowNo.SetFocus;
    end;
    edt_RowNoChange(Self);
  end;
end;

procedure TKsHmcEdit.edt_PageNoKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    edt_RowNo.SetFocus;
end;

procedure TKsHmcEdit.edt_RowNoChange(Sender: TObject);
begin
  btn_Save.Enabled := (edt_RowNo.Text<>'') and (edt_PageNo.Text<>'');
end;

procedure TKsHmcEdit.edt_RowNoKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key=#13) and btn_Save.Enabled then
  begin
    btn_Save.SetFocus;
    btn_SaveClick(Self);
  end;
end;

procedure TKsHmcEdit.edt_ValueChange(Sender: TObject);
begin
  lbl_Len.Caption := '('+IntToStr(Length(edt_Value.Text))+')';
end;

procedure TKsHmcEdit.edt_ValueKeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
    btn_Search.Click;
end;

procedure TKsHmcEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveInfoToIni;
end;

procedure TKsHmcEdit.FormShow(Sender: TObject);
begin
  SetDBEditStatus(False);
  if edt_Value.Text='' then
    LoadInfoFromIni;
  edt_Value.SetFocus;
end;

procedure TKsHmcEdit.LoadInfoFromIni;
var
  fn,str:string;
  iLen:Integer;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  if not FileExists(fn) then Exit;
  with TIniFile.Create(fn) do
  begin
    str := ReadString(Self.Name,'������ѯֵ','');
    edt_Length.Value := ReadInteger(Self.Name,'����λ��',0);
    iLen := edt_Length.Value;
    edt_Value.Text := Copy(str,1,iLen);
    edt_Value.SelStart := edt_Length.Value;
    edt_Value.SelLength := 0;
    Free;
  end;
end;

procedure TKsHmcEdit.SaveData;
begin
  aDataSet.Edit;
  aDataSet.FieldByName('������ҳ��').AsString := edt_PageNo.Text;
  aDataSet.FieldByName('�������к�').AsString := edt_RowNo.Text;
  aDataSet.Post;
end;

procedure TKsHmcEdit.SaveInfoToIni;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  if not FileExists(fn) then Exit;
  with TIniFile.Create(fn) do
  begin
    WriteString(Self.Name,'������ѯֵ',edt_Value.Text);
    WriteInteger(Self.Name,'����λ��',edt_Length.Value);
    Free;
  end;
end;

procedure TKsHmcEdit.SetData(const ksh: string;DataSet:TClientDataSet);
begin
  aDataSet := DataSet;
  cbb_Field.Text := '������';
  edt_Value.Text := ksh;
  SetDBEditStatus(False);
end;

procedure TKsHmcEdit.SetDBEditStatus(const bFound:Boolean);
begin
  if bFound then
  begin
    with aDataSet do
    begin
      edt_ksh.Text := FieldByName('������').Value;
      edt_sf.Text := FieldByName('ʡ��').Value;
      edt_zkzh.Text := FieldByName('׼��֤��').Value;
      edt_lqzy.Text := FieldByName('¼ȡרҵ�淶��').Value;
      edt_xm.Text := FieldByName('��������').Value;
      edt_xb.Text := FieldByName('�Ա�').Value;
      if FieldByName('������ҳ��').AsString<>'' then
        edt_PageNo.Text := FieldByName('������ҳ��').AsString;
      if FieldByName('�������к�').AsString<>'' then
        edt_RowNo.Text := FieldByName('�������к�').AsString;
  end;
  end else
  begin
    edt_ksh.Text := '';
    edt_sf.Text := '';
    edt_zkzh.Text := '';
    edt_lqzy.Text := '';
    edt_xm.Text := '';
    edt_xb.Text := '';
  end;
end;

end.

