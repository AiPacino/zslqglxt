unit uZsjhBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TZsjhBrowse = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    grp_Yx: TGroupBox;
    cbb_XlCc: TDBComboBoxEh;
    btn_print: TBitBtn;
    GroupBox2: TGroupBox;
    lst_Sf: TListBox;
    GroupBox3: TGroupBox;
    DBGridEh1: TDBGridEh;
    GroupBox1: TGroupBox;
    cbb_Lb: TDBComboBoxEh;
    img_Hint: TImage;
    GroupBox4: TGroupBox;
    cbb_KL: TDBComboBoxEh;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_XlCcChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure lst_SfClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
    procedure GetZyList;
  public
    { Public declarations }
  end;

var
  ZsjhBrowse: TZsjhBrowse;

implementation
uses uDM;
{$R *.dfm}

procedure TZsjhBrowse.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TZsjhBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TZsjhBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TZsjhBrowse.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from view_分省专业计划表 ',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TZsjhBrowse.cbb_XlCcChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TZsjhBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TZsjhBrowse.FormCreate(Sender: TObject);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.SetXlCcComboBox(cbb_Xlcc);
    dm.SetLbComboBox(cbb_Lb,True);
    dm.SetKlComboBox(cbb_KL,True);
    
    dm.GetSfList(sList,True);
    lst_Sf.Items.Assign(sList);
    lst_Sf.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TZsjhBrowse.FormShow(Sender: TObject);
begin
  Open_Table;
end;

procedure TZsjhBrowse.GetSfList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    dm.GetSfList(sList);
    lst_Sf.Clear;
    //lst_Sf.Items.Add('==不限==');
    lst_Sf.Items.AddStrings(sList);
    lst_Sf.ItemIndex := 0;

  finally
    sList.Free;
  end;
end;

function TZsjhBrowse.GetWhere: string;
begin
  Result := ' where 学历层次='+quotedstr(cbb_XlCc.Text);
  if (lst_Sf.ItemIndex>0) then
    Result := Result + ' and 省份='+quotedstr(lst_Sf.Items[lst_Sf.ItemIndex]);
  if cbb_Lb.Text<>'全部' then
    Result := Result + ' and 类别='+quotedstr(cbb_Lb.Text);
  if cbb_KL.Text<>'全部' then
    Result := Result + ' and 科类='+quotedstr(cbb_Kl.Text);
end;

procedure TZsjhBrowse.GetZyList;
begin
end;

procedure TZsjhBrowse.lst_SfClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TZsjhBrowse.Open_Table;
var
  sqlstr:string;
begin
  if Self.Showing then
  begin
    sqlstr := 'select * from view_分省专业计划表 '+GetWhere+' order by 省份,专业';
    ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  end;
end;

end.
