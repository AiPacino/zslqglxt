unit uCzyRightGroupSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, GridsEh, DBGridEh, DB, DBClient,
  Menus, ComCtrls, RzTreeVw, ImgList, CheckLst, RzPanel, pngimage,
  frxpngimage, DBGridEhGrouping;

type
  TCzyRightGroupSet = class(TForm)
    pnl1: TPanel;
    btn_Close: TBitBtn;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    cds_Temp: TClientDataSet;
    cds_Master: TClientDataSet;
    ds_Master: TDataSource;
    il_small: TImageList;
    cds_GroupRight: TClientDataSet;
    cds1: TClientDataSet;
    btn_Post: TBitBtn;
    N4: TMenuItem;
    N5: TMenuItem;
    bvl1: TBevel;
    GroupBox1: TRzGroupBox;
    chklst1: TCheckListBox;
    RightChkTree: TRzCheckTree;
    RzGroupBox1: TRzGroupBox;
    DBGridEh2: TDBGridEh;
    pnl2: TPanel;
    btn_Add: TBitBtn;
    btn_Del: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    procedure Btn_CloseClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_AddClick(Sender: TObject);
    procedure edt_groupNameChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_DelClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ds_MasterDataChange(Sender: TObject; Field: TField);
    procedure btn_PostClick(Sender: TObject);
    procedure cds_MasterAfterPost(DataSet: TDataSet);
    procedure N5Click(Sender: TObject);
  private
    { Private declarations }
    Old_Id:string;
    procedure InitRightTree;
    procedure Open_Master;
    procedure Open_Delta;
    function  Update_Master:Boolean;
    function  Update_Delta(const sId:string):Boolean;
    procedure SetChecked(const CheckType:Integer);
    procedure InitMenuItemCheck(const sId:string);
  public
    { Public declarations }
  end;

var
  CzyRightGroupSet: TCzyRightGroupSet;

implementation
uses uDM;
{$R *.dfm}

procedure TCzyRightGroupSet.btn_AddClick(Sender: TObject);
begin
  cds_Master.DisableControls;
  try
    cds_Master.Append;
    cds_Master.FieldByName('ID').AsInteger := cds_Master.RecordCount+1;
    cds_Master.FieldByName('权限组名称').AsString := '权限组'+IntToStr(cds_Master.RecordCount+1);
    cds_Master.Post;
    DBGridEh2.ReadOnly := False;
    DBGridEh2.SetFocus;
    DBGridEh2.SelectedIndex := 1;
  finally
    cds_Master.EnableControls;
  end;
end;

procedure TCzyRightGroupSet.btn_CloseClick(Sender: TObject);
begin
  Close;
end;

procedure TCzyRightGroupSet.btn_DelClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要删除当前权限组吗？　　', '系统提示', MB_YESNO + 
    MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    cds_Master.Delete;
    cds_GroupRight.MergeChangeLog;
    btn_Post.Click;
  end;

end;

procedure TCzyRightGroupSet.btn_PostClick(Sender: TObject);
var
  sId:string;
  bl:Boolean;
begin
  bl := Update_Master;
  if bl then
    bl := Update_Delta(sId);
  if bl then
     MessageBox(Handle, '权限组权限配置成功！　　', '系统提示', MB_OK +
       MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST)
  else
     MessageBox(Handle, '权限组权限配置失败！请重新配置！　　', '系统提示',
       MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);

end;

procedure TCzyRightGroupSet.btn_SaveClick(Sender: TObject);
begin
  if cds_Master.ChangeCount>0 then
    if dm.UpdateData('ID','select top 1 * from 权限组表',cds_Master.Delta,False) then
      cds_Master.MergeChangeLog
    else
      Exit;
{
  UpdateRight(cds_Master.FieldByName('权限组名称').AsString);
  if SaveRight(edt_groupName.Text) then
     MessageBox(Handle, '当前权限组权限设置成功！　　', '系统提示', MB_OK +
       MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST)
  else
     MessageBox(Handle, '权限组权限保存失败！请重新保存！　　', '系统提示',
       MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
}
end;

procedure TCzyRightGroupSet.cds_MasterAfterPost(DataSet: TDataSet);
begin
  Update_Master;
end;

procedure TCzyRightGroupSet.DBGridEh1CellClick(Column: TColumnEh);
begin
  if Column.Index=0 then
  begin
    cds1.Edit;
    cds1.FieldByName('chk').AsBoolean := not cds1.FieldByName('chk').AsBoolean;
    cds1.Post;
  end;
end;

procedure TCzyRightGroupSet.ds_MasterDataChange(Sender: TObject; Field: TField);
var
  sId:string;
begin
  sId := cds_Master.FieldByName('ID').AsString;
  if (Old_Id<>'') then
  begin
    Update_Delta(Old_Id);
  end;
  if sId<>'' then
    cds_GroupRight.XMLData := dm.OpenData('select * from 权限组明细表 where pid='+sId)
  else
    cds_GroupRight.XMLData := dm.OpenData('select * from 权限组明细表 where 1=2');

  InitMenuItemCheck(sId);
  Old_Id := sId;
end;

procedure TCzyRightGroupSet.edt_groupNameChange(Sender: TObject);
begin
  btn_Add.Enabled := TEdit(Sender).Text<>'';
  btn_Del.Enabled := TEdit(Sender).Text<>'';
end;

procedure TCzyRightGroupSet.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cds1.Close;
  cds_Temp.Close;
end;

procedure TCzyRightGroupSet.FormCreate(Sender: TObject);
begin
  Old_Id := '';
  InitRightTree;
  Open_Master;
  //Open_Delta;
end;

procedure TCzyRightGroupSet.InitMenuItemCheck(const sId: string);
var
  sSqlStr:string;
  i,sMenuId,iWidth:Integer;
  bl:Boolean;
begin
  if sId='' then Exit;

  //sSqlStr := 'select * from 权限组表 where 权限组名称='+quotedstr(sGroupName);
  //cds_Temp.XMLData := dm.OpenData(sSqlStr);

  Screen.Cursor := crHourGlass;
  try
    for i:=0 to RightChkTree.Items.Count-1 do
    begin
      if RightChkTree.Items[i].Level=1 then
      begin
        iWidth := Pos('－',RightChkTree.Items[i].Text)-1;
        sMenuId := StrToInt(Copy(RightChkTree.Items[i].Text,1,iWidth));
        //sMenuId := StrToInt(Copy(RightChkTree.Items[i].Text,1,3));
        bl := False;
        if cds_GroupRight.Locate('MenuId',VarArrayOf([sMenuId]),[]) then
           bl := cds_GroupRight.FieldByName('是否可用').AsBoolean;
        if bl then
          RightChkTree.ItemState[i] := csChecked
        else
          RightChkTree.ItemState[i] := csUnchecked;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TCzyRightGroupSet.Open_Master;
begin
  cds_Master.XMLData := dm.OpenData('select ID,权限组名称 from 权限组表 order by ID');
end;

procedure TCzyRightGroupSet.InitRightTree;
var
  sqlStr,sXmmc,sId,sId_Temp:string;
  Rmn,tn:TTreeNode;
begin
  try
    RightChkTree.Items.BeginUpdate;
    RightChkTree.Items.Clear;

    //if (CZY_LEVEL='-1') then
    //   ss := 'select distinct substring(机房号,2,1) as 楼层号 from 机房信息表 order by substring(机房号,2,1)'
    //else
    sqlStr := 'select id,项目名称 from 菜单项目表 where pid=-1 order by id';

    cds1.XMLData := dm.OpenData(sqlStr);

    while not cds1.Eof do
    begin
      sId := cds1.Fields[0].AsString;
      sId_Temp := Format('%.3d',[cds1.Fields[0].AsInteger]);
      sXmmc := sId_Temp+'－'+Trim(cds1.Fields[1].AsString);
      Rmn := RightChkTree.Items.Add(nil,sXmmc);
      Rmn.ImageIndex := 0;

      sqlStr := 'select Id,项目名称 from 菜单项目表 where pid='+sId+' order by id';
      cds_Temp.XMLData := dm.OpenData(sqlStr);

      while not cds_Temp.Eof do
      begin
        sId := cds_Temp.Fields[0].AsString;
        sXmmc := sId+'－'+Trim(cds_Temp.Fields[1].AsString);
        tn := RightChkTree.Items.AddChild(Rmn,sXmmc);
        tn.ImageIndex := 1;
        cds_Temp.Next;
      end;
      cds_Temp.Close;
      cds1.Next;
    end;
    cds1.Close;
    //RightChkTree.FullExpand;
    RightChkTree.Items[0].SelectedIndex :=0;
  finally
    RightChkTree.Items.EndUpdate;
  end;
end;

procedure TCzyRightGroupSet.N3Click(Sender: TObject);
begin
  SetChecked(TMenuItem(Sender).Tag);
end;

procedure TCzyRightGroupSet.N5Click(Sender: TObject);
begin
  RightChkTree.FullExpand;
end;

procedure TCzyRightGroupSet.Open_Delta;
begin
  cds_GroupRight.DisableControls;
  try
    cds_GroupRight.XMLData := dm.OpenData('select * from 权限组明细表 order by Id');
  finally
    cds_GroupRight.EnableControls;
  end;
end;

procedure TCzyRightGroupSet.SetChecked(const CheckType: Integer);
var
  i:integer;
begin
  Screen.Cursor := crHourGlass;
  try
    for i:=0 to RightChkTree.Items.Count-1 do
    begin
      if RightChkTree.Items[i].Level=1 then
      begin
        case CheckType of
          0:
            RightChkTree.ItemState[i] := csUnchecked;
          1:
            RightChkTree.ItemState[i] := csChecked;
          2:
            if RightChkTree.ItemState[i] = csChecked then
              RightChkTree.ItemState[i] := csUnchecked
            else if RightChkTree.ItemState[i] = csUnChecked then
              RightChkTree.ItemState[i] := csChecked;
        end;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TCzyRightGroupSet.Update_Delta(const sId: string): Boolean;
var
  i,iWidth:Integer;
  sMenuId:string;
begin
  Screen.Cursor := crHourGlass;
  try
    for i:=0 to RightChkTree.Items.Count-1 do
    begin
      iWidth := Pos('－',RightChkTree.Items[i].Text)-1;
      sMenuId := Copy(RightChkTree.Items[i].Text,1,iWidth);
      if not cds_GroupRight.Locate('MenuId',VarArrayOf([sMenuId]),[]) then
      begin
        cds_GroupRight.Append;
        cds_GroupRight.FieldByName('pId').AsString := sId;
        cds_GroupRight.FieldByName('MenuId').AsInteger := StrToInt(sMenuId);
        cds_GroupRight.FieldByName('是否可用').Value := False;
        cds_GroupRight.FieldByName('是否可见').Value := False;
        cds_GroupRight.Post;
      end;

      if RightChkTree.ItemState[i] In [csChecked,csPartiallyChecked] then
      begin
        if not cds_GroupRight.FieldByName('是否可见').AsBoolean then
        begin
          cds_GroupRight.Edit;
          cds_GroupRight.FieldByName('是否可用').Value := True;
          cds_GroupRight.FieldByName('是否可见').Value := True;
          cds_GroupRight.Post;
        end;
      end else
      begin
        if cds_GroupRight.FieldByName('是否可见').AsBoolean then
        begin
          cds_GroupRight.Edit;
          cds_GroupRight.FieldByName('是否可用').Value := False;
          cds_GroupRight.FieldByName('是否可见').Value := False;
          cds_GroupRight.Post;
        end;
      end;
    end;
    if cds_GroupRight.ChangeCount>0 then
    begin
      Result := dm.UpdateData('ID','select top 1 * from 权限组明细表',cds_GroupRight.Delta,False);
      if Result then
         cds_GroupRight.MergeChangeLog;
    end else
      Result := True;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TCzyRightGroupSet.Update_Master: Boolean;
begin
  if cds_Master.State in [dsInsert,dsEdit] then
    cds_Master.Post;
  if cds_Master.ChangeCount>0 then
    Result := dm.UpdateData('ID','select top 1 * from 权限组表 order by id',cds_Master.Delta,False)
  else
    Result := True;
  if Result then
  begin
    cds_Master.MergeChangeLog;
    DBGridEh2.ReadOnly := True;
  end;
end;

end.
