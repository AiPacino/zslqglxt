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

    function ApplyJLItem(const Czy_Id,ksh,JLMemo:string):Boolean; stdcall;
    function CancelJLItem(const Czy_Id,ksh:string):Boolean; stdcall;
    function CanBaoDao(const xlcc:string;var sMsg:string):Boolean; stdcall;//�ܷ񱨵�
    function CanApplyJL(const jxmc:string;var sMsg:string):Boolean; stdcall;//�ܷ����뽱��

    function FirstCjIsEnd(const Yx,Sf,Km:string):Boolean; stdcall; //��һ�γɼ��Ƿ�¼�����
    function InitCjInputData(const Yx,Sf,Km:string;const DelData:Boolean;var sError:string):Boolean; stdcall; //��ʼ�ɼ�¼������
    function InitCjStateData(const Yx,Sf,Km:string;var sError:string):Boolean; stdcall; //��ʼ�ɼ�¼��״̬
    function CopyKsInfoToCjB(const ksh,km,yx:string;var sError:string):Boolean; stdcall;      //���ƿ������ݵ��ɼ���
    function SaveInputCj(const ksh,km,yx,pw:string;const CjIndex:Integer;const cj:Double;const CzyId:string;var sError:string):Boolean; stdcall;      //���濼���ɼ����ݵ��ɼ�¼����ϸ��
    function UpLoadInputCj(const Id:Integer;var sError:string):Boolean; stdcall;      //�ϴ������ɼ����ݣ�д��ɼ���Ϣ���ɼ�У�Ա�

    function CjIsConfirmed(const Yx,Sf,Km:string):Boolean; stdcall;                    //�Ƿ�����˳ɼ�
    function CjIsPosted(const CjIndex:Integer;const Yx,Sf,Km:string):Boolean; stdcall; //�ɼ��Ƿ��ύ

    function CjIsUpload(const CjIndex:Integer;const Yx,SjBH:string):Boolean; stdcall;  //�ɼ��Ƿ��ϴ�

    function IsCanInputCj(const CzyId:string):Boolean; stdcall; //�ܷ�¼��ɼ�
    function GetCjInputInfo(const CzyId:string;var Yx,Km:string;var CjIndex:Integer):Boolean; stdcall; //��óɼ�¼����Ϣ

    function PostCj(const CjIndex:Integer;const Yx,Sf,Km:string;const bPost:Boolean=True):Boolean; stdcall;     //�ύ�ɼ�
    function ConfirmCj(const Yx,Sf,Km:string;const bConfirm:Boolean=True):Boolean; stdcall;                        //��˳ɼ�
    function KsIsExcept(const ksh:string;var Msg:string):Boolean; stdcall;                            //�����Ƿ��쳣
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
    sqlstr := 'Insert Into ������־�� (�û�,ActionTime,����,IP) values'+
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
    sqlstr := 'Insert Into ����Ա��¼�� (����Ա���,��¼ʱ��,��¼IP,SrvHost,�Ƿ�����,�ͻ��˰汾) values'+
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
    sqlstr := 'Update ����Ա��¼�� Set ע��ʱ��=getdate(),ע��IP='+quotedstr(sIP)+',�Ƿ�����=0 '+
              'where ����Ա���='+quotedstr(UserID)+' and �Ƿ�����=0';
    dm.con_Access.Execute(sqlstr);
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.AdjustJH(const sNo, sXlcc,sSf,sCzlx,sWhy, Czy_Id, sDelta: string;out sError:string): Boolean;
var
  sqlstr:String;
begin
  if RecordIsExists('where Id='+quotedstr(sNo),'�ƻ�������') then
    sqlstr := 'update �ƻ������� set ʡ��='+quotedstr(sSf)+',����='+quotedstr(sCzlx)+',˵��='+quotedstr(sWhy)+
              ',״̬='+QuotedStr('�༭��')+' where Id='+quotedstr(sNo)
  else
    sqlstr := 'insert into �ƻ������� (Id,ѧ�����,ʡ��,����,˵��,������,״̬,����ʱ��) values('+
              quotedstr(sNo)+','+quotedstr(sXlcc)+','+quotedstr(sSf)+','+quotedstr(sCzlx)+','+
              quotedstr(sWhy)+','+quotedstr(Czy_Id)+','+quotedStr('�༭��')+',getdate())';
    Result := ExecSql(sqlstr,sError);
    if not Result then Exit;
    if sDelta<>'' then
      Result := Update_Data('Id','select top 0 * from �ƻ�������ϸ��',sDelta,sError);
end;

function TNewStuLqBd.ApplyJLItem(const Czy_Id,ksh, JLMemo: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr:String;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'update ¼ȡ��Ϣ�� set ������='+quotedstr(JLMemo)+' where ������='+quotedstr(ksh);
    Result := dm.ExecSqlCmd(sqlstr);
    if Result then
      WriteLog(Czy_Id,'������'+ksh+JLMemo+'�ɹ���')
    else
      WriteLog(Czy_Id,'������'+ksh+JLMemo+'ʧ�ܣ�');
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.CanApplyJL(const jxmc:string;var sMsg: string): Boolean;
var
  sqlstr:String;
begin
  sqlstr := 'select count(*) from ������Ŀ���ñ� where ��������='+quotedstr(jxmc)+' and ��������<>0';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.CanBaoDao(const xlcc: string; var sMsg: string): Boolean;
var
  sqlstr:String;
  curTime:string;
begin
  curTime := FormatDateTime('yyyy-mm-dd hh:nn:ss',Now);
  sqlstr := 'select count(*) from ����ʱ�����ñ� where �������='+quotedstr(xlcc)+' and �Ƿ�����<>0'+
            ' and ('+quotedstr(curTime)+' between ��ʼʱ�� and ����ʱ��)';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.CancelJH(const sNo,sWhy, Czy_Id:string;out sError:string): Boolean;
var
  sqlstr:String;
begin
  sqlstr := 'update �ƻ������� set ���ԭ��='+quotedstr(sWhy)+',�����='+quotedstr(Czy_Id)+
            ',״̬='+quotedstr('�༭��')+',���ʱ��=getdate()'+' where Id='+quotedstr(sNo);
  Result := ExecSql(sqlstr,sError);
end;

function TNewStuLqBd.CancelJLItem(const Czy_Id, ksh: string): Boolean;
var
  dm:TNewStuLqBdSoapDM;
  sqlstr:String;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'update ¼ȡ��Ϣ�� set ������=null where ������='+quotedstr(ksh);
    Result := dm.ExecSqlCmd(sqlstr);
    if Result then
      WriteLog(Czy_Id,'ȡ��������'+ksh+'������ɹ���')
    else
      WriteLog(Czy_Id,'ȡ��������'+ksh+'������ʧ�ܣ�');
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
  sqlstr := 'select count(*) from У�������걨ʱ�����ñ� where �Ƿ�����<>0'+
            ' and ('+quotedstr(curTime)+' between ��ʼʱ�� and ����ʱ��)';
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
  WriteLog(Czy_ID,'��������');
  try
    sqlstr := 'update ����Ա�� set ����Ա����='+quotedstr(newPwd)+
              ' where ����Ա���='+quotedstr(Czy_ID);
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
  sqlstr := 'select count(*) from У���ɼ�¼��״̬�� where �п�Ժϵ='+quotedstr(yx)+
            ' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km)+' and �Ƿ����=1';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.CjIsPosted(const CjIndex: Integer; const Yx, Sf,
  Km: string): Boolean;
var
  cjField,sqlstr:string;
begin
  cjField := '�ɼ�'+IntToStr(CjIndex)+'�Ƿ��ύ';
  sqlstr := 'select count(*) from У���ɼ�¼��״̬�� where �п�Ժϵ='+quotedstr(yx)+
            ' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km)+' and '+cjField+'=1';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.CjIsUpload(const CjIndex: Integer; const Yx,
  SjBH: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from У������ɼ���ϸ�� where �Ծ���='+quotedstr(SjBH)+
            ' and �Ƿ��ύ=1 and �п�Ժϵ='+quotedstr(yx)+' and ¼�����='+IntToStr(CjIndex);
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

  sqlstr := 'select count(*) from У���ɼ�¼��״̬�� where �п�Ժϵ='+quotedstr(yx)+
            ' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km);
  if GetRecordCountBySql(sqlstr)=0 then
  begin
    Result := False;
    Exit;
  end else
  begin
    sqlstr := 'update У���ɼ�¼��״̬�� set �Ƿ����='+ConfirmValue+' where �п�Ժϵ='+quotedstr(yx)+
              ' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km);
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
    sqlstr := 'update �ƻ������� set �����='+quotedstr(Czy_Id)+',״̬='+quotedstr('�����')+
              ',���ʱ��=getdate()'+' where Id='+quotedstr(sNo);
    Result := ExecSql(sqlstr,sError);
{
    if not Result then Exit;

    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select ѧ�����,sum(������) from View_�ƻ�����ͳ�Ʊ� '+
                                   'where ���='+quotedstr('Ԥ���ƻ�')+' and רҵ='+quotedstr('Ԥ���ƻ�');
    DM.DataSet_Temp.Active := True;
    while not dm.DataSet_Temp.Eof do
    begin
      sXlCc := dm.DataSet_Temp.Fields[0].AsString;
      iSum := dm.DataSet_Temp.Fields[1].AsString;
      sqlstr := 'update view_��ʡרҵ�ƻ��� set �ƻ���='+iSum+' where ѧ�����='+quotedstr(sXlCc)+
                ' and ʡ��='+quotedstr('Ԥ���ƻ�')+' and ���='+quotedstr('Ԥ���ƻ�')+' and רҵ='+quotedstr('Ԥ���ƻ�');
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
  sWhere := 'where ������='+quotedstr(ksh)+' and ���Կ�Ŀ='+quotedstr(Km);
  sqlstr := 'select count(*) from У�����Ƴɼ��� '+sWhere;
  if GetRecordCountBySql(sqlstr)<=0 then
  begin
    sqlstr := 'INSERT INTO У�����Ƴɼ��� (������, �п�Ժϵ, ���Կ�Ŀ) '+
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
    sMsg := '����汾���ͣ���';
    Exit;
  end;
  if not RegIsOK then
  begin
    sMsg := 'ϵͳ����Thread error! Error code id is 403!��';
    Sleep(100000);
    Exit;
  end;

  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    DM.DataSet_Temp.Close;
    DM.DataSet_Temp.CommandText := 'select �Ƿ�����,����Ա�ȼ� from ����Ա�� '+
                                   ' where ����Ա���='+#39+Czy_ID+#39+
                                   ' and ����Ա����='+#39+Czy_Pwd+#39;
    DM.DataSet_Temp.Active := True;

    Result := dm.DataSet_Temp.RecordCount>0;
    if not Result then
    begin
      sMsg := '�û��������������˶Ժ��������룡��';
      Exit;
    end;

    Result := dm.DataSet_Temp.Fields[0].AsBoolean;
    if not Result then
    begin
      sMsg := '�û���'+Czy_ID+'���ѱ�ͣ�ã���˶Ժ��������룡��';
    end
    else if GetCzyLevel(Czy_ID)<>'-1' then
    begin
      if (not IsValidIp) then
      begin
        sMsg := '��¼���ܾ����Ƿ���IP�����ַ���������ʣ�����ϵͳ����Ա��'+#13+
                         '��Ӧ��ϵͳ��������ϵ������'+#13;
        Result := False;
      end
      else if (not SrvIsOpen) then
      begin
        sMsg := '��¼���ܾ�����������ϵͳ�������ѹرգ��������ʣ���'+#13+
                         '����ϵͳ����Ա��Ӧ��ϵͳ��������ϵ������'+#13;
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
       WriteLog(Czy_ID,'�û���¼ʧ�ܣ�Ver:'+sVersion);
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
  sqlstr := 'delete from �ƻ�������ϸ�� where Id='+quotedstr(sNo);
  Result := ExecSql(sqlstr,sError);
  sqlstr := 'delete from �ƻ������� where Id='+quotedstr(sNo);
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
    sError := '�ļ������ڣ�';
    Exit;
  end;
  cds_Temp := TClientDataSet.Create(nil);
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    dm.Query_Data('select top 0 * from �ļ��ϴ��ṹ��',sData);
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
  sqlstr := 'select count(*) from View_У�����Ƴɼ��� where �п�Ժϵ='+quotedstr(Yx)+
            ' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km)+' and �ɼ�1 Is null';
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

function TNewStuLqBd.GetDBMareSql(const sSf,sXlcc:string):string;stdcall;//�ϲ�����SQL
var
  ccstr,sqlstr:string;
  dm:TNewStuLqBdSoapDM;
begin
  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    if sXlcc='����' then //td_pcdm.db�е�GBCCDM�ֶΣ�1�����ƣ�2��ר��
      sqlstr := 'select SqlText from ���ݲɼ�SQL���ñ� where ���='+quotedstr('001')
    else //if sXlcc='ר��' then
      sqlstr := 'select SqlText from ���ݲɼ�SQL���ñ� where ���='+quotedstr('002');

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
    sqlstr := 'select ���� from ������Ϣ���ñ� where ����='+quotedstr(sType);
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
      //sTitle := '�ƿ�';
      Result := '��ˮ��,ʡ��,���,������,���֤��,��������,�Ա�,����У��,left(��ͥ��ַ,6) as ����' ;
    end;
    1:
    begin
      //sTitle := 'EMS';
      Result := '��ˮ��,ʡ��,���,������,��������,�ռ���,��������,��ͥ��ַ,��ϵ�绰' ;
    end;
    2:
    begin
      //sTitle := '����';
      Result := '��ˮ��,ѧ�����,ʡ��,���,����,������,���֤��,��������,�Ա�,ѧ�����,¼ȡרҵ�淶�� as רҵ,Ժϵ,����У��,�ռ���,��������,��ͥ��ַ,��ϵ�绰' ;
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
    sqlstr := 'select SavePath from ��Ƭ·����Ϣ�� ';
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
    sqlstr := 'select sUrl from ��Ƭ·����Ϣ�� ';
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
    sqlstr := 'select ¼��Ժϵ,¼���Ŀ,¼��˳�� from �ɼ�¼�����ñ� '+
              'where ¼��Ա='+quotedstr(CzyId);
    if Yx<>'' then
      sqlstr := sqlstr+' and ¼��Ժϵ='+quotedstr(Yx);
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
    DM.DataSet_Temp.CommandText := 'select ClientUrl from �Զ����µ�ַ�� ';
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
    DM.DataSet_Temp.CommandText := 'select Ժϵ from ����Ա�� where ����Ա���='+quotedstr(Czy_ID);
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
    DM.DataSet_Temp.CommandText := 'select ����Ա�ȼ� from ����Ա�� where ����Ա���='+quotedstr(Czy_ID);
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
    DM.DataSet_Temp.CommandText := 'select ����Ա���� from ����Ա�� where ����Ա���='+quotedstr(Czy_ID);
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
    sqlstr := 'select ��ѧУ�� from view_Ժϵרҵ�� where '+
              'where Ժϵ='+quotedstr(yx)+
              ' and רҵ='+quotedstr(zy)+
              ' and ѧ�����='+quotedstr(xlcc);
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
    DM.DataSet_Temp.CommandText := 'select SrvUrl from �Զ����µ�ַ�� ';
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
    if sXlcc='����' then //td_pcdm.db�е�GBCCDM�ֶΣ�1�����ƣ�2��ר��
      sqlstr := 'select SqlText from ���ݲɼ�SQL���ñ� where ���='+quotedstr('101')
    else //if sXlcc='ר��' then
      sqlstr := 'select SqlText from ���ݲɼ�SQL���ñ� where ���='+quotedstr('102');

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
    if sXlcc='����' then //td_pcdm.db�е�GBCCDM�ֶΣ�1�����ƣ�2��ר��
      sqlstr := 'select SqlText from ���ݲɼ�SQL���ñ� where ���='+quotedstr('201')
    else //if sXlcc='ר��' then
      sqlstr := 'select SqlText from ���ݲɼ�SQL���ñ� where ���='+quotedstr('202');

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
      Result := 'δ����ϵͳ�û���Ϣ';
  finally
    dm.Free;
  end;
end;

function TNewStuLqBd.GetZyJHChgCount(const sXlcc, sSf, sZyId, sKl: string): Integer;
var
  sqlstr:string;
begin
  sqlstr := 'select sum(������) from View_�ƻ�������ϸ�� where ʡ��='+quotedstr(sSf)+
            ' and ѧ�����='+quotedstr(sXlcc)+' and רҵId='+sZyId+
            ' and ����='+quotedstr(sKl);
  Result := GetRecordCountBySql(sqlstr);
end;

function TNewStuLqBd.GetZyJHCount(const sXlcc, sSf, sZyId, sKl: string): Integer;
var
  sqlstr:string;
begin
  sqlstr := 'select �ƻ��� from View_��ʡרҵ�ƻ��� where ʡ��='+quotedstr(sSf)+
            ' and ѧ�����='+quotedstr(sXlcc)+' and רҵId='+sZyId+
            ' and ����='+quotedstr(sKl);
  Result := GetRecordCountBySql(sqlstr);
end;

function TNewStuLqBd.InitCjInputData(const Yx, Sf, Km: string;const DelData:Boolean;
  var sError: string): Boolean;
var
  sWhere,sqlstr:string;
begin
  sWhere := 'where �п�Ժϵ='+quotedstr(Yx)+' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km);
  if DelData then
  begin
    sqlstr := 'delete from У�����Ƴɼ��� where ������ in (select ������ from view_У�����Ƴɼ��� '+sWhere+')';
    if not ExecSql(sqlstr,sError) then Exit;
  end;
  sqlstr := 'select count(*) from View_У�����Ƴɼ��� '+sWhere;
  if GetRecordCountBySql(sqlstr)<=0 then
  begin
    sqlstr := 'INSERT INTO У�����Ƴɼ��� (������, �п�Ժϵ, ���Կ�Ŀ) '+
              'SELECT ������, �п�Ժϵ, ���Կ�Ŀ FROM View_У���������Կ�Ŀ�� '+sWhere;
    Result := ExecSql(sqlstr,sError);
  end else
    Result := True;
end;

function TNewStuLqBd.InitCjStateData(const Yx, Sf, Km: string;
  var sError: string): Boolean;
var
  sWhere,sqlstr:string;
begin
  sWhere := 'where �п�Ժϵ='+quotedstr(Yx)+' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km);
  sqlstr := 'select count(*) from У���ɼ�¼��״̬�� '+sWhere;
  if GetRecordCountBySql(sqlstr)<=0 then
  begin
    sqlstr := 'INSERT INTO У���ɼ�¼��״̬�� (ʡ��, �п�Ժϵ, ���Կ�Ŀ) '+
              'SELECT ʡ��, �п�Ժϵ, ���Կ�Ŀ FROM View_У�����㿼�Կ�Ŀ�� '+sWhere;
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
    sqlstr := 'select top 1 �Ƿ�����,��¼IP from ����Ա��¼�� where �û�='+quotedstr(Czy_ID)+' order by ID desc';
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
  if GetRecordCount('�ͻ���IP��')=0 then
  begin
    Result := True;
    Exit;
  end;
  sqlstr := 'select count(*) from �ͻ���IP�� where '+Sip+' between ��ʼIP and ����IP';
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.KsIsExcept(const ksh: string;var Msg:string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from У�������쳣����ǼǱ� where ������='+quotedstr(ksh);
  Result := GetRecordCountBySql(sqlstr)>0;
end;

function TNewStuLqBd.KsIsExists(const ksh: string; var Msg: string): Boolean;
var
  sqlstr:string;
begin
  sqlstr := 'select count(*) from У����������רҵ�� where ������='+quotedstr(ksh);
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
    
  cjField := '�ɼ�'+IntToStr(CjIndex)+'�Ƿ��ύ';
  sqlstr := 'select count(*) from У���ɼ�¼��״̬�� where �п�Ժϵ='+quotedstr(yx)+
            ' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km);
  if GetRecordCountBySql(sqlstr)=0 then
  begin
    sqlstr := ' Insert into У���ɼ�¼��״̬�� (�п�Ժϵ,ʡ��,���Կ�Ŀ,'+cjField+') Values('+quotedstr(Yx)+','+quotedstr(Sf)+','+quotedstr(Km)+','+cjValue+')';
  end else
  begin
    sqlstr := 'update У���ɼ�¼��״̬�� set '+cjField+'='+cjValue+' where �п�Ժϵ='+quotedstr(yx)+
              ' and ʡ��='+quotedstr(Sf)+' and ���Կ�Ŀ='+quotedstr(Km);
  end;
  Result := ExecSql(sqlstr,sError);
end;

function TNewStuLqBd.PostJH(const sNo, Czy_Id: string;
  out sError: string): Boolean;
var
  sqlstr:String;
begin
  sqlstr := 'update �ƻ������� set ״̬='+quotedstr('�����')+' where Id='+quotedstr(sNo)+
            ' and ������='+quotedstr(Czy_Id);
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
  sqlstr := 'delete from ������־��';
  sError := '';
  Result := ExecSql(sqlstr,sError);
  if Result then
    sError := 'ɾ��������־��OK��'
  else
    sError := 'ɾ��������־ʧ�ܣ�'+sError;
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
  sqlstr := 'delete from ����Ա��¼��';
  sError := '';
  Result := ExecSql(sqlstr,sError);
  if Result then
    sError := 'ɾ����¼��־��OK��'
  else
    sError := 'ɾ����¼��־ʧ�ܣ�'+sError;
  if Length(sError)>50 then
    sError := Copy(sError,1,50);
  WriteLog(Czy_ID,sError);
end;

function TNewStuLqBd.SaveInputCj(const ksh,km,yx,pw:string;const CjIndex:Integer;const cj:Double;const CzyId:string;var sError:string): Boolean;
var
  sWhere,sqlstr,czyField,cjField:string;
begin
  Result := False;
  sWhere := 'where ������='+quotedstr(ksh)+' and ���Կ�Ŀ='+quotedstr(Km)+' and ¼�����='+IntToStr(CjIndex)+' and ��ί='+quotedstr(pw);
  sqlstr := 'select count(*) from У������ɼ�¼��� '+sWhere;
  if GetRecordCountBySql(sqlstr)<=0 then
    sqlstr := 'INSERT INTO У������ɼ�¼��� (������, �п�Ժϵ,���Կ�Ŀ,��ί,¼�����,�ɼ�,¼��Ա,¼��ʱ��,�Ƿ��ύ) '+
              'Values('+quotedstr(ksh)+','+quotedstr(yx)+','+quotedstr(km)+','+quotedstr(pw)+','+IntToStr(CjIndex)+','+FloatToStr(cj)+','+quotedstr(CzyId)+',getdate(),0'+')'
  else
    sqlstr := 'update У������ɼ�¼��� set �ɼ�='+FloatToStr(cj)+',¼��Ա='+quotedstr(CzyId)+',¼��ʱ��=getdate() '+
              'where ������='+quotedstr(ksh)+' and ���Կ�Ŀ='+quotedstr(km)+' and ��ί='+quotedstr(pw)+' and ¼�����='+IntToStr(CjIndex);

  Result := ExecSql(sqlstr,sError);
{
  if Result then
  begin
    cjField := '�ɼ�'+IntTostr(CjIndex);
    czyField := '¼��Ա'+IntTostr(CjIndex);
    sWhere := 'where ������='+quotedstr(ksh)+' and ���Կ�Ŀ='+quotedstr(Km)+' and ��ί='+quotedstr(pw);
    sqlstr := 'select count(*) from У������ɼ�У�Ա� '+sWhere;
    if GetRecordCountBySql(sqlstr)<=0 then
      sqlstr := 'INSERT INTO У������ɼ�У�Ա� (������, �п�Ժϵ,���Կ�Ŀ,��ί,'+cjField+','+czyField+',�Ƿ����) '+
              'Values('+quotedstr(ksh)+','+quotedstr(yx)+','+quotedstr(km)+','+quotedstr(pw)+','+FloatToStr(cj)+','+quotedstr(CzyId)+',0'+')'
    else
      sqlstr := 'update У������ɼ�У�Ա� set '+cjField+'='+FloatToStr(cj)+','+czyField+'='+quotedstr(CzyId)+',�Ƿ����=0 '+sWhere;

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
    sqlstr := 'select count(*) from ������Ϣ���ñ� where ����='+quotedstr(sType);
    if dm.RecordIsExists(sqlstr) then
      sqlstr := 'update ������Ϣ���ñ� set ����='+quotedstr(sFieldList)+' where ����='+quotedstr(sType)
    else
      sqlstr := 'Insert into ������Ϣ���ñ� (����,����) values('+quotedstr(sType)+','+quotedstr(sFieldList)+')';

    Result := dm.ExecSqlCmd(sqlstr);
  finally
    dm.Free;
  end;
{
  case iType of
    0:
    begin
      //sTitle := '�ƿ�';
      Result := '��ˮ��,ʡ��,���,������,���֤��,��������,�Ա�,����У��,left(��ͥ��ַ,6) as ����' ;
    end;
    1:
    begin
      //sTitle := 'EMS';
      Result := '��ˮ��,ʡ��,���,������,��������,�ռ���,��������,��ͥ��ַ,��ϵ�绰' ;
    end;
    2:
    begin
      //sTitle := '����';
      Result := '��ˮ��,ѧ�����,ʡ��,���,����,������,���֤��,��������,�Ա�,ѧ�����,¼ȡרҵ�淶�� as רҵ,Ժϵ,����У��,�ռ���,��������,��ͥ��ַ,��ϵ�绰' ;
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

  sqlstr := 'update ¼ȡ��Ϣ�� set ����״̬='+state+',δ����ԭ��='+bz+',��������='+sdate+
            ',����Ա='+quotedstr(czy)+' where ������='+quotedstr(sKsh);
  try
    Result := dm.ExecSqlCmd(sqlstr);
    if sState<>'' then
      WriteLog(czy,sKsh+'������Ա����Ϊ'+sState)
    else
      WriteLog(czy,sKsh+'������Ա����Ϊ��ʼ״̬');
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
  sqlstr := 'select count(*) from ������״̬���ñ� where �Ƿ�����<>0';
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
  sqlstr := 'select count(*) from У������ɼ�¼��� where Id='+IntTostr(Id);
  if GetRecordCountBySql(sqlstr)<=0 then Exit;

  dm := TNewStuLqBdSoapDM.Create(nil);
  try
    sqlstr := 'select * from У������ɼ�¼��� where Id='+IntTostr(Id);
    dm.qry_Temp.Close;
    dm.qry_Temp.SQL.Text := sqlstr;
    dm.qry_Temp.Open;

    ksh := dm.qry_Temp.FieldByName('������').AsString;
    yx := dm.qry_Temp.FieldByName('�п�Ժϵ').AsString;
    km := dm.qry_Temp.FieldByName('���Կ�Ŀ').AsString;
    pw := dm.qry_Temp.FieldByName('��ί').AsString;
    cjIndex := dm.qry_Temp.FieldByName('¼�����').AsInteger;
    Cj := dm.qry_Temp.FieldByName('�ɼ�').AsFloat;
    CzyId := dm.qry_Temp.FieldByName('¼��Ա').AsString;

    dm.qry_Temp.Close;

    cjField := '�ɼ�'+IntTostr(CjIndex);
    czyField := '¼��Ա'+IntTostr(CjIndex);
    sWhere := 'where ������='+quotedstr(ksh)+' and ���Կ�Ŀ='+quotedstr(Km)+
              ' and ��ί='+quotedstr(pw);
    sqlstr := 'select count(*) from У������ɼ�У�Ա� '+sWhere;
    if GetRecordCountBySql(sqlstr)<=0 then
      sqlstr := 'INSERT INTO У������ɼ�У�Ա� (������, �п�Ժϵ,���Կ�Ŀ,��ί,'+cjField+','+czyField+',�Ƿ����) '+
              'Values('+quotedstr(ksh)+','+quotedstr(yx)+','+quotedstr(km)+','+quotedstr(pw)+','+FloatToStr(cj)+','+quotedstr(CzyId)+',0'+')'
    else
      sqlstr := 'update У������ɼ�У�Ա� set '+cjField+'='+FloatToStr(cj)+','+czyField+'='+quotedstr(CzyId)+',�Ƿ����=0 '+sWhere;

    Result := ExecSql(sqlstr,sError);
    if not Result then Exit;
    sqlstr := 'update У������ɼ�¼��� set �Ƿ��ύ=1,�ύʱ��=getdate() where Id='+IntTostr(Id);
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
      Result := GetRecordCountBySql('select count(*) lqmd where ֪ͨ����='+quotedstr(sNo))=0;
      if not Result then
      begin
        sMsg := '��֪ͨ�����Ѵ��ڣ�';
        Exit;
      end;
    end;

    sqlstr := 'select ������ from ¼ȡ��Ϣ�� where (��ˮ�� is not null) and ((֪ͨ���� is null) or ֪ͨ����='+quotedstr('')+')';
    if ksh<>'' then
      sqlstr := sqlstr+' and ������='+quotedstr(ksh);
    sqlstr := sqlstr+' order by ʡ��,��ˮ��';
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
      sKsh := cds_Temp.FieldByName('������').AsString;
      sNo := dm.GetLqtzsNo(sKsh);
      sqlstr := 'update ¼ȡ��Ϣ�� set ֪ͨ����='+quotedstr(sNo)+' where ������='+quotedstr(sKsh);
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
    sqlstr := 'update ¼ȡ��Ϣ�� set ¼ȡרҵ='+new_zy+',¼ȡרҵ�淶��='+new_zy+',Ժϵ='+new_yx+',����У��='+new_xq+' where ������='+ksh;
    if dm.ExecSqlCmd(sqlstr,sError) then
    begin
      sqlstr := 'Insert Into ����רҵ��¼�� (������,ѧ�����,ԭ¼ȡרҵ,ԭԺϵ,��¼ȡרҵ,��Ժϵ,����Ա,����ʱ��) '+
                'values('+ksh+','+vxlcc+','+old_zy+','+old_yx+','+new_zy+','+new_yx+','+quotedstr(czyId)+',getdate())';
      Result := dm.ExecSqlCmd(sqlstr,sError);
      WriteLog(czyId,sKsh+'����רҵ��'+oldzy+'->'+newzy);
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
          Result := ExecSql('update lqmd set ��Ƭ�ļ�='+quotedstr(sFileName)+' where ������='+quotedstr(sKsh),sError)
        else
        begin
          Result := ExecSql('update lqmd set ��Ƭ�ļ�=NULL where ������='+quotedstr(sKsh),sError);
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
    DM.DataSet_Temp.CommandText := 'select ��Ƭ�ļ� from lqmd where ������='+quotedstr(sKsh);
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

