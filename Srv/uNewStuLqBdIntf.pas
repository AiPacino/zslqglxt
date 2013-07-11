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

    function GetAdjustJHNo:string;stdcall; //�õ��ƻ������
    function GetZyJHCount(const sXlcc,sSf,sZyId,sKl:string):Integer;stdcall; //��ȡרҵԭʼ�ƻ���
    function GetZyJHChgCount(const sXlcc,sSf,sZyId,sKl:string):Integer;stdcall; //��ȡרҵ����ƻ���
    function AdjustJH(const sNo,sXlcc,sSf,sCzlx,sWhy,Czy_Id,sDelta:string;out sError:string):Boolean;stdcall; //��������ƻ�
    function PostJH(const sNo,Czy_Id:string;out sError:string):Boolean;stdcall; //�ύ�ƻ�����
    function ConfirmJH(const sNo,Czy_Id:string;out sError:string):Boolean;stdcall; //���ͨ���ƻ�����
    function CancelJH(const sNo,sWhy,Czy_Id:string;out sError:string):Boolean;stdcall;  //�ƻ��������δͨ��
    function DeleteJH(const sNo,Czy_Id:string;out sError:string):Boolean;stdcall;

    function SetStuBdState(const sKsh,sState,czy:string;const sBz:string=''):Boolean; stdcall;
    function UpdateStuZy(const sKsh,xlcc,oldzy,oldyx,newzy,newyx,newxq,czyId:string;out sError:string):Boolean; stdcall;
    function GetRxxq(const yx,zy,xlcc:string):string; stdcall;

    function ApplyJLItem(const Czy_Id,ksh,JLMemo:string):Boolean; stdcall;  //���뽱��
    function CancelJLItem(const Czy_Id,ksh:string):Boolean; stdcall;        //ȡ����������
    function CanBaoDao(const xlcc:string;var sMsg:string):Boolean; stdcall; //�ܷ񱨵�
    function CanApplyJL(const jxmc:string;var sMsg:string):Boolean; stdcall;//�ܷ����뽱��

    function FirstCjIsEnd(const Yx,Sf,Km:string):Boolean; stdcall; //��һ�γɼ��Ƿ�¼�����
    function InitCjInputData(const Yx,Sf,Km:string;const DelData:Boolean;var sError:string):Boolean; stdcall; //��ʼ�ɼ�¼������
    function InitCjStateData(const Yx,Sf,Km:string;var sError:string):Boolean; stdcall;//��ʼ�ɼ�¼��״̬
    function CopyKsInfoToCjB(const ksh,km,yx:string;var sError:string):Boolean; stdcall;      //���ƿ������ݵ��ɼ���
    function SaveInputCj(const ksh,km,yx,pw:string;const CjIndex:Integer;const cj:Double;const CzyId:string;var sError:string):Boolean; stdcall;      //���濼���ɼ����ݵ��ɼ�¼����ϸ��
    function UpLoadInputCj(const Id:Integer;var sError:string):Boolean; stdcall;      //�ϴ������ɼ����ݣ�д��ɼ���Ϣ���ɼ�У�Ա�

    function CjIsConfirmed(const Yx,Sf,Km:string):Boolean; stdcall;                    //�Ƿ�����˳ɼ�
    function CjIsPosted(const CjIndex:Integer;const Yx,Sf,Km:string):Boolean; stdcall; //�ɼ��Ƿ��ύ

    function CjIsUpload(const CjIndex:Integer;const Yx,SjBH:string):Boolean; stdcall;  //�ɼ��Ƿ��ϴ�

    function IsCanInputCj(const CzyId:string):Boolean; stdcall; //�ܷ�¼��ɼ�
    function GetCjInputInfo(const CzyId:string;var Yx,Km:string;var CjIndex:Integer):Boolean; stdcall; //��óɼ�¼����Ϣ

    function PostCj(const CjIndex:Integer;const Yx,Sf,Km:string;const bPost:Boolean=True):Boolean; stdcall;     //�ύ�ɼ�
    function ConfirmCj(const Yx,Sf,Km:string;const bConfirm:Boolean=True):Boolean; stdcall;           //��˳ɼ�
    function KsIsExcept(const ksh:string;var Msg:string):Boolean; stdcall;           //�����Ƿ��쳣
    function KsIsExists(const ksh:string;var Msg:string):Boolean; stdcall;           //�����Ƿ����

    function GetUserInfo:string;stdcall;//��ȡ�����û�����
    function GetMACInfo:string;stdcall;//��ȡ����MAC��Ϣ
    function GetSrvMACAddress:string;stdcall;//��ȡ����������MAC��ַ
    function GetUserCode:string;stdcall;//��ȡ�����û�ע����
    function RegUserInfo(const UserName,UserCode:string):Boolean;stdcall;
    function RegIsOK:Boolean;stdcall;//ϵͳ�Ƿ�ע��
    function SrvIsOK:Boolean;stdcall;
    function SrvIsOpen:Boolean;stdcall; //ϵͳ�����Ƿ񿪷�
    function IsValidIp:Boolean;stdcall; //�Ƿ�Ϸ�IP

    function CzyLogin(const Czy_ID,Czy_Pwd:string;const sVersion:string;var sMsg:string):Boolean;stdcall;//��¼
    function CzyLogOut(const Czy_ID:string):Boolean;stdcall;//�˳�
    function IsLogined(const Czy_ID:string):Boolean;stdcall;//�Ƿ��ѵ�¼
    function GetCzyName(const Czy_ID:string):string;stdcall;
    function GetCzyLevel(const Czy_ID:string):string;stdcall;
    function GetCzyDept(const Czy_ID:string):string;stdcall;
    function ChangeCzyPwd(const Czy_ID,Old_Pwd,newPwd:string):Boolean;stdcall;
    function RecordIsExists(const sWhere,sTable:string):Boolean;stdcall;
    function ReleaseLoginLog(const Czy_ID:string):Boolean ;stdcall; //��յ�¼��־
    function ReleaseLog(const Czy_ID:string):Boolean ;stdcall; //��ղ�����־

    function CanEditXkKdInfo(var sMsg:string):Boolean; stdcall;//�ܷ����������������

    function GetSrvAutoUpdateUrl:string;stdcall;      //�õ����������µ�ַ
    function GetClientAutoUpdateUrl:string;stdcall;   //�õ��ͻ��˸��µ�ַ

    function GetDBMareSql(const sSf,sXlcc:string):string;stdcall;//�ϲ�����SQL
    function GetTdksSql(const sSf,sXlcc:string):string;stdcall;//�˵���������SQL
    function GetTddCountSql(const sXlcc:string):string;stdcall;//Ͷ������¼��SQL

    function UpdateLqInfo(const sXlCc:string):Boolean;stdcall; //����¼ȡ��Ϣ������¿��ࡢרҵ־Ը�����

    function GetPhotoSavePath:string;stdcall; //��Ƭ�洢·��
    function GetPhotoUrlPath:string;stdcall;  //��ƬUrl·��
    function UpLoadFile(const sPath,sXmlData:string;out sError:string;
                        const bOverWrite:Boolean=False):Boolean;stdcall;
    function DownLoadFile(const sFileName:string;out sXmlData,sError:string):Boolean;stdcall;

    function UpLoadPhoto(const sXmlData:string;out sError:string;
                        const bOverWrite:Boolean=False):Boolean;stdcall;
    function DownLoadPhoto(const sKsh:string;out sXmlData,sError:string):Boolean;stdcall;

    function UpdateLqtzsNo(const ksh:string;out sMsg:string):Boolean;stdcall; //����¼ȡ֪ͨ����

    function GetExportFieldList(const sType:string):string;stdcall;//�õ�������Ϣ�ֶ��б�
    function SetExportFieldList(const sType,sFieldList:string):Boolean;stdcall;//�õ�������Ϣ�ֶ��б�
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
