unit uXkPwWorkSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, GridsEh, DBGridEh, DB, DBClient, StdCtrls, Buttons,
  ExtCtrls, pngimage, frxpngimage, Mask, DBCtrlsEh, DBGridEhGrouping, ComCtrls,
  RzTreeVw, RzTabs;

type
  TXkPwWorkSet = class(TForm)
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    Panel2: TPanel;
    btn_Exit: TBitBtn;
    btn_Refresh: TBitBtn;
    ds_Delta: TDataSource;
    cds_Delta: TClientDataSet;
    btn_Add: TBitBtn;
    grp_Yx: TGroupBox;
    cbb_Yx: TDBComboBoxEh;
    Panel1: TPanel;
    RzPageControl1: TRzPageControl;
    TabSheet1: TRzTabSheet;
    LeftTree: TRzTreeView;
    RzPageControl2: TRzPageControl;
    TabSheet2: TRzTabSheet;
    DBGridEh1: TDBGridEh;
    lbl1: TLabel;
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
    procedure LeftTreeClick(Sender: TObject);
  private
    { Private declarations }
    aSf,aKd,aZy,aKm:string;
    function  GetWhere:string;
    procedure Open_DeltaTable;
    procedure GetXkZyList;
    procedure GetYxList;
    procedure InitLeftTreeList;
  public
    { Public declarations }
  end;

var
  XkPwWorkSet: TXkPwWorkSet;

implementation
uses uDM,uSelectZyKmPw;
{$R *.dfm}

procedure TXkPwWorkSet.btn_AddClick(Sender: TObject);
begin
  with TSelectZyKmPw.Create(nil) do
  begin
    SetParam(cbb_Yx.Text,asf,akd,azy,akm,cds_Delta);
    ShowModal;
  end;
end;

procedure TXkPwWorkSet.btn_CancelClick(Sender: TObject);
begin
  cds_Delta.Cancel;
end;

procedure TXkPwWorkSet.btn_DelClick(Sender: TObject);
begin
  if Application.MessageBox('真的要删除当前记录吗？', '系统提示', MB_YESNO + 
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
  Open_DeltaTable;
end;

procedure TXkPwWorkSet.btn_SaveClick(Sender: TObject);
begin
  if IsModified(cds_Delta) then
  begin
    if dm.UpdateData('Id','select top 0 * from 校考考点评委配置表',cds_Delta.Delta,True) then
      cds_Delta.MergeChangeLog;
  end;
end;

procedure TXkPwWorkSet.cbb_YxChange(Sender: TObject);
var
  cds_temp:TClientDataSet;
begin
  if Self.Showing then
  begin
    InitLeftTreeList;
    LeftTree.SetFocus;
    Open_DeltaTable;
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
end;

procedure TXkPwWorkSet.DBGridEh2RowDetailPanelShow(Sender: TCustomDBGridEh;
  var CanShow: Boolean);
begin
  btn_Add.Enabled := True;
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
    if Application.MessageBox('警告！数据已修改但未保存！要保存吗？',
      '系统提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) =
      IDYES then
    begin
      btn_SaveClick(Self);
    end;
  end;
end;

procedure TXkPwWorkSet.FormCreate(Sender: TObject);
begin
  GetYxList;
  InitLeftTreeList;
  Open_DeltaTable;
end;

function TXkPwWorkSet.GetWhere: string;
var
  sWhere:string;
begin
  if cbb_Yx.ItemIndex<>-1 then
    sWhere := ' where 承考院系='+quotedstr(cbb_Yx.Text)
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
    cds_Temp.XMLData := dm.OpenData('select 考试科目 from 校考科目表 '+GetWhere);
    DBGridEh1.Columns[3].PickList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('考试科目').AsString);
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
      //cbb_Yx.Items.Add('不限院系');
      sList.Add('艺术设计学院');
      sList.Add('音乐学院');
      //sList.Add('不限院系');
    end else
      sList.Add(gb_Czy_Dept);
    cbb_Yx.Items.AddStrings(sList);
    cbb_Yx.ItemIndex := 1;
  finally
    sList.Free;
  end;
end;

procedure TXkPwWorkSet.InitLeftTreeList;
var
  sqlStr,sXmmc,sId,sId_Temp:string;
  Rmn,tn,tn2:TTreeNode;
  cds1,cds_Temp,cds_Temp2:TClientDataSet;
begin
  cds1 := TClientDataSet.Create(nil);
  cds_Temp := TClientDataSet.Create(nil);
  cds_Temp2 := TClientDataSet.Create(nil);
  try
    LeftTree.Items.BeginUpdate;
    LeftTree.Items.Clear;

    sqlStr := 'select 专业 from 校考专业表 where 承考院系='+quotedstr(cbb_Yx.Text)+' order by 专业';
    cds_Temp2.XMLData := dm.OpenData(sqlStr);

    sqlStr := 'select distinct 省份 from 校考考点设置表 where 承考院系='+quotedstr(cbb_Yx.Text)+' order by 省份';
    cds1.XMLData := dm.OpenData(sqlStr);

    while not cds1.Eof do
    begin
      sXmmc := Trim(cds1.Fields[0].AsString);
      Rmn := LeftTree.Items.Add(nil,sXmmc);
      Rmn.ImageIndex := 0;

      sqlStr := 'select 考点名称 from 校考考点设置表 where 承考院系='+quotedstr(cbb_Yx.Text)+
                ' and 省份='+quotedstr(sXmmc)+' order by 考点名称';
      cds_Temp.XMLData := dm.OpenData(sqlStr);

      while not cds_Temp.Eof do
      begin
        sXmmc := Trim(cds_Temp.Fields[0].AsString);
        tn := LeftTree.Items.AddChild(Rmn,sXmmc);
        tn.ImageIndex := 1;
        
        cds_Temp2.First;
        while not cds_Temp2.Eof do
        begin
          sXmmc := Trim(cds_Temp2.Fields[0].AsString);
          tn2 := LeftTree.Items.AddChild(tn,sXmmc);
          tn2.ImageIndex := 1;
          cds_Temp2.Next;
        end;
        cds_Temp.Next;
      end;
      cds1.Next;
    end;
    //LeftTree.FullExpand;
    if LeftTree.Items.Count>=2 then
    begin
      LeftTree.Items[1].Expand(True);
      LeftTree.Items[2].Selected := True;
    end;
  finally
    LeftTree.Items.EndUpdate;
    cds1.Free;
    cds_Temp.Free;
    cds_Temp2.Free;
  end;
end;

procedure TXkPwWorkSet.LeftTreeClick(Sender: TObject);
var
  tn:TTreeNode;
begin
  Open_DeltaTable;
end;

procedure TXkPwWorkSet.Open_DeltaTable;
var
  sWhere:string;
  yx,sqlstr:string;
  tn:TTreeNode;
begin
  yx := cbb_yx.Text;
  asf := '';
  akd := '';
  azy := '';
  if (LeftTree.Selected<>nil) then
  begin
    tn := LeftTree.Selected;
    case tn.Level of
      0:
      begin
        asf := tn.Text;
      end;
      1:
      begin
        akd := tn.Text;
        asf := tn.Parent.Text;
      end;
      2:
      begin
        azy := tn.Text;
        akd := tn.Parent.Text;
        asf := tn.Parent.Parent.Text;
      end;
    end;
  end;

  sWhere := ' where 承考院系='+quotedstr(yx)+' and 省份='+quotedstr(asf)+' and 考点名称 like '+quotedstr(akd+'%')+
            ' and 专业 like '+quotedstr(azy+'%');//+' and 科目='+quotedstr(km);
  sqlstr := 'select * from 校考考点评委配置表 '+sWhere+' order by Id';
  cds_Delta.XMLData := DM.OpenData(sqlstr);
  btn_Add.Enabled := azy<>'';
end;


end.
