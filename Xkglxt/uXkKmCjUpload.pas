unit uXkKmCjUpload;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBFieldComboBox,
  DBGridEhGrouping,uXkKmCjEdit, Menus;

type
  TXkKmCjUpload = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    DataSource1: TDataSource;
    ClientDataSet1: TClientDataSet;
    btn_Refresh: TBitBtn;
    btn_Post: TBitBtn;
    pm1: TPopupMenu;
    L1: TMenuItem;
    C1: TMenuItem;
    T1: TMenuItem;
    P1: TMenuItem;
    E1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    mi_Delete: TMenuItem;
    rg_UpLoad: TRadioGroup;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    grp1: TGroupBox;
    cbb_Km: TDBComboBoxEh;
    DBGridEh1: TDBGridEh;
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_RefreshClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1ColEnter(Sender: TObject);
    procedure btn_PostClick(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure rg_UpLoadClick(Sender: TObject);
    procedure mi_DeleteClick(Sender: TObject);
  private
    { Private declarations }
    fCjIndex,fBL_1,fBL_2:Integer;
    fYx,fSf,fKm:string;
    function  GetWhere:string;
    procedure Open_Table;
    procedure CheckData;
    procedure UpLoadCj;
  public
    { Public declarations }
    procedure SetYxSfKmValue(const Yx,Sf,Km:string);
    procedure SetFieldValue(const iCjIndex:Integer;const sCjField,sCzyField:string);
  end;

var
  XkKmCjUpload: TXkKmCjUpload;

implementation
uses uDM,CnProgressFrm;
{$R *.dfm}

procedure TXkKmCjUpload.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TXkKmCjUpload.btn_PostClick(Sender: TObject);
var
  sqlstr,sError:string;
begin
  if MessageBox(Handle, '已录入成绩上传后将不能再进行修改！　' +
    #13#10 + '确定要上传吗？', '系统提示', MB_YESNO + MB_ICONWARNING +
    MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  ShowProgress('正在上传...',ClientDataSet1.RecordCount);
  try
    ClientDataSet1.DisableControls;
    ClientDataSet1.First;
    while not ClientDataSet1.Eof do
    begin
      UpdateProgress(ClientDataSet1.RecNo);
      if not vobj.UpLoadInputCj(ClientDataSet1.FieldByName('Id').AsInteger,sError) then
        Exit;

      ClientDataSet1.Next;
    end;

    if sError='' then
    begin
      MessageBox(Handle, '当前成绩数据上传成功，已上传成绩不能再进行修改了！　',
      '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
      //ClientDataSet1.MergeChangeLog;
      Open_Table;
    end else
    begin
      MessageBox(Handle, PChar('成绩数据上传失败，请检查后重试！'+#13+sError),
        '系统提示', MB_OK + MB_ICONERROR + MB_TOPMOST);
    end;
  finally
    HideProgress;
    ClientDataSet1.EnableControls;
  end;
end;

procedure TXkKmCjUpload.btn_RefreshClick(Sender: TObject);
begin
  Open_Table;
end;

procedure TXkKmCjUpload.CheckData;
begin
end;

procedure TXkKmCjUpload.DataSource1DataChange(Sender: TObject; Field: TField);
begin
  mi_Delete.Enabled := (rg_UpLoad.ItemIndex=0) and (ClientDataSet1.RecordCount>0);
  btn_Post.Enabled := (rg_UpLoad.ItemIndex=0) and (ClientDataSet1.RecordCount>0);
  //btn_Post.Enabled := ClientDataSet1.RecordCount>0;
                      //(ClientDataSet1.ChangeCount>0);
end;

procedure TXkKmCjUpload.DBGridEh1ColEnter(Sender: TObject);
begin
  DBGridEh1.SelectedIndex := 7;
end;

procedure TXkKmCjUpload.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TXkKmCjUpload.FormShow(Sender: TObject);
begin
  if not vobj.GetCjInputInfo(gb_Czy_ID,fYx,fKm,fCjIndex) then
  begin
    MessageBox(Handle, '录入员成绩录入配置信息读取失败！　', '系统提示', MB_OK
      + MB_ICONSTOP + MB_TOPMOST);
  end else
  begin
    Self.Caption := fYx+'【'+fKm+'】第'+IntTostr(fCjIndex)+'组成绩录入';
    if gb_Czy_Dept='音乐学院' then
    begin
      fBL_1 := 80;
      fBL_2 := 20;
    end else
    begin
      fBL_1 := 100;
      fBL_2 := 0;
    end;
    dm.SetXkYxComboBox(cbb_Yx);
    cbb_Km.Text := fKm;
    Open_Table;
  end;
end;

function TXkKmCjUpload.GetWhere: string;
var
  sWhere:string;
begin
  sWhere := ' where 承考院系='+quotedstr(gb_Czy_Dept)+' and 录入员='+quotedstr(gb_Czy_ID)+
            ' and 考试科目='+quotedstr(cbb_Km.Text)+
            ' and 是否提交='+IntToStr(rg_UpLoad.ItemIndex);
  Result := sWhere;
end;

procedure TXkKmCjUpload.mi_DeleteClick(Sender: TObject);
begin
  if Application.MessageBox('真的要删除当前成绩记录吗？　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  if not ClientDataSet1.FieldByName('是否提交').AsBoolean then
  begin
    ClientDataSet1.Delete;
    UpLoadCj;
  end;
end;

procedure TXkKmCjUpload.Open_Table;
var
  sqlstr:string;
begin
  sqlstr := 'select * from view_校考卷面成绩录入表 '+GetWhere+' order by 考生号';
  ClientDataSet1.XMLData := DM.OpenData(sqlstr);
  if Self.Showing then
    DBGridEh1.SetFocus;
end;

procedure TXkKmCjUpload.rg_UpLoadClick(Sender: TObject);
begin
  btn_Post.Enabled := (rg_UpLoad.ItemIndex=0) and (ClientDataSet1.RecordCount>0);
  if Self.Showing then
    Open_Table;
end;

procedure TXkKmCjUpload.SetFieldValue(const iCjIndex:Integer;const sCjField, sCzyField: string);
begin
end;

procedure TXkKmCjUpload.SetYxSfKmValue(const Yx, Sf, Km: string);
begin
  fYx := Yx;
  fSf := Sf;
  fKm := Km;
end;

procedure TXkKmCjUpload.UpLoadCj;
begin
  CheckData;
  if DataSetNoSave(ClientDataSet1) then
  begin
    if dm.UpdateData('Id','select * from 校考卷面成绩录入表 where 1=0',ClientDataSet1.Delta,False) then
    begin
      //ClientDataSet1.MergeChangeLog;
      Open_Table;
    end;
  end;
end;

end.
