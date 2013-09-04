unit uToolsMain;

interface

uses
  SysUtils, Classes, Forms, Controls, CnAAFont, CnAACtrls, RzStatus,
  ExtCtrls, RzPanel, Menus, CoolTrayIcon, ShellAPI,StrUtils,
  Windows, Graphics,ADODB,IniFiles,Messages, auHTTP,
  auAutoUpgrader, ImgList;

type
  TToolsMain = class(TForm)
    albl_Title: TCnAALabel;
    albl_Dwmc: TCnAALabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    mi_DbSet: TMenuItem;
    mi_Hide: TMenuItem;
    N5: TMenuItem;
    mi_Exit: TMenuItem;
    N6: TMenuItem;
    I1: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    A1: TMenuItem;
    RzStatusBar1: TRzStatusBar;
    RzImage_msg: TRzGlyphStatus;
    sp_SrvState: TRzStatusPane;
    RzStatusPane1: TRzStatusPane;
    PopupMenu1: TPopupMenu;
    pi_Show: TMenuItem;
    pi_ShowHint: TMenuItem;
    pi_Exit: TMenuItem;
    CoolTrayIcon1: TCoolTrayIcon;
    mi_Url: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    mi_BackUp_Restore: TMenuItem;
    N4: TMenuItem;
    tmr_AutoBackup: TTimer;
    auAutoUpgrader1: TauAutoUpgrader;
    mi_Update: TMenuItem;
    ImageList1: TImageList;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    procedure mi_DbSetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure mi_HideClick(Sender: TObject);
    procedure pi_ShowClick(Sender: TObject);
    procedure pi_ExitClick(Sender: TObject);
    procedure CoolTrayIcon1DblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure mi_UrlClick(Sender: TObject);
    procedure mi_ExitClick(Sender: TObject);
    procedure A1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure mi_BackUp_RestoreClick(Sender: TObject);
    procedure tmr_AutoBackupTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure CoolTrayIcon1MinimizeToTray(Sender: TObject);
    procedure CoolTrayIcon1BalloonHintClick(Sender: TObject);
    procedure mi_UpdateClick(Sender: TObject);
    procedure auAutoUpgrader1DoOwnCloseAppMethod(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure auAutoUpgrader1AfterRestart(Sender: TObject);
    procedure auAutoUpgrader1EndUpgrade(Sender: TObject);
    procedure auAutoUpgrader1FileStart(Sender: TObject; const FileURL: string;
      FileSize: Integer; FileTime: TDateTime; var CanUpgrade: Boolean);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
  private
    { Private declarations }
    UserName,UserCode:string;
    procedure QueryEndSession(var Msg:TMessage);Message WM_QueryEndSession;
    function GetUserInfo:Boolean;
    function SrvIsOpened:Boolean;
    function RegIsOK:Boolean;
    procedure UpdateSrvStatus;
    function IsAutoBackup:Boolean;
  public
    { Public declarations }
  end;

const
  SYS_TITLE = 'NewStu服务配置程序';

var
  ToolsMain: TToolsMain;
  gbCanClose: Boolean;

implementation

uses uDM,Net,uDbInfoSet,uServiceSet,uDbConnect,PwdFunUnit,
  uSQLBackupRestore,uDbBackupRestore,uPhotoSavePathSet,uSrvStateSet;

{$R *.dfm}

procedure TToolsMain.A1Click(Sender: TObject);
var
  fn :string;
begin
  fn := ExtractFilePath(ParamStr(0))+'About.exe';
  if FileExists(fn) then
    RunAndWait(fn,SW_SHOW)
  else
    MessageBox(Handle, '关于本程序文件：About.exe 未找到！　　', '系统提示',
      MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
  UpdateSrvStatus;
end;

procedure TToolsMain.auAutoUpgrader1AfterRestart(Sender: TObject);
begin
  //MessageBox(Handle, '重启完成！　　', '系统提示', MB_OK + MB_ICONINFORMATION
  //  + MB_DEFBUTTON2 + MB_TOPMOST);
  ShellExecute(Handle,'open','iisreset',' /Restart',nil,SW_HIDE);
end;

procedure TToolsMain.auAutoUpgrader1DoOwnCloseAppMethod(Sender: TObject);
begin
  gbCanClose := True;
  Close;
end;

procedure TToolsMain.auAutoUpgrader1EndUpgrade(Sender: TObject);
begin
  //MessageBox(Handle, '更新完成！　　', '系统提示', MB_OK + MB_ICONINFORMATION
  //  + MB_DEFBUTTON2 + MB_TOPMOST);
  ShellExecute(Handle,'open','iisreset',' /stop',nil,SW_HIDE);
end;

procedure TToolsMain.auAutoUpgrader1FileStart(Sender: TObject;
  const FileURL: string; FileSize: Integer; FileTime: TDateTime;
  var CanUpgrade: Boolean);
var
  sfn:string;
begin
  sfn := LowerCase(FileURL);
  if Pos('newstulqbdsrv.dll',sfn)>0 then
    ShellExecute(Handle,'open','iisreset',' /stop',nil,SW_HIDE);
end;

procedure TToolsMain.CoolTrayIcon1BalloonHintClick(Sender: TObject);
begin
  if not DbSrvIsOK then
    Self.CoolTrayIcon1.ShowMainForm;
end;

procedure TToolsMain.CoolTrayIcon1DblClick(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;

procedure TToolsMain.CoolTrayIcon1MinimizeToTray(Sender: TObject);
begin
  if DbSrvIsOK then
    CoolTrayIcon1.ShowBalloonHint(SYS_TITLE,'NewStu Server 正在运行......',bitInfo,10)
  else
    CoolTrayIcon1.ShowBalloonHint(SYS_TITLE,'数据库服务器连接失败......',bitError,10);
end;

procedure TToolsMain.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
  var Resize: Boolean);
begin
  Resize := False;
end;

procedure TToolsMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not gbCanClose then
    Hide;
  CanClose := gbCanClose;
end;

procedure TToolsMain.FormCreate(Sender: TObject);
begin
  if Screen.Fonts.IndexOf('楷体_GB2312')<>-1 then
  begin
    albl_Title.Font.Name := '楷体_GB2312';
    albl_Dwmc.Font.Name := '楷体_GB2312';
  end;

  gbCanClose := False;
  Application.ShowMainForm := False;
  Self.CoolTrayIcon1.Hint := SYS_TITLE;
  Application.Title := SYS_TITLE;
  UpdateSrvStatus;
  CoolTrayIcon1MinimizeToTray(Self);
end;

procedure TToolsMain.FormShow(Sender: TObject);
begin
  if GetConnectString='' then
    mi_DbSet.Click;
end;

function TToolsMain.GetUserInfo:Boolean;
var
  qry_Temp:TAdoquery;
begin
  Result := DbSrvIsOK;
  if not Result then
    Exit;

  qry_Temp := TAdoquery.Create(nil);
  try
    try
      qry_Temp.Active := False;
      qry_Temp.ConnectionString := GetConnectString;
      qry_Temp.CommandTimeout := 3;
      qry_Temp.SQL.Text := 'select 用户名称,注册码 from 机主信息表';
      qry_Temp.Active := True;
      UserName := qry_Temp.Fields[0].AsString;
      UserCode := qry_Temp.Fields[1].AsString;
      Result := True;
    except;
      Result := False;
    end;
  finally
    qry_temp.Free;
  end;
{
  try
    UserName := vobj_Account.GetUserInfo;
    UserCode := vobj_Account.GetUserCode;
    Result := True;
  except
    Result := False;
  end;
}
end;

function TToolsMain.IsAutoBackup: Boolean;
begin
  Result := ReadAutoBackup;
end;

procedure TToolsMain.mi_UpdateClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;

  try
    auAutoUpgrader1.AutoCheck := False;
    auAutoUpgrader1.VersionNumber := Get_Version;
    auAutoUpgrader1.InfoFileURL := vobj.GetSrvAutoUpdateUrl;
    auAutoUpgrader1.ShowMessages := [mAskUpgrade];
    auAutoUpgrader1.CheckUpdate;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TToolsMain.mi_UrlClick(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://xieyunc.jxstnu.edu.cn/',nil,nil,1);
end;

procedure TToolsMain.mi_BackUp_RestoreClick(Sender: TObject);
begin
  with TDbBackUpRestore.Create(nil) do
  begin
    //Top := Self.Top+40;
    //Left := Self.Left+30;
    ShowModal;
  end;
end;

procedure TToolsMain.mi_DbSetClick(Sender: TObject);
begin
  TDbInfoSet.Create(nil).ShowModal;
  UpdateSrvStatus;
end;

procedure TToolsMain.mi_ExitClick(Sender: TObject);
begin
  gbCanClose := True;
  Close;
end;

procedure TToolsMain.mi_HideClick(Sender: TObject);
begin
  CoolTrayIcon1.HideMainForm;
end;

procedure TToolsMain.N10Click(Sender: TObject);
begin
  TPhotoSavePathSet.Create(nil).ShowModal;
end;

procedure TToolsMain.N11Click(Sender: TObject);
begin
  TSrvStateSet.Create(nil).ShowModal;
  UpdateSrvStatus;
end;

procedure TToolsMain.N2Click(Sender: TObject);
begin
  TServiceSet.Create(nil).ShowModal;
  UpdateSrvStatus;
end;

procedure TToolsMain.N3Click(Sender: TObject);
var
  fn :string;
begin
  fn := ExtractFilePath(ParamStr(0))+'SysReg.exe';
  if FileExists(fn) then
    RunAndWait(fn,SW_SHOW)
  else
    MessageBox(Handle, '系统注册工具：SysReg.exe 未找到！　　', '系统提示',
      MB_OK + MB_ICONINFORMATION + MB_TOPMOST);

  UpdateSrvStatus;
end;

procedure TToolsMain.N9Click(Sender: TObject);
begin
  CoolTrayIcon1.CycleIcons := TMenuItem(Sender).Checked;
  if not CoolTrayIcon1.CycleIcons then
    CoolTrayIcon1.IconIndex := 0;
end;

procedure TToolsMain.pi_ExitClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要退出系统配置程序吗？　　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    gbCanClose := True;
    Close;
  end else
  begin
    gbCanClose := False;
  end;
end;

procedure TToolsMain.pi_ShowClick(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;


procedure TToolsMain.QueryEndSession(var Msg: TMessage);
begin
  gbCanClose := True;
  Msg.Result:=1;  //0:不允许系统关机/重启，1：允许
end;

function TToolsMain.RegIsOK: Boolean;
begin
  Result := (UserName<>'') and (UserCode<>'') and (DeCrypt(UserCode) = UserName);
  //Result := vobj_Account.RegIsOK;
end;

function TToolsMain.SrvIsOpened: Boolean;
var
  qry_Temp:TAdoquery;
begin
  Result := DbSrvIsOK;
  if not Result then
    Exit;

  Result := False;
  qry_Temp := TAdoquery.Create(nil);
  try
    try
      qry_Temp.Active := False;
      qry_Temp.ConnectionString := GetConnectString;
      qry_Temp.CommandTimeout := 3;
      qry_Temp.SQL.Text := 'select 是否启用 from 服务器状态配置表';
      qry_Temp.Active := True;
      Result := qry_Temp.Fields[0].AsBoolean;
    except;
      Result := False;
    end;
  finally
    qry_temp.Free;
  end;
end;

procedure TToolsMain.tmr_AutoBackupTimer(Sender: TObject);
var
  sTime:string;
begin
  sTime := FormatDateTime('hh:nn',Time);
  if sTime='03:00' then
  begin
    if IsAutoBackup and DbSrvIsOK then
      BackupSQLDB;
  end;
end;

procedure TToolsMain.UpdateSrvStatus;
begin
  if not DbSrvIsOK then
  begin
    sp_SrvState.Font.Color := clBlack;
    sp_SrvState.Caption := '正在获取服务器状态...';
  end else
  begin
    if GetUserInfo then
    begin
      Caption := SYS_TITLE+' Ver '+Get_Version;
      if RegIsOK then
      begin
        Caption := Caption + ' [已注册版本]';
        albl_Dwmc.Font.Color := clBlue;
        albl_Dwmc.Caption := Format('%26s',['---已授权:'+UserName]);
      end else
      begin
        Caption := Caption + ' [未注册版本]';
        albl_Dwmc.Font.Color := clRed;
        albl_Dwmc.Caption := '---'+'系统未注册！请尽快注册！';
      end;
    end;
    if SrvIsOpened then
    begin
      sp_SrvState.Font.Color := clBlue;
      sp_SrvState.Caption := '系统服务运行中...';
      CoolTrayIcon1.IconIndex := 0;
    end else
    begin
      sp_SrvState.Font.Color := clRed;
      sp_SrvState.Caption := '系统服务已停止！';
      CoolTrayIcon1.IconIndex := 1;
    end;
  end;
end;

end.
