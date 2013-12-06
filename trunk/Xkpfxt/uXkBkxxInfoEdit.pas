unit uXkBkxxInfoEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox, DBCtrls,
  Spin;

type
  TXkBkxxInfoEdit = class(TForm)
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    edt_Ksh: TDBEditEh;
    btn_Save: TBitBtn;
    lbl3: TLabel;
    edt_zy: TDBComboBoxEh;
    lbl4: TLabel;
    DBEditEh3: TDBDateTimeEditEh;
    lbl5: TLabel;
    DBEditEh4: TDBDateTimeEditEh;
    lbl8: TLabel;
    bvl1: TBevel;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_KshChange(Sender: TObject);
  private
    { Private declarations }
    aYx:string;
    procedure LoadInfoFromIni;
    procedure SaveInfoToIni;
    procedure GetXkZyList;
  public
    { Public declarations }
    procedure SetParam(const yx,Ksh:string;const IsAdd:Boolean);
  end;

implementation
uses uDM,uXkInfoInput,IniFiles;
{$R *.dfm}


procedure TXkBkxxInfoEdit.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkBkxxInfoEdit.btn_SaveClick(Sender: TObject);
var
  cds_Temp:TClientDataSet;
begin
  if (edt_Ksh.Text='') or (edt_zy.Text='') then
  begin
    Application.MessageBox('报考专业不能为空！　', '系统提示', MB_OK + MB_ICONSTOP);
    Exit;
  end;
  cds_Temp := TClientDataSet(edt_Ksh.DataSource.DataSet);
  if IsModified(cds_Temp) then
    if dm.UpdateData('id','select top 0 * from 校考考生报考专业表 ',cds_Temp.Delta) then
    begin
      cds_Temp.MergeChangeLog;
      Self.Close;
    end;
end;

procedure TXkBkxxInfoEdit.edt_KshChange(Sender: TObject);
begin
  btn_Save.Enabled := (edt_Ksh.Text<>'') and (edt_zy.Text<>'');
end;

procedure TXkBkxxInfoEdit.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  edt_Ksh.DataSource.DataSet.Cancel;
  SaveInfoToIni;
end;

procedure TXkBkxxInfoEdit.FormShow(Sender: TObject);
begin
  if edt_Ksh.Enabled then
    edt_Ksh.SetFocus
  else
    edt_zy.SetFocus;
end;

procedure TXkBkxxInfoEdit.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select 专业 from 校考专业表 where 承考院系='+quotedstr(aYx)+' order by 专业');
    edt_zy.Items.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
    edt_zy.Items.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkBkxxInfoEdit.LoadInfoFromIni;
begin
end;

procedure TXkBkxxInfoEdit.SaveInfoToIni;
begin
end;

procedure TXkBkxxInfoEdit.SetParam(const yx,Ksh:string;const IsAdd:Boolean);
var
  vKsh:string;
begin
  aYx := yx;
  GetXkZyList;
  if IsAdd then
  begin
    edt_Ksh.DataSource.DataSet.Append;
    vKsh := ''
  end else
  begin
    edt_Ksh.DataSource.DataSet.Edit;
    vKsh := Ksh;
  end;
  //edt_Ksh.Text := vKsh;
  edt_Ksh.Enabled := IsAdd;
end;

end.

