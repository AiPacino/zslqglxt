unit uXkInfoEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, DBCtrls,
  Spin;

type
  TXkInfoEdit = class(TForm)
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edt_Ksh: TDBEditEh;
    Label2: TLabel;
    edt_Xm: TDBEditEh;
    Label3: TLabel;
    Label8: TLabel;
    edt_Sfzh: TDBEditEh;
    btn_Save: TBitBtn;
    Label4: TLabel;
    edt_Zkzh: TDBEditEh;
    lbl2: TLabel;
    lbl3: TLabel;
    edt_zy: TDBComboBoxEh;
    lbl4: TLabel;
    DBEditEh3: TDBEditEh;
    lbl5: TLabel;
    DBEditEh4: TDBEditEh;
    lbl6: TLabel;
    DBEditEh5: TDBEditEh;
    lbl7: TLabel;
    lbl8: TLabel;
    cbb_1: TDBComboBoxEh;
    lbl_Len: TLabel;
    edt_Length: TDBNumberEditEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_ZkzhChange(Sender: TObject);
  private
    { Private declarations }
    procedure LoadInfoFromIni;
    procedure SaveInfoToIni;
  public
    { Public declarations }
    procedure SetParam(const Zkzh:string;const IsAdd:Boolean);
  end;

implementation
uses uDM,uXkInfoInput,IniFiles;
{$R *.dfm}


procedure TXkInfoEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkInfoEdit.btn_SaveClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  if (edt_Zkzh.Text='') or (edt_xm.Text='') or (edt_zy.Text='') then
  begin
    Application.MessageBox('准考证号、姓名和报考专业不能为空！　', '系统提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  cds_Temp := TClientDataSet(edt_Zkzh.DataSource.DataSet);
  if IsModified(cds_Temp) then
    if dm.UpdateData('id','select top 0 * from 校考考生报考专业表 ',cds_Temp.Delta) then
    begin
      cds_Temp.MergeChangeLog;
      Self.Close;
    end;
end;

procedure TXkInfoEdit.edt_ZkzhChange(Sender: TObject);
begin
  btn_Save.Enabled := (edt_Zkzh.Text<>'') and (edt_Xm.Text<>'') and (edt_zy.Text<>'');
end;

procedure TXkInfoEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edt_Zkzh.DataSource.DataSet.Cancel;
  SaveInfoToIni;
end;

procedure TXkInfoEdit.FormShow(Sender: TObject);
begin
  if (edt_Zkzh.Text='') then
    LoadInfoFromIni;
  if edt_Zkzh.Enabled then
    edt_Zkzh.SetFocus
  else
    edt_Ksh.SetFocus;
end;

procedure TXkInfoEdit.LoadInfoFromIni;
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
    edt_Zkzh.Text := Copy(str,1,iLen);
    edt_Zkzh.SelStart := edt_Length.Value;
    edt_Zkzh.SelLength := 0;
    Free;
  end;
end;

procedure TXkInfoEdit.SaveInfoToIni;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  if not FileExists(fn) then Exit;
  with TIniFile.Create(fn) do
  begin
    WriteString(Self.Name,'保留查询值',edt_Zkzh.Text);
    WriteInteger(Self.Name,'保留位数',edt_Length.Value);
    Free;
  end;
end;

procedure TXkInfoEdit.SetParam(const Zkzh:string;const IsAdd:Boolean);
var
  vzkzh:string;
begin
  if IsAdd then
  begin
    edt_Zkzh.DataSource.DataSet.Append;
    vzkzh := ''
  end else
  begin
    edt_Zkzh.DataSource.DataSet.Edit;
    vzkzh := Zkzh;
  end;
  edt_Zkzh.Text := vzkzh;
  edt_Zkzh.Enabled := IsAdd;
end;

end.

