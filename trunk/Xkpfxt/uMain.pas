unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ActnList, DB,
  Menus, ImgList, frxClass, frxDesgn, Spin, DBCtrls,
  MyDBNavigator, StatusBarEx, DBGridEh,
  DBFieldComboBox, StdActns, RzBckgnd, dxBar,
  cxClasses, XPStyleActnCtrls, ActnMan, DBClient, auHTTP, auAutoUpgrader,
  RzStatus, RzPanel, GIFImg;

type
  TMain = class(TForm)
    il1: TImageList;
    RzBackground1: TRzBackground;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    Status_Czy: TRzStatusPane;
    RzStatusPane3: TRzStatusPane;
    RzFieldStatus1: TRzFieldStatus;
    RzClockStatus1: TRzClockStatus;
    Status_SunVoteBaseInfo: TRzStatusPane;
    tmr1: TTimer;
    tmr_Count: TTimer;
    auAutoUpgrader1: TauAutoUpgrader;
    cds_Temp: TClientDataSet;
    ActionManger1: TActionManager;
    act_sys_Czy: TAction;
    act_sys_CzyRight: TAction;
    act_sys_ChgCzyPwd: TAction;
    act_sys_OnlineUpdateSet: TAction;
    act_sys_LoginLog: TAction;
    act_sys_SysLog: TAction;
    act_sys_LockScreen: TAction;
    act_sys_Exit: TAction;
    act_hlp_Help: TAction;
    act_hlp_Reg: TAction;
    act_hlp_Update: TAction;
    act_cwsf_UpdateReport: TAction;
    act_hlp_about: TAction;
    act_Win_CloseAll: TWindowCascade;
    act_Win_CloseCurWin: TWindowClose;
    act_Win_Wizard: TAction;
    act_Rep_DesignCenter: TAction;
    act_Win_HintMessage: TAction;
    act_Rep_TjSQLSet: TAction;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem5: TdxBarSubItem;
    dxBarSubItem6: TdxBarSubItem;
    dxBarSubItem8: TdxBarSubItem;
    dxBarSeparator1: TdxBarSeparator;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton5: TdxBarButton;
    dxBarButton6: TdxBarButton;
    dxBarButton21: TdxBarButton;
    dxBarButton46: TdxBarButton;
    dxBarButton7: TdxBarButton;
    dxBarButton47: TdxBarButton;
    dxBarButton32: TdxBarButton;
    dxBarButton33: TdxBarButton;
    dxBarButton34: TdxBarButton;
    dxBarButton35: TdxBarButton;
    dxBarButton42: TdxBarButton;
    dxBarButton43: TdxBarButton;
    dxBarButton44: TdxBarButton;
    dxBarButton48: TdxBarButton;
    dxBarButton45: TdxBarButton;
    ImageList_mm: TImageList;
    RzStatusPane2: TRzStatusPane;
    Status_Dept: TRzStatusPane;
    dxBarButton20: TdxBarButton;
    act_XkZySet: TAction;
    act_XkKmSet: TAction;
    dxBarButton31: TdxBarButton;
    dxBarSubItem7: TdxBarSubItem;
    dxBarButton36: TdxBarButton;
    act_XkZyKmSet: TAction;
    dxBarButton37: TdxBarButton;
    act_XkKdSet: TAction;
    act_XkKdBrowse: TAction;
    dxBarButton39: TdxBarButton;
    act_Data_XkKdTimeSet: TAction;
    dxBarButton40: TdxBarButton;
    dxBarSubItem10: TdxBarSubItem;
    dxBarSubItem12: TdxBarSubItem;
    dxBarSubItem13: TdxBarSubItem;
    act_XkData_Import: TAction;
    act_XkData_Init: TAction;
    act_XkData_ExceptEdit: TAction;
    act_XkData_Tjfx: TAction;
    dxBarButton53: TdxBarButton;
    dxBarButton54: TdxBarButton;
    dxBarButton56: TdxBarButton;
    dxBarButton57: TdxBarButton;
    act_XKData_Browse: TAction;
    dxBarButton62: TdxBarButton;
    act_XkData_Edit: TAction;
    dxBarButton64: TdxBarButton;
    act_XkCj_InputResultBrowse: TAction;
    dxBarButton69: TdxBarButton;
    dxBarButton70: TdxBarButton;
    act_XkSet_PwRsSet: TAction;
    dxBarButton73: TdxBarButton;
    act_Cj_Pwpf: TAction;
    dxbrbtn1: TdxBarButton;
    act_Cj_pwset: TAction;
    dxbrbtn2: TdxBarButton;
    procedure RzGroup4Items1Click(Sender: TObject);
    procedure RzGroup3Items0Click(Sender: TObject);
    procedure mmi_PrnLQTZSClick(Sender: TObject);
    procedure btn_OKClick(Sender: TObject);
    procedure mmi_PrnEMSClick(Sender: TObject);
    procedure mmi_DesEMSClick(Sender: TObject);
    procedure mmi_DesLQTZSClick(Sender: TObject);
    procedure mmi_DesLQKSMDClick(Sender: TObject);
    procedure mmi_OldLQTZSClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure frxReport1GetValue(const VarName: String;
      var Value: Variant);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure act_sys_CzyExecute(Sender: TObject);
    procedure act_sys_ChgCzyPwdExecute(Sender: TObject);
    procedure act_sys_LoginLogExecute(Sender: TObject);
    procedure act_sys_SysLogExecute(Sender: TObject);
    procedure act_sys_ExitExecute(Sender: TObject);
    procedure act_Rep_TjSQLSetExecute(Sender: TObject);
    procedure act_hlp_aboutExecute(Sender: TObject);
    procedure act_sys_CzyRightExecute(Sender: TObject);
    procedure act_sys_LockScreenExecute(Sender: TObject);
    procedure act_sys_OnlineUpdateSetExecute(Sender: TObject);
    procedure act_hlp_UpdateExecute(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure act_Win_CloseAllExecute(Sender: TObject);
    procedure act_XkZySetExecute(Sender: TObject);
    procedure act_XkKmSetExecute(Sender: TObject);
    procedure act_XkZyKmSetExecute(Sender: TObject);
    procedure act_XkKdSetExecute(Sender: TObject);
    procedure act_XkKdBrowseExecute(Sender: TObject);
    procedure act_Data_XkKdTimeSetExecute(Sender: TObject);
    procedure act_Xk_KdConfirmExecute(Sender: TObject);
    procedure act_XkCj_EditExecute(Sender: TObject);
    procedure act_XkData_ImportExecute(Sender: TObject);
    procedure act_XkData_InitExecute(Sender: TObject);
    procedure act_XKData_BrowseExecute(Sender: TObject);
    procedure act_XkData_EditExecute(Sender: TObject);
    procedure act_XkData_TjfxExecute(Sender: TObject);
    procedure act_XkSet_PwRsSetExecute(Sender: TObject);
    procedure act_hlp_RegExecute(Sender: TObject);
    procedure act_Cj_PwpfExecute(Sender: TObject);
    procedure act_Cj_pwsetExecute(Sender: TObject);
  private
    { Private declarations }
    IsShowHint:Boolean;
    vsorted :Boolean;
    repfn:string;
    sWhereList:Tstrings;
    procedure QueryEndSession(var Msg:TMessage);Message WM_QueryEndSession;
    procedure Open_Access_Table;
    procedure Print_EMS(const designed:Boolean = False);
    procedure Print_LQTZS(const designed:Boolean = False);
    procedure Print_LQKSMD(const designed:Boolean = False);
    function  GetOrderString:string;
    function  GetFilterString:String;
    function  GetXznxString:String;
    procedure GetWhereList;
    procedure InitMenuItem;
    procedure ShowXkpfForm(const yx,sf,kd,zy:string);
  public
    { Public declarations }
    procedure ShowUpdateZyHistory;
    procedure ShowMdiChildForm(const FormClass:TFormClass);
  end;

var
  Main: TMain;

implementation
uses uDM,Net,DBGridEhImpExp,uCzyEdit,uABOUT,uChangeCzyPwd,
     uCountSqlSet,uUserLoginLog,uSysLog,uCzyRightSet,uLockScreen,uXkKdTimeSet,
     uOnlineUpdateSet,uXkInfoInput, uXkPwSet,uXkPwWorkSet,
     uXkZySet,uXkKmSet,uXkZyKmSet,uXkKdSet,uXkKdBrowse,
     uXkKdSetConfirm,uXkInfoImport,uSelectYxKdZy,
     uXkDataInit,uXkInfoBrowse,uSysRegister,
     uXkInfoCount,uXkpf;

{$R *.dfm}

procedure TMain.ShowMdiChildForm(const FormClass:TFormClass);
var
  myForm: TForm;
  FormName: string;

  function ActionFlagYesNo: Boolean;
  var i:Integer;
  begin
    Result:=False;
    for i:=0 to Self.MDIChildCount-1 do
    begin
      if UpperCase(Self.MDIChildren[i].Name)=UpperCase(FormName) then
      begin
        myForm := Self.MDIChildren[i];
        Result:=True;
        Break;
      end;
    end;
  end;
begin
  myForm := nil;
  FormName := FormClass.ClassName;
  FormName := Copy(FormName,2,Length(FormName)-1);

  if ActionFlagYesNo then
  begin
    if myForm.WindowState=wsMinimized then
      myForm.WindowState := wsNormal;
    MyForm.BringToFront;
    myForm.SetFocus;
  end
  else
  begin
    myForm := FormClass.Create(Self);
    //myForm.OnCreate := MdiChildFormShow;
    //myForm.OnShow := MdiChildFormShow;//(myForm);
    //if not (myForm.Position in [poMainFormCenter,poScreenCenter,poDesktopCenter]) then
    //SetWinPos(myForm);
    //myForm.Show;
  end;
  //当然如果你想知道某个字窗体是否为活动的还可以用MyChild.Active来判断。
end;

procedure TMain.ShowUpdateZyHistory;
begin
end;

procedure TMain.ShowXkpfForm(const yx, sf, kd, zy: string);
var
  aForm:TForm;
begin
  aForm := GetMdiChildForm(Txkpf);
  if aForm=nil then
  begin
    aForm := Txkpf.Create(Self);
  end else
  begin
    if aForm.WindowState=wsMinimized then
      aForm.WindowState := wsNormal;
    aForm.BringToFront;
    aForm.SetFocus;
  end;
  Txkpf(aForm).SetParam(yx,sf,kd,zy);
  aForm.Show;
end;

procedure TMain.RzGroup4Items1Click(Sender: TObject);
begin
  Close;
end;

procedure TMain.RzGroup3Items0Click(Sender: TObject);
begin
  //frm_PrintLqtzs.ShowModal;
end;

procedure TMain.mmi_PrnLQTZSClick(Sender: TObject);
begin
  Print_LQTZS();
end;

procedure TMain.act_Cj_PwpfExecute(Sender: TObject);
var
  yx,sf,kd,zy:string;
  ii:Integer;
  aForm:TForm;
begin
  with TSelectYxKdZy.Create(nil) do
  begin
    if ShowModal=mrOk then
    begin
      yx := cbb_yx.Text;
      ii := Pos('|',cbb_Kd.Text);
      sf := Copy(cbb_Kd.Text,1,ii-1);
      kd := Copy(cbb_Kd.Text,ii+1,100);
      zy := cbb_Zy.Text;
      ShowXkpfForm(yx,sf,kd,zy);
    end;
  end;
end;

procedure TMain.act_Cj_pwsetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkPwSet);
end;

procedure TMain.act_Data_XkKdTimeSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkkdTimeSet);
end;

procedure TMain.act_hlp_aboutExecute(Sender: TObject);
begin
  TAboutBox.Create(nil).showModal;
end;

procedure TMain.act_hlp_RegExecute(Sender: TObject);
begin
  TSysRegister.Create(nil).showModal;
end;

procedure TMain.act_hlp_UpdateExecute(Sender: TObject);
begin
  if not AppSrvIsOK then
  begin
    //MessageBox(Handle, '未注册系统不能升级，升级前请先注册！　　',
    //  '不允许升级', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Exit;
  end;

  Screen.Cursor := crHourGlass;
  try
    auAutoUpgrader1.AutoCheck := False;
    auAutoUpgrader1.InfoFileURL := dm.GetClientAutoUpdateUrl;
    auAutoUpgrader1.ShowMessages := auAutoUpgrader1.ShowMessages+[mNoUpdateAvailable];
    auAutoUpgrader1.VersionNumber := Get_Version;
    auAutoUpgrader1.CheckUpdate;
  finally
    Screen.Cursor := crDefault;
  end;

end;

procedure TMain.act_Rep_TjSQLSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TCountSqlSet);
end;

procedure TMain.act_sys_ChgCzyPwdExecute(Sender: TObject);
begin
  ShowMdiChildForm(TChangeCzyPwd);
end;

procedure TMain.act_sys_CzyExecute(Sender: TObject);
begin
  ShowMdiChildForm(TCzyEdit);
end;

procedure TMain.act_sys_CzyRightExecute(Sender: TObject);
begin
  ShowMdiChildForm(TCzyRightSet);
end;

procedure TMain.act_sys_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMain.act_sys_LockScreenExecute(Sender: TObject);
begin
  TLockScreen.Create(nil).ShowModal;
end;

procedure TMain.act_sys_LoginLogExecute(Sender: TObject);
begin
  ShowMdiChildForm(TUserLoginLog);
end;

procedure TMain.act_sys_OnlineUpdateSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TOnlineUpdateSet);
end;

procedure TMain.act_sys_SysLogExecute(Sender: TObject);
begin
  ShowMdiChildForm(TSysLog);
end;

procedure TMain.act_Win_CloseAllExecute(Sender: TObject);
var
  i: Integer;
begin
  for i := 0 to Self.MDIChildCount - 1 do
  begin
    if (UpperCase(Self.MDIChildren[i].Name)<>UpperCase('NewStuList')) and
       (UpperCase(Self.MDIChildren[i].Name)<>UpperCase('Wizard')) and
       (UpperCase(Self.MDIChildren[i].Name)<>UpperCase('StatusDisplay')) then
    begin
      Self.MDIChildren[i].Close;
    end;
  end;
end;

procedure TMain.act_XkCj_EditExecute(Sender: TObject);
var
  yx,sf,km:string;
  ii:Integer;
begin
{
  if not SelectCjInputNo(yx,sf,km,ii) then Exit;
  with TXkZyCjInput.Create(nil) do
  begin
    SetYxSfKmValue(yx,sf,km);
    if ii=0 then
      SetFieldValue(1,'成绩1','操作员1')
    else
      SetFieldValue(2,'成绩2','操作员2');
    ShowModal;
  end;
}
end;

procedure TMain.act_XKData_BrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkInfoBrowse);
end;

procedure TMain.act_XkData_EditExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkInfoInput);
end;

procedure TMain.act_XkData_ImportExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkInfoImport);
end;

procedure TMain.act_XkData_InitExecute(Sender: TObject);
begin
  TXkDataInit.Create(nil).ShowModal;
end;

procedure TMain.act_XkData_TjfxExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkInfoCount);
end;

procedure TMain.act_XkKdBrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkKdBrowse);
end;

procedure TMain.act_XkKdSetExecute(Sender: TObject);
var
  sMsg:string;
begin
  try
    //if not dm.CanEditXkKdInfo(sMsg) then
    begin
      if IsShowHint then
      begin
        MessageBox(Handle, '当前不在考点申报时间之内，不能进行考点申报业务处理！　',
                '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
      end;
      //if (gb_Czy_Level<>'-1') then
        Exit;
    end;

    ShowMdiChildForm(TXkKdSet);
{
    if (gb_Czy_Level<>'-1') and (gb_Czy_Level<>'2') and IsShowHint then
    begin
      MessageBox(Handle, '不能进行考点申报业务处理，请以院系操作员的身份进行登录！　',
                '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
    end
    else if (gb_Czy_Level='2') or ((gb_Czy_Level='-1') and IsShowHint) then
    begin
      ShowMdiChildForm(TXkKdSet);
    end;
}
  finally
    IsShowHint := True;
  end;
end;

procedure TMain.act_XkKmSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkKmSet);
end;

procedure TMain.act_XkSet_PwRsSetExecute(Sender: TObject);
begin
  //ShowMdiChildForm(TXkKmPwRsSet);
  ShowMdiChildForm(TXkPwWorkSet);
end;

procedure TMain.act_XkZyKmSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkZyKmSet);
end;

procedure TMain.act_XkZySetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkZySet);
end;

procedure TMain.act_Xk_KdConfirmExecute(Sender: TObject);
begin
  ShowMdiChildForm(TXkkdSetConfirm);
end;

procedure TMain.btn_OKClick(Sender: TObject);
begin
  GetWhereList;
  Open_Access_Table;
end;

procedure TMain.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
  var Resize: Boolean);
begin
  if Screen.Width>=1024 then
  begin
    if NewWidth<1024 then
      NewWidth := 1024;
    if NewHeight<750 then
      NewHeight := 750;
  end;

  if NewWidth<800 then
    NewWidth := 800;
  if NewHeight<600 then
    NewHeight := 600;
  Resize := True;
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Screen.Cursor := crHourGlass;
  try
    if not AppSrvIsOK then  //连接服务器失败
       Exit;
    dm.CzyLogOut(gb_Czy_ID);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not gbCanClose then
    if MessageBox(Handle, PAnsiChar('确定要退出'+Application.Title+'吗？　'), '系统提示',
      MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
    begin
      gbCanClose := True;
    end;
  CanClose := gbCanClose;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sWhereList);
end;

procedure TMain.FormShow(Sender: TObject);
var
  sMsg:string;
begin
  Screen.Cursor := crHourGlass;
  try
    Self.Caption := Application.Title +'  Ver '+ Get_Version;
    IsShowHint := False;
    Status_Czy.Caption := gb_Czy_Name+'('+gb_czy_Id+')';
    Status_Dept.Caption := gb_Czy_Dept;
    InitMenuItem;
    //act_Cj_PwpfExecute(Self);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMain.Open_Access_Table;
begin
end;

procedure TMain.mmi_PrnEMSClick(Sender: TObject);
begin
  Print_EMS();
end;

procedure TMain.Print_EMS(const designed: Boolean);
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'\rep\ems.fr3';
  if not FileExists(fn) then
  begin
    MessageBox(Handle, PChar('报表文件：'+fn+' 不存在！    '), '报表文件不存在', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  with DM do
  begin
    frxReport1.LoadFromFile(fn);
    if Designed then
      frxReport1.DesignReport
    else
      frxReport1.ShowReport;
  end;
end;

procedure TMain.Print_LQKSMD(const designed: Boolean);
var
  repfn:String;
begin
  with DM do
  begin
    repfn := ExtractFilePath(Application.ExeName)+'Rep\专业分类录取名单.fr3';
    frxReport1.LoadFromFile(repfn);
    if designed then
      frxReport1.DesignReport
    else
      frxReport1.ShowReport;
  end;
end;

procedure TMain.Print_LQTZS(const designed: Boolean);
begin
  if not FileExists(repfn) then
  begin
    MessageBox(Handle, PChar('报表文件：'+repfn+' 不存在！    '), '报表文件不存在', MB_OK +
      MB_ICONSTOP);
    Exit;
  end;
  with DM do
  begin
    frxReport1.LoadFromFile(repfn);
    if designed then
      frxReport1.DesignReport
    else
      frxReport1.ShowReport;
  end;
end;

procedure TMain.QueryEndSession(var Msg: TMessage);
begin
  gbCanClose := True;
  Msg.Result := 1; //关闭
end;

procedure TMain.mmi_DesEMSClick(Sender: TObject);
begin
  Print_EMS(True);
end;

procedure TMain.mmi_DesLQTZSClick(Sender: TObject);
begin
  Print_LQTZS(True);
end;

procedure TMain.mmi_DesLQKSMDClick(Sender: TObject);
begin
  Print_LQKSMD(True);
end;

procedure TMain.mmi_OldLQTZSClick(Sender: TObject);
begin
{
  with Tfrm_PrintLqtzs.Create(Application) do
  begin
    ShowModal;
    Free;
  end;
}
end;

function TMain.GetOrderString: string;
begin
end;

procedure TMain.GetWhereList;
begin
end;

function TMain.GetFilterString: String;
begin
end;

function TMain.GetXznxString: String;
begin
end;

procedure TMain.InitMenuItem;
var
  i,iPos: Integer;
  sqlstr:string;
  sMenu:string;
  bEnabled,bVisible:Boolean;
  function IsEnabled:Boolean;
  begin
    Result := False;
    cds_Temp.First;
    while not cds_Temp.Eof do
    begin
//      if sMenu=cds_Temp.FieldByName('项目名称').AsString then
      if (sMenu=cds_Temp.FieldByName('项目名称').AsString) //then
         or ((cds_Temp.FieldByName('MenuId').AsInteger<100) and   //删除【01.系统管理】中的【01.】后再来比较
            (sMenu=Copy(cds_Temp.FieldByName('项目名称').AsString,4,100))) then
      begin
        Result := cds_Temp.FieldByName('是否可用').AsBoolean ;// or (cds_Temp.FieldByName('Tag').AsString='-1');
        Break;
      end;
      cds_Temp.Next;
    end;
  end;
begin
  cds_Temp.Close;
  sqlstr := 'select * from view_操作员权限表 where 操作员编号='+quotedstr(gb_Czy_ID);
  cds_Temp.XMLData := DM.OpenData(sqlstr);
  with Main.ActionManger1 do
  begin
    for I := 0 to ActionCount - 1 do
    begin
      //str1 := Actions[i].Category;
      sMenu := TAction(Main.ActionManger1.Actions[i]).Caption;

      if gb_Czy_Level = '-1' then
      begin
        bEnabled := True;
        bVisible := True;
      end else
      begin
        //if Pos('登录',sMenu)>0 then
        //  ShowMessage(sMenu);

        if (sMenu='操作员管理(&C)') or (sMenu='操作权限管理(&R)') or
           (sMenu='网银信息设置(&N)') or (sMenu='系统注册(&R)') then
          bEnabled := False
        else
          bEnabled := IsEnabled;
        bVisible := bEnabled;

      end;
      if (sMenu='网银信息设置(&N)') then // or (sMenu='系统注册(&R)') then
        bVisible := True;
      if (sMenu='退出系统(&X)') or (sMenu='密码修改(&P)') or (sMenu='锁屏离开(&K)') then
      begin
        bEnabled := True;
        bVisible := True;
      end;

      TAction(Main.ActionManger1.Actions[i]).Enabled := bEnabled;
      TAction(Main.ActionManger1.Actions[i]).Visible := bVisible;
    end;
  end;
  for i:=0 to Main.dxBarManager1.ItemCount-1 do
  begin
    if Main.dxBarManager1.Items[i] is TdxBarSubItem then //is TdxBarItem then // 
    begin
      sMenu := Main.dxBarManager1.Items[i].Caption;
      //if Pos('登录',sMenu)>0 then
      //  ShowMessage(sMenu);
      iPos := Pos('[&',sMenu);
      if iPos>0 then
        sMenu := Copy(sMenu,1,iPos-1);
      if (gb_Czy_Level = '-1') or (IsEnabled) then
      begin
        //main.dxBarManager1.Items[i].Enabled := IsEnabled;
        Main.dxBarManager1.Items[i].Visible := ivAlways;
      end
      else
      begin
        //main.dxBarManager1.Items[i].Enabled := IsEnabled;
        Main.dxBarManager1.Items[i].Visible := ivNever;
      end;
    end;
  end;
  cds_Temp.Close;
end;

procedure TMain.N6Click(Sender: TObject);
begin
{
  frm_PhotoProcess := Tfrm_PhotoProcess.Create(Application);

  frm_PhotoProcess.xlcc := rg2.Items.Strings[rg2.ItemIndex];
  frm_PhotoProcess.ShowModal;
  frm_PhotoProcess.Free;
}
end;

procedure TMain.frxReport1GetValue(const VarName: String;
  var Value: Variant);
var
  ksh:string;
begin
  if VarName = 'photo_fn' then
  begin
    //ksh := DM.qry_Access.FieldbyName('考生号').AsString;
    ksh := ExtractFilePath(ParamStr(0))+'image\'+ksh+'.bmp';

    if FileExists(ksh) then
      Value := ksh
    else
      Value := '';
  end;
end;

end.
