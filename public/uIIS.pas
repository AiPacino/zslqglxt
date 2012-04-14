unit uIIS;

{=======================================================
Unit Name: uIIS
Comment: 对IIS进行控件一组函数，主要有WebSite的信息的获取、停止、启动、暂停，
         虚拟目录的新建、修改、删除、是否存在的判断，IIS的停止、启动、暂停等
         所有执行命令的函数执行不成功时都加上提示对话框，而执行成功时理应由
         程序调用者决定是否出现执行成功的提示
Author: xieyunc http://xieyunc.jxstnu.edu.cn/
Date: 2008.10.31
========================================================}
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComObj,ShellAPI;

  function GetFirstWebSite:String;
  function GetWebSiteList(slWebSiteList:TStrings):Integer;
  function GetWebSitePath(const iWebSiteIndex:Integer=1):string;
  function GetWebSiteIP(const iWebSiteIndex:Integer=1):string;
  function VirtualDirIsExists(const strVirtualDir:string;
                              const iWebSiteIndex:Integer=1):Boolean;

  function CreateVirtualDir(const strVirtualDir,strDir,AppName:string;
                            const iWebSiteIndex:Integer=1;const bAllowExec:Boolean=True):Boolean;
  function DeleteVirtualDir(const strVirtualDir: string;
                            const iWebSiteIndex:Integer=1): Boolean;
  function DeleteVirtualDirApp(const strVirtualDir: string;
                               const iWebSiteIndex:Integer=1): Boolean;

  function StopWebServer(const iWebSiteIndex:Integer=1):Boolean;
  function StartWebServer(const iWebSiteIndex:Integer=1):Boolean;
  function PauseWebServer(const iWebSiteIndex:Integer=1):Boolean;
  //如何得到WEB站点的三种状态： 2是运行,4是停止,6是暂停
  function GetWebServerState(const iWebSiteIndex:Integer=1):Integer;

  function ControlIIS(const strAction:string='restart'):Boolean;
                            //参数  /restart   停止并重起所有INTERNET服务
                            //      /start     启动所有INTERNET   服务
                            //      /stop      停止所有INTERNET服务
                            //      /reboot    重起计算机
                            //      /Status    显示所有INTERNET服务状态等等

implementation

function GetFirstWebSite:String;
var
  WebSite, WebServer: Variant;
begin
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    //iCount得到第几个站点的信息
    WebServer := WebSite.GetObject('IIsWebServer', '1');//第一个Web Site
    Result :=  WebServer.ServerComment;
  except
    Result := '';
  end;
end;

function GetWebSiteList(slWebSiteList:TStrings):Integer;
var
  WebSite, WebServer: Variant;
  iCount: Integer;
begin
  Result := 0;
  iCount :=1;

  slWebSiteList.Clear;
  while True do
  begin
    try
      WebSite :=CreateOLEObject('IISNamespace');
      WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
      //iCount得到第几个站点的信息
      WebServer := WebSite.GetObject('IIsWebServer', InttoStr(iCount));
      slWebSiteList.Add(WebServer.ServerComment);
      Result := iCount;
      Inc(iCount);
    except
      Break;
    end;
  end;
end;

function GetWebSitePath(const iWebSiteIndex:Integer=1):string;
var
  WebSite, WebServer, WebRoot: Variant;
begin
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    Result := WebRoot.Path; //这就是地址,C\Inetpub\wwwroot 或D:\Inetpub\wwwroot
  except
    Result := '';
  end;
end;

function GetWebSiteIP(const iWebSiteIndex:Integer=1):string;
var
  WebSite, WebServer: Variant;
  ar: array of variant;
begin
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    ar :=    WebServer.ServerBindings;   //把IIS虚拟站点绑定的IP、端口、域名的值放入数组
    Result := ar[0];
   except
   end;
end;

function VirtualDirIsExists(const strVirtualDir:string;
                            const iWebSiteIndex:Integer=1):Boolean;
var
  WebSite, WebServer, WebRoot, VDir: Variant;
begin
  Result := False;
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    vdir := WebRoot.GetObject('IIsWebVirtualDir', strVirtualDir);
    Result := True;
  except
    //on e:Exception do
    begin
      //如果出错则代表不存在此虚拟目录;
      //MessageBox(0, '虚拟目录不存在！　　', '系统提示', MB_OK + MB_ICONSTOP);
      //ShowMessage(e.Message);
      Result := False;
    end;
  end;
end;

//如何删除虚拟目录[/color]
function DeleteVirtualDir(const strVirtualDir: string;
                          const iWebSiteIndex:Integer=1): Boolean;
var
  WebSite, WebServer, WebRoot: Variant;
begin
  Result := True;
  try
    WebSite := CreateOleObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    WebRoot.Delete('IIsWebVirtualDir',strVirtualDir);
    //MessageBox(0, '虚拟目录删除成功！　　', '系统提示', MB_OK + MB_ICONINFORMATION);
  except
    MessageBox(0, '虚拟目录删除失败！　　', '系统提示', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;

//如何创建 IIS 虚拟目录：[/color]
function CreateVirtualDir(const strVirtualDir,strDir,AppName:string;
                          const iWebSiteIndex:Integer=1;const bAllowExec:Boolean=True):Boolean;
var
  WebSite, WebServer, WebRoot, VDir: Variant;
begin
  if VirtualDirIsExists(strVirtualDir,iWebSiteIndex) then
    DeleteVirtualDir(strVirtualDir,iWebSiteIndex);

  try
    WebSite := CreateOleObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebServer.SetInfo;
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    VDir := WebRoot.Create('IIsWebVirtualDir', strVirtualDir);
    //虚拟目录权限设置
    VDir.AccessRead := True;   //读取
    VDir.AccessWrite := False;  //写入
    VDir.AccessScript := True;   //纯脚本
    VDir.AccessExecute := bAllowExec;  //True //脚本和可执行文件
    VDir.EnableDirBrowsing := False; //目录浏览
    VDir.Path := strDir;
    if AppName<>'' then
    begin
      VDir.AppCreate(True);  //如果没有这句的话,虚拟目录就要人为的手工创建应用程序名
      VDir.AppFriendlyName := AppName; //应用程序名
    end;
    VDir.SetInfo;
    //MessageBox(0,'虚拟目录创建成功！　　','系统提示', MB_OK +MB_ICONINFORMATION);
    Result := True;
  except
    MessageBox(0, '虚拟目录创建失败！　　', '系统提示', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;
//附虚拟目录的属性：
//有网友问我为什么前面的创建虚拟目录的例子执行权限都是无，看了一下自己写滴，确实有一些属性没有设置，现贴出一些常用属性供参考
{
  VDir.AccessRead := True;   //读取
  VDir.AccessWrite := True;  //写入
  VDir.AccessExecute := True;  //脚本和可执行文件
  VDir.AccessScript := True;   //纯脚本
  VDir.EnableDirBrowsing := True; //目录浏览
  VDir.Path := 'F:&#92;VariantTest'; //路径
  VDir.AppCreate(True);
  VDir.AppFriendlyName :='VariantTest'; //应用程序名
}

//如何删除虚拟目录应用程序名[/color]
function DeleteVirtualDirApp(const strVirtualDir: string;
                             const iWebSiteIndex:Integer=1): Boolean;
var
  WebSite, WebServer, WebRoot,vdir: Variant;
begin
  Result := True;
  try
    WebSite := CreateOleObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    WebRoot := WebServer.GetObject('IIsWebVirtualDir', 'Root');
    vdir :=WebRoot.GetObject('IIsWebVirtualDir', strVirtualDir);
    vdir.AppDelete;
    vdir.SetInfo;
    //MessageBox(0, '虚拟目录应用程序名称删除成功！　　', '系统提示', MB_OK + MB_ICONINFORMATION);
  except
    MessageBox(0, '虚拟目录应用程序名称删除失败！　　', '系统提示', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;

//如何通过程序控制默认WEB站点的例子,三种状态2是运行,4是停止,6是暂停[/color]
//停止WEB站点
function StopWebServer(const iWebSiteIndex:Integer=1):Boolean;
var
  WebSite, WebServer: Variant;
begin
  Result := True;
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    if string(WebServer.ServerState)='2' then
    begin
      WebServer.Stop;
      //MessageBox(Application.Handle, 'Web站点服务已停止！　　', '系统提示', MB_OK + MB_ICONINFORMATION);
      Result := True;
    end;
  except
    MessageBox(0, 'Web站点服务停止失败！请重试！　　', '系统提示', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;

//启动WEB站点
function StartWebServer(const iWebSiteIndex:Integer=1):Boolean;
var
  WebSite, WebServer: Variant;
begin
  Result := True;
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    if string(webserver.ServerState) ='4' then
    begin
      WebServer.Start;
      //MessageBox(0, 'Web站点服务已启动！　　', '系统提示', MB_OK + MB_ICONINFORMATION);
      Result := True;
    end;
  except
    MessageBox(0, 'Web站点启动失败！请重试！　　', '系统提示', MB_OK +
      MB_ICONSTOP);
    Result := False;
  end;
end;

//暂停WEB站点
function PauseWebServer(const iWebSiteIndex:Integer=1):Boolean;
var
  WebSite, WebServer: Variant;
begin
  Result := True;
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    if string(WebServer.ServerState) ='2' then
    begin
      WebServer.Pause;
      //MessageBox(Application.Handle, 'Web站点已暂停！　　', '系统提示', MB_OK + MB_ICONINFORMATION);
      Result := True;
    end;
  except
    MessageBox(0, 'Web站点暂停失败！请重试！　　', '系统提示', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;

//如何得到WEB站点的三种状态： 2是运行,4是停止,6是暂停
function GetWebServerState(const iWebSiteIndex:Integer=1):Integer;
var
  WebSite, WebServer: Variant;
begin
  try
    WebSite :=CreateOLEObject('IISNamespace');
    WebSite := WebSite.GetObject('IIsWebService', 'localhost/w3svc');
    WebServer := WebSite.GetObject('IIsWebServer', IntToStr(iWebSiteIndex));
    Result := WebServer.ServerState;
  except
    MessageBox(0, '获取Web站点服务状态失败！请重试！　　', '系统提示', MB_OK + MB_ICONSTOP);
    Result := -1;
  end;
end;

//Q: 如何重启IIS  A:用IISRESET /? 命令
//参数  /restart   停止并重起所有INTERNET服务
//      /start     启动所有INTERNET   服务
//      /stop      停止所有INTERNET服务
//      /reboot    重起计算机
//      /Status    显示所有INTERNET服务状态等等
function ControlIIS(const strAction:string='restart'):Boolean;
var
  sCmd:string;
begin
  if strAction[1]<>'/' then
    sCmd := '/'+strAction
  else
    sCmd := strAction;
  try
    //WinExec(pchar('iisReset'+sCmd),SW_HIDE); //用WinExec执行时好象有问题
    //WinExec(pchar('iisReset'+sCmd),SW_SHOW); //用WinExec执行时好象有问题
    ShellExecute(Application.Handle,'open','IISReset',PChar(sCmd),nil,SW_Hide);
    Result := True;
    //MessageBox(Application.Handle, '操作完成！命令执行成功！　　', '系统提示', MB_OK +
    //    MB_ICONINFORMATION);
  except
    MessageBox(0, 'IIS控制命令执行失败！请重试！　　', '系统提示', MB_OK + MB_ICONSTOP);
    Result := False;
  end;
end;


end.
