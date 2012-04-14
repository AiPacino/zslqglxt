unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Buttons, ActnList, DB, Menus, ImgList, frxClass, frxDesgn,
  Spin, DBCtrls, MyDBNavigator, StatusBarEx, DBGridEh, DBFieldComboBox, StdActns,
  RzBckgnd, dxBar, cxClasses, XPStyleActnCtrls, ActnMan, DBClient, auHTTP, auAutoUpgrader,
  RzStatus, RzPanel, uWorkHint, pngimage, StdCtrls, frxpngimage,
  dxGDIPlusClasses, cxControls, dxNavBar;

type
  TMain = class(TForm)
    il1: TImageList;
    RzStatusBar1: TRzStatusBar;
    RzStatusPane1: TRzStatusPane;
    Status_Czy: TRzStatusPane;
    RzStatusPane3: TRzStatusPane;
    RzFieldStatus1: TRzFieldStatus;
    RzClockStatus1: TRzClockStatus;
    Status_SrvInfo: TRzStatusPane;
    tmr1: TTimer;
    tmr_Count: TTimer;
    auAutoUpgrader1: TauAutoUpgrader;
    cds_Temp: TClientDataSet;
    ActionManger1: TActionManager;
    act_sys_Czy: TAction;
    act_sys_CzyRight: TAction;
    act_sys_ChgCzyPwd: TAction;
    act_sys_IpSet: TAction;
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
    act_Lq_DataImport: TAction;
    act_Win_HintMessage: TAction;
    act_Rep_TjSQLSet: TAction;
    dxBarManager1: TdxBarManager;
    dxBarManager1Bar1: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    dxBarSubItem2: TdxBarSubItem;
    dxBarSubItem3: TdxBarSubItem;
    dxBarSubItem4: TdxBarSubItem;
    dxBarSubItem5: TdxBarSubItem;
    dxBarSubItem6: TdxBarSubItem;
    dxBarSubItem8: TdxBarSubItem;
    dxBarSubItem9: TdxBarSubItem;
    dxBarSeparator1: TdxBarSeparator;
    dxBarButton51: TdxBarButton;
    dxBarButton1: TdxBarButton;
    dxBarButton2: TdxBarButton;
    dxBarButton3: TdxBarButton;
    dxBarButton4: TdxBarButton;
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
    act_Lq_PhotoImport: TAction;
    act_Bd_Process: TAction;
    act_Lq_OpenData: TAction;
    act_Lq_UpdateZy: TAction;
    act_Data_ZySet: TAction;
    act_Rep_UpdateZyHistory: TAction;
    act_Rep_BdlTj: TAction;
    act_Data_YxSet: TAction;
    act_Data_YxZySet: TAction;
    dxBarButton8: TdxBarButton;
    dxBarButton9: TdxBarButton;
    dxBarButton10: TdxBarButton;
    dxBarButton11: TdxBarButton;
    dxBarButton12: TdxBarButton;
    dxBarButton13: TdxBarButton;
    dxBarButton14: TdxBarButton;
    dxBarButton15: TdxBarButton;
    dxBarButton16: TdxBarButton;
    dxBarButton17: TdxBarButton;
    dxBarButton18: TdxBarButton;
    dxBarButton19: TdxBarButton;
    act_Data_SrvSet: TAction;
    act_Data_BdTimeSet: TAction;
    dxBarButton22: TdxBarButton;
    dxBarButton23: TdxBarButton;
    dxBarButton20: TdxBarButton;
    dxBarButton24: TdxBarButton;
    act_Data_JlxmSet: TAction;
    dxBarButton25: TdxBarButton;
    act_Rep_StuBdHistory: TAction;
    dxBarButton26: TdxBarButton;
    act_Data_YxZyList: TAction;
    dxBarButton27: TdxBarButton;
    act_Lq_Process: TAction;
    dxBarButton28: TdxBarButton;
    dxBarButton29: TdxBarButton;
    act_Bd_PhotoExport: TAction;
    dxBarButton30: TdxBarButton;
    dxBarButton40: TdxBarButton;
    dxBarSubItem11: TdxBarSubItem;
    dxBarSubItem12: TdxBarSubItem;
    dxBarSubItem13: TdxBarSubItem;
    dxBarSubItem14: TdxBarSubItem;
    act_Jh_JhEdit: TAction;
    act_Jh_JhBrowse: TAction;
    dxBarButton49: TdxBarButton;
    dxBarButton52: TdxBarButton;
    act_Jh_WorkSet: TAction;
    act_Jh_WorkBrowse: TAction;
    dxBarButton31: TdxBarButton;
    dxBarButton36: TdxBarButton;
    act_Win_WorkHint: TAction;
    dxBarButton37: TdxBarButton;
    act_Lq_SqlSet: TAction;
    dxBarButton38: TdxBarButton;
    act_Jh_JhAdjustEdit: TAction;
    act_Jh_JhAdjustConfirm: TAction;
    act_Jh_jhAdjustBrowse: TAction;
    dxBarButton39: TdxBarButton;
    dxBarButton41: TdxBarButton;
    dxBarButton50: TdxBarButton;
    act_Lq_FormatZySqlSet: TAction;
    act_Lq_FormatZy: TAction;
    act_Lq_FormatKL: TAction;
    dxBarButton53: TdxBarButton;
    act_Lq_lqqkCount: TAction;
    dxBarButton54: TdxBarButton;
    act_Lq_zsjhWorkBrowse: TAction;
    dxBarButton55: TdxBarButton;
    RzBackground1: TRzBackground;
    img_Show: TImage;
    lbl_Ver: TLabel;
    lbl_Year: TLabel;
    act_Lq_AllKsInfoBrowse: TAction;
    dxBarButton56: TdxBarButton;
    act_Lq_ExportToAccess: TAction;
    dxBarButton57: TdxBarButton;
    dxBarPopupMenu1: TdxBarPopupMenu;
    act_Lq_TdKsInfoBrowse: TAction;
    dxBarButton58: TdxBarButton;
    act_Lq_EMSNumberImport: TAction;
    dxBarButton59: TdxBarButton;
    act_Tools_DbTools: TAction;
    dxBarButton60: TdxBarButton;
    act_File_FileEdit: TAction;
    dxBarButton61: TdxBarButton;
    act_File_FileBrowse: TAction;
    dxBarButton62: TdxBarButton;
    act_sys_CzySfSet: TAction;
    dxBarButton63: TdxBarButton;
    act_Lq_JwInfoImport: TAction;
    dxBarButton64: TdxBarButton;
    procedure RzGroup4Items1Click(Sender: TObject);
    procedure RzGroup3Items0Click(Sender: TObject);
    procedure mmi_PrnLQTZSClick(Sender: TObject);
    procedure mmi_PrnLQKSMDClick(Sender: TObject);
    procedure mmi_ExcelClick(Sender: TObject);
    procedure mmi_ProcessAddrClick(Sender: TObject);
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
    procedure act_Data_ZySetExecute(Sender: TObject);
    procedure act_sys_LoginLogExecute(Sender: TObject);
    procedure act_sys_SysLogExecute(Sender: TObject);
    procedure act_sys_ExitExecute(Sender: TObject);
    procedure act_Rep_UpdateZyHistoryExecute(Sender: TObject);
    procedure act_Bd_ProcessExecute(Sender: TObject);
    procedure act_Lq_UpdateZyExecute(Sender: TObject);
    procedure act_Rep_BdlTjExecute(Sender: TObject);
    procedure act_Rep_TjSQLSetExecute(Sender: TObject);
    procedure act_hlp_aboutExecute(Sender: TObject);
    procedure act_sys_CzyRightExecute(Sender: TObject);
    procedure act_sys_IpSetExecute(Sender: TObject);
    procedure act_sys_LockScreenExecute(Sender: TObject);
    procedure act_sys_OnlineUpdateSetExecute(Sender: TObject);
    procedure act_Data_SrvSetExecute(Sender: TObject);
    procedure act_Data_BdTimeSetExecute(Sender: TObject);
    procedure act_Data_JlxmSetExecute(Sender: TObject);
    procedure act_hlp_UpdateExecute(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure act_Win_CloseAllExecute(Sender: TObject);
    procedure act_Rep_StuBdHistoryExecute(Sender: TObject);
    procedure act_Data_YxSetExecute(Sender: TObject);
    procedure act_Data_YxZyListExecute(Sender: TObject);
    procedure act_Data_YxZySetExecute(Sender: TObject);
    procedure act_Lq_DataImportExecute(Sender: TObject);
    procedure act_Lq_ProcessExecute(Sender: TObject);
    procedure act_Lq_OpenDataExecute(Sender: TObject);
    procedure act_Bd_PhotoExportExecute(Sender: TObject);
    procedure act_XkData_InitExecute(Sender: TObject);
    procedure act_XkCj_SumExecute(Sender: TObject);
    procedure act_Jh_JhEditExecute(Sender: TObject);
    procedure act_XkData_TjfxExecute(Sender: TObject);
    procedure act_XkCj_CountCjInfoExecute(Sender: TObject);
    procedure act_Jh_WorkSetExecute(Sender: TObject);
    procedure act_Jh_WorkBrowseExecute(Sender: TObject);
    procedure act_Win_WorkHintExecute(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure act_Jh_JhBrowseExecute(Sender: TObject);
    procedure act_Lq_SqlSetExecute(Sender: TObject);
    procedure act_Jh_JhAdjustEditExecute(Sender: TObject);
    procedure act_Jh_JhAdjustConfirmExecute(Sender: TObject);
    procedure act_Jh_jhAdjustBrowseExecute(Sender: TObject);
    procedure act_Rep_DesignCenterExecute(Sender: TObject);
    procedure act_cwsf_UpdateReportExecute(Sender: TObject);
    procedure act_Lq_FormatZySqlSetExecute(Sender: TObject);
    procedure act_Lq_PhotoImportExecute(Sender: TObject);
    procedure act_Lq_lqqkCountExecute(Sender: TObject);
    procedure act_Lq_zsjhWorkBrowseExecute(Sender: TObject);
    procedure img_ShowDblClick(Sender: TObject);
    procedure act_Lq_AllKsInfoBrowseExecute(Sender: TObject);
    procedure act_Lq_ExportToAccessExecute(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure img_ShowMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RzBackground1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure act_Lq_TdKsInfoBrowseExecute(Sender: TObject);
    procedure act_Lq_EMSNumberImportExecute(Sender: TObject);
    procedure act_Tools_DbToolsExecute(Sender: TObject);
    procedure act_File_FileEditExecute(Sender: TObject);
    procedure act_File_FileBrowseExecute(Sender: TObject);
    procedure act_sys_CzySfSetExecute(Sender: TObject);
    procedure act_Lq_JwInfoImportExecute(Sender: TObject);
  private
    { Private declarations }
    WorkHint: TWorkHint;
    IsShowHint:Boolean;
    repfn:string;
    sWhereList:Tstrings;
    procedure QueryEndSession(var Msg:TMessage);Message WM_QueryEndSession;
    procedure Open_Access_Table;
    procedure Print_EMS(const designed:Boolean = False);
    procedure Print_LQTZS(const designed:Boolean = False);
    procedure Print_LQKSMD(const designed:Boolean = False);
    procedure GetWhereList;
    procedure InitMenuItem;
  public
    { Public declarations }
    procedure ShowUpdateZyHistory;
    procedure ShowMdiChildForm(const FormClass:TFormClass);
  end;

var
  Main: TMain;

implementation
uses uDM, Net,DBGridEhImpExp,uNewStuList,uChgZyHistory,uChangeZy,uCzyEdit,uABOUT,
     uChangeCzyPwd,uCountXkCjInfo,uCountBdl,uZySet,uCountSqlSet,uUserLoginLog,
     uSysLog,uCzyRightSet,uIpSet,uLockScreen,uOnlineUpdateSet,uSrvStateSet,
     uBaoDaoTimeSet,uJlxmSet,uNewStuBdHistory,uYxSet,uYxZyList,uYxZySet,uMareData_BDE,
     uKsList,uKsInfoBrowse,uPhotoExport, uDataInit,uZsjhSet, uCountXkInfo,uWorkSet,
     uWorkBrowse,uZsjhBrowse,uSqlCmdSet,uZsjhAdjustEdit,uZsjhAdjustConfirm,
     uZsjhAdjustBrowse,uReportDesign,uFormatZySqlSet,uLqqkCount,uLqqkBrowse,
     uKsInfoBrowse_All,uMareData_BDE_Photo,uExportToAccess,uTdKsInfoBrowse,
     uEMSNumberImport,uDbTools,uFileEdit,uFileBrowse,uCzySfSet,uJwInfoImport;

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
  act_Rep_UpdateZyHistory.Execute;
end;

procedure TMain.RzGroup4Items1Click(Sender: TObject);
begin
  Close;
end;

procedure TMain.RzBackground1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbRight then
    dxBarPopupMenu1.PopupFromCursorPos;
end;

procedure TMain.RzGroup3Items0Click(Sender: TObject);
begin
  //frm_PrintLqtzs.ShowModal;
end;

procedure TMain.mmi_PrnLQTZSClick(Sender: TObject);
begin
  Print_LQTZS();
end;

procedure TMain.mmi_PrnLQKSMDClick(Sender: TObject);
begin
{
  dxgrd_1.Columns[1].Title.SortIndex := 1;  //省份
  dxgrd_1.Columns[1].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[2].Title.SortIndex := 2;  //FindColumnByName('批次').
  dxgrd_1.Columns[2].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[3].Title.SortIndex := 3;  //FindColumnByName('科类').
  dxgrd_1.Columns[3].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[8].Title.SortIndex := 4; //FindColumnByName('录取专业规范名').
  dxgrd_1.Columns[8].Title.SortMarker := smUpEh;
  dxgrd_1.Columns[13].Title.SortIndex := 5; //FindColumnByName('投档成绩').
  dxgrd_1.Columns[13].Title.SortMarker := smDownEh;
}
  if Application.MessageBox('打印前请先确认考生数据已经按照省份↑、批次↑、科类↑、　' +
    #13#10 + '录取专业规范名↑、投档成绩↓进行了排序！' + #13#10#13#10 +
    '要继续操作吗？', '系统提示', MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2)
    = IDYES then

  begin
    Print_LQKSMD();
  end;
end;

procedure TMain.mmi_ExcelClick(Sender: TObject);
//var
//  fn,Ext,mfn:string;
begin
{
  with DM do
  begin
    dlgSave_1.FileName := '考生数据.xls';
    if dlgSave_1.Execute then
    begin
      if FileExists(dlgSave_1.FileName) then
        if MessageBox(Handle, PChar('Excel文件：'+dlgSave_1.FileName+'已存在，要覆盖它吗？　　'), '文件已存在', MB_YESNO + MB_ICONWARNING +
          MB_DEFBUTTON2) = IDNO then
          Exit
        else
          DeleteFile(dlgSave_1.FileName);

      try
        Screen.Cursor := crHourGlass;
        fn := dlgSave_1.FileName;
        Ext := ExtractFileExt(fn);
        mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
        SaveDBGridEhToExportFile(TDBGridEhExportAsXLS,dxgrd_1, fn,True);
        dxgrd_1.SetFocus;
      finally
        Screen.Cursor := crDefault;
        MessageBox(Handle, 'Excel文件导出完成！　　', '导出成功', MB_OK + MB_ICONINFORMATION);
      end;
    end;
  end;
}
end;

procedure TMain.mmi_ProcessAddrClick(Sender: TObject);
//var
//  InsertSql,sWhere:String;
//  Update_Count:Integer;
begin
{
  if Application.MessageBox('真的要让系统自动处理院系及校区地址吗？　　',
    '操作确认', MB_YESNO + MB_ICONINFORMATION + MB_DEFBUTTON2) = IDNO then
  begin
    Exit;
  end;

  if rg2.ItemIndex = 0 then
    sWhere := ' and lqmd.学制='+quotedstr('4')
  else if rg2.ItemIndex = 1 then
    sWhere := ' and lqmd.录取专业 like '+quotedstr('%预科%')
  else
    sWhere := ' and lqmd.学制='+quotedstr('3');

  InsertSql := 'update lqmd set 院系=null,入学校区=null where 1>0 ';
  InsertSql := InsertSql+sWhere;

  DM.con_Access.Execute(InsertSql,Update_Count);

  InsertSql := 'update lqmd,yxzy set lqmd.院系=yxzy.院系,lqmd.入学校区=yxzy.入学校区 where trim(lqmd.录取专业规范名)=trim(yxzy.专业) and trim(lqmd.学制)=trim(yxzy.学制年限)';
  InsertSql := InsertSql+sWhere;

  DM.con_Access.Execute(InsertSql,Update_Count);
  MessageBox(Handle, PChar('院系名称处理完成！共有' +inttostr(Update_Count)+'条记录被更新！　　'), '处理完成', MB_OK + MB_ICONINFORMATION);
  DM.qry_Access.Requery();
}
end;

procedure TMain.act_Bd_PhotoExportExecute(Sender: TObject);
begin
  ShowMdiChildForm(TPhotoExport);
end;

procedure TMain.act_Bd_ProcessExecute(Sender: TObject);
var
  sMsg:string;
begin
  try
    gb_CanBd_BK := vobj.CanBaoDao('本科',sMsg);
    gb_CanBd_ZK := vobj.CanBaoDao('专科',sMsg);

    if (not gb_CanBd_BK) and (not gb_CanBd_ZK) then
    begin
      if IsShowHint then
      begin
        MessageBox(Handle, '当前不在报到时间之内，不能进行报到业务处理！　',
                '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
      end;
      //if (gb_Czy_Level<>'-1') then
        Exit;
    end;

    if (gb_Czy_Level<>'-1') and (gb_Czy_Level<>'2') and IsShowHint then
    begin
      MessageBox(Handle, '不能进行报到业务处理，请以院系操作员的身份进行登录！　',
                '系统提示', MB_OK + MB_ICONSTOP + MB_DEFBUTTON2 + MB_TOPMOST);
    end
    else if (gb_Czy_Level='2') or ((gb_Czy_Level='-1') and IsShowHint) then
    begin
      ShowMdiChildForm(TNewStuList);
    end;
  finally
    IsShowHint := True;
  end;

end;

procedure TMain.act_cwsf_UpdateReportExecute(Sender: TObject);
begin
  if Application.MessageBox('确定要更新本地报表模板文件吗？　　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    dm.UpdateReportFile(True);
  end;
end;

procedure TMain.act_Data_BdTimeSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TBaoDaoTimeSet);
end;

procedure TMain.act_Data_JlxmSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TJlxmSet);
end;

procedure TMain.act_Data_SrvSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TSrvStateSet);
end;

procedure TMain.act_Data_YxSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TYxSet);
end;

procedure TMain.act_Data_YxZyListExecute(Sender: TObject);
begin
  ShowMdiChildForm(TYxZyList);
end;

procedure TMain.act_Data_YxZySetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TYxZySet);
end;

procedure TMain.act_Data_ZySetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TZySet);
end;

procedure TMain.act_File_FileBrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TFileBrowse);
end;

procedure TMain.act_File_FileEditExecute(Sender: TObject);
begin
  ShowMdiChildForm(TFileEdit);
end;

procedure TMain.act_hlp_aboutExecute(Sender: TObject);
begin
  TAboutBox.Create(nil).showModal;
end;

procedure TMain.act_hlp_UpdateExecute(Sender: TObject);
begin
  if not vobj.SrvIsOK then
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

procedure TMain.act_Jh_jhAdjustBrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TZsjhAdjustBrowse);
end;

procedure TMain.act_Jh_JhAdjustConfirmExecute(Sender: TObject);
begin
  ShowMdiChildForm(TZsjhAdjustConfirm);
end;

procedure TMain.act_Jh_JhAdjustEditExecute(Sender: TObject);
begin
  ShowMdiChildForm(TZsjhAdjustEdit);
end;

procedure TMain.act_Jh_JhBrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TZsjhBrowse);
end;

procedure TMain.act_Jh_JhEditExecute(Sender: TObject);
begin
  ShowMdiChildForm(TZsjhSet);
end;

procedure TMain.act_Jh_WorkBrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TWorkBrowse);
end;

procedure TMain.act_Jh_WorkSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TWorkSet);
end;

procedure TMain.act_Lq_AllKsInfoBrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TKsInfoBrowse_All);
end;

procedure TMain.act_Lq_DataImportExecute(Sender: TObject);
begin
  ShowMdiChildForm(TMareData_BDE);
end;

procedure TMain.act_Lq_EMSNumberImportExecute(Sender: TObject);
begin
  ShowMdiChildForm(TEMSNumberImport);
end;

procedure TMain.act_Lq_ExportToAccessExecute(Sender: TObject);
begin
  TExportToAccess.Create(nil).ShowModal;
end;

procedure TMain.act_Lq_FormatZySqlSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TFormatZySqlSet);
end;

procedure TMain.act_Lq_JwInfoImportExecute(Sender: TObject);
begin
  ShowMdiChildForm(TJwInfoImport);
end;

procedure TMain.act_Lq_lqqkCountExecute(Sender: TObject);
begin
  ShowMdiChildForm(TLqqkCount);
end;

procedure TMain.act_Lq_OpenDataExecute(Sender: TObject);
begin
  ShowMdiChildForm(TKsInfoBrowse);
end;

procedure TMain.act_Lq_PhotoImportExecute(Sender: TObject);
begin
  //Application.MessageBox('等一下哟，正在做，到时自动升级一下！^_^　',
  //  '系统提示', MB_OK + MB_ICONINFORMATION);
  ShowMdiChildForm(TMareData_BDE_Photo);
end;

procedure TMain.act_Lq_ProcessExecute(Sender: TObject);
begin
  ShowMdiChildForm(TKsList);
end;

procedure TMain.act_Lq_SqlSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TSqlCmdSet);
end;

procedure TMain.act_Lq_TdKsInfoBrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TTdKsInfoBrowse);
end;

procedure TMain.act_Lq_UpdateZyExecute(Sender: TObject);
begin
  ShowMdiChildForm(TChangeZy);
end;

procedure TMain.act_Lq_zsjhWorkBrowseExecute(Sender: TObject);
begin
  ShowMdiChildForm(TLqqkBrowse);
end;

procedure TMain.act_Rep_BdlTjExecute(Sender: TObject);
begin
  ShowMdiChildForm(TCountBdl);
end;

procedure TMain.act_Rep_DesignCenterExecute(Sender: TObject);
begin
  ShowMdiChildForm(TReportDesign);
end;

procedure TMain.act_Rep_StuBdHistoryExecute(Sender: TObject);
begin
  ShowMdiChildForm(TNewStuBdHistory);
end;

procedure TMain.act_Rep_TjSQLSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TCountSqlSet);
end;

procedure TMain.act_Rep_UpdateZyHistoryExecute(Sender: TObject);
begin
  ShowMdiChildForm(TChgZyHistory);
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

procedure TMain.act_sys_CzySfSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TCzySfSet);
end;

procedure TMain.act_sys_ExitExecute(Sender: TObject);
begin
  Close;
end;

procedure TMain.act_sys_IpSetExecute(Sender: TObject);
begin
  ShowMdiChildForm(TIpSet);
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

procedure TMain.act_Tools_DbToolsExecute(Sender: TObject);
begin
  ShowMdiChildForm(TDbTools);
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

procedure TMain.act_Win_WorkHintExecute(Sender: TObject);
begin
  if act_Win_WorkHint.Checked then
  begin
    if Assigned(WorkHint) then
    begin
       WorkHint.Close;
       FreeAndNil(WorkHint);
    end;
    act_Win_WorkHint.Checked := False;
  end else
  begin
    if not Assigned(WorkHint) then
    begin
      WorkHint := TWorkHint.Create(Self);
      //WorkHint.Left := Self.ClientWidth-WorkHint.Width-6;
      //WorkHint.Top := Self.ClientHeight-WorkHint.Height-55;
    end;
    WorkHint.Show;
    act_Win_WorkHint.Checked := True;
  end;
end;

procedure TMain.act_XkCj_CountCjInfoExecute(Sender: TObject);
begin
  ShowMdiChildForm(TCountXkCjInfo);
end;

procedure TMain.act_XkCj_SumExecute(Sender: TObject);
begin
  MessageBox(Handle, '考生成绩录入尚未结束，无法进行专业总分计算！　',
    '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
end;

procedure TMain.act_XkData_InitExecute(Sender: TObject);
begin
  TDataInit.Create(nil).ShowModal;
end;

procedure TMain.act_XkData_TjfxExecute(Sender: TObject);
begin
  ShowMdiChildForm(TCountXkInfo);
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
    vobj.CzyLogOut(gb_Czy_ID);
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

procedure TMain.FormCreate(Sender: TObject);
begin
  Self.Top := 0;
  Self.Left := 0;
  //Self.Width := Screen.Width;
  //Self.Height := Screen.Height;
end;

procedure TMain.FormDestroy(Sender: TObject);
begin
  FreeAndNil(sWhereList);
end;

procedure TMain.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbRight then
    dxBarPopupMenu1.PopupFromCursorPos;
end;

procedure TMain.FormResize(Sender: TObject);
begin
  if Self.WindowState<>wsMaximized then
  begin
    Self.Top := 0;
    Self.Left := 0;
  end;
  if WorkHint<>nil then
  begin
    WorkHint.Left := Self.ClientWidth-WorkHint.Width-6;
    WorkHint.Top := Self.ClientHeight-WorkHint.Height-55
  end;
  img_Show.Left := Trunc((Self.Width-img_Show.Width)/2);
  img_Show.Top := Trunc((Self.Height-img_Show.Height)/2)-5;
  lbl_Ver.Left := img_Show.Left+502;
  lbl_Ver.Top := img_Show.Top+277;
  lbl_Year.Left := img_Show.Left+25;
  lbl_Year.Top := img_Show.Top+450;
end;

procedure TMain.FormShow(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    lbl_Year.Caption := FormatDateTime('yyyy·南昌',date);
    lbl_Ver.Caption := 'Ver '+ Get_Version;
    Self.Caption := Application.Title +'  '+lbl_Ver.Caption;
    IsShowHint := False;
    Status_Czy.Caption := gb_Czy_Name+'('+gb_czy_Id+')';
    Status_Dept.Caption := gb_Czy_Dept;
    Status_SrvInfo.Caption := dm.GetConnInfo;
    InitMenuItem;

    //act_Win_WorkHintExecute(Self);

    act_Bd_Process.Execute;
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

procedure TMain.GetWhereList;
begin
end;

procedure TMain.img_ShowDblClick(Sender: TObject);
begin
  act_Win_WorkHintExecute(Self);
end;

procedure TMain.img_ShowMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbRight then
    dxBarPopupMenu1.PopupFromCursorPos;
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
