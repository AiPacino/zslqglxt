unit uXkPwWorkSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping;

type
  TXkPwWorkSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Save: TBitBtn;
    btn_Refresh: TBitBtn;
    ds_Delta: TDataSource;
    cds_Delta: TClientDataSet;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    btn_Cancel: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    DBGridEh2: TDBGridEh;
    cds_Master: TClientDataSet;
    ds_Master: TDataSource;
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    ds_Zy: TDataSource;
    cds_Zy: TClientDataSet;
    DBGridEh3: TDBGridEh;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure cbb_YxChange(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure DBGridEh2CellClick(Column: TColumnEh);
    procedure DBGridEh3CellClick(Column: TColumnEh);
    procedure btn_DelClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure cds_DeltaBeforeClose(DataSet: TDataSet);
    procedure DBGridEh2RowDetailPanelHide(Sender: TCustomDBGridEh;
      var CanHide: Boolean);
    procedure DBGridEh2RowDetailPanelShow(Sender: TCustomDBGridEh;
      var CanShow: Boolean);
  private
    { Private declarations }
    function  GetWhere:string;
    procedure Open_Table;
    procedure Open_DeltaTable;
    procedure GetXkZyList;
    procedure GetYxList;
  public
    { Public declarations }
  end;

var
  XkPwWorkSet: TXkPwWorkSet;

implementation
uses uDM,uSelectZyKmPw;
{$R *.dfm}

procedure TXkPwWorkSet.btn_AddClick(Sender: TObject);
var
  yx,sf,kd,zy,km:string;
begin
  yx := cds_Master.FieldByName('�п�Ժϵ').AsString;
  sf := cds_Master.FieldByName('ʡ��').AsString;
  kd := cds_Master.FieldByName('��������').AsString;
  zy := cds_zy.FieldByName('רҵ').AsString;
  //km := cds_zy.FieldByName('���Կ�Ŀ').AsString;
{
  with TSelectZyKmPw.Create(nil) do
  begin
    SetParam(yx,sf,kd,zy,km);
    ShowModal;
  end;
}
  with cds_Delta do
  begin
    Append;
    FieldByName('�п�Ժϵ').Value := yx;
    FieldByName('ʡ��').Value := sf;
    FieldByName('��������').Value := kd;
    FieldByName('רҵ').Value := zy;
    FieldByName('�Ƿ�ǩ��').AsBoolean := False;
    //FieldByName('��Ŀ').Value := km;
    DBGridEh1.SetFocus;
  end;
end;

procedure TXkPwWorkSet.btn_CancelClick(Sender: TObject);
begin
  cds_Delta.Cancel;
end;

procedure TXkPwWorkSet.btn_DelClick(Sender: TObject);
begin
  if Application.MessageBox('���Ҫɾ����ǰ��¼��', 'ϵͳ��ʾ', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    cds_Delta.Delete;
  end;
end;

procedure TXkPwWorkSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkPwWorkSet.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkPwWorkSet.btn_SaveClick(Sender: TObject);
begin
  if IsModified(cds_Delta) then
  begin
    if dm.UpdateData('Id','select top 0 * from У��������ί��',cds_Delta.Delta,True) then
      cds_Delta.MergeChangeLog;
  end;
end;

procedure TXkPwWorkSet.cbb_YxChange(Sender: TObject);
var
  cds_temp:TClientDataSet;
begin
  if Self.Showing then
  begin
    Open_Table;
    cds_temp := TClientDataSet.Create(nil);
    try
      cds_temp.XMLData := dm.OpenData('select ��ί from У����ί������ where �п�Ժϵ='+quotedstr(cbb_Yx.Text));
      DBGridEh1.Columns[5].PickList.Clear;
      while not cds_temp.Eof do
      begin
        DBGridEh1.Columns[5].PickList.Add(cds_temp.Fields[0].AsString);
        cds_temp.Next;
      end;
    finally
      cds_temp.Free;
    end;
  end;
end;

procedure TXkPwWorkSet.cds_DeltaBeforeClose(DataSet: TDataSet);
begin
  btn_SaveClick(Self);
end;

procedure TXkPwWorkSet.DBGridEh2CellClick(Column: TColumnEh);
begin
  Open_DeltaTable;
end;

procedure TXkPwWorkSet.DBGridEh2RowDetailPanelHide(Sender: TCustomDBGridEh;
  var CanHide: Boolean);
begin
  btn_Add.Enabled := False;
  btn_Del.Enabled := False;
  btn_Cancel.Enabled := False;
  btn_Save.Enabled := False;
end;

procedure TXkPwWorkSet.DBGridEh2RowDetailPanelShow(Sender: TCustomDBGridEh;
  var CanShow: Boolean);
begin
  btn_Add.Enabled := True;
  btn_Del.Enabled := True;
  btn_Cancel.Enabled := True;
  btn_Save.Enabled := True;
end;

procedure TXkPwWorkSet.DBGridEh3CellClick(Column: TColumnEh);
begin
  Open_DeltaTable;
end;

procedure TXkPwWorkSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkPwWorkSet.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if IsModified(cds_Delta) then
  begin
    if Application.MessageBox('���棡�������޸ĵ�δ���棡Ҫ������',
      'ϵͳ��ʾ', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
      IDYES then
    begin
      btn_SaveClick(Self);
    end;
  end;
end;

procedure TXkPwWorkSet.FormCreate(Sender: TObject);
begin
  GetYxList;
  Open_Table;
  //GetXkZyList;
  Open_DeltaTable;
end;

function TXkPwWorkSet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where �п�Ժϵ='+quotedstr(cbb_Yx.Text)
  else
    sWhere := ' where 1>0';
  Result := sWhere;
end;

procedure TXkPwWorkSet.GetXkZyList;
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

procedure TXkPwWorkSet.GetYxList;
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    cbb_Yx.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      //dm.GetAllYxList(sList);
      //cbb_Yx.Items.Add('����Ժϵ');
      sList.Add('�������ѧԺ');
      sList.Add('����ѧԺ');
      //sList.Add('����Ժϵ');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TXkPwWorkSet.Open_DeltaTable;
var
  sWhere:string;
  sqlstr:string;
  yx,sf,kd,zy,km:string;
begin
  yx := cds_Master.FieldByName('�п�Ժϵ').AsString;
  sf := cds_Master.FieldByName('ʡ��').AsString;
  kd := cds_Master.FieldByName('��������').AsString;
  zy := cds_zy.FieldByName('רҵ').AsString;
  //km := cds_zy.FieldByName('���Կ�Ŀ').AsString;

  sWhere := ' where �п�Ժϵ='+quotedstr(yx)+' and ʡ��='+quotedstr(sf)+' and ��������='+quotedstr(kd)+
            ' and רҵ='+quotedstr(zy);//+' and ��Ŀ='+quotedstr(km);
  sqlstr := 'select * from У��������ί�� '+sWhere+' order by Id';
  cds_Delta.XMLData := DM.OpenData(sqlstr);
end;

procedure TXkPwWorkSet.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select ʡ��,��������,�п�Ժϵ from У���������ñ� '+GetWhere+' order by ʡ��,��������';
  cds_Master.XMLData := DM.OpenData(sqlstr);

  //sqlstr := 'select �п�Ժϵ,רҵ,���Կ�Ŀ from У��רҵ��Ŀ�� '+GetWhere+' order by רҵ,���Կ�Ŀ';
  sqlstr := 'select �п�Ժϵ,רҵ from У��רҵ�� '+GetWhere+' order by רҵ';
  cds_Zy.XMLData := DM.OpenData(sqlstr);
  //GetXkZyList;
end;

end.
