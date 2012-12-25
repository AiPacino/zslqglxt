unit uServiceSet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, Rio, ShellAPI, uNewStuLqBdIntf,StrUtils,
  SOAPHTTPClient, InvokeRegistry, pngimage, frxpngimage, RzLabel;

type
  TServiceSet = class(TForm)
    btn_Set: TBitBtn;
    btn_Exit: TBitBtn;
    btn_ReSet: TButton;
    btn_Test: TBitBtn;
    HTTPRIO1: THTTPRIO;
    bvl1: TBevel;
    Label1: TLabel;
    lbledt_VirtualDir: TLabeledEdit;
    lbledt_Path: TLabeledEdit;
    lbledt_IP: TLabeledEdit;
    chk1: TCheckBox;
    btn_Ini: TBitBtn;
    btn_Browse: TBitBtn;
    img1: TImage;
    Label2: TLabel;
    btn_IIsExp: TBitBtn;
    URLLabel: TRzURLLabel;
    procedure lbledt_VirtualDirChange(Sender: TObject);
    procedure btn_BrowseClick(Sender: TObject);
    procedure btn_SetClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure chk1Click(Sender: TObject);
    procedure btn_ReSetClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btn_ExitClick(Sender: TObject);
    procedure btn_TestClick(Sender: TObject);
    procedure btn_IniClick(Sender: TObject);
    procedure btn_IIsExpClick(Sender: TObject);
    procedure URLLabelClick(Sender: TObject);
  private
    { Private declarations }
    sSrvUrl:string;
  public
    { Public declarations }
  end;

//var
//  ServiceSet: TServiceSet;

implementation
uses uIIS,Net, uDM;
{$R *.dfm}

function   GetWindowsPath:   String;
var
    buf       :   Array[0..255]   of   Char;
    s           :   String;
begin
    GetWindowsDirectory(   @Buf,   255   );
    s   :=   StrPas(   @Buf   );
    if   s[Length(s)]   <>   '\'   then
          s   :=   s   +   '\';
    Result   :=   s;
end;

procedure TServiceSet.btn_BrowseClick(Sender: TObject);
var
  sDir:string;
begin
  sDir := lbledt_Path.Text;
  if SelectFolder('请选择虚拟目录所在的文件夹'   ,'我的电脑' ,sDir) then
    lbledt_Path.Text := sDir;
end;

procedure TServiceSet.btn_ExitClick(Sender: TObject);
begin
  Close;
end;

procedure TServiceSet.btn_IIsExpClick(Sender: TObject);
var
  fn:string;
begin
  if not ((GetWindowsVersion='Windows 2003') or (GetWindowsVersion='Windows 2003 Later')) then
    Application.MessageBox(PChar(GetWindowsVersion+'无须配置Web扩展！只有Windows 2003/2008　　'
      + #13#10 + '及以后版本才需进行Web扩展设置！'), '系统提示', MB_OK +
      MB_ICONINFORMATION)
  else
  begin
    fn := GetWindowsPath+'system32\inetsrv\iis.msc';
    ShellExecute(0,'open',PChar(fn),PChar(lbledt_Path.Text),nil,SW_SHOW);
  end;
end;

procedure TServiceSet.btn_IniClick(Sender: TObject);
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  dm.SetConnInfo(sSrvUrl); //存储服务器配置信息
  if MessageBox(Handle, '客户端文件已生成！要查看配置文件内容吗？　　',
    '系统提示', MB_YESNO + MB_ICONINFORMATION + MB_TOPMOST) = IDYES  then
    ShellExecute(Application.Handle,'open',PChar(fn),nil,nil,SW_SHOW);
end;

procedure TServiceSet.btn_ReSetClick(Sender: TObject);
var
  sIp:String;
begin
  if GetFirstWebSite='' then
  begin
    MessageBox(Handle,
      '服务器信息读取失败！请确定本机已安装好IIS 5.0/6.0！　　',
      '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    sIp := GetLocalIpStr;
  end else
  begin
    sIp := GetWebSiteIP(1);//第一个Web Site
    if sIp[Length(sIp)]=':' then
       sIp := Copy(sIp,1,Length(sIp)-1);
    if sIp[1]=':' then
       sIp := GetLocalIpStr+sIp;
  end;
  lbledt_IP.Text := 'http://'+sIp+'/';
  lbledt_Path.Text := ExtractFilePath(ParamStr(0));
  lbledt_VirtualDir.Text := 'zslq/Srv';
  lbledt_VirtualDir.OnChange(Sender);
  //Label1.Caption := '即客户端连接URL：'+lbledt_IP.Text+lbledt_VirtualDir.Text+'/';
end;

procedure TServiceSet.btn_SetClick(Sender: TObject);
var
  iWebSiteIndex:Integer;
  sWebDir,sHint,sVirDir:string;
begin
  iWebSiteIndex := 0;
  if lbledt_Path.Text='' then
  begin
    MessageBox(Handle, '请选择虚拟目录所在的物理路径！　　',
      '系统提示', MB_OK + MB_ICONINFORMATION);
    Exit;
  end;

  sVirDir := lbledt_VirtualDir.Text;
  if Pos('/',sVirDir)>0 then  //如果有二级虚拟目录
    sVirDir := LeftStr(sVirDir,PosRight('/',sVirDir));
  if RightStr(sVirDir,1)='/' then
    sVirDir := LeftStr(sVirDir,Length(sVirDir)-1);
  
  //if not VirtualDirIsExists(sVirDir,iWebSiteIndex+1) then
  begin
    sWebDir := ExtractFileDir(lbledt_Path.Text);
    sWebDir := LeftStr(sWebDir,PosRight('\',sWebDir));
    if not DirectoryExists(sWebDir) then
      CreateDir(sWebDir);
    CreateVirtualDir(sVirDir,sWebDir,'录取报到系统根目录',iWebSiteIndex+1,False);
    //CreateVirtualDir(sVirDir,sWebDir,'',iWebSiteIndex+1,False);
  end;

  if VirtualDirIsExists(lbledt_VirtualDir.Text,iWebSiteIndex+1) then
  begin
    sHint := '虚拟目录已存在！要删除它重新建立吗？　　';

    if MessageBox(Handle, PAnsiChar(sHint), '系统提示', MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2) <> IDYES then
      Exit;
  end;

  //if not VirtualDirIsExists(sVirDir'/Web',iWebSiteIndex+1) then
  begin
    sWebDir := ExtractFileDir(lbledt_Path.Text);
    sWebDir := LeftStr(sWebDir,PosRight('\',sWebDir));
    if sWebDir[Length(sWebDir)]<>'\' then sWebDir := sWebDir+'\';
    sWebDir := sWebDir+'Web';
    if not DirectoryExists(sWebDir) then
      CreateDir(sWebDir);
    CreateVirtualDir(sVirDir+'/Web',sWebDir,'录取报到Web子系统',iWebSiteIndex+1,False);
  end;
  if CreateVirtualDir(lbledt_VirtualDir.Text,lbledt_Path.Text,'系统内核Web Service',iWebSiteIndex+1) then
    MessageBox(Handle,'服务器参数设置设置成功！　　','系统提示', MB_OK +MB_ICONINFORMATION);
end;

procedure TServiceSet.btn_TestClick(Sender: TObject);
begin
  HTTPRIO1.URL := sSrvUrl+SOAP_NAME;
  try
    (HTTPRIO1 as INewStuLqBd).SrvIsOK;
    MessageBox(Handle, '系统服务器连接成功！　　', '系统提示', MB_OK +
      MB_ICONINFORMATION + MB_TOPMOST);
    //btn_Ini.Click; //生成一个客户端配置文件
  except
    MessageBox(Handle, '系统服务器连接失败！　　', '系统提示', MB_OK +
      MB_ICONSTOP + MB_TOPMOST);
  end;
end;

procedure TServiceSet.chk1Click(Sender: TObject);
begin
  lbledt_VirtualDir.Enabled := chk1.Checked;
end;

procedure TServiceSet.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure TServiceSet.FormCreate(Sender: TObject);
begin
  btn_ReSetClick(Sender);
end;

procedure TServiceSet.lbledt_VirtualDirChange(Sender: TObject);
var
  sUrl:string;
begin
  sSrvUrl := lbledt_IP.Text+lbledt_VirtualDir.Text;;
  if sSrvUrl[Length(sSrvUrl)]<>'/' then
    sSrvUrl := sSrvUrl+'/';
  sUrl := sSrvUrl+SOAP_NAME;
  URLLabel.Caption := sUrl;
  sUrl := StringReplace(sUrl,'/soap','',[rfReplaceAll,rfIgnoreCase]);
  URLLabel.URL := sUrl;
end;

procedure TServiceSet.URLLabelClick(Sender: TObject);
var
  sUrl:string;
begin
  sUrl := URLLabel.Caption;
  sUrl := StringReplace(LowerCase(sUrl),'/soap','/wsdl',[rfReplaceAll]);
  ShellExecute(0,'open',PChar(sUrl),nil,nil,SW_SHOW);
end;

end.
