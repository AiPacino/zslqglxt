unit uFormatZy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrlsEh, ExtCtrls, DB, DBClient;

type
  TFormatZy = class(TForm)
    lbledt_sf: TEdit;
    lbledt_Pc: TEdit;
    lbledt_Zy: TEdit;
    cbb_NewZy: TDBComboBoxEh;
    lbl_NewKl: TLabel;
    btn_OK: TBitBtn;
    btn_Cancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Bevel1: TBevel;
    lbl1: TLabel;
    lbledt_XlCc: TEdit;
    lbl2: TLabel;
    lbledt_kl: TEdit;
    procedure btn_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_NewZyChange(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
  private
    { Private declarations }
    aXlCc:string;
    aDataSet:TClientDataSet;
    aTableName:string;
    procedure SaveData;
  public
    { Public declarations }
    procedure FillData(const vXlCc, vSf, vPc, vKl, vZy: string;cds_Source:TclientDataSet;const sTableName:string);
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TFormatZy.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormatZy.btn_OKClick(Sender: TObject);
var
  sHint:string;
begin
  if not ZyIsEqual(lbledt_Zy.Text,cbb_NewZy.Text) then
  begin
    sHint := 'רҵ�淶����¼ȡרҵ���Ʋ�һ�´ǣ���Ҫִ����һ�����𣿡�';
    if MessageBox(Handle, PChar(sHint), 'ϵͳ��ʾ', MB_YESNO +
      MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      Exit;
    if UpperCase(InputBox('����ȷ��','�����롾OK����ȷ�ϲ�����',''))<>'OK' then
      Exit;
  end else
  begin
    if MessageBox(Handle, 'ȷ��Ҫִ����һ�����𣿡�', 'ϵͳ��ʾ', MB_YESNO +
      MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;
  end;
  SaveData;
end;

procedure TFormatZy.cbb_NewZyChange(Sender: TObject);
begin
  btn_OK.Enabled := cbb_NewZy.Text<>'';
end;

procedure TFormatZy.FillData(const vXlCc, vSf, vPc, vKl, vZy: string;
  cds_Source: TClientDataSet;const sTableName:string);
var
  i: Integer;
  str:string;
begin
  aXlCc := vXlCc;
  aTableName := sTableName;
  lbledt_sf.Text := vSf;
  lbledt_XlCc.Text := vXlCc;
  lbledt_Pc.Text := vPc;
  lbledt_kl.Text := vKl;
  lbledt_Zy.Text := vZy;

  dm.SetZyComboBox(vXlCc,vKl,cbb_NewZy);
  cbb_NewZy.Text := '';
  for i := 0 to cbb_NewZy.Items.Count - 1 do
  begin
    str := cbb_NewZy.Items[i];
    if Pos(vZy,str)>0 then
    begin
      cbb_NewZy.ItemIndex := i;
      Break;
    end;
  end;
  if i>cbb_NewZy.Items.Count - 1 then
  for i := 0 to cbb_NewZy.Items.Count - 1 do
  begin
    str := cbb_NewZy.Items[i];
    if Pos(str,vZy)>0 then
    begin
      cbb_NewZy.ItemIndex := i;
      Break;
    end;
  end;

  aDataSet := cds_Source;
end;

procedure TFormatZy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormatZy.SaveData;
var
  xlcc,sf,pc,kl,zy,sqlstr,sWhere:string;
  iResult :Integer;
begin
  xlcc := lbledt_XlCc.Text;
  sf := lbledt_sf.Text;
  pc := lbledt_pc.Text;
  kl := lbledt_kl.Text;
  zy := lbledt_Zy.Text;

  sWhere := ' where ѧ�����='+quotedstr(xlcc)+' and ¼ȡרҵ='+quotedstr(zy)
            +' and ¼ȡרҵ�淶��=¼ȡרҵ and ���='+quotedstr(kl);
  sqlstr := 'update '+aTableName+' set ¼ȡרҵ�淶��='+quotedstr(cbb_NewZy.Text)+sWhere;
  dm.ExecSql(sqlstr);

  sWhere := ' where ѧ�����='+quotedstr(xlcc)+' and ¼ȡרҵ='+quotedstr(zy)
            +' and ¼ȡרҵ�淶��='+quotedstr(cbb_NewZy.Text)+' and ���='+quotedstr(kl);
  sqlstr := 'select count(*) from '+aTableName+' '+sWhere;
  iResult := vobj.GetRecordCountBySql(sqlstr);

  if iResult>0 then
    vobj.UpdateLqInfo(xlcc);
  MessageBox(Handle, PChar('������ɣ�����'+IntToStr(iResult)+'����¼�����£���'), 'ϵͳ��ʾ',
    MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
end;

end.