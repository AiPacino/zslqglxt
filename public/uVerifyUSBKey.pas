unit uVerifyUSBKey;

interface
uses SysUtils,Smart1000AppApis;
var
  gb_SrvIP:string;
  function CheckUSBKey(const APPID:Integer;const AppName:string):Boolean;
  function GetSrvIp:string;

implementation

function CheckUSBKey(const APPID:Integer;const AppName:string):Boolean;
var
  keyHandle:array [0..7] of Integer;
  keyNumber:Integer;
  keyName:array [0..16] of Char;//加密锁别名
  pwd1,pwd2,pwd3,pwd4:Integer;//4个用户密码
  request:Integer;//返回密钥A
  response:Integer;//密钥B
  pageData:array [0..256] of Char; //分页存储区数据
  Rtn,i:Integer;
  url,sLastDate:string;
begin
  Result := False;
  //查找加密锁
  //APPID:=$00ABCDEF;    //应用程序标识,输入范围0x0--0xFFFFFFFF，设号工具中设置值为16进制，$代表16进制
  Rtn:=Smart1000AppApis.Smart1000Find(APPID,@keyHandle,@keyNumber); //输入正确的程序标识
  if Rtn<>0 then Exit;

  try
    //获取硬件序列号(32位固定长度)
    //Rtn:=Smart1000AppApis.Smart1000GetUID(keyHandle[0],@GUID);
    //if Rtn<>0 then Exit;

    //获取加密锁别名(最大长度16位)
    keyName:='';
    Rtn:=Smart1000AppApis.Smart1000GetKeyName(keyHandle[0],keyName);
    if Rtn<>0 then Exit;
    if keyName<>AppName then Exit;


    //打开加密锁
    //用户密码，通过设号工具设置,以下数据是出厂默认设置 由 超级密码（admin） + 种子码（FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF）生成的十六进制数;
    pwd1:=$87DA211;//$1ADC0193;
    pwd2:=$3EBCB2F7;//$854110F2;
    pwd3:=$CE3BDBAD;//$5DAE0EBC;
    pwd4:=$6B6D224F;//$A89011EE;
    Rtn:=Smart1000AppApis.Smart1000Open(keyHandle[0],pwd1,pwd2,pwd3,pwd4,@request); //输入正确的用户密码进行打开,并返回密钥A
    //RtnMSG('Smart1000 Open Successful！','Smart1000 Open fail！' );

    //二次认证，成功后才能进行读写操作
    //二次冲击认证  response由设号工具设置，open后返回的requestFromKey 对应相关response；
    //request(A) 和 response(B) 由用户通过设号工具设置 默认设置为request = 1 2 …… 64 与  response = 1 2 …… 64 对应，即request  = response ，
    //示例中使用的是默认出厂设置.
    response:=request;//出厂默认密钥A和密钥B相同，分别为1、2、3...64
    Rtn:=Smart1000AppApis.Smart1000Verify(keyHandle[0],response);
    if Rtn<>0 then Exit;

    //读分页存储区
    //0,1,2,3共4个分页存储区，0: http://ip:80/kjcx/srv/   1: 2013-12-24 软件日期
    Rtn:=Smart1000AppApis.Smart1000ReadPage(keyHandle[0],0,pageData);  // 读取数据，读取的数据放在pageData中
    if Rtn<>0 then Exit;
    //--------------------------------------------//
    url := pageData;
    if LowerCase(Copy(url,1,7))<>'http://' then
      url := 'http://'+url;
    if Copy(url,Length(url),1)<>'/' then
      url := url+'/';
    gb_SrvIP := url;
    //-------------------------------------------//
    Rtn:=Smart1000AppApis.Smart1000ReadPage(keyHandle[0],1,pageData);  // 读取数据，读取的数据放在pageData中

    //if (pageData < '2014-03-10') then
    //  Rtn:=Smart1000AppApis.Smart1000WritePage(keyHandle[0],1,pageData);
    sLastDate := pageData;
    if (Rtn<>0) or (FormatDateTime('yyyy-mm-dd',Now)>sLastDate) then Exit;

    Result := True;
  finally
    //关闭加密锁
    Smart1000AppApis.Smart1000Close(keyHandle[0]);    //关闭加密锁，释放权限
    //可以通过keyHandle中的值去操作每一只锁。
  end;
end;

function GetSrvIp:string;
begin

end;

end.
