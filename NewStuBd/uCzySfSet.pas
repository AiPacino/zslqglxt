unit uCzySfSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, uCzyRightGroupSet,
  Buttons, DB, DBClient,ActnList, CheckLst, Menus, RzPanel, RzRadGrp,
  GridsEh, DBGridEh, ImgList, RzTreeVw, pngimage, frxpngimage, DBGridEhGrouping;

type
  TCzySfSet = class(TForm)
    pnl1: TPanel;
    pnl_Main: TPanel;
    btn_Set: TBitBtn;
    btn_Exit: TBitBtn;
    pm1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    pnl2: TPanel;
    pnl7: TPanel;
    rg_XlCc: TRzRadioGroup;
    GroupBox1: TRzGroupBox;
    chklst1: TCheckListBox;
    RzGroupBox1: TRzGroupBox;
    DBGridEh1: TDBGridEh;
    cds_Czy: TClientDataSet;
    ds_Czy: TDataSource;
    RightChkTree: TRzCheckTree;
    il_small: TImageList;
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
    procedure ds_CzyDataChange(Sender: TObject; Field: TField);
    procedure rg_XlCcChanging(Sender: TObject; NewIndex: Integer;
      var AllowChange: Boolean);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    myform :TCzyRightGroupSet;
    Old_CzyId:string;
    procedure Open_CzyTable;
    procedure InitRightTree;
    procedure InitMenuItemCheckByCzy(const sCzyId:string);//�ò���ԱȨ�޳�ʼ����

    procedure SetChecked(const CheckType:Integer);
    function  InitMenuTable:Boolean;
    function  ItemInEnabled(const sItem:string):Boolean;
    function  ItemInVisabled(const sItem:string):Boolean;
    function  UpdateCzyRight(const sCzyId:string):Boolean;
  public
    { Public declarations }
  end;

var
  CzySfSet: TCzySfSet;

implementation
uses uDM,uMain;
{$R *.dfm}

procedure TCzySfSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TCzySfSet.btn_ReSetClick(Sender: TObject);
begin
  if Application.MessageBox('ȷ��Ҫ�ָ�����Ա֮ǰ��Ȩ������һ������ȡ������' 
    + #13#10 + '��ǰ�Բ���ԱȨ���������޸ģ�', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONWARNING + MB_DEFBUTTON2) = IDYES then
  begin
    InitMenuItemCheckByCzy(cds_Czy.FieldByName('����Ա���').AsString);
  end;
end;

procedure TCzySfSet.btn_RightGroupClick(Sender: TObject);
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

procedure TCzySfSet.btn_SaveItemClick(Sender: TObject);
var
  sPwd:string;
begin
  if MessageBox(Handle, '���ò��������ؽ����в˵���Ŀ�����ȫ���û�Ȩ�ޣ�����' 
    + #13#10 + '��Ҫ����ִ����һ������', 'ϵͳ��ʾ', MB_YESNO +
    MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
  begin
    Exit;
  end;

  if InputQuery('������֤','��������֤����:',sPwd) then
  begin
    if sPwd<>'xlinuxx' then
    begin
      Application.MessageBox('�������������������룡����', 'ϵͳ��ʾ',
        MB_OK + MB_ICONSTOP);
      Exit;
    end;
  end else
    Exit;
  if InitMenuTable then
  begin
    Application.MessageBox('������ɣ�ϵͳ�˵����óɹ�������', 'ϵͳ��ʾ',MB_OK + MB_ICONINFORMATION);
    Self.OnCreate(Self);
  end else
    Application.MessageBox('ϵͳ�˵�����ʧ�ܣ�������ִ�����ò���������', 'ϵͳ��ʾ',MB_OK + MB_ICONSTOP);

end;

procedure TCzySfSet.btn_SetClick(Sender: TObject);
var
  sCzyId:string;
begin
  sCzyId := cds_Czy.FieldByName('����Ա���').AsString;
  if UpdateCzyRight(sCzyId) then
     MessageBox(Handle, '����ԱȨ�����óɹ�������', 'ϵͳ��ʾ', MB_OK +
       MB_ICONINFORMATION + MB_DEFBUTTON2 + MB_TOPMOST)
  else
     MessageBox(Handle, '����ԱȨ������ʧ�ܣ����������ã�����', 'ϵͳ��ʾ',
       MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
end;

procedure TCzySfSet.ds_CzyDataChange(Sender: TObject; Field: TField);
var
  sCzyId:string;
begin
  if Old_CzyId<>'' then
     UpdateCzyRight(Old_CzyId);

  sCzyId := cds_Czy.FieldByName('����Ա���').AsString;
  InitMenuItemCheckByCzy(sCzyId);
  Old_CzyId := sCzyId;
end;

function TCzySfSet.InitMenuTable:Boolean;
var
  I,j,ii: Integer;
  str,str1: string;
  sList: TStrings;
  cds_Menu:TClientDataSet;
begin
  sList := TStringList.Create;
  cds_Menu := TClientDataSet.Create(nil);
  cds_Menu.XMLData := dm.OpenData('select * from �˵���Ŀ�� where 1=0');
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
    TStringList(sList).Sort; //����

    for i := 0 to sList.Count - 1 do
    begin
      //===========================================
      cds_Menu.Append;
      cds_Menu.FieldByName('ID').AsInteger := i+1;
      cds_Menu.FieldByName('pID').AsInteger := -1;
      cds_Menu.FieldByName('��Ŀ����').AsString := sList.Strings[i];
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
          cds_Menu.FieldByName('��Ŀ����').AsString := str;
          cds_Menu.Post;
          Inc(ii);
          //=========================================
        end;
      end;
    end;
    Result := dm.ExecSql('delete from �˵���Ŀ��');
    if Result then
    begin
      Result := dm.ExecSql('delete from Ȩ������ϸ��');
      if Result then
      begin
        Result := DM.ExecSql('delete from ����ԱȨ�ޱ�');
        if Result then
          Result := dm.UpdateData('id','select top 1 * from �˵���Ŀ��',cds_Menu.Delta,False);
      end;
    end;
  finally
    cds_Menu.Free;
    sList.Free;
  end;
end;

procedure TCzySfSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TCzySfSet.FormCreate(Sender: TObject);
begin
  Old_CzyId := '';
  InitRightTree;
  Open_CzyTable;
end;

procedure TCzySfSet.FormDestroy(Sender: TObject);
begin
//  if Assigned(myform) then
//    FreeAndNil(myform);
end;

procedure TCzySfSet.FormShow(Sender: TObject);
begin
  Open_CzyTable;
end;

procedure TCzySfSet.InitMenuItemCheckByCzy(const sCzyId: string);
var
  sSqlStr:string;
  i:Integer;
  sMenuId:string;
  bl:Boolean;
  cds_Temp:TClientDataSet;
begin
  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);

  if sCzyId='' then
    sSqlStr := 'select ʡ�� from ����Աʡ�ݱ� where 1=2'
  else
    sSqlStr := 'select ʡ�� from ����Աʡ�ݱ� where ����Ա='+quotedstr(sCzyId)+' and ѧ�����='+quotedstr(rg_XlCc.Items[rg_XlCc.ItemIndex]);
  cds_Temp.XMLData := dm.OpenData(sSqlStr);
  try
    for i:=0 to RightChkTree.Items.Count-1 do
    begin
      if RightChkTree.Items[i].Level=1 then
      begin
        sMenuId := RightChkTree.Items[i].Text;
        bl := False;
        if cds_Temp.Locate('ʡ��',VarArrayOf([sMenuId]),[]) then
           bl := True;
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

procedure TCzySfSet.InitRightTree;
var
  sqlStr,sXmmc:string;
  Rmn,tn:TTreeNode;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    RightChkTree.Items.BeginUpdate;
    RightChkTree.Items.Clear;

    sXmmc := 'ȫ��';
    Rmn := RightChkTree.Items.Add(nil,sXmmc);
    Rmn.ImageIndex := 0;

    sqlStr := 'select ������ from view_ʡ�ݱ� order by ������';
    cds_Temp.XMLData := dm.OpenData(sqlStr);

    while not cds_Temp.Eof do
    begin
      sXmmc := Trim(cds_Temp.Fields[0].AsString);
      tn := RightChkTree.Items.AddChild(Rmn,sXmmc);
      tn.ImageIndex := 1;
      cds_Temp.Next;
    end;
    cds_Temp.Close;

    RightChkTree.FullExpand;
    if RightChkTree.Items.Count>0 then
      RightChkTree.Items[0].SelectedIndex :=0;
  finally
    RightChkTree.Items.EndUpdate;
    cds_Temp.Free;
  end;
end;

function TCzySfSet.ItemInEnabled(const sItem: string): Boolean;
begin
end;

function TCzySfSet.ItemInVisabled(const sItem: string): Boolean;
begin
end;

procedure TCzySfSet.N1Click(Sender: TObject);
begin
  SetChecked(TMenuItem(Sender).Tag);
end;

procedure TCzySfSet.Open_CzyTable;
begin
  cds_Czy.DisableControls;
  try
    cds_Czy.XMLData := DM.OpenData('select ����Ա���,����Ա����,����Ա�ȼ� from ����Ա�� where ����Ա�ȼ� between 0 and 9  order by ����Ա���');
  finally
    cds_Czy.EnableControls;
  end;
end;

procedure TCzySfSet.rg_XlCcChanging(Sender: TObject; NewIndex: Integer;
  var AllowChange: Boolean);
var
  sCzyId:string;
begin
  if not Self.Showing then Exit;

  if Old_CzyId<>'' then
     UpdateCzyRight(Old_CzyId);

  sCzyId := cds_Czy.FieldByName('����Ա���').AsString;
  InitMenuItemCheckByCzy(sCzyId);
  Old_CzyId := sCzyId;
end;

procedure TCzySfSet.SetChecked(const CheckType: Integer);
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

function TCzySfSet.UpdateCzyRight(const sCzyId:string):Boolean;
var
  i,iWidth: Integer;
  sID:string;
  bl,bFound:Boolean;
  cds_CzyMenu:TClientDataSet;
begin
  if sCzyId='' then Exit;

  cds_CzyMenu := TClientDataSet.Create(nil);
  try
    cds_CzyMenu.XMLData := DM.OpenData('select * from ����Աʡ�ݱ� where ����Ա='+quotedstr(sCzyId));
    cds_CzyMenu.First;

    for i := 0 to RightChkTree.Items.Count - 1 do
    begin
      sID := RightChkTree.Items[i].Text;
      bl := RightChkTree.ItemState[i] in [csChecked,csPartiallyChecked];
      bFound := cds_CzyMenu.Locate('ʡ��',sID,[]);
      if bl and (not bFound) then
      begin
        cds_CzyMenu.Append;
        cds_CzyMenu.FieldByName('ѧ�����').Value := rg_Xlcc.Items[rg_Xlcc.ItemIndex];
        cds_CzyMenu.FieldByName('����Ա').Value := sCzyId;
        cds_CzyMenu.FieldByName('ʡ��').AsString := sID;
        cds_CzyMenu.Post;
      end
      else if bFound and (not bl) then
      begin
        cds_CzyMenu.Delete;
      end;
    end;

    Result := True;
    if cds_CzyMenu.ChangeCount>0 then
    begin
      Result := dm.UpdateData('ID','select top 0 * from ����Աʡ�ݱ� where ����Ա='+quotedstr(sCzyId),cds_CzyMenu.Delta,False);
      if Result then
      begin
        cds_CzyMenu.MergeChangeLog;
        //Application.MessageBox('����ԱȨ���ѳɹ����£�����', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION);
      end;
    end;
  finally
    cds_CzyMenu.Free;
  end;
end;

end.
