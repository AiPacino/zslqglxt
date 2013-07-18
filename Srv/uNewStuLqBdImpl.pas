{ Invokable implementation File for TNewStuLqBd which implements INewStuLqBd }

unit uNewStuLqBdImpl;

interface

uses InvokeRegistry, Types, XSBuiltIns, SysUtils, DB, WebBrokerSOAP,DBClient, uNewStuLqBdIntf;

type

  { TNewStuLqBd }
  TNewStuLqBd = class(TInvokableClass, INewStuLqBd)
  private
    function _GetRecordCount(const sqlstr:string):Integer;
    function _GetKsPhotoFileName(const sKsh:string):string;
  public
    function Query_Data(const SqlText: string; var sData: string):Integer; stdcall;
    function Update_Data(const pkField,SqlText: string; const sData: string; var sError:string):Boolean; stdcall;
    function GetRecordCount(const sTableName:string):Integer; stdcall;
    function GetRecordCountBySql(const sqlstr:string):Integer; stdcall;
    function IsAutoIncField(const sFieldName,sTableName:string):Boolean; stdcall;
    function ExecSql(const SqlText: string;var sError:string):Boolean; stdcall;

    function GetAdjustJHNo:string;stdcall; //得到计划调编号
    function GetZyJHCount(const sXlcc,sSf,sZyId,sKl:string):Integer;stdcall; //获取专业原始计划数
    function GetZyJHChgCount(const sXlcc,sSf,sZyId,sKl:string):Integer;stdcall; //获取专业变更计划数
    function AdjustJH(const sNo,sXlcc,sSf,sCzlx,sWhy,Czy_Id,sDelta:string;out sError:string):Boolean;stdcall; //申请调整计划
    function PostJH(const sNo,Czy_Id:string;out sError:string):Boolean;stdcall; //提交计划调整
    function ConfirmJH(const sNo,Czy_Id:string;out sError:string):Boolean;stdcall; //审核通过计划调整
    function CancelJH(const sNo,sWhy,Czy_Id:string;out sError:string):Boolean;stdcall;  //计划调整审核未通过
    function DeleteJH(const sNo,Czy_Id:string;out sError:string):Boolean;stdcall;

    function SetStuBdState(const sKsh,sState,czy:string;const sBz:string=''):Boolean; stdcall;
    function UpdateStuZy(const sKsh,xlcc,oldzy,oldyx,newzy,newyx,newxq,czyId:string;out sError:string):Boolean; stdcall;
    function GetRxxq(const yx,zy,xlcc:string):string; stdcall;

    function ApplyJLItem(const Czy_Id,ksh,JLMemo:string):Boolean; stdcall;
    function CancelJLItem(const Czy_Id,ksh:string):Boolean; stdcall;
    function CanBaoDao(const xlcc:string;var sMsg:string):Boolean; stdcall;//能否报到
    function CanApplyJL(const jxmc:string;var sMsg:string):Boolean; stdcall;//能否申请奖励

    function FirstCjIsEnd(const Yx,Sf,Km:string):Boolean; stdcall; //第一次成绩是否录入完成
    function InitCjInputData(const Yx,Sf,Km:string;const DelData:Boolean;var sError:string):Boolean; stdcall; //初始成绩录入名单
    function InitCjStateData(const Yx,Sf,Km:string;var sError:string):Boolean; stdcall; //初始成绩录入状态
    function CopyKsInfoToCjB(const ksh,km,yx:string;var sError:string):Boolean; stdcall;      //复制考生数据到成绩表
    function SaveInputCj(const ksh,km,yx,pw:string;const CjIndex:Integer;const cj:Double;const CzyId:string;var sError:string):Boolean; stdcall;      //保存考生成绩数据到成绩录入明细表
    function UpLoadInputCj(const Id:Integer;var sError:string):Boolean; stdcall;      //上传考生成绩数据，写入成绩信息到成绩校对表

    function CjIsConfirmed(const Yx,Sf,Km:string):Boolean; stdcall;                    //是否已审核成绩
    function CjIsPosted(const CjIndex:Integer;const Yx,Sf,Km:string):Boolean; stdcall; //成绩是否提交

    function CjIsUpload(const CjIndex:Integer;const Yx,SjBH:string):Boolean; stdcall;  //成绩是否上传

    function IsCanInputCj(const CzyId:string):Boolean; stdcall; //能否录入成绩
    function GetCjInputInfo(const CzyId:string;var Yx,Km:string;var CjIndex:Integer):Boolean; stdcall; //获得成绩录入信息

    function PostCj(const CjIndex:Integer;const Yx,Sf,Km:string;const bPost:Boolean=True):Boolean; stdcall;     //提交成绩
    function ConfirmCj(const Yx,Sf,Km:string;const bConfirm:Boolean=True):Boolean; stdcall;                        //审核成绩
    function KsIsExcept(const ksh:string;var Msg:string):Boolean; stdcall;                            //考生是否异常
    function KsIsExists(const ksh:string;var Msg:string):Boolean; stdcall;           //考生是否存在

    function GetUserInfo:string;stdcall;//获取机主用户名称
    function GetMACInfo:string;stdcall;//获取机主MAC信息
    function GetSrvMACAddress:string;stdcall;//获取服务器网卡MAC地址
    function GetUserCode:string;stdcall;//获取机主用户注册码
    function RegUserInfo(const UserName,UserCode:string):Boolean;stdcall;
    function RegIsOK:Boolean;stdcall;//系统是否注册
    function SrvIsOK:Boolean;stdcall;
    function SrvIsOpen:Boolean;stdcall; //系统服务是否开放
    function IsValidIp:Boolean;stdcall; //是否合法IP

    function CzyLogin(const Czy_ID,Czy_Pwd:string;const sVersion:string;var sMsg:string):Boolean;stdcall;//登录
    function CzyLogOut(const Czy_ID:string):Boolean;stdcall;//退出
    function IsLogined(const Czy_ID:string):Boolean;stdcall;//是否已登录
    function GetCzyName(const Czy_ID:string):string;stdcall;
    function GetCzyLevel(const Czy_ID:string):string;stdcall;
    function GetCzyDept(const Czy_ID:string):string;stdcall;
    function ChangeCzyPwd(const Czy_ID,Old_Pwd,newPwd:string):Boolean;stdcall;
    function RecordIsExists(const sWhere,sTable:string):Boolean;stdcall;
    function ReleaseLoginLog(const Czy_ID:string):Boolean ;stdcall; //清空登录日志
    function ReleaseLog(const Czy_ID:string):Boolean ;stdcall; //清空操作日志

    function CanEditXkKdInfo(var sMsg:string):Boolean; stdcall;//能否进行艺术考点申请

    function GetSrvAutoUpdateUrl:string;stdcall;      //得到服务器更新地址
    function GetClientAutoUpdateUrl:string;stdcall;   //得到客户端更新地址

    function GetDBMareSql(const sSf,sXlcc:string):string;stdcall;//合并数据SQL
    function GetTdksSql(const sSf,sXlcc:string):string;stdcall;//退档考生数据SQL
    function GetTddCountSql(const sXlcc:string):string;stdcall;//投档单记录数SQL

    function UpdateLqInfo(const sXlCc:string):Boolean;stdcall; //更新录取信息，如更新科类、专业志愿情况等

    function GetPhotoSavePath:string;stdcall; //照片存储路径
    function GetPhotoUrlPath:string;stdcall;  //照片Url路径
    function UpLoadFile(const sPath,sXmlData:string;out sError:string;
                        const bOverWrite:Boolean=False):Boolean;stdcall;
    function DownLoadFile(const sFileName:string;out sXmlData,sError:string):Boolean;stdcall;

    function UpLoadPhoto(const sXmlData:string;out sError:string;
                        const bOverWrite:Boolean=False):Boolean;stdcall;
    function DownLoadPhoto(const sKsh:string;out sXmlData,sError:string):Boolean;stdcall;

    function UpdateLqtzsNo(const ksh:string;out sMsg:string):Boolean;stdcall; //更新录取通知书编号

    function GetExportFieldList(const sType:string):string;stdcall;//得到导出信息字段列表
    function SetExportFieldList(const sType,sFieldList:string):Boolean;stdcall;//得到导出信息字段列表
  end;

implementation
uses uNewStuLqBdSoapDM,Net,EncdDecdEx ;

{ TNewStuLqBd }

procedure WriteLog(const UserID,sWhat:string);
var
  dm:TNewStuLqBdSoapDM;
  sIP,sqlstr:String;  //sSrvHost,
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'Insert Into 操作日志表 (用户,ActionTime,内容,IP) values'+
              '('+quotedstr(UserID)+',getdate(),'+quotedstr(sWhat)+','+quotedstr(sIP)+')';
    dm.con_Access.Execute(sqlstr);
  finally
    dm.Free;
  end;
end;

procedure WriteLoginLog(const UserID,sVer:string);
var
  dm:TNewStuLqBdSoapDM;
  sIP,sSrvHost,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  sSrvHost := GetSOAPWebModule.Request.RemoteHost;
{
  //GetSOAPWebModule.Request.URL ==> /NetPay/NetPayWebSrv.dll
  //GetSOAPWebModule.Request.PathInfo ==> /soap/IAdmin
  //GetLocalHostName(); // //GetSOAPWebModule.Request.RemoteHost;
}
  if Length(sSrvHost)>30 then
    sSrvHost := Copy(sSrvHost,1,30);
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'Insert Into 操作员登录表 (操作员编号,登录时间,登录IP,SrvHost,是否在线,客户端版本) values'+
              '('+quotedstr(UserID)+',getdate(),'+quotedstr(sIP)+','+quotedstr(GetLocalHostName())+',0,'+quotedstr(sVer)+')';
    dm.con_Access.Execute(sqlstr);
  finally
    dm.Free;
  end;
end;

procedure WriteLogoutLog(const UserID:string);
var
  dm:TNewStuLqBdSoapDM;
  sIP,sqlstr:String;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'Update 操作员登录表 Set 注销时间=getdate(),注销IP='+quotedstr(sIP)+',是否在线=0 '+
              'where 操作员编号='+quotedstr(UserID)+' and 是否在线=0';
    dm.con_Access.Execute(sqlstr);
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.AdjustJH(const sNo, sXlcc,sSf,sCzlx,sWhy, Czy_Id, sDelta: string;out sError:string): Boolean;
var
  sqlstr:String;
begin
  if RecordIsExists('where Id='+quotedstr(sNo),'计划调整表') then
    sqlstr := 'update 计划调整表 set 省份='+quotedstr(sSf)+',类型='+quotedstr(sCzlx)+',说明='+quotedstr(sWhy)+
              ',状态='+QuotedStr('编辑中')+' where Id='+quotedstr(sNo)
  else
    sqlstr := 'insert into 计划调整表 (Id,学历层次,省份,类型,说明,申请人,状态,申请时间) values('+
              quotedstr(sNo)+','+quotedstr(sXlcc)+','+quotedstr(sSf)+','+quotedstr(sCzlx)+','+
              quotedstr(sWhy)+','+quotedstr(Czy_Id)+','+quotedStr('编辑中')+',getdate())';
    Result := ExecSql(sqlstr,sError);
    if not Result then Exit;
    if sDelta<>'' then
      Result := Update_Data('Id','select top 0 * from 计划调整明细表',sDelta,sError);
end;

function TNewStuLqBd.ApplyJLItem(const Czy_Id,ksh, JLMemo: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr:String;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'update 录取信息表 set 获奖内容='+quotedstr(JLMemo)+' where 考生号='+quotedstr(ksh);
    Result := dm.ExecSqlCmd(sqlstr);
    if Result then
      WriteLog(Czy_Id,'考生：'+ksh+JLMemo+'成功！')
    else
      WriteLog(Czy_Id,'考生：'+ksh+JLMemo+'失败！');
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.CanApplyJL(const jxmc:string;var sMsg: string): Boolean;
var
  sqlstr:String;
begin
  sqlstr := 'select count(*) from 奖励项目配置表 where 奖项名称='+quotedstr(jxmc)+' and 开入申请<>0';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.CanBaoDao(const xlcc: string; var sMsg: string): Boolean;
var
  sqlstr:String;
  curTime:string;
begin
  curTime := FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
  sqlstr := 'select count(*) from 报到时间配置表 where 报到层次='+quotedstr(xlcc)+' and 是否启用<>0'+
            ' and ('+quotedstr(curTime)+' between 开始时间 and 结束时间)';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.CancelJH(const sNo,sWhy, Czy_Id:string;out sError:string): Boolean;
var
  sqlstr:String;
begin
  sqlstr := 'update 计划调整表 set 审核原因='+quotedstr(sWhy)+',审核人='+quotedstr(Czy_Id)+
            ',状态='+quotedstr('编辑中')+',审核时间=getdate()'+' where Id='+quotedstr(sNo);
  Result := ExecSql(sqlstr,sError);
end;

function TNewStuLqBd.CancelJLItem(const Czy_Id, ksh: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr:String;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'update 录取信息表 set 获奖内容=null where 考生号='+quotedstr(ksh);
    Result := dm.ExecSqlCmd(sqlstr);
    if Result then
      WriteLog(Czy_Id,'取消考生：'+ksh+'获奖申请成功！')
    else
      WriteLog(Czy_Id,'取消考生：'+ksh+'获奖申请失败！');
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.CanEditXkKdInfo(var sMsg: string): Boolean;
var
  sqlstr:String;
  curTime:string;
begin
  curTime := FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
  sqlstr := 'select count(*) from 校考考点申报时间配置表 where 是否启用<>0'+
            ' and ('+quotedstr(curTime)+' between 开始时间 and 结束时间)';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.ChangeCzyPwd(const Czy_ID, Old_Pwd,
  newPwd: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr,sMsg:String;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  Result := CzyLogin(Czy_ID,Old_Pwd,'',sMsg);
  if not Result then
    Exit;
  WriteLog(Czy_ID,'更改密码');
  try
    sqlstr := 'update 操作员表 set 操作员密码='+quotedstr(newPwd)+
              ' where 操作员编号='+quotedstr(Czy_ID);
    dm.con_Access.Execute(sqlstr);
    Result := True;
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.CjIsConfirmed(const Yx, Sf, Km: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from 校考成绩录入状态表 where 承考院系='+quotedstr(yx)+
            ' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km)+' and 是否审核=1';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.CjIsPosted(const CjIndex: Integer; const Yx, Sf,
  Km: string): Boolean;
var
  cjField,sqlstr:string;
begin
  cjField := '成绩'+IntToStr(CjIndex)+'是否提交';
  sqlstr := 'select count(*) from 校考成绩录入状态表 where 承考院系='+quotedstr(yx)+
            ' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km)+' and '+cjField+'=1';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.CjIsUpload(const CjIndex: Integer; const Yx,
  SjBH: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from 校考卷面成绩明细表 where 试卷编号='+quotedstr(SjBH)+
            ' and 是否提交=1 and 承考院系='+quotedstr(yx)+' and 录入分组='+IntToStr(CjIndex);
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.ConfirmCj(const Yx, Sf, Km: string;const bConfirm:Boolean=True): Boolean;
var
  ConfirmValue,sqlstr,sError:string;
begin
  if bConfirm then
    ConfirmValue := '1'
  else
    ConfirmValue := '0';

  sqlstr := 'select count(*) from 校考成绩录入状态表 where 承考院系='+quotedstr(yx)+
            ' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km);
  if GetRecordCountBySql(sqlstr)=0 then
  begin
    Result := False;
    Exit;
  end else
  begin
    sqlstr := 'update 校考成绩录入状态表 set 是否审核='+ConfirmValue+' where 承考院系='+quotedstr(yx)+
              ' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km);
    Result := ExecSql(sqlstr,sError);
  end;
end;

function TNewStuLqBd.ConfirmJH(const sNo, Czy_Id:string;out sError:string): Boolean;
var
  sqlstr:String;
  //sXlCc,iSum:string;
  //dm:TNewStuLqBdSoapDM;
begin
  //dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'update 计划调整表 set 审核人='+quotedstr(Czy_Id)+',状态='+quotedstr('已审核')+
              ',审核时间=getdate()'+' where Id='+quotedstr(sNo);
    Result := ExecSql(sqlstr,sError);
{
    if not Result then Exit;

    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 学历层次,sum(增减数) from View_计划调整统计表 '+
                                   'where 类别='+quotedstr('预留计划')+' and 专业='+quotedstr('预留计划');
    DM.DataSet_Temp.Active := True;
    while not dm.DataSet_Temp.Eof do
    begin
      sXlCc := dm.DataSet_Temp.Fields[0].AsString;
      iSum := dm.DataSet_Temp.Fields[1].AsString;
      sqlstr := 'update view_分省专业计划表 set 计划数='+iSum+' where 学历层次='+quotedstr(sXlCc)+
                ' and 省份='+quotedstr('预留计划')+' and 类别='+quotedstr('预留计划')+' and 专业='+quotedstr('预留计划');
      Result := ExecSql(sqlstr,sError);
      if not Result then Exit;
      dm.DataSet_Temp.Next;
    end;
}
  finally
    //dm.DataSet_Temp.Close;
    //dm.Free;
  end;
end;

function TNewStuLqBd.CopyKsInfoToCjB(const ksh,km,yx: string;
  var sError: string): Boolean;
var
  sWhere,sqlstr:string;
begin
  sWhere := 'where 考生号='+quotedstr(ksh)+' and 考试科目='+quotedstr(Km);
  sqlstr := 'select count(*) from 校考单科成绩表 '+sWhere;
  if GetRecordCountBySql(sqlstr)<=0 then
  begin
    sqlstr := 'INSERT INTO 校考单科成绩表 (考生号, 承考院系, 考试科目) '+
              'Values('+quotedstr(ksh)+','+quotedstr(yx)+','+quotedstr(km)+')';
    Result := ExecSql(sqlstr,sError);
  end else
    Result := True;
end;

function TNewStuLqBd.CzyLogin(const Czy_ID, Czy_Pwd, sVersion: string;var sMsg:string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  //sLevel:string;
begin
  CzyLogOut(Czy_ID);
  Result := False;
  if sVersion<='1.0.1.128' then
  begin
    sMsg := '软件版本过低！　';
    Exit;
  end;
  if not RegIsOK then
  begin
    sMsg := '系统错误！Thread error! Error code id is 403!　';
    Sleep(100000);
    Exit;
  end;

  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 是否启用,操作员等级 from 操作员表 '+
                                   ' where 操作员编号='+#39+Czy_ID+#39+
                                   ' and 操作员密码='+#39+Czy_Pwd+#39;
    DM.DataSet_Temp.Active := True;

    Result := dm.DataSet_Temp.RecordCount>0;
    if not Result then
    begin
      sMsg := '用户名或密码错误！请核对后重新输入！　';
      Exit;
    end;

    Result := dm.DataSet_Temp.Fields[0].AsBoolean;
    if not Result then
    begin
      sMsg := '用户【'+Czy_ID+'】已被停用！请核对后重新输入！　';
    end
    else if GetCzyLevel(Czy_ID)<>'-1' then
    begin
      if (not IsValidIp) then
      begin
        sMsg := '登录被拒绝！非法的IP接入地址！如有疑问，请与系统管理员　'+#13+
                         '或应用系统管理部门联系！　　'+#13;
        Result := False;
      end
      else if (not SrvIsOpen) then
      begin
        sMsg := '登录被拒绝！新生报到系统服务器已关闭！如有疑问，　'+#13+
                         '请与系统管理员或应用系统管理部门联系！　　'+#13;
        Result := False;
      end
      else
        Result := True;
    end;

    if Result then
    begin
       WriteLoginLog(Czy_ID,'Ver:'+sVersion);
    end
    else
    begin
       WriteLog(Czy_ID,'用户登录失败！Ver:'+sVersion);
    end;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd.CzyLogOut(const Czy_ID: string): Boolean;
begin
  WriteLogoutLog(Czy_ID);
  Result := True;
end;

function TNewStuLqBd.DeleteJH(const sNo, Czy_Id:string;out sError:string): Boolean;
var
  sqlstr:String;
begin
  sqlstr := 'delete from 计划调整明细表 where Id='+quotedstr(sNo);
  Result := ExecSql(sqlstr,sError);
  sqlstr := 'delete from 计划调整表 where Id='+quotedstr(sNo);
  Result := ExecSql(sqlstr,sError);
end;

function TNewStuLqBd.DownLoadFile(const sFileName: string; out sXmlData,
  sError: string): Boolean;
var
  cds_Temp:TClientDataSet;
  sData:string;
  dm:TNewStuLqBdSoapDM;
  //sLevel:string;
begin
  Result := False;

  if not FileExists(sFileName) then
  begin
    sError := '文件不存在！';
    Exit;
  end;
  cds_Temp := TClientDataSet.Create(nil);
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    dm.Query_Data('select top 0 * from 文件上传结构表',sData);
    if gb_Use_Zip then
    begin
      sData := DecodeString(sData);
      sData := dm.VCLUnZip1.ZLibDecompressString(sData);
    end;
    cds_Temp.XMLData := sData;
    cds_Temp.Append;
    cds_Temp.FieldByName('FileName').AsString := ExtractFileName(sFileName);
    TBlobField(cds_Temp.FieldByName('FileData')).LoadFromFile(sFileName);
    cds_Temp.Post;
    sXmlData := cds_Temp.XMLData;
    Result := True;
  finally
    cds_Temp.Free;
    dm.Free;
  end;
end;

function TNewStuLqBd.DownLoadPhoto(const sKsh: string; out sXmlData,
  sError: string): Boolean;
var
  sFileName:string;
begin
  sFileName := _GetKsPhotoFileName(sKsh);
  if sFileName<>'' then
  begin
    sFileName := GetPhotoSavePath+sFileName;
    Result := DownLoadFile(sFileName,sXmlData,sError);
  end;
end;

function TNewStuLqBd.ExecSql(const SqlText: string;
  var sError: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.ExecSqlCmd(SqlText,sError);
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.FirstCjIsEnd(const Yx, Sf, Km: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from View_校考单科成绩表 where 承考院系='+quotedstr(Yx)+
            ' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km)+' and 成绩1 Is null';
  Result := GetRecordCountBySql(sqlstr)<=0;
end;

function TNewStuLqBd.GetAdjustJHNo: string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.GetAdjustJHNo;
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.GetDBMareSql(const sSf,sXlcc:string):string;stdcall;//合并数据SQL
var
  ccstr,sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    if sXlcc='本科' then //td_pcdm.db中的GBCCDM字段，1：本科，2：专科
      sqlstr := 'select SqlText from 数据采集SQL配置表 where 编号='+quotedstr('001')
    else //if sXlcc='专科' then
      sqlstr := 'select SqlText from 数据采集SQL配置表 where 编号='+quotedstr('002');

    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    dm.DataSet_Temp.Active := True;
    sqlstr := dm.DataSet_Temp.Fields[0].AsString;
    Result := sqlstr;
  finally
    dm.DataSet_Temp.Close;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetExportFieldList(const sType: string): string;
var
  sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select 内容 from 导出信息配置表 where 类型='+quotedstr(sType);
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    try
      dm.DataSet_Temp.Active := True;
      Result := dm.DataSet_Temp.Fields[0].AsString;
      if Result = '' then Result := '*';
    except
      Result := '*';
    end;
  finally
    dm.DataSet_Temp.Close;
    dm.Free;
  end;
{
  case iType of
    0:
    begin
      //sTitle := '制卡';
      Result := '流水号,省份,类别,考生号,身份证号,考生姓名,性别,报到校区,left(家庭地址,6) as 籍贯' ;
    end;
    1:
    begin
      //sTitle := 'EMS';
      Result := '流水号,省份,类别,考生号,考生姓名,收件人,邮政编码,家庭地址,联系电话' ;
    end;
    2:
    begin
      //sTitle := '教务';
      Result := '流水号,学历层次,省份,类别,科类,考生号,身份证号,考生姓名,性别,学历层次,录取专业规范名 as 专业,院系,报到校区,收件人,邮政编码,家庭地址,联系电话' ;
    end;
    3:
    begin
      //sTitle := '';
      Result := '*' ;
    end;
  end;
}  
end;

function TNewStuLqBd.GetMACInfo: string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.GetMACInfo;
    if Result='' then
      Result := '';
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.GetPhotoSavePath: string;
var
  sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select SavePath from 照片路径信息表 ';
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    try
      dm.DataSet_Temp.Active := True;
      Result := dm.DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    dm.DataSet_Temp.Close;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetPhotoUrlPath: string;
var
  sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select sUrl from 照片路径信息表 ';
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    try
      dm.DataSet_Temp.Active := True;
      Result := dm.DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    dm.DataSet_Temp.Close;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetCjInputInfo(const CzyId: string; var Yx,Km: string;
  var CjIndex: Integer): Boolean;
var
  sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select 录入院系,录入科目,录入顺序 from 成绩录入设置表 '+
              'where 录入员='+quotedstr(CzyId);
    if Yx<>'' then
      sqlstr := sqlstr+' and 录入院系='+quotedstr(Yx);
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    try
      dm.DataSet_Temp.Active := True;
      Yx := dm.DataSet_Temp.Fields[0].AsString;
      Km := dm.DataSet_Temp.Fields[1].AsString;
      CjIndex := dm.DataSet_Temp.Fields[2].AsInteger;
      Result := dm.DataSet_Temp.RecordCount>0;
    except
      Result := False;
    end;
  finally
    dm.DataSet_Temp.Close;
    dm.Free;
  end;

end;

function TNewStuLqBd.GetClientAutoUpdateUrl: string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select ClientUrl from 自动更新地址表 ';
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
    if Result = '' then
      Result := 'http://vir.jxstnu.edu.cn/NewStuLqBd/download/ClientAutoUpdate.inf';
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetCzyDept(const Czy_ID: string): string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 院系 from 操作员表 where 操作员编号='+quotedstr(Czy_ID);
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetCzyLevel(const Czy_ID: string): string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 操作员等级 from 操作员表 where 操作员编号='+quotedstr(Czy_ID);
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetCzyName(const Czy_ID: string): string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 操作员姓名 from 操作员表 where 操作员编号='+quotedstr(Czy_ID);
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetRecordCount(const sTableName: string): Integer;
begin
  Result := _GetRecordCount('select count(*) from '+sTableName);
end;

function TNewStuLqBd.GetRecordCountBySql(const sqlstr: string): Integer;
begin
  Result := _GetRecordCount(sqlstr);
end;

function TNewStuLqBd.GetRxxq(const yx, zy, xlcc: string): string;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr:String;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select 入学校区 from view_院系专业表 where '+
              'where 院系='+quotedstr(yx)+
              ' and 专业='+quotedstr(zy)+
              ' and 学历层次='+quotedstr(xlcc);
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    dm.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
  finally
    dm.DataSet_Temp.Close;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetSrvAutoUpdateUrl: string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select SrvUrl from 自动更新地址表 ';
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsString;
    if Result = '' then
      Result := 'http://vir.jxstnu.edu.cn/NewStuLqBd/download/SrvAutoUpdate.inf';
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetSrvMACAddress: string;
begin
  try
    Result := GetMacAddress;
  except
    Result := '';
  end;
end;

function TNewStuLqBd.GetTddCountSql(const sXlcc: string): string;
var
  ccstr,sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    if sXlcc='本科' then //td_pcdm.db中的GBCCDM字段，1：本科，2：专科
      sqlstr := 'select SqlText from 数据采集SQL配置表 where 编号='+quotedstr('101')
    else //if sXlcc='专科' then
      sqlstr := 'select SqlText from 数据采集SQL配置表 where 编号='+quotedstr('102');

    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    dm.DataSet_Temp.Active := True;
    sqlstr := dm.DataSet_Temp.Fields[0].AsString;

    Result := sqlstr;
  finally
    dm.DataSet_Temp.Close;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetTdksSql(const sSf, sXlcc: string): string;
var
  ccstr,sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    if sXlcc='本科' then //td_pcdm.db中的GBCCDM字段，1：本科，2：专科
      sqlstr := 'select SqlText from 数据采集SQL配置表 where 编号='+quotedstr('201')
    else //if sXlcc='专科' then
      sqlstr := 'select SqlText from 数据采集SQL配置表 where 编号='+quotedstr('202');

    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    dm.DataSet_Temp.Active := True;
    sqlstr := dm.DataSet_Temp.Fields[0].AsString;
    Result := sqlstr;
  finally
    dm.DataSet_Temp.Close;
    dm.Free;
  end;
end;

function TNewStuLqBd.GetUserCode: string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.GetUserCode;
    if Result='' then
      Result := '';
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.GetUserInfo: string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.GetUserInfo;
    if Result='' then
      Result := '未输入系统用户信息';
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.GetZyJHChgCount(const sXlcc, sSf, sZyId, sKl: string): Integer;
var
  sqlstr:string;
begin
  sqlstr := 'select sum(增减数) from View_计划调整明细表 where 省份='+quotedstr(sSf)+
            ' and 学历层次='+quotedstr(sXlcc)+' and 专业Id='+sZyId+
            ' and 科类='+quotedstr(sKl);
  Result := GetRecordCountBySql(sqlstr);
end;

function TNewStuLqBd.GetZyJHCount(const sXlcc, sSf, sZyId, sKl: string): Integer;
var
  sqlstr:string;
begin
  sqlstr := 'select 计划数 from View_分省专业计划表 where 省份='+quotedstr(sSf)+
            ' and 学历层次='+quotedstr(sXlcc)+' and 专业Id='+sZyId+
            ' and 科类='+quotedstr(sKl);
  Result := GetRecordCountBySql(sqlstr);
end;

function TNewStuLqBd.InitCjInputData(const Yx, Sf, Km: string;const DelData:Boolean;
  var sError: string): Boolean;
var
  sWhere,sqlstr:string;
begin
  sWhere := 'where 承考院系='+quotedstr(Yx)+' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km);
  if DelData then
  begin
    sqlstr := 'delete from 校考单科成绩表 where 考生号 in (select 考生号 from view_校考单科成绩表 '+sWhere+')';
    if not ExecSql(sqlstr,sError) then Exit;
  end;
  sqlstr := 'select count(*) from View_校考单科成绩表 '+sWhere;
  if GetRecordCountBySql(sqlstr)<=0 then
  begin
    sqlstr := 'INSERT INTO 校考单科成绩表 (考生号, 承考院系, 考试科目) '+
              'SELECT 考生号, 承考院系, 考试科目 FROM View_校考考生考试科目表 '+sWhere;
    Result := ExecSql(sqlstr,sError);
  end else
    Result := True;
end;

function TNewStuLqBd.InitCjStateData(const Yx, Sf, Km: string;
  var sError: string): Boolean;
var
  sWhere,sqlstr:string;
begin
  sWhere := 'where 承考院系='+quotedstr(Yx)+' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km);
  sqlstr := 'select count(*) from 校考成绩录入状态表 '+sWhere;
  if GetRecordCountBySql(sqlstr)<=0 then
  begin
    sqlstr := 'INSERT INTO 校考成绩录入状态表 (省份, 承考院系, 考试科目) '+
              'SELECT 省份, 承考院系, 考试科目 FROM View_校考考点考试科目表 '+sWhere;
    Result := ExecSql(sqlstr,sError);
  end else
    Result := True;
end;

function TNewStuLqBd.IsAutoIncField(const sFieldName,
  sTableName: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr:String;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select top 1 '+sFieldName+' from '+sTableName;
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    dm.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].DataType in [ftAutoInc];
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.IsCanInputCj(const CzyId: string): Boolean;
begin

end;

function TNewStuLqBd.IsLogined(const Czy_ID: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sIP,sLoginedIP,sqlstr:String;
  bIsOnline:Boolean;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select top 1 是否在线,登录IP from 操作员登录表 where 用户='+quotedstr(Czy_ID)+' order by ID desc';
    dm.DataSet_Temp.Close;
    dm.DataSet_Temp.CommandText := sqlstr;
    dm.DataSet_Temp.Active := True;
    bIsOnline := dm.DataSet_Temp.Fields[0].AsBoolean;
    sLoginedIP := dm.DataSet_Temp.Fields[1].AsString;
    sIP := GetSOAPWebModule.Request.RemoteAddr;
    Result := bIsOnline and (sIP=sLoginedIP);
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.IsValidIp: Boolean;
var
  sIP,sqlstr:string;
begin
  sIP := GetSOAPWebModule.Request.RemoteAddr;
  if sIP='127.0.0.1' then
  begin
    Result := True;
    Exit;
  end;
  
  sIP := QuotedStr(FormatIP(sIP));
  if GetRecordCount('客户端IP表')=0 then
  begin
    Result := True;
    Exit;
  end;
  sqlstr := 'select count(*) from 客户端IP表 where '+Sip+' between 开始IP and 结束IP';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.KsIsExcept(const ksh: string;var Msg:string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from 校考考生异常情况登记表 where 考生号='+quotedstr(ksh);
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.KsIsExists(const ksh: string; var Msg: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from 校考考生报考专业表 where 考生号='+quotedstr(ksh);
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.PostCj(const CjIndex: Integer; const Yx, Sf,
  Km: string;const bPost:Boolean=True): Boolean;
var
  cjField,cjValue,sqlstr,sError:string;
begin
  if bPost then
    cjValue := '1'
  else
    cjValue := '0';
    
  cjField := '成绩'+IntToStr(CjIndex)+'是否提交';
  sqlstr := 'select count(*) from 校考成绩录入状态表 where 承考院系='+quotedstr(yx)+
            ' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km);
  if GetRecordCountBySql(sqlstr)=0 then
  begin
    sqlstr := ' Insert into 校考成绩录入状态表 (承考院系,省份,考试科目,'+cjField+') Values('+quotedstr(Yx)+','+quotedstr(Sf)+','+quotedstr(Km)+','+cjValue+')';
  end else
  begin
    sqlstr := 'update 校考成绩录入状态表 set '+cjField+'='+cjValue+' where 承考院系='+quotedstr(yx)+
              ' and 省份='+quotedstr(Sf)+' and 考试科目='+quotedstr(Km);
  end;
  Result := ExecSql(sqlstr,sError);
end;

function TNewStuLqBd.PostJH(const sNo, Czy_Id: string;
  out sError: string): Boolean;
var
  sqlstr:String;
begin
  sqlstr := 'update 计划调整表 set 状态='+quotedstr('审核中')+' where Id='+quotedstr(sNo)+
            ' and 申请人='+quotedstr(Czy_Id);
  Result := ExecSql(sqlstr,sError);
end;

function TNewStuLqBd.Query_Data(const SqlText: string;
  var sData: string): Integer;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.Query_Data(SqlText,sData);
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.RecordIsExists(const sWhere, sTable: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select count(*) from '+sTable+' '+sWhere;
    DM.DataSet_Temp.Active := True;
    Result := dm.DataSet_Temp.Fields[0].AsInteger>0;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd.RegIsOK: Boolean;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.RegIsOK;
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.RegUserInfo(const UserName, UserCode: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.RegUserInfo(UserName,UserCode);
  finally
    dm.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd.ReleaseLog(const Czy_ID: string): Boolean;
var
  sqlstr,sError:string;
begin
  if GetCzyLevel(Czy_ID)<>'-1' then
  begin
    Result := False;
    Exit;
  end;
  sqlstr := 'delete from 操作日志表';
  sError := '';
  Result := ExecSql(sqlstr,sError);
  if Result then
    sError := '删除操作日志！OK！'
  else
    sError := '删除操作日志失败！'+sError;
  if Length(sError)>50 then
    sError := Copy(sError,1,50);
  WriteLog(Czy_ID,sError);
end;

function TNewStuLqBd.ReleaseLoginLog(const Czy_ID: string): Boolean;
var
  sqlstr,sError:string;
begin
  if GetCzyLevel(Czy_ID)<>'-1' then
  begin
    Result := False;
    Exit;
  end;
  sqlstr := 'delete from 操作员登录表';
  sError := '';
  Result := ExecSql(sqlstr,sError);
  if Result then
    sError := '删除登录日志！OK！'
  else
    sError := '删除登录日志失败！'+sError;
  if Length(sError)>50 then
    sError := Copy(sError,1,50);
  WriteLog(Czy_ID,sError);
end;

function TNewStuLqBd.SaveInputCj(const ksh,km,yx,pw:string;const CjIndex:Integer;const cj:Double;const CzyId:string;var sError:string): Boolean;
var
  sWhere,sqlstr,czyField,cjField:string;
begin
  Result := False;
  sWhere := 'where 考生号='+quotedstr(ksh)+' and 考试科目='+quotedstr(Km)+' and 录入分组='+IntToStr(CjIndex)+' and 评委='+quotedstr(pw);
  sqlstr := 'select count(*) from 校考卷面成绩录入表 '+sWhere;
  if GetRecordCountBySql(sqlstr)<=0 then
    sqlstr := 'INSERT INTO 校考卷面成绩录入表 (考生号, 承考院系,考试科目,评委,录入分组,成绩,录入员,录入时间,是否提交) '+
              'Values('+quotedstr(ksh)+','+quotedstr(yx)+','+quotedstr(km)+','+quotedstr(pw)+','+IntToStr(CjIndex)+','+FloatToStr(cj)+','+quotedstr(CzyId)+',getdate(),0'+')'
  else
    sqlstr := 'update 校考卷面成绩录入表 set 成绩='+FloatToStr(cj)+',录入员='+quotedstr(CzyId)+',录入时间=getdate() '+
              'where 考生号='+quotedstr(ksh)+' and 考试科目='+quotedstr(km)+' and 评委='+quotedstr(pw)+' and 录入分组='+IntToStr(CjIndex);

  Result := ExecSql(sqlstr,sError);
{
  if Result then
  begin
    cjField := '成绩'+IntTostr(CjIndex);
    czyField := '录入员'+IntTostr(CjIndex);
    sWhere := 'where 考生号='+quotedstr(ksh)+' and 考试科目='+quotedstr(Km)+' and 评委='+quotedstr(pw);
    sqlstr := 'select count(*) from 校考卷面成绩校对表 '+sWhere;
    if GetRecordCountBySql(sqlstr)<=0 then
      sqlstr := 'INSERT INTO 校考卷面成绩校对表 (考生号, 承考院系,考试科目,评委,'+cjField+','+czyField+',是否审核) '+
              'Values('+quotedstr(ksh)+','+quotedstr(yx)+','+quotedstr(km)+','+quotedstr(pw)+','+FloatToStr(cj)+','+quotedstr(CzyId)+',0'+')'
    else
      sqlstr := 'update 校考卷面成绩校对表 set '+cjField+'='+FloatToStr(cj)+','+czyField+'='+quotedstr(CzyId)+',是否审核=0 '+sWhere;

    Result := ExecSql(sqlstr,sError);
  end;
}
end;

function TNewStuLqBd.SetExportFieldList(const sType: string;
  const sFieldList: string): Boolean;
var
  sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select count(*) from 导出信息配置表 where 类型='+quotedstr(sType);
    if dm.RecordIsExists(sqlstr) then
      sqlstr := 'update 导出信息配置表 set 内容='+quotedstr(sFieldList)+' where 类型='+quotedstr(sType)
    else
      sqlstr := 'Insert into 导出信息配置表 (类型,内容) values('+quotedstr(sType)+','+quotedstr(sFieldList)+')';

    Result := dm.ExecSqlCmd(sqlstr);
  finally
    dm.Free;
  end;
{
  case iType of
    0:
    begin
      //sTitle := '制卡';
      Result := '流水号,省份,类别,考生号,身份证号,考生姓名,性别,报到校区,left(家庭地址,6) as 籍贯' ;
    end;
    1:
    begin
      //sTitle := 'EMS';
      Result := '流水号,省份,类别,考生号,考生姓名,收件人,邮政编码,家庭地址,联系电话' ;
    end;
    2:
    begin
      //sTitle := '教务';
      Result := '流水号,学历层次,省份,类别,科类,考生号,身份证号,考生姓名,性别,学历层次,录取专业规范名 as 专业,院系,报到校区,收件人,邮政编码,家庭地址,联系电话' ;
    end;
    3:
    begin
      //sTitle := '';
      Result := '*' ;
    end;
  end;
}  
end;

function TNewStuLqBd.SetStuBdState(const sKsh, sState, czy,
  sBz: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr,state,bz,sdate:string;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  if sBz='' then
    bz := 'null'
  else
    bz := QuotedStr(sBz);
  if sState='' then
  begin
    state := 'null';
    sdate := 'null';
  end else
  begin
    sdate := quotedstr(formatDateTime('yyyy-mm-dd hh:nn:ss',Now));
    state := QuotedStr(sState);
  end;

  sqlstr := 'update 录取信息表 set 报到状态='+state+',未报到原因='+bz+',报到日期='+sdate+
            ',操作员='+quotedstr(czy)+' where 考生号='+quotedstr(sKsh);
  try
    Result := dm.ExecSqlCmd(sqlstr);
    if sState<>'' then
      WriteLog(czy,sKsh+'被操作员设置为'+sState)
    else
      WriteLog(czy,sKsh+'被操作员设置为初始状态');
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.SrvIsOK: Boolean;
begin
  Result := True;
end;

function TNewStuLqBd.SrvIsOpen: Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from 服务器状态配置表 where 是否启用<>0';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.UpLoadInputCj(const Id:Integer;
  var sError: string): Boolean;
var
  cjIndex:Integer;
  cj:Double;
  ksh,km,yx,pw,CzyId,
  sWhere,sqlstr,czyField,cjField:string;
  sData:string;
  dm:TNewStuLqBdSoapDM;
begin
  Result := False;
  sqlstr := 'select count(*) from 校考卷面成绩录入表 where Id='+IntTostr(Id);
  if GetRecordCountBySql(sqlstr)<=0 then Exit;

  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select * from 校考卷面成绩录入表 where Id='+IntTostr(Id);
    dm.qry_Temp.Close;
    dm.qry_Temp.SQL.Text := sqlstr;
    dm.qry_Temp.Open;

    ksh := dm.qry_Temp.FieldByName('考生号').AsString;
    yx := dm.qry_Temp.FieldByName('承考院系').AsString;
    km := dm.qry_Temp.FieldByName('考试科目').AsString;
    pw := dm.qry_Temp.FieldByName('评委').AsString;
    cjIndex := dm.qry_Temp.FieldByName('录入分组').AsInteger;
    Cj := dm.qry_Temp.FieldByName('成绩').AsFloat;
    CzyId := dm.qry_Temp.FieldByName('录入员').AsString;

    dm.qry_Temp.Close;

    cjField := '成绩'+IntTostr(CjIndex);
    czyField := '录入员'+IntTostr(CjIndex);
    sWhere := 'where 考生号='+quotedstr(ksh)+' and 考试科目='+quotedstr(Km)+
              ' and 评委='+quotedstr(pw);
    sqlstr := 'select count(*) from 校考卷面成绩校对表 '+sWhere;
    if GetRecordCountBySql(sqlstr)<=0 then
      sqlstr := 'INSERT INTO 校考卷面成绩校对表 (考生号, 承考院系,考试科目,评委,'+cjField+','+czyField+',是否审核) '+
              'Values('+quotedstr(ksh)+','+quotedstr(yx)+','+quotedstr(km)+','+quotedstr(pw)+','+FloatToStr(cj)+','+quotedstr(CzyId)+',0'+')'
    else
      sqlstr := 'update 校考卷面成绩校对表 set '+cjField+'='+FloatToStr(cj)+','+czyField+'='+quotedstr(CzyId)+',是否审核=0 '+sWhere;

    Result := ExecSql(sqlstr,sError);
    if not Result then Exit;
    sqlstr := 'update 校考卷面成绩录入表 set 是否提交=1,提交时间=getdate() where Id='+IntTostr(Id);
    Result := ExecSql(sqlstr,sError);
  finally
   dm.Free;
  end;
end;

function TNewStuLqBd.UpdateLqInfo(const sXlCc: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.UpdateLqInfo(sXlCc);
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.UpdateLqtzsNo(const ksh: string;out sMsg:string): Boolean;
var
  sKsh,sNo,sqlstr,sData:string;
  dm:TNewStuLqBdSoapDM;
  cds_Temp:TClientDataSet;
begin
  Result := False;
  dm := TNewStuLqBdSoapDM.Create(nil);
  cds_Temp := TClientDataSet.Create(nil);
  //dm.con_Access.BeginTrans;
  sNo := sMsg;
  try
    if (sNo<>'') then
    begin
      Result := GetRecordCountBySql('select count(*) lqmd where 通知书编号='+quotedstr(sNo))=0;
      if not Result then
      begin
        sMsg := '该通知书编号已存在！';
        Exit;
      end;
    end;

    sqlstr := 'select 考生号 from 录取信息表 where (流水号 is not null) and ((通知书编号 is null) or 通知书编号='+quotedstr('')+')';
    if ksh<>'' then
      sqlstr := sqlstr+' and 考生号='+quotedstr(ksh);
    sqlstr := sqlstr+' order by 省份,流水号';
    if dm.Query_Data(sqlstr,sData)<>S_OK then Exit;
    if gb_Use_Zip then
    begin
      //Base64Decode(sData,sTempData);
      sData := DecodeString(sData);
      sData := dm.VCLUnZip1.ZLibDecompressString(sData);
    end;

    cds_Temp.XMLData := sData;
    while not cds_Temp.Eof do
    begin
      sKsh := cds_Temp.FieldByName('考生号').AsString;
      sNo := dm.GetLqtzsNo(sKsh);
      sqlstr := 'update 录取信息表 set 通知书编号='+quotedstr(sNo)+' where 考生号='+quotedstr(sKsh);
      Result := dm.ExecSqlCmd(sqlstr,sMsg);
      if not Result then Exit;
      cds_Temp.Next;
    end;
    cds_Temp.Close;

  finally
    //if Result then
    //  dm.con_Access.CommitTrans
    //else
    //  dm.con_Access.RollbackTrans;
    dm.Free;
    cds_Temp.Free;
  end;
end;

function TNewStuLqBd.UpdateStuZy(const sKsh,xlcc, oldzy, oldyx, newzy, newyx, newxq, czyId: string;out sError:string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr:string;
  ksh,old_zy,old_yx,new_zy,new_yx,new_xq,vxlcc:string;
begin
  ksh := QuotedStr(sKsh);
  old_zy := QuotedStr(oldzy);
  old_yx := QuotedStr(oldyx);
  new_zy := QuotedStr(newzy);
  new_yx := QuotedStr(newyx);
  new_xq := QuotedStr(newxq);
  vxlcc := QuotedStr(xlcc);
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'update 录取信息表 set 录取专业='+new_zy+',录取专业规范名='+new_zy+',院系='+new_yx+',报到校区='+new_xq+' where 考生号='+ksh;
    if dm.ExecSqlCmd(sqlstr,sError) then
    begin
      sqlstr := 'Insert Into 更换专业记录表 (考生号,学历层次,原录取专业,原院系,新录取专业,新院系,操作员,操作时间) '+
                'values('+ksh+','+vxlcc+','+old_zy+','+old_yx+','+new_zy+','+new_yx+','+quotedstr(czyId)+',getdate())';
      Result := dm.ExecSqlCmd(sqlstr,sError);
      WriteLog(czyId,sKsh+'更换专业：'+oldzy+'->'+newzy);
    end;
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.Update_Data(const pkField, SqlText, sData: string;
  var sError: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    Result := dm.Update_Data(pkField,SqlText,sData,sError);
  finally
    dm.Free;
  end;

end;

function TNewStuLqBd.UpLoadFile(const sPath, sXmlData: string;
  out sError: string; const bOverWrite: Boolean): Boolean;
var
  cds_Temp:TClientDataSet;
  sFileName,sKsh:string;
begin
  Result := True;

  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := sXmlData;
    while not cds_Temp.Eof do
    begin
      try
        sKsh := cds_Temp.FieldByName('Ksh').AsString;
        sFileName := cds_Temp.FieldByName('FileName').AsString;

        if (not cds_Temp.FieldByName('FileData').IsNull) then
        begin
          //if bOverWrite and FileExists(sPath+sFileName) then DeleteFile(sPath+sFileName);
          if (not FileExists(sPath+sFileName)) or bOverWrite then
            TBlobField(cds_Temp.FieldByName('FileData')).SaveToFile(sPath+sFileName);
        end;
        if FileExists(sPath+sFileName) then
          Result := ExecSql('update lqmd set 照片文件='+quotedstr(sFileName)+' where 考生号='+quotedstr(sKsh),sError)
        else
        begin
          Result := ExecSql('update lqmd set 照片文件=NULL where 考生号='+quotedstr(sKsh),sError);
        end;
      except
        on e:Exception do
        begin
          Result := False;
          sError := e.Message;
          Exit;
        end;
      end;
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TNewStuLqBd.UpLoadPhoto(const sXmlData: string;
  out sError: string; const bOverWrite: Boolean): Boolean;
var
  sPath:string;
begin
  sPath := GetPhotoSavePath;
  Result := UpLoadFile(sPath,sXmlData,sError,bOverWrite);
end;

function TNewStuLqBd._GetKsPhotoFileName(const sKsh: string): string;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select 照片文件 from lqmd where 考生号='+quotedstr(sKsh);
    try
      DM.DataSet_Temp.Active := True;
      Result := dm.DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

function TNewStuLqBd._GetRecordCount(const sqlstr: string): Integer;
var
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := sqlstr;
    try
      DM.DataSet_Temp.Active := True;
      Result := dm.DataSet_Temp.Fields[0].AsInteger;
    except
      Result := -1;
    end;
  finally
    DM.DataSet_Temp.Active := False;
    dm.Free;
  end;
end;

initialization
{ Invokable classes must be registered }
   InvRegistry.RegisterInvokableClass(TNewStuLqBd);
end.

