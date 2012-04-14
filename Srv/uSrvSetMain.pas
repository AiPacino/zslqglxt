unit uSrvSetMain;

interface

uses
  SysUtils, Classes, Forms, Controls, CnAAFont, CnAACtrls, RzStatus,
  ExtCtrls, RzPanel, Menus, CoolTrayIcon, ShellAPI, 
  Windows, Graphics,ADODB,IniFiles,Messages, auHTTP,
  auAutoUpgrader;

type
  TSrvSetMain = class(TForm)
    CnAALabel1: TCnAALabel;
    lbl_Dwmc: TCnAALabel;
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
    sp_Time: TRzStatusPane;
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
  private
    { Private declarations }
    UserName,UserCode:string;
    procedure QueryEndSession(var Msg:TMessage);Message WM_QueryEndSession;
    function GetUserInfo:Boolean;
    function RegIsOK:Boolean;
    procedure UpdateSrvStatus;
    function IsAutoBackup:Boolean;
  public
    { Public declarations }
  end;

const
  SYS_TITLE = '教材管理系统服务小精灵';

var
  SrvSetMain: TSrvSetMain;
  gbCanClose: Boolean;

implementation

uses uDM,Net,SockApp,uDbInfoSet,uServiceSet,uDbConnect,PwdFunUnit,
  uSQLBackupRestore,uDbBackupRestore;

{$R *.dfm}

procedure TSrvSetMain.A1Click(Sender: TObject);
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

procedure TSrvSetMain.auAutoUpgrader1DoOwnCloseAppMethod(Sender: TObject);
begin
  gbCanClose := True;
  Close;
end;

procedure TSrvSetMain.CoolTrayIcon1BalloonHintClick(Sender: TObject);
begin
  if not DbSrvIsOK then
    Self.CoolTrayIcon1.ShowMainForm;
end;

procedure TSrvSetMain.CoolTrayIcon1DblClick(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;

procedure TSrvSetMain.CoolTrayIcon1MinimizeToTray(Sender: TObject);
begin
  if DbSrvIsOK then
    CoolTrayIcon1.ShowBalloonHint(SYS_TITLE,'教材服务正在运行......',bitInfo,10)
  else
    CoolTrayIcon1.ShowBalloonHint(SYS_TITLE,'数据库服务器连接失败......',bitError,10);
end;

procedure TSrvSetMain.FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
  var Resize: Boolean);
begin
  Resize := False;
end;

procedure TSrvSetMain.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if not gbCanClose then
    Hide;
  CanClose := gbCanClose;
end;

procedure TSrvSetMain.FormCreate(Sender: TObject);
begin
  gbCanClose := False;
  Application.ShowMainForm := False;
  sp_Time.Caption := DateTimeToStr(Now);
  Self.CoolTrayIcon1.Hint := SYS_TITLE;
  Application.Title := SYS_TITLE;
  UpdateSrvStatus;
  CoolTrayIcon1MinimizeToTray(Self);
end;

function TSrvSetMain.GetUserInfo:Boolean;
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
    UserName := vobj.GetUserInfo;
    UserCode := vobj.GetUserCode;
    Result := True;
  except
    Result := False;
  end;
}
end;

function TSrvSetMain.IsAutoBackup: Boolean;
var
  fn:string;
  ifn :TIniFile;
begin
  fn := ExtractFilePath(ParamStr(0))+'SrvSet.ini';
  ifn := TIniFile.Create(fn);
  try
    Result := ifn.ReadBool('SRVSET','AUTOBACK',False);
  finally
    ifn.Free;
  end;
end;

procedure TSrvSetMain.mi_UpdateClick(Sender: TObject);
begin
  Screen.Cursor := crHourGlass;
  try
    auAutoUpgrader1.InfoFileURL := vobj.GetSrvAutoUpdateUrl;
    auAutoUpgrader1.CheckUpdate;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TSrvSetMain.mi_UrlClick(Sender: TObject);
begin
  ShellExecute(Handle,'open','http://xieyunc.jxstnu.edu.cn/',nil,nil,1);
end;

procedure TSrvSetMain.mi_BackUp_RestoreClick(Sender: TObject);
begin
  with TDbBackUpRestore.Create(nil) do
  begin
    //Top := Self.Top+40;
    //Left := Self.Left+30;
    ShowModal;
  end;
end;

procedure TSrvSetMain.mi_DbSetClick(Sender: TObject);
begin
  TDbInfoSet.Create(nil).ShowModal;
  UpdateSrvStatus;
end;

procedure TSrvSetMain.mi_ExitClick(Sender: TObject);
begin
  gbCanClose := True;
  Close;
end;

procedure TSrvSetMain.mi_HideClick(Sender: TObject);
begin
  CoolTrayIcon1.HideMainForm;
end;

procedure TSrvSetMain.N2Click(Sender: TObject);
begin
  TServiceSet.Create(nil).ShowModal;
  UpdateSrvStatus;
end;

procedure TSrvSetMain.N3Click(Sender: TObject);
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

procedure TSrvSetMain.pi_ExitClick(Sender: TObject);
begin
  if MessageBox(Handle, '真的要退出教材管理系统小精灵吗？　　', '系统提示',
    MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDYES then
  begin
    gbCanClose := True;
    Close;
  end else
  begin
    gbCanClose := False;
  end;
end;

procedure TSrvSetMain.pi_ShowClick(Sender: TObject);
begin
  CoolTrayIcon1.ShowMainForm;
end;


procedure TSrvSetMain.QueryEndSession(var Msg: TMessage);
begin
  gbCanClose := True;
  Msg.Result:=1;  //0:不允许系统关机/重启，1：允许
end;

function TSrvSetMain.RegIsOK: Boolean;
begin
  Result := (UserName<>'') and (UserCode<>'') and (DeCrypt(UserCode) = UserName);
  //Result := vobj.RegIsOK;
end;

procedure TSrvSetMain.tmr_AutoBackupTimer(Sender: TObject);
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

procedure TSrvSetMain.UpdateSrvStatus;
begin
  if GetUserInfo then
  begin
    Caption := SYS_TITLE+' Ver '+Get_Version;
    if RegIsOK then
    begin
      Caption := Caption + ' [已注册版本]';
      lbl_Dwmc.Font.Color := clBlue;
      lbl_Dwmc.Caption := Format('%26s',['---已授权:'+UserName]);
    end else
    begin
      Caption := Caption + ' [未注册版本]';
      lbl_Dwmc.Font.Color := clRed;
      lbl_Dwmc.Caption := '---'+'系统未注册！请尽快注册！';
    end;
  end;
end;

end.
