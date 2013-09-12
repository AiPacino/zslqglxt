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
    chk_OnlySf: TCheckBox;
    lbledt_zydm: TEdit;
    lbl3: TLabel;
    lbledt_Lb: TEdit;
    lbl4: TLabel;
    edt_oldzygfm: TEdit;
    procedure btn_CancelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbb_NewZyChange(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure chk_OnlySfClick(Sender: TObject);
  private
    { Private declarations }
    aXlCc:string;
    aDataSet:TClientDataSet;
    aTableName:string;
    function FormatZymc:Boolean;
    procedure InitNewZyList;
  public
    { Public declarations }
    procedure FillData(const vXlCc, vSf, vPc, vLb, vKl, vZydm, vZy, vZygfm: string;cds_Source:TclientDataSet;const sTableName:string);
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
    sHint := '专业规范名和录取专业名称不一致！还要执行这一操作吗？　';
    if MessageBox(Handle, PChar(sHint), '系统提示', MB_YESNO +
      MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      Exit;
    if UpperCase(InputBox('操作确认','请输入【OK】以确认操作：',''))<>'OK' then
      Exit;
  end;
  if FormatZymc then
    Self.ModalResult := mrOk
  else
    Self.ModalResult := mrCancel;
end;

procedure TFormatZy.cbb_NewZyChange(Sender: TObject);
begin
  btn_OK.Enabled := cbb_NewZy.Text<>'';
end;

procedure TFormatZy.chk_OnlySfClick(Sender: TObject);
begin
  InitNewZyList;
end;

procedure TFormatZy.FillData(const vXlCc, vSf, vPc, vLb, vKl, vZydm, vZy,vZygfm: string;
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
  lbledt_Lb.Text := vLb;
  lbledt_kl.Text := vKl;
  lbledt_zydm.Text := vZydm;
  lbledt_Zy.Text := vZy;
  edt_oldZygfm.Text := vZygfm;

  InitNewZyList;
  
  aDataSet := cds_Source;
end;

procedure TFormatZy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormatZy.InitNewZyList;
var
  i:integer;
  str,vZydm,vZy:string;
begin
  cbb_NewZy.Items.Clear;
  cbb_NewZy.KeyItems.Clear;
  cbb_NewZy.Text := '';
  vZydm := lbledt_zydm.Text;
  vZy := lbledt_Zy.Text;
  //if chk_OnlySf.Checked then
    dm.SetZyComboBox(lbledt_XlCc.Text,lbledt_Lb.Text,lbledt_sf.Text,cbb_NewZy);
  //else
  //  dm.SetZyComboBox(lbledt_XlCc.Text,lbledt_kl.Text,'',cbb_NewZy);

  cbb_NewZy.Text := '';
  for i := 0 to cbb_NewZy.Items.Count - 1 do
  begin
    str := cbb_NewZy.Items[i];
    //if vZy=str then
    if ZyIsEqual(vZy,str,True) then //精确比较
    begin
      cbb_NewZy.ItemIndex := i;
      Break;
    end;
  end;
  if i>cbb_NewZy.Items.Count - 1 then
  for i := 0 to cbb_NewZy.Items.Count - 1 do
  begin
    str := cbb_NewZy.Items[i];
    if ZyIsEqual(vZy,str) then
    begin
      cbb_NewZy.ItemIndex := i;
      Break;
    end;
  end;
end;

function TFormatZy.FormatZymc:Boolean;
var
  xlcc,sf,pc,lb,kl,zydm,zy,oldzygfm,sqlstr,sWhere:string;
  iResult :Integer;
begin
  Result := False;
  xlcc := lbledt_XlCc.Text;
  sf := lbledt_sf.Text;
  pc := lbledt_pc.Text;
  lb := lbledt_Lb.Text;
  kl := lbledt_kl.Text;
  zydm := lbledt_zydm.Text;
  zy := lbledt_Zy.Text;
  oldzygfm := edt_oldzygfm.Text;

  sWhere := ' where 学历层次='+quotedstr(xlcc)+' and 录取代码='+quotedstr(zydm)
            //+' and 类别='+quotedstr(lb);
            +' and 录取专业规范名='+quotedstr(oldzygfm)+' and 科类名称='+quotedstr(kl);
  if chk_OnlySf.Checked then
    sWhere := sWhere+' and 省份='+quotedstr(lbledt_sf.Text);

  sqlstr := 'select count(*) from '+aTableName+' '+sWhere;
  iResult := vobj.GetRecordCountBySql(sqlstr);

  if iResult>0 then
  begin
    if MessageBox(Handle, PChar('共有'+IntToStr(iResult)+'条记录将被更新！确定要执行这一操作吗？　'), '系统提示', MB_YESNO +
      MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
    begin
      sqlstr := 'update '+aTableName+' set 录取专业规范名='+quotedstr(cbb_NewZy.Text)+sWhere;
      dm.ExecSql(sqlstr);
      vobj.UpdateLqInfo(xlcc);
      MessageBox(Handle, PChar('操作完成！共有'+IntToStr(iResult)+'条记录被更新！　'), '系统提示',
        MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
      Result := True;
    end;
  end else
  begin
    MessageBox(Handle, '没有满足条件的记录可以更新　', '系统提示', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);
    Exit;
  end;

end;

end.
