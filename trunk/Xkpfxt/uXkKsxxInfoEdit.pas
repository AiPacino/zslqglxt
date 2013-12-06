unit uXkKsxxInfoEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, DBCtrls,
  Spin;

type
  TXkKsxxInfoEdit = class(TForm)
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
    lbl4: TLabel;
    DBEditEh3: TDBEditEh;
    DBEditEh4: TDBEditEh;
    lbl6: TLabel;
    DBEditEh5: TDBEditEh;
    lbl7: TLabel;
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
    procedure SetParam(const Ksh:string;const IsAdd:Boolean);
  end;

implementation
uses uDM,uXkInfoInput,IniFiles;
{$R *.dfm}


procedure TXkKsxxInfoEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKsxxInfoEdit.btn_SaveClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  if (edt_Ksh.Text='') or (edt_xm.Text='') then
  begin
    Application.MessageBox('考生号和姓名不能为空！　', '系统提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  cds_Temp := TClientDataSet(edt_Zkzh.DataSource.DataSet);
  if IsModified(cds_Temp) then
    if dm.UpdateData('id','select top 0 * from 校考考生信息表 ',cds_Temp.Delta) then
    begin
      cds_Temp.MergeChangeLog;
      Self.Close;
    end;
end;

procedure TXkKsxxInfoEdit.edt_ZkzhChange(Sender: TObject);
begin
  btn_Save.Enabled := (edt_Ksh.Text<>'') and (edt_Xm.Text<>'');
end;

procedure TXkKsxxInfoEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edt_Zkzh.DataSource.DataSet.Cancel;
  SaveInfoToIni;
end;

procedure TXkKsxxInfoEdit.FormShow(Sender: TObject);
begin
  if (edt_Zkzh.Text='') then
    LoadInfoFromIni;
  if edt_Ksh.Enabled then
    edt_Ksh.SetFocus
  else
    edt_Zkzh.SetFocus;
end;

procedure TXkKsxxInfoEdit.LoadInfoFromIni;
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
    edt_Ksh.Text := Copy(str,1,iLen);
    edt_Ksh.SelStart := edt_Length.Value;
    edt_Ksh.SelLength := 0;
    Free;
  end;
end;

procedure TXkKsxxInfoEdit.SaveInfoToIni;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  if not FileExists(fn) then Exit;
  with TIniFile.Create(fn) do
  begin
    WriteString(Self.Name,'保留查询值',edt_Ksh.Text);
    WriteInteger(Self.Name,'保留位数',edt_Length.Value);
    Free;
  end;
end;

procedure TXkKsxxInfoEdit.SetParam(const Ksh:string;const IsAdd:Boolean);
var
  vKsh:string;
begin
  if IsAdd then
  begin
    edt_Ksh.DataSource.DataSet.Append;
    vKsh := ''
  end else
  begin
    edt_Ksh.DataSource.DataSet.Edit;
    vKsh := Ksh;
  end;
  edt_Ksh.Text := vKsh;
  edt_Ksh.Enabled := IsAdd;
end;

end.

