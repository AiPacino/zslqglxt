unit uDbConnect;

interface
uses SysUtils,IniFiles,Windows,ADODB;

Resourcestring
//const
  GbDbSetFileName = '\NewStuLqBdDbConnSet.INI';

function ReadConnInfo(var vHost,vDb,vSa,vPwd,vMode:string):string;
function GetConnectString:string;
function WriteConnInfo(const vHost,vDb,vSa,vPwd,vMode:string):Boolean;
function DbSrvIsOK:Boolean;

implementation

function ReadConnInfo(var vHost,vDb,vSa,vPwd,vMode:string):string;
var
  vMdb,fn:string;
  sPath: array [0..255] of Char;
begin
{ //������ISAPIģʽ��Web Service����COM+��ʱ��Ĭ�ϵ�Internet�û�IUS_XXX��Ȩ�޶�дע����
  //��ֻ�ܸ�Ϊ��ȡWindowsϵͳĿ¼�е������ļ���ʽ��
  //by С��ɵ� 2008-5-2
  with TRegistry.Create do
  try
    RootKey := HKEY_CURRENT_USER;
    OpenKey(FRegKey, True);
    str := ReadString('Host_Name');
    FHost := DeCrypt(str);
    str := ReadString('Db_Name');
    FDbName := DeCrypt(str);
    str := ReadString('Sa_Name');
    FSaName := DeCrypt(str);
    str := ReadString('Sa_Pwd');
    FSaPwd := DeCrypt(str);
    CloseKey;
  finally
    Free;
  end;
}
  //fn := ExtractFilePath(ParamStr(0))+'DbConnSet.ini';
  GetWindowsDirectory(@sPath,40);  //�õ�Windows��ϵͳĿ¼
  fn := sPath+GbDbSetFileName;

  //CoInitialize(nil);
  with TIniFile.Create(fn) do
  begin
    try
      vMode := ReadString('DBSET','ConnMode','SQL');
      if UpperCase(vMode)='ACCESS' then
        vMdb := ReadString('DBSET','MdbFileName','E:\xxx\����ϵͳ\Exe\Data\lqmd.mdb')
      else
      begin
        vHost := ReadString('DBSET','Host','(local)');
        vSa := ReadString('DBSET','SaName','NewStuLqBd_sa');
        vPwd := ReadString('DBSET','SaPwd','');
        vDb := ReadString('DBSET','DbName','');
      end;
    finally
      Free;
      //CoUninitialize;
    end;
  end;
  if not FileExists(fn) then
    WriteConnInfo(vHost,vDb,vSa,vPwd,vMode);

  if vHost='' then Result := '';

  if UpperCase(vMode) = 'SQL' then  //SQL����ģʽ
     Result := 'Provider=SQLOLEDB.1;Password='+vPwd+';Persist Security Info=True;User ID='+vSa+';'+
               'Initial Catalog='+vDb+';Data Source='+vHost
  else if UpperCase(vMode) = 'WIN' then //Windows NT����ģʽ
     Result := 'Provider=SQLOLEDB.1;Integrated Security=SSPI;Persist Security Info=False;'+
               'Initial Catalog='+vDb+';Data Source='+vHost
  else if UpperCase(vMode)='ACCESS' then
     Result := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+vMdb+';Persist Security Info=False'
end;

function GetConnectString:string;
var
  vHost,vDb,vSa,vPwd,vMode:string;
begin
  Result := ReadConnInfo(vHost,vDb,vSa,vPwd,vMode);
end;

function WriteConnInfo(const vHost,vDb,vSa,vPwd,vMode:string):Boolean;
var
  fn:string;
  sPath: array [0..255] of Char;
begin
  try
    //fn := ExtractFilePath(ParamStr(0))+'DbConnSet.ini';
    GetWindowsDirectory(@sPath,40);  //�õ�Windows��ϵͳĿ¼
    fn := sPath+GbDbSetFileName;

    //CoInitialize(nil);
    with TIniFile.Create(fn) do
    begin
      try
        WriteString('DBSET','ConnMode',vMode);
        if (UpperCase(vMode)='SQL') or (UpperCase(vMode)='WIN') then
        begin
          WriteString('DBSET','Host',vHost);
          WriteString('DBSET','SaName',vSa);
          WriteString('DBSET','SaPwd',vPwd);
          WriteString('DBSET','DbName',vDb);
        end
        else if UpperCase(vMode)='ACCESS' then
          WriteString('DBSET','MdbFileName','E:\xxx\����ϵͳ\Exe\Data\lqmd.mdb');
      finally
        Free;
        //CoUninitialize;
      end;
    end;
    Result := True;
  except
    MessageBox(0, PChar('���ݿ����������ļ�����ʧ�ܣ���'+#13+fn), 'ϵͳ��ʾ', MB_OK + MB_ICONWARNING 
      + MB_TOPMOST);
    Result := False;
  end;
end;

function DbSrvIsOK:Boolean;
var
  adoConn:TAdoconnection;
begin
  Result := True;
  adoConn := TADOConnection.Create(nil);
  try
    adoConn.ConnectionString := GetConnectString;
    if adoConn.ConnectionString='' then Exit;

    adoConn.LoginPrompt := False;
    adoConn.ConnectionTimeout := 3;
    try
      adoConn.Connected := True;
      Result := True;
    except
      Result := False;
    end;
  finally
    adoConn.Close;
    adoConn.Free;
  end;
end;

end.
