unit uXkKdBrowse;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TXkKdBrowse = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    DBGridEh1: TDBGridEh;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    btn_print: TBitBtn;
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure GetSfList;
    procedure GetXkZyList;
  public
    { Public declarations }
  end;

var
  XkKdBrowse: TXkKdBrowse;

implementation
uses uDM;
{$R *.dfm}

procedure TXkKdBrowse.btn_AddClick(Sender: TObject);
begin
  ClientDataSet1.Append;
  DBGridEh1.SetFocus;
end;

procedure TXkKdBrowse.btn_CancelClick(Sender: TObject);
begin
  ClientDataSet1.Cancel;
end;

procedure TXkKdBrowse.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKdBrowse.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKdBrowse.btn_SaveClick(Sender: TObject);
begin
  if DataSetNoSave(ClientDataSet1) then
    if dm.UpdateData('Id','select * from У���������ñ� ',ClientDataSet1.Delta) then
      ClientDataSet1.MergeChangeLog;
end;

procedure TXkKdBrowse.cbb_YxChange(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKdBrowse.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKdBrowse.FormCreate(Sender: TObject);
begin
  dm.GetYxList(cbb_Yx);
  Open_Table;
end;

procedure TXkKdBrowse.GetSfList;
begin
end;

function TXkKdBrowse.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where ״̬='+quotedstr('�����')+' and �п�Ժϵ='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where ״̬='+quotedstr('�����');
  Result := sWhere;
end;

procedure TXkKdBrowse.GetXkZyList;
var
  cds_Temp:TClientDataSet;
  sList:TStrings;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select ���Կ�Ŀ from У����Ŀ�� '+GetWhere);
    DBGridEh1.Columns[3].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('���Կ�Ŀ').AsString);
      cds_Temp.Next;
    end;
    DBGridEh1.Columns[3].PickList.AddStrings(sList);
  finally
    sList.Free;
    cds_Temp.Free;
  end;
end;

procedure TXkKdBrowse.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from У���������ñ� '+GetWhere+' order by ʡ��,��������';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
end;

end.
