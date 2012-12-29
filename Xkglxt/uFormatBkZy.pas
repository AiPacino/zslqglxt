unit uFormatBkZy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrlsEh, ExtCtrls, DB, DBClient;

type
  TFormatBkZy = class(TForm)
    lbledt_Zy: TEdit;
    cbb_NewZy: TDBComboBoxEh;
    lbl_NewKl: TLabel;
    btn_OK: TBitBtn;
    btn_Cancel: TBitBtn;
    Label3: TLabel;
    Bevel1: TBevel;
    lbl_1: TLabel;
    lbl_2: TLabel;
    lbl_lbl1: TLabel;
    edt_sf: TEdit;
    edt_Kd: TEdit;
    edt_Yx: TEdit;
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
    procedure SetZyComboBox(const vYx:string);
  public
    { Public declarations }
    procedure FillData(const vSf, vYx, vKd, vZy: string;cds_Source:TClientDataSet);
  end;

implementation
uses uDM;
{$R *.dfm}

procedure TFormatBkZy.btn_CancelClick(Sender: TObject);
begin
  Close;
end;

procedure TFormatBkZy.btn_OKClick(Sender: TObject);
var
  sHint:string;
begin
{
  if not ZyIsEqual(lbledt_Zy.Text,cbb_NewZy.Text) then
  begin
    //sHint := '专业规范名和录取专业名称不一致辞！还要执行这一操作吗？　';
    if MessageBox(Handle, PChar(sHint), '系统提示', MB_YESNO +
      MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      Exit;
    if UpperCase(InputBox('操作确认','请输入【OK】以确认操作：',''))<>'OK' then
      Exit;
  end else
}
  begin
    sHint := '真的要把原专业名称替换成新的专业名吗？这一操作执行后是无法撤消的，'+#13+'还要执行这一操作吗？　';
    if MessageBox(Handle, PChar(sHint), '系统提示', MB_YESNO +
      MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;
  end;
  SaveData;
end;

procedure TFormatBkZy.cbb_NewZyChange(Sender: TObject);
begin
  btn_OK.Enabled := (cbb_NewZy.Text<>'') and (cbb_NewZy.Text<>lbledt_Zy.Text);
end;

procedure TFormatBkZy.FillData(const vSf, vYx, vKd, vZy: string;cds_Source:TClientDataSet);
var
  i: Integer;
  str:string;
begin
  edt_sf.Text := vSf;
  edt_Yx.Text := vYx;
  edt_Kd.Text := vKd;
  lbledt_Zy.Text := vZy;

  SetZyComboBox(vYx);
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

procedure TFormatBkZy.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TFormatBkZy.SaveData;
var
  zy1,zy2:string;
  iResult:Integer;
begin
  iResult := 0;
  zy1 := lbledt_Zy.Text;
  zy2 := cbb_NewZy.Text;
  if zy1=zy2 then Exit;

  aDataSet.First;
  while not aDataSet.Eof do
  begin
    if aDataSet.FieldByName('专业').AsString=zy1 then
    begin
      aDataSet.Edit;
      aDataSet.FieldByName('专业').AsString := zy2;
      aDataSet.Post;
      iResult := iResult + 1;
    end;
    aDataSet.Next;
  end;
  if iResult>0 then
  begin
    if dm.UpdateData('id','select top * from 校考考生报考专业表',aDataSet.Delta,False) then
       aDataSet.MergeChangeLog;
    MessageBox(Handle, PChar('操作完成！共有'+IntToStr(iResult)+'条记录被更新！　'), '系统提示',
    MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  end;
end;

procedure TFormatBkZy.SetZyComboBox(const vYx: string);
var
  sqlstr:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select 专业 from 校考专业表 where 承考院系='+quotedstr(vYx);
    cds_Temp.XMLData := dm.OpenData(sqlstr,False);
    cbb_NewZy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      cbb_NewZy.Items.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;

end;

end.
