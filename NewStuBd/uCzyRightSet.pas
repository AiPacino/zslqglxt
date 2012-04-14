unit uCzyRightSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, uCzyRightGroupSet,
  Buttons, DB, DBClient,ActnList, CheckLst, Menus, RzPanel, RzRadGrp,
  GridsEh, DBGridEh, ImgList, RzTreeVw, pngimage, frxpngimage, DBGridEhGrouping;

type
  TCzyRightSet = class(TForm)
    pnl1: TPanel;
    pnl_Main: TPanel;
    btn_Set: TBitBtn;
    btn_Exit: TBitBtn;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    btn_SaveItem: TBitBtn;
    btn_ReSet: TBitBtn;
    pnl2: TPanel;
    pnl7: TPanel;
    rg_RightGroup: TRzRadioGroup;
    GroupBox1: TRzGroupBox;
    chklst1: TCheckListBox;
    RzGroupBox1: TRzGroupBox;
    DBGridEh1: TDBGridEh;
    cds_Czy: TClientDataSet;
    ds_Czy: TDataSource;
    RightChkTree: TRzCheckTree;
    il_small: TImageList;
    btn_RightGroup: TBitBtn;
    pnl_Title: TPanel;
    img_Title: TImage;
    img_Hint: TImage;
    lbl_Title: TLabel;
    procedure btn_ExitClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveItemClick(Sender: TObject);
    procedure btn_SetClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_ReSetClick(Sender: TObject);
    procedure btn_RightGroupClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure rg_RightGroupClick(Sender: TObject);
    procedure ds_CzyDataChange(Sender: TObject; Field: TField);
    procedure rg_RightGroupChanging(Sender: TObject; NewIndex: Integer;
      var AllowChange: Boolean);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    myform :TCzyRightGroupSet;
    Old_CzyId:string;
    procedure Open_CzyTable;
    procedure InitRightGroup;
    procedure InitRightTree;
    procedure InitMenuItemCheckByGroup(const sId:string); //用组权限初始化树
    procedure InitMenuItemCheckByCzy(const sCzyId:string);//用操作员权限初始化树

    procedure SetChecked(const CheckType:Integer);
    function  InitMenuTable:Boolean;
    function  ItemInEnabled(const sItem:string):Boolean;
    function  ItemInVisabled(const sItem:string):Boolean;
    function  UpdateCzyRight(const sCzyId:string):Boolean;
  public
    { Public declarations }
  end;

var
  CzyRightSet: TCzyRightSet;

implementation
uses uDM,uMain;
{$R *.dfm}

procedure TCzyRightSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCzyRightSet.btn_ReSetClick(Sender: TObject);
begin
  if Application.MessageBox('确定要恢复操作员之前的权限吗？这一操作将取消　　' 
    + #13#10 + '当前对操作员权限所作的修改！', '系统提示', MB_YESNO +
    MB_ICONWARNING + MB_DEFBUTTON2) = IDYES then
  begin
    InitMenuItemCheckByCzy(cds_Czy.FieldByName('操作员编号').AsString);
  end;
end;

procedure TCzyRightSet.btn_RightGroupClick(Sender: TObject);
var
  t,l:Integer;
begin
  t := Self.Top;
  l := Self.Left;
  with TCzyRightGroupSet.Create(Self) do
  begin
    Top := t-50;
    Left := l+80;
    ShowModal;
  end;
end;

procedure TCzyRightSet.btn_SaveItemClick(Sender: TObject);
var
  sPwd:string;
begin
  if MessageBox(Handle, '重置操作将会重建所有菜单项目并清除全部用户权限！　　' 
    + #13#10 + '还要继续执行这一操作吗？', '系统提示', MB_YESNO +
    MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  if InputQuery('密码验证','请输入认证密码:',sPwd) then
  begin
    if sPwd<>'xlinuxx' then
    begin
      Application.MessageBox('密码错误，请检查后重新输入！　　', '系统提示',
        MB_OK + MB_ICONSTOP);
      Exit;
    end;
  end else
    Exit;
  if InitMenuTable then
  begin
    Application.MessageBox('操作完成！系统菜单重置成功！　　', '系统提示',MB_OK + MB_ICONINFORMATION);
    Self.OnCreate(Self);
  end else
    Application.MessageBox('系统菜单重置失败！请重新执行重置操作！　　', '系统提示',MB_OK + MB_ICONSTOP);

end;

procedure TCzyRightSet.btn_SetClick(Sender: TObject);
var
  sCzyId:string;
begin
  sCzyId := cds_Czy.FieldByName('操作员编号').AsString;
  if UpdateCzyRight(sCzyId) then
     MessageBox(Handle, '操作员权限配置成功！　　', '系统提示', MB_OK +
       MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST)
  else
     MessageBox(Handle, '操作员权限配置失败！请重新配置！　　', '系统提示',
       MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
end;

procedure TCzyRightSet.ds_CzyDataChange(Sender: TObject; Field: TField);
var
  sCzyId:string;
begin
  if Old_CzyId<>'' then
     UpdateCzyRight(Old_CzyId);

  sCzyId := cds_Czy.FieldByName('操作员编号').AsString;
  InitMenuItemCheckByCzy(sCzyId);
  Old_CzyId := sCzyId;
  rg_RightGroup.ItemIndex := -1;
end;

function TCzyRightSet.InitMenuTable:Boolean;
var
  I,j,ii: Integer;
  str,str1: string;
  sList: TStrings;
  cds_Menu:TClientDataSet;
begin
  sList := TStringList.Create;
  cds_Menu := TClientDataSet.Create(nil);
  cds_Menu.XMLData := dm.OpenData('select * from 菜单项目表 where 1=0');
  try
    str1 := '';
    for I := 0 to Main.ActionManger1.ActionCount - 1 do
    begin
      str1 := Main.ActionManger1.Actions[i].Category;
      if sList.IndexOf(str1)=-1 then
      begin
        sList.Add(str1);
        //str1 := Main.ActionManger1.Actions[i].Category;
      end;
    end;
    TStringList(sList).Sort; //排序

    for i := 0 to sList.Count - 1 do
    begin
      //===========================================
      cds_Menu.Append;
      cds_Menu.FieldByName('ID').AsInteger := i+1;
      cds_Menu.FieldByName('pID').AsInteger := -1;
      cds_Menu.FieldByName('项目名称').AsString := sList.Strings[i];
      cds_Menu.Post;
      //===========================================

      ii := 1;
      for j := 0 to Main.ActionManger1.ActionCount - 1 do
      begin
        str1 := Main.ActionManger1.Actions[j].Category;
        if str1=sList[i] then
        begin
          str := TAction(Main.ActionManger1.Actions[j]).Caption;
          //=========================================
          cds_Menu.Append;
          cds_Menu.FieldByName('ID').AsInteger := (i+1)*100+ii;
          cds_Menu.FieldByName('pID').AsInteger := i+1;
          cds_Menu.FieldByName('项目名称').AsString := str;
          cds_Menu.Post;
          Inc(ii);
          //=========================================
        end;
      end;
    end;
    Result := dm.ExecSql('delete from 菜单项目表');
    if Result then
    begin
      Result := dm.ExecSql('delete from 权限组明细表');
      if Result then
      begin
        Result := DM.ExecSql('delete from 操作员权限表');
        if Result then
          Result := dm.UpdateData('id','select top 1 * from 菜单项目表',cds_Menu.Delta,False);
      end;
    end;
  finally
    cds_Menu.Free;
    sList.Free;
  end;
end;

procedure TCzyRightSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCzyRightSet.FormCreate(Sender: TObject);
begin
  Old_CzyId := '';
  InitRightTree;
  InitRightGroup;
  Open_CzyTable;
end;

procedure TCzyRightSet.FormDestroy(Sender: TObject);
begin
//  if Assigned(myform) then
//    FreeAndNil(myform);
end;

procedure TCzyRightSet.FormShow(Sender: TObject);
begin
  Open_CzyTable;
end;

procedure TCzyRightSet.InitMenuItemCheckByCzy(const sCzyId: string);
var
  sSqlStr:string;
  i,sMenuId,iWidth:Integer;
  bl:Boolean;
  cds_Temp:TClientDataSet;
begin
  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);

  if sCzyId='' then
    sSqlStr := 'select MenuId,是否可用 from 操作员权限表 where 1=2'
  else
    sSqlStr := 'select MenuId,是否可用 from 操作员权限表 where 操作员编号='+quotedstr(sCzyId);
  cds_Temp.XMLData := dm.OpenData(sSqlStr);
  try
    for i:=0 to RightChkTree.Items.Count-1 do
    begin
      if RightChkTree.Items[i].Level=1 then
      begin
        iWidth := Pos('－',RightChkTree.Items[i].Text)-1;
        sMenuId := StrToInt(Copy(RightChkTree.Items[i].Text,1,iWidth));
        //sMenuId := StrToInt(Copy(RightChkTree.Items[i].Text,1,3));
        bl := False;
        if cds_Temp.Locate('MenuId',VarArrayOf([sMenuId]),[]) then
           bl := cds_Temp.FieldByName('是否可用').AsBoolean;
        if bl then
          RightChkTree.ItemState[i] := csChecked
        else
          RightChkTree.ItemState[i] := csUnchecked;
      end;
    end;
  finally
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TCzyRightSet.InitMenuItemCheckByGroup(const sId: string);
var
  sSqlStr:string;
  i,sMenuId,iWidth:Integer;
  bl:Boolean;
  cds_Temp:TClientDataSet;
begin
  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);

  if sId='' then
    sSqlStr := 'select * from 权限组明细表 where 1=2'
  else
    sSqlStr := 'select * from 权限组明细表 where Pid='+sId;
  cds_Temp.XMLData := dm.OpenData(sSqlStr);
  try
    for i:=0 to RightChkTree.Items.Count-1 do
    begin
      if RightChkTree.Items[i].Level=1 then
      begin
        iWidth := Pos('－',RightChkTree.Items[i].Text)-1;
        //sMenuId := Copy(RightChkTree.Items[i].Text,1,iWidth);
        sMenuId := StrToInt(Copy(RightChkTree.Items[i].Text,1,iWidth));
        bl := False;
        if cds_Temp.Locate('MenuId',VarArrayOf([sMenuId]),[]) then
           bl := cds_Temp.FieldByName('是否可用').AsBoolean;
        if bl then
          RightChkTree.ItemState[i] := csChecked
        else
          RightChkTree.ItemState[i] := csUnchecked;
      end;
    end;
  finally
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

procedure TCzyRightSet.InitRightGroup;
var
  sqlStr,sXmmc,sId:string;
  Rmn,tn:TTreeNode;
  cds1,cds_Temp:TClientDataSet;
begin
  cds1 := TClientDataSet.Create(nil);
  cds_Temp := TClientDataSet.Create(nil);
  try
    rg_RightGroup.Items.Clear;

    sqlStr := 'select id,权限组名称 from 权限组表 order by id';

    cds_Temp.XMLData := dm.OpenData(sqlStr);

    while not cds_Temp.Eof do
    begin
      sId := Format('%.3d',[cds_Temp.Fields[0].AsInteger]);
      sXmmc := sId+'－'+Trim(cds_Temp.Fields[1].AsString);
      rg_RightGroup.Items.Add(sXmmc);
      cds_Temp.Next;
    end;
    //if rg_RightGroup.Items.Count>0 then
    //  rg_RightGroup.ItemIndex := 0;
  finally
    cds_Temp.Free;
  end;
end;

procedure TCzyRightSet.InitRightTree;
var
  sqlStr,sXmmc,sId,sId_Temp:string;
  Rmn,tn:TTreeNode;
  cds1,cds_Temp:TClientDataSet;
begin
  cds1 := TClientDataSet.Create(nil);
  cds_Temp := TClientDataSet.Create(nil);
  try
    RightChkTree.Items.BeginUpdate;
    RightChkTree.Items.Clear;

    sqlStr := 'select id,项目名称 from 菜单项目表 where pid=-1 order by id';

    cds1.XMLData := dm.OpenData(sqlStr);

    while not cds1.Eof do
    begin
      sId := cds1.Fields[0].asString;
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
    RightChkTree.FullExpand;
    if RightChkTree.Items.Count>0 then
      RightChkTree.Items[0].SelectedIndex :=0;
  finally
    RightChkTree.Items.EndUpdate;
    cds1.Free;
    cds_Temp.Free;
  end;
end;

function TCzyRightSet.ItemInEnabled(const sItem: string): Boolean;
begin
end;

function TCzyRightSet.ItemInVisabled(const sItem: string): Boolean;
begin
end;

procedure TCzyRightSet.N1Click(Sender: TObject);
begin
  SetChecked(TMenuItem(Sender).Tag);
end;

procedure TCzyRightSet.Open_CzyTable;
begin
  cds_Czy.DisableControls;
  try
    cds_Czy.XMLData := DM.OpenData('select 操作员编号,操作员姓名,操作员等级 from 操作员表 where 操作员等级>-1 order by 操作员编号');
  finally
    cds_Czy.EnableControls;
  end;
end;

procedure TCzyRightSet.rg_RightGroupChanging(Sender: TObject; NewIndex: Integer;
  var AllowChange: Boolean);
begin
  if MessageBox(Handle, PChar('真的要为当前操作员分配〖'+rg_rightGroup.Items[NewIndex]+'】权限吗？　　' + #13#10 +
    '这一操作将会清除操作员原来的权限分配方案！' + #13#10 + '还要继续吗？'),
    '系统提示', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) =  IDNO then
   begin
     AllowChange := False;
     Exit;
   end else
     AllowChange := True;
end;

procedure TCzyRightSet.rg_RightGroupClick(Sender: TObject);
var
  sId:string;
begin
  if rg_RightGroup.ItemIndex = -1 then Exit;
  sId := Copy(rg_RightGroup.Items[rg_RightGroup.ItemIndex],1,3);
  InitMenuItemCheckByGroup(sId);
end;

procedure TCzyRightSet.SetChecked(const CheckType: Integer);
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

function TCzyRightSet.UpdateCzyRight(const sCzyId:string):Boolean;
var
  i,iWidth: Integer;
  sID:string;
  bl:Boolean;
  cds_CzyMenu:TClientDataSet;
begin
  if sCzyId='' then Exit;

  cds_CzyMenu := TClientDataSet.Create(nil);
  try
    cds_CzyMenu.XMLData := DM.OpenData('select * from 操作员权限表 where 操作员编号='+quotedstr(sCzyId));
    cds_CzyMenu.First;
    for i := 0 to RightChkTree.Items.Count - 1 do
    begin
      iWidth := Pos('－',RightChkTree.Items[i].Text)-1;
      sID := Copy(RightChkTree.Items[i].Text,1,iWidth);
      //==============================
      sID := IntToStr(StrToInt(sID));
      //==============================
      if not cds_CzyMenu.Locate('MenuId',sID,[]) then
      begin
        cds_CzyMenu.Append;
        cds_CzyMenu.FieldByName('操作员编号').Value := sCzyId;
        cds_CzyMenu.FieldByName('MenuId').AsString := sID;
        cds_CzyMenu.FieldByName('是否可用').Value := False;
        cds_CzyMenu.FieldByName('是否可见').Value := False;
        cds_CzyMenu.Post;
      end;
      bl := RightChkTree.ItemState[i] in [csChecked,csPartiallyChecked];
      //if bl <> cds_CzyMenu.FieldByName('是否可用').AsBoolean then
      begin
        cds_CzyMenu.Edit;
        cds_CzyMenu.FieldByName('是否可用').Value := bl;
        cds_CzyMenu.FieldByName('是否可见').Value := bl;
        cds_CzyMenu.Post;
      end;
    end;
    Result := True;
    if cds_CzyMenu.ChangeCount>0 then
    begin
      Result := dm.UpdateData('ID','select top 1 * from 操作员权限表 where 操作员编号='+quotedstr(sCzyId),cds_CzyMenu.Delta,False);
      if Result then
      begin
        cds_CzyMenu.MergeChangeLog;
        //Application.MessageBox('操作员权限已成功更新！　　', '系统提示', MB_OK + MB_ICONINFORMATION);
      end;
    end;
  finally
    cds_CzyMenu.Free;
  end;
end;

end.
