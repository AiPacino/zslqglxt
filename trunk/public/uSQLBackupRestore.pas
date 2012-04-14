unit uSQLBackupRestore;

interface
uses SysUtils,Windows,ADODB,Controls,Forms,Dialogs,IniFiles;

var
  sSaConnStr:string;

function ReadBakPath:string;
function WriteBakPath(const sBakPath:string):Boolean;
function WriteAutoBackup(const Value:Boolean=True):Boolean;
function ReadAutoBackup:Boolean;

function BackupSQLDB(const bkfn:string='';const IsPrompt:Boolean=False):Boolean;
function RestoreSQLDB(const bkfn:string;const IsPrompt:Boolean=False):Boolean;
function CurHostIsDBSrvHost:Boolean;

implementation
uses uDbConnect,uInputSAPwd,Net;

function ReadBakPath:string;
var
  sBakPath,fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'DbBakSet.ini';
  with TIniFile.Create(fn) do
  try
    sBakPath := ReadString('SRVSET','BAKPATH','');
    if sBakPath='' then
    begin
      if DirectoryExists('D:\') then
        sBakPath := 'D:\ZsLqDB_BAK\'
      else if DirectoryExists('E:\') then
        sBakPath := 'E:\ZsLqDB_BAK\'
      else if DirectoryExists('F:\') then
        sBakPath := 'F:\ZsLqDB_BAK\'
      else if DirectoryExists('G:\') then
        sBakPath := 'G:\ZsLqDB_BAK\'
      else if DirectoryExists('H:\') then
        sBakPath := 'H:\ZsLqDB_BAK\'
      else
        sBakPath := ExtractFilePath(ParamStr(0))+'ZsLqDB_BAK\';
      WriteBakPath(sBakPath);
    end;
    if sBakPath[Length(sBakPath)]<>'\' then sBakPath := sBakPath+'\';
    Result := sBakPath;
  finally
    Free;
  end;
end;

function WriteBakPath(const sBakPath:string):Boolean;
var
  sPath,fn:string;
begin
  sPath := sBakPath;
  fn := ExtractFilePath(ParamStr(0))+'DbBakSet.ini';
  with TIniFile.Create(fn) do
  try
    if sPath='' then  sPath := ExtractFilePath(ParamStr(0))+'BAK\';
    if sPath[Length(sPath)]<>'\' then sPath := sPath+'\';
    WriteString('SRVSET','BAKPATH',sPath);
    if not DirectoryExists(sPath) then
      CreateDir(sPath);
    Result := True;
  finally
    Free;
  end;
end;

function WriteAutoBackup(const Value:Boolean=True):Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'SrvSet.ini';
  with TIniFile.Create(fn) do
  try
    WriteBool('SRVSET','AUTOBACK',Value);
    Result := True;
  finally
    Free;
  end;
end;

function ReadAutoBackup:Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+'SrvSet.ini';
  with TIniFile.Create(fn) do
  try
    Result := ReadBool('SRVSET','AUTOBACK',True);
  finally
    Free;
  end;
end;

//1) 覆盖式的备份数据库到文件
function BackupSQLDB(const bkfn:string='';const IsPrompt:Boolean=False):Boolean;
var
  adoConnStr,vHost,vDb,vSa,vPwd,vMode:string;
  adoConn_Temp:TADOConnection;
  sBakPath,old_fn,fn,sqlstr:string;
begin
  fn := bkfn;
  sBakPath := ReadBakPath;
  if not DirectoryExists(sBakPath) then
    CreateDir(sBakPath);

  if fn = '' then
    fn := sBakPath+FormatDateTime('yyyy-mm-dd',Date)+'备份.dbk';

  old_fn := sBakPath+FormatDateTime('yyyy-mm-dd',Date-3)+'备份.dbk';

  adoConnStr := ReadConnInfo(vHost,vDb,vSa,vPwd,vMode);
  Result := False;
  if adoConnStr='' then Exit;

  if IsPrompt then
  begin
    if FileExists(fn) then
    begin
      if MessageBox(0, '备份文件已存在，要覆盖它吗？　　', '系统提示',
        MB_YESNO + MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      begin
        Exit;
      end;
    end;
    if MessageBox(0, '数据库备份操作可能要花费数秒至数分钟不等　　' +
      #13#10 + '的时间！还要继续数据备份操作吗？　　', '系统提示', MB_YESNO +
      MB_ICONQUESTION + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;
  end;

  Result := DbSrvIsOK;
  if not Result then
    Exit;

  if FileExists(old_fn) then//删除三天之前的备份，以免备份文件过多
     DeleteFile(PChar(old_fn));
  if FileExists(fn) then
     DeleteFile(PChar(fn));

  adoConn_Temp := TADOConnection.Create(nil);
  adoConn_Temp.ConnectionString := adoConnStr;
  adoConn_Temp.LoginPrompt := False;
  Screen.Cursor := crHourGlass;
  try
    sqlstr := 'BACKUP DATABASE '+vDb+' TO DISK = '+quotedstr(fn)+' WITH INIT';
    try
      adoConn_Temp.Execute(sqlstr);
      if IsPrompt then
         MessageBox(0, '操作完成！数据已成功备份！　　', '系统提示', MB_OK + MB_ICONINFORMATION + MB_TOPMOST);
      Result := True;
    except
      Result := False;
      if IsPrompt then
         MessageBox(0, '数据备份失败！请检查磁盘空间是否充足！　　', '系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end;
  finally
    adoConn_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

//2) 数据恢复
function RestoreSQLDB(const bkfn:string;const IsPrompt:Boolean=False):Boolean;
var
  adoConn_Temp:TADOConnection;
  sqlstr:string;
  vHost,vDb,vSa,vPwd,vMode:string;
begin
  Result := False;
  //if IsPrompt then
  begin
    if MessageBox(0, '数据恢复操作会删除当前数据库的中的所有记录！　　' +
      #13#10 + '还要进行数据恢复操作吗？　　', '系统提示', MB_YESNO +
      MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;

    if not FileExists(bkfn) then
    begin
      MessageBox(0, '备份文件不存在，请选择要恢复的备份文件　　', '系统提示', MB_OK + MB_ICONERROR + MB_TOPMOST);
      Exit;
    end;
    sSaConnStr := '';
    TInputSaPwd.Create(nil).ShowModal;
    if sSaConnStr='' then
      Exit;

    if MessageBox(0, '数据恢复操作会删除当前数据库的中的所有记录！　　' +
      #13#10 + '确定要进行数据恢复操作吗？　　', '再次确认', MB_YESNO +
      MB_ICONWARNING + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
    begin
      Exit;
    end;

  end;

  if ReadConnInfo(vHost,vDb,vSa,vPwd,vMode)='' then Exit;
  adoConn_Temp := TADOConnection.Create(nil);
  adoConn_Temp.ConnectionString := sSaConnStr;
  adoConn_Temp.LoginPrompt := False;
  Screen.Cursor := crHourGlass;
  try
    sqlstr := 'USE MASTER'+#13+
              'ALTER DATABASE '+vDb+' SET OFFLINE WITH ROLLBACK IMMEDIATE'+#13+
              'RESTORE DATABASE '+vDb+' FROM DISK = '+quotedstr(bkfn)+' WITH RECOVERY'+#13+
              'ALTER DATABASE '+vDb+' SET ONLINE WITH ROLLBACK IMMEDIATE';
    try
      adoConn_Temp.Execute('USE MASTER');
      adoConn_Temp.BeginTrans;
      adoConn_Temp.Execute('ALTER DATABASE '+vDb+' SET OFFLINE WITH ROLLBACK IMMEDIATE');
      adoConn_Temp.Execute('RESTORE DATABASE '+vDb+' FROM DISK = '+quotedstr(bkfn)+' WITH REPLACE');
      adoConn_Temp.Execute('ALTER DATABASE '+vDb+' SET ONLINE WITH ROLLBACK IMMEDIATE');
      adoConn_Temp.CommitTrans;
      Result := True;
      if IsPrompt then
        MessageBox(0, '操作完成！数据已成功恢复！　　', '系统提示', MB_OK +  MB_ICONINFORMATION + MB_TOPMOST);
    except
      on e:Exception do
      begin
        adoConn_Temp.RollbackTrans;
        if IsPrompt then
          MessageBox(0, PChar('数据恢复失败！请检查数据库的连接是否均已断开！　　'+#13+e.Message+'　　'),'系统提示', MB_OK + MB_ICONSTOP + MB_TOPMOST);
        Result := False;
      end;
    end;
  finally
    adoConn_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

function CurHostIsDBSrvHost:Boolean;
var
  vHost,vDb,vSa,vPwd,vMode:string;
begin
  Result := False;
  if ReadConnInfo(vHost,vDb,vSa,vPwd,vMode)='' then Exit;
  vHost := LowerCase(vHost);
  Result := (vHost='(local)') or (vHost='localhost') or
            (vHost='127.0.0.1') or (vHost='.') or
            (vHost=LowerCase(GetLocalHostName)) or
            (vHost=GetLocalIpStr);
end;

end.
