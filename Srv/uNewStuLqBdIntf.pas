{ Invokable interface INewStuLqBd }

unit uNewStuLqBdIntf;

interface

uses InvokeRegistry, Types, SOAPHTTPClient;

const
  gb_Use_Zip: Boolean = True; //False;//

type

  { Invokable interfaces must derive from IInvokable }
  INewStuLqBd = interface(IInvokable)
  ['{52460BEF-ACCA-46C1-A0F3-C1A498F232AD}']

    { Methods of Invokable interface must not use the default }
    { calling convention; stdcall is recommended }
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

    function ApplyJLItem(const Czy_Id,ksh,JLMemo:string):Boolean; stdcall;  //申请奖项
    function CancelJLItem(const Czy_Id,ksh:string):Boolean; stdcall;        //取消奖项申请
    function CanBaoDao(const xlcc:string;var sMsg:string):Boolean; stdcall; //能否报到
    function CanApplyJL(const jxmc:string;var sMsg:string):Boolean; stdcall;//能否申请奖励

    function FirstCjIsEnd(const Yx,Sf,Km:string):Boolean; stdcall; //第一次成绩是否录入完成
    function InitCjInputData(const Yx,Sf,Km:string;const DelData:Boolean;var sError:string):Boolean; stdcall; //初始成绩录入名单
    function InitCjStateData(const Yx,Sf,Km:string;var sError:string):Boolean; stdcall;//初始成绩录入状态
    function CopyKsInfoToCjB(const ksh,km,yx:string;var sError:string):Boolean; stdcall;      //复制考生数据到成绩表
    function SaveInputCj(const ksh,km,yx,pw:string;const CjIndex:Integer;const cj:Double;const CzyId:string;var sError:string):Boolean; stdcall;      //保存考生成绩数据到成绩录入明细表
    function UpLoadInputCj(const Id:Integer;var sError:string):Boolean; stdcall;      //上传考生成绩数据，写入成绩信息到成绩校对表

    function CjIsConfirmed(const Yx,Sf,Km:string):Boolean; stdcall;                    //是否已审核成绩
    function CjIsPosted(const CjIndex:Integer;const Yx,Sf,Km:string):Boolean; stdcall; //成绩是否提交

    function CjIsUpload(const CjIndex:Integer;const Yx,SjBH:string):Boolean; stdcall;  //成绩是否上传

    function IsCanInputCj(const CzyId:string):Boolean; stdcall; //能否录入成绩
    function GetCjInputInfo(const CzyId:string;var Yx,Km:string;var CjIndex:Integer):Boolean; stdcall; //获得成绩录入信息

    function PostCj(const CjIndex:Integer;const Yx,Sf,Km:string;const bPost:Boolean=True):Boolean; stdcall;     //提交成绩
    function ConfirmCj(const Yx,Sf,Km:string;const bConfirm:Boolean=True):Boolean; stdcall;           //审核成绩
    function KsIsExcept(const ksh:string;var Msg:string):Boolean; stdcall;           //考生是否异常
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

function GetINewStuLqBd(UseWSDL: Boolean=System.False; Addr: string=''; HTTPRIO: THTTPRIO = nil): INewStuLqBd;

implementation

function GetINewStuLqBd(UseWSDL: Boolean; Addr: string; HTTPRIO: THTTPRIO): INewStuLqBd;
const
  defWSDL = 'http://localhost/NewStuLqBd/NewStuLqBdSrv.dll/wsdl/INewStuLqBd';
  defURL  = 'http://localhost/NewStuLqBd/NewStuLqBdSrv.dll/soap/INewStuLqBd';
  defSvc  = 'INetPayservice';
  defPrt  = 'INetPayPort';
var
  RIO: THTTPRIO;
begin
  Result := nil;
  if (Addr = '') then
  begin
    if UseWSDL then
      Addr := defWSDL
    else
      Addr := defURL;
  end;
  if HTTPRIO = nil then
    RIO := THTTPRIO.Create(nil)
  else
    RIO := HTTPRIO;

  RIO.HTTPWebNode.UseUTF8InHeader := True;

  try
    Result := (RIO as INewStuLqBd);
    if UseWSDL then
    begin
      RIO.WSDLLocation := Addr;
      RIO.Service := defSvc;
      RIO.Port := defPrt;
    end else
      RIO.URL := Addr;
  finally
    if (Result = nil) and (HTTPRIO = nil) then
      RIO.Free;
  end;
end;

initialization
  { Invokable interfaces must be registered }
  InvRegistry.RegisterInterface(TypeInfo(INewStuLqBd));

end.
