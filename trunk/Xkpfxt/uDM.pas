unit uDM;

interface

uses
  SysUtils, Classes, DB, DBClient, SOAPConn, Rio, SOAPHTTPClient,GridsEh,
  Messages, IniFiles, Windows,Forms, DBGridEh,DBCtrlsEh, Dialogs,DBGridEhImpExp,
  jpeg, ExtCtrls,EncdDecdEx,EhLibCDS, IdGlobal,EhLibBDE,EhLibADO,PublicVariable,
  PrnDbgEH,Graphics, frxChart, frxDesgn, StdActns, ActnList,StrUtils,DateUtils,
  Menus, ImgList, Controls, frxClass, frxDBSet,CnProgressFrm, uVobj,uActiveSetLanguage,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP,
  VCLUnZip, VCLZip, InvokeRegistry, ADODB,IdMultipartFormData, frxBarcode,
  Provider, TConnect, SunVote_TLB, OleServer, SpeechLib_TLB,uDownloadDataOperate ;

type
 // TMessageHandler = class     //ʹ�ûس���Ϣת����Tab��Ϣ
 //   class procedure AppMessage(var Msg:TMsg;var Handled:Boolean);
 // end;
  TDM = class(TDataModule)
    SaveDialog1: TSaveDialog;
    frxDesigner1: TfrxDesigner;
    frxChartObject1: TfrxChartObject;
    actlst1: TActionList;
    EditCut1: TEditCut;
    EditCopy1: TEditCopy;
    EditPaste1: TEditPaste;
    PopupMenu1: TPopupMenu;
    Cut1: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    N1: TMenuItem;
    mi_Export: TMenuItem;
    ImageList_pm: TImageList;
    act_DataExport: TAction;
    act_Locate: TAction;
    L1: TMenuItem;
    N2: TMenuItem;
    fds_Delta: TfrxDBDataset;
    fds_Master: TfrxDBDataset;
    frxReport1: TfrxReport;
    cds_Master: TClientDataSet;
    cds_Delta: TClientDataSet;
    dlgOpen1: TOpenDialog;
    dlgSave1: TSaveDialog;
    act_DataExportByButton: TAction;
    IdHTTP1: TIdHTTP;
    VCLZip1: TVCLZip;
    VCLUnZip1: TVCLUnZip;
    frxBarCodeObject1: TfrxBarCodeObject;
    con_Local: TLocalConnection;
    con_DB: TADOConnection;
    DSP_Open: TDataSetProvider;
    qry_Open: TADOQuery;
    cds_Open: TClientDataSet;
    qry_Update: TADOQuery;
    DSP_Update: TDataSetProvider;
    cds_Update: TClientDataSet;
    SpVoice1: TSpVoice;
    BaseConnection1: TBaseConnection;
    BaseManage1: TBaseManage;
    KeypadManage1: TKeypadManage;
    Message1: TMessage;
    procedure DataModuleCreate(Sender: TObject);
    procedure SaveDialog1TypeChange(Sender: TObject);
    procedure act_DataExportExecute(Sender: TObject);
    procedure act_LocateExecute(Sender: TObject);
    procedure frxReport1GetValue(const VarName: string; var Value: Variant);
    procedure frxReport1PrintPage(Page: TfrxReportPage; CopyNo: Integer);
    procedure cds_MasterAfterScroll(DataSet: TDataSet);
    procedure act_DataExportByButtonExecute(Sender: TObject);
    procedure HTTPRIO1HTTPWebNode1ReceivingData(Read, Total: Integer);
    procedure HTTPRIO1HTTPWebNode1PostingData(Sent, Total: Integer);
    procedure HTTPRIO1BeforeExecute(const MethodName: string;
      var SOAPRequest: WideString);
    procedure DataModuleDestroy(Sender: TObject);
    procedure BaseConnection1BaseOnLine(ASender: TObject; BaseID,
      BaseState: Integer);
  private
    { Private declarations }
    SendTotal,GetTotal:Integer;

    ii:Integer;
    function _GetRecordCount(const sqlstr:string):Integer;
    function  SaveAsUrlImage(const sUrl,sFileName:string):Boolean;
    function  DownloadUrlImage(const sUrl:string;img:TImage;const OverPhoto:Boolean=True):Boolean;
    function  UploadUrlImage(const BmNo,sFileName:string):Boolean;
    function  GetSfxmJe(const Id,sfxm:string):string;
    procedure GetListFromTable(const sqlstr:string;out sList:TStrings);
    function  GetDeltaTableSqlText(const RepFileName:string):string;
    function  GetDeltaRepSetInfo(const RepFileName:string;
              out sDeltaTableName,sMasterFieldName,sDeltaFieldName:string):Boolean;
    function  HaveDeltaTable(const RepFileName:string):Boolean;

    procedure GetDeptListBySql(const sqlstr:string;var sList:TStrings);

    //--------------------------------------------------------------
    function Query_Data(const sSqlStr:string;const ShowHint:Boolean=False):string;
    function Update_Data(const sKey,sSqlStr:string;const vDelta:OleVariant;const ShowMsgBox:Boolean=True;const ShowHint:Boolean=False):Boolean;//ֻ��ֱ�Ӱ�Delta���������Ұ���תXML��ʽ
    //--------------------------------------------------------------

    procedure InitSunVote;
    procedure SetLanguage;

  public
    { Public declarations }
    procedure GetYxList(var aComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False);
    function GetRecordCountBySql(const sqlstr:string):Integer; stdcall;
    function RecordIsExists(const sSqlStr:string):Boolean;
    function ExecSqlCmd(const sSqlStr:string):Boolean;overload;
    function ExecSqlCmd(const sSqlStr:string;var sError:string):Boolean;overload;

    function GetUserInfo:string;//����û�����
    function GetMACInfo:string;//����û�������
    function GetUserCode:string;//����û�ע����
    function RegUserInfo(const UserName,UserCode:string):Boolean;//ע���û�
    function SrvIsOpen:Boolean;stdcall; //ϵͳ�����Ƿ񿪷�
    function RegIsOK:Boolean;

    procedure SetConnInfo(const sUrl:string);
    function  GetConnInfo:string;

    function CzyLogin(const Czy_ID,Czy_Pwd:string;const sVersion:string;var sMsg:string):Boolean;stdcall;//��¼
    function CzyLogOut(const Czy_ID:string):Boolean;stdcall;//�˳�
    function IsLogined(const Czy_ID:string):Boolean;stdcall;//�Ƿ��ѵ�¼
    function GetCzyName(const Czy_ID:string):string;stdcall;
    function GetCzyLevel(const Czy_ID:string):string;stdcall;
    function GetCzyDept(const Czy_ID:string):string;stdcall;
    function ChangeCzyPwd(const Czy_ID,Old_Pwd,newPwd:string):Boolean;stdcall;

    function  GetPrintBH:string;
    function  GetNextPrintBH(const Number:string):string;
    function  SetPrintBH(const Number:string):Boolean;

    function  GetSkyName:string; //�տ�Ա
    function  SetSkyName(const sName:string):Boolean;
    function  GetKpyName:string; //��ƱԱ
    function  SetKpyName(const sName:string):Boolean;

    function  GetCjBL(const Km:string;const Cj_No:Integer):Integer; //���á���ȡ�ɼ�¼�����
    function  SetCjBL(const Km:string;const Cj_No,Cj_BL:Integer):Boolean;

    function  OpenData(const sSqlStr:string;const ShowHint:Boolean=False):string;
    function  UpdateData(const sKey,sSqlStr:string;const vDelta:OleVariant;const ShowMsgBox:Boolean=True;const ShowHint:Boolean=False):Boolean;//ֻ��ֱ�Ӱ�Delta���������Ұ���תXML��ʽ
    function  SaveCjData(const CjIndex:Integer;const vDelta:OleVariant):Boolean;
    //function  UpdateData(const sKey,sSqlStr:string;const vDelta:OleVariant):Boolean;overload;//ֻ��ֱ�Ӱ�Delta���������Ұ���תXML��ʽ
    function  UpdateData2(const sKey,sSqlStr,sDelta:string):Boolean;//��ת��DeltaΪXML��ʽ�ٴ�����
    function  ExecSql(const sSqlStr:string):Boolean;
    function  GetJjList(var JjList:TStrings):Boolean; //�õ������б�
    function  GetSrvAutoUpdateUrl:string;
    function  GetClientAutoUpdateUrl:string;

    function  _PrintReport(const sPath:string;const ReportFileName:string;const cds_Master_XMLData:String;
                          const OperateType:Integer;const ShowDialog:Boolean):Boolean; //OperateType: 0:Print 1:Privew 2:Design
    function  _PrintReport2(const sPath:string;const ReportFileName:string;const cds_Master_XMLData:String;
                          const Page:Integer):Boolean; //OperateType: 0:Privew 1:Print 2:Design
    function  PrintReport(const ReportFileName:string;const cds_Master_XMLData:String;
                          const OperateType:Integer=1;const ShowDialog:Boolean=True):Boolean; //OperateType: 0:Privew 1:Print 2:Design
    function  PrintSFD(const sId:string;const OperateType:Integer=0;const ShowDialog:Boolean=True):Boolean;overload;
    function  PrintSFD(const sIdList:Tstrings;const OperateType:Integer=0;const ShowDialog:Boolean=True):Boolean;overload;
    function  PrintSFD2(const sId:string;const Page:Integer):Boolean;
    function  UpdatePrintBH(const ID:string):Boolean;

    function  UpLoadReportFile(const Id: Integer;var ReportFileName: string;
                              var LastModifideTime:TDateTime;
                              const ShowSelectFolder:Boolean=False): Boolean;
    function  DownLoadReportFile(const Id:Integer;var ReportFileName:string;
                                 const ShowSelectFolder:Boolean=False):Boolean;
    procedure UpdateReportFile(const IsOver:Boolean=True);
    procedure DBGridEh1DrawColumnCell(Sender: TObject;  const Rect: TRect; DataCol: Integer; Column: TColumnEh;  State: TGridDrawState);
    function  ExportDBEditEH(const MyDBGridEH:TDBGridEh):Boolean;

    function  DownLoadKsPhoto(const sUrl:string; img:TImage;const OverPhoto:Boolean=True):Boolean;
    function  UpLoadKsPhoto(const BmNo,sFileName: string):Boolean;
    function  DownLoadKsPhotoByKSH(const sKsh,sFileName:string; img:TImage;const OverPhoto:Boolean=True):Boolean;

    function  IsDisplayJiangXi:Boolean; //�Ƿ���ʾ����
    procedure GetDeptList(var sList:TStrings); //���в���
    procedure GetAllYxList(var sList:TStrings);//����ѧԺ
    procedure GetBKYxList(var sList:TStrings); //����ѧԺ
    procedure GetZKYxList(var sList:TStrings); //ר��ѧԺ
    procedure GetXQList(var sList:TStrings);   //У����Ϣ
    procedure CheckKsbmData(const cds_Temp:TClientDataSet;var sError:string);//��֤����������Ϣ
    function  GetKshByZkzh(const sZkzh:string):string; //ͨ��׼��֤�ŵõ�������
    function  GetKshBySfzh(const sSfzh:string):string; //ͨ�����֤�ŵõ�������
    procedure SetXkYxComboBox(aDbComboBox:TDBComboBoxEh);
    function  GetIdByZkzh(const sZkzh:string):string; //ͨ��׼��֤�ŵõ�������
    function  GetIdByKsh(const sKsh:string):string; //ͨ��׼��֤�ŵõ�������
    function  GetIdBySfzh(const sSfzh:string):string; //ͨ�����֤�ŵõ�������

    procedure GetCzySfList(const sXlCc:string;out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetCzySfComboBox(const sXlCc:string;aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False);

    procedure GetSfList(out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetSfComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //ʡ��
    procedure GetSfDirList(out sList:TStrings);

    procedure GetLbList(out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetLbComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //רҵ���

    procedure GetKsLbList(out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetKsLbComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //�������

    procedure GetKLList(out sList:TStrings;const IncludeAll:Boolean=False); //����
    procedure SetKlComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //רҵ����

    procedure GetZyList(const XlCc,ZyLb,Sf:string;out sList:TStrings);
    procedure SetZyComboBox(const XlCc,ZyLb,Sf:string;aDbComboBox:TDBComboBoxEh); //רҵ

    procedure GetZyWithIdList(const XlCc,ZyLb:string;out sList:TStrings);

    //ͨ��ĳһרҵ��Ϣ�õ��������רҵ
    procedure SetZyComboBoxByZy(const XlCc,Zy:string;aDbComboBox:TDBComboBoxEh);

    procedure GetXlCcList(out sList:TStrings;const IncludeAll:Boolean=False);
    procedure SetXlCcComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False); //ѧ�����
    function  SelectZy(const XlCc,ZyLb:string;var sList:TStrings): Boolean;
    function  GetWebSrvUrl:string;
    function  ReleaseLoginLog(const Czy_ID:string):Boolean ;stdcall; //��յ�¼��־
    function  ReleaseLog(const Czy_ID:string):Boolean ;stdcall; //��ղ�����־

    function  PostCj(const CjIndex:Integer;const Yx,Sf,Km:string;const bPost:Boolean=True):Boolean; stdcall;     //�ύ�ɼ�

    //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    procedure FillKsKmList(const yx,zy:string);
 end;


const
  PWZS:Integer = 5;//��ί����

  gb_Use_Zip = False;//True;

//{$DEFINE WAD_DEBUG}
  gb_UserSetFileName = 'UserSet.ini';
{$IFNDEF WAD_DEBUG}
  SOAP_NAME   = 'NewStuLqBdSrv.DLL/soap';
{$ELSE}
//����ʱ������������л�ʱ����Build�Ա��ؽ���Դ
  SOAP_NAME   = 'NewStuLqBdWadSrv.NewStuLqBd/soap';
{$ENDIF}

const
  WM_MiniSQLMsg     = WM_USER + $829;   //���������Ϣ������
  cMiniSqlStop      = $0001;
  cMiniSqlStart     = $0002;
  cMiniSqlClose     = $0003;
  cMiniSqlTitle     = $0004;
  cTitle            = '�ֳ��������ݿ�';//'����SQL2000 v1.16 for vista/win7/xp/2000/2003';


var
  gb_System_Mode:String; //ϵͳģ�飬¼ȡ��������У����
  gbIsOK,gbCanClose:Boolean;
  gb_SfDirList:TStrings;
  gb_Czy_ID,gb_Czy_Name,gb_Czy_Level,gb_Czy_Dept:String;
  gb_CanBd_BK,gb_CanBd_ZK:Boolean;//���ơ�ר���Ƿ�������
  gb_Cur_Xn,gb_Cur_Sfmc,gb_Cur_StartTime,gb_Cur_EndTime:string; //��ǰ�շ�����,��ʼʱ��,����ʱ��
  gb_Last_PrintBH:string; //�ϴ��ù��Ĵ�ӡ���
  DM: TDM;
  //vobj: TVobj;//�ٴη�װGetINetPay�ӿں���
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  gb_KeyCjList,gb_KeyPwList,gb_PwCodeList,gb_KskmList: TStrings;
  MsgBaseKeyScopeError, MsgSignCodeError, MsgSignModeError, MsgBaseSoftDogError,
  MsgKeyIDError, MsgBaseDemoOpen, MsgBaseDemoClose, MsgItemInfo,
  MsgRandomItem, MsgMultipleAssess, MsgEvaluationRule, MsgScoreRule,
  MsgSelfExercise,MsgFileDownload,MsgAvoidItemsDownload: String;

  procedure CreateKeysList;
  procedure DestoryKeysList;
  procedure ClearKeysListValue; //������̳ɼ�
  function  GetPwByKeyCode(const KeyCode: string): string; //ͨ��ǩ����õ���ί����
  function  GetKeyIdByPw(const pw: string): string; //ͨ����ί�õ����̺�
  function  GetCj1ByKeyId(const KeyId:Integer):string;
  function  GetCj2ByKeyId(const KeyId:Integer):string;
  function  GetCj1ByPw(const Pw:string):string;
  function  GetCj2ByPw(const Pw:string):string;
  //+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++


  function AppSrvIsOK: Boolean;
  function GetOneSqlStr(const sSql:string):string;
  function GetSearchKey(const sStr:string;const sType:String='PY';const KeyLength:Integer=4):string;
  function IsModified(cds:TClientDataSet):Boolean;
  function GetAutoUpdateInfo:string;
  procedure PrintDBGridEH(AGrid:TDBGridEh;AOwner:Tform;APageHeader:string='';
                          ALineType:TPageColontitleLineType=pcltSingleLine);
  function  LowerJeToUpper(const je:Real):string; //Сд���ת��Ϊ��д���
  procedure SaveLog(const sMsg:string);
  procedure InitXnList(sList:TDBComboBoxEh);
  function  GetFileLastAccessTime(FileName:   String;   AFlag:   Integer):   TDateTime;
  function  DataSetNoSave(const ClientDataSet:TClientDataSet):Boolean;
  function  GetNextSjBH(const CurBH:string;const SjBHWidth:Integer):string;

  function  GetMdiChildForm(const aClassName:TFormClass):TForm;

  function  PosRight(const subStr,S:string):Integer;
  procedure RealseSortedIcon(const aDBGrid:TDBGridEh);
  procedure SetDBGridEHColumnWidth(const aDBGrid:TDBGridEh);
  function  ZyIsEqual(const zy1,zy2:string;const bSame:Boolean=False):Boolean; //רҵ�Ƿ���ͬ
  function  PhotoIsExists(const photofilename:string):Boolean; //������Ƭ�Ƿ����
  function  GetKsDataPath:string;
  function  GetKsDataPath_Old:string;

  function  GetSfMcBySfDm(const sfDm:string):String;
  function  GetSfDmBySfMc(const sfDm:string):String;
  procedure Speak(const sText:string);
  function  SetMiniSql(vMode: Integer; vTitle: string = ''): Boolean;

implementation
uses uMain,PwdFunUnit, Net,ActiveX,shellapi,shlObj,uXkPwqd,uXkPwpf;
{$R *.dfm}
{ TDM }

function SetMiniSql(vMode: Integer; vTitle: string = ''): Boolean;
var
  vH                : HWND;
begin
  vH := Findwindow('TfrmMain', PChar(cTitle));
  if vH = 0 then
  begin
    Result := False;
    Exit;
  end;
  if vMode = 4 then
    sendmessage(vH, WM_SETTEXT, 255, Integer(PChar(vTitle)))
  else
    PostMessage(vH, WM_MiniSQLMsg, vMode, 0);
  Result := true;
end;

procedure Speak(const sText:string);
begin
  dm.SpVoice1.Voice:= dm.SpVoice1.GetVoices('','').Item(0); //�������Ĳ���
  dm.SpVoice1.Speak(sText, SVSFlagsAsync);
end;

procedure CreateKeysList;
var
  i: Integer;
begin
  gb_KeyCjList := TStringList.Create;
  gb_KeyPwList := TStringList.Create;
  gb_PwCodeList := TStringList.Create;
  gb_KskmList := TStringList.Create;
  for i := 0 to PWZS - 1 do
  begin
    gb_KeyCjList.Add(IntToStr(i+1)+'=');
    gb_KeyPwList.Add(IntToStr(i+1)+'=');
  end;
end;

procedure DestoryKeysList;
begin
  FreeAndNil(gb_KeyCjList);
  FreeAndNil(gb_KeyPwList);
  FreeAndNil(gb_PwCodeList);
  FreeAndNil(gb_KskmList);
end;

procedure ClearKeysListValue; //������̳ɼ�
var
  i:Integer;
begin
  gb_KeyCjList.Clear;
  gb_KeyPwList.Clear;
  for i := 0 to PWZS - 1 do
  begin
    gb_KeyCjList.Add(IntToStr(i+1)+'=');
    gb_KeyPwList.Add(IntToStr(i+1)+'=');
  end;
end;

function  GetKeyIdByPw(const pw: string): string;
var
  i: Integer;
begin
  Result := '';
  gb_KeyPwList.BeginUpdate;
  try
    for i := 0 to gb_KeyPwList.Count - 1 do
      if pw=gb_KeyPwList.ValueFromIndex[i] then
      begin
        Result := gb_KeyPwList.Names[i];
        Exit;
      end;
  finally
    gb_KeyPwList.EndUpdate;
  end;
end;

function  GetPwByKeyCode(const KeyCode: string): string;
var
  i,ii :Integer;
begin
  //������=3721
  gb_PwCodeList.BeginUpdate;
  try
    for i := 0 to gb_PwCodeList.Count - 1 do
      if gb_PwCodeList.ValueFromIndex[i]=KeyCode then
      begin
        Result := gb_PwCodeList.Names[i];
        Exit;
      end;
  finally
    gb_PwCodeList.EndUpdate;
  end;
end;

function  GetCj1ByKeyId(const KeyId:Integer):string;
var
  s:string;
  ii:Integer;
begin
  Result := '';
  //KeyValue //1_1=89,2_1=56.5
  s := gb_KeyCjList.Values[IntToStr(KeyId)]; //89.5,77.5
  if s='' then Exit;

  ii := Pos(',',s);
  if ii=0 then ii:=10;
    Result := Copy(s,1,ii-1);
end;

function  GetCj2ByKeyId(const KeyId:Integer):string;
var
  s:string;
  ii:Integer;
begin
  Result := '';
  //KeyValue //1_1=89,2_1=56.5
  s := gb_KeyCjList.Values[IntToStr(KeyId)]; //89.5,77.5
  if s='' then Exit;

  ii := Pos(',',s);
  if ii>0 then
    Result := Copy(s,ii+1,10);
end;

function  GetCj1ByPw(const Pw:string):string;
var
  s:string;
  KeyId,ii:Integer;
  i: Integer;
begin
  Result := '';
  for i := 0 to gb_KeyPwList.Count - 1 do
    if Pw=gb_KeyPwList.ValueFromIndex[i] then
    begin
      ii := i;
      Exit;
    end;
  if i=gb_KeyPwList.Count then Exit;
  KeyId := StrToInt(gb_KeyPwList.Names[ii]);
  Result := GetCj1ByKeyId(KeyId);
end;

function  GetCj2ByPw(const Pw:string):string;
var
  s:string;
  KeyId,ii:Integer;
  i: Integer;
begin
  Result := '';
  for i := 0 to gb_KeyPwList.Count - 1 do
    if Pw=gb_KeyPwList.ValueFromIndex[i] then
    begin
      ii := i;
      Exit;
    end;
  if i=gb_KeyPwList.Count then Exit;
  KeyId := StrToInt(gb_KeyPwList.Names[ii]);
  Result := GetCj2ByKeyId(KeyId);
end;

function  PosRight(const subStr,S:string):Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := Length(S) downto 0 do
    if S[i]=subStr then
    begin
      Result := i;
      Break;
    end;
end;

procedure WriteLog(const UserID,sWhat:string);
var
  sIP,sqlstr:String;  //sSrvHost,
begin
  sIP := GetLocalIpStr;
  try
    sqlstr := 'Insert Into ������־�� (�û�,ActionTime,����,IP) values'+
              '('+quotedstr(UserID)+',getdate(),'+quotedstr(sWhat)+','+quotedstr(sIP)+')';
    dm.ExecSql(sqlstr);
  finally
    dm.Free;
  end;
end;

procedure WriteLoginLog(const UserID,sVer:string);
var
  sIP,sSrvHost,sqlstr:String;
begin
  sIP := GetLocalIpStr;
  sSrvHost := 'localhost';
{
  //GetSOAPWebModule.Request.URL ==> /NetPay/NetPayWebSrv.dll
  //GetSOAPWebModule.Request.PathInfo ==> /soap/IAdmin
  //GetLocalHostName(); // //GetSOAPWebModule.Request.RemoteHost;
}
  if Length(sSrvHost)>30 then
    sSrvHost := Copy(sSrvHost,1,30);
  try
    sqlstr := 'Insert Into ����Ա��¼�� (����Ա���,��¼ʱ��,��¼IP,SrvHost,�Ƿ�����,�ͻ��˰汾) values'+
              '('+quotedstr(UserID)+',getdate(),'+quotedstr(sIP)+','+quotedstr(GetLocalHostName())+',0,'+quotedstr(sVer)+')';
    dm.ExecSql(sqlstr);
  finally
    dm.Free;
  end;
end;

procedure WriteLogoutLog(const UserID:string);
var
  sIP,sqlstr:String;
begin
  sIP := GetLocalIpStr;
  try
    sqlstr := 'Update ����Ա��¼�� Set ע��ʱ��=getdate(),ע��IP='+quotedstr(sIP)+',�Ƿ�����=0 '+
              'where ����Ա���='+quotedstr(UserID)+' and �Ƿ�����=0';
    dm.ExecSql(sqlstr);
  finally
    dm.Free;
  end;
end;

function  GetMdiChildForm(const aClassName:TFormClass):TForm;
var
  i:Integer;
  aForm :TForm;
  str:string;
begin
  Result:=nil;
  aForm := Application.MainForm;
  str := UpperCase(aClassName.ClassName);
  for i:=0 to aForm.MDIChildCount-1 do
  begin
    if UpperCase(aForm.MDIChildren[i].ClassName)=str then
    begin
      Result:=aForm.MDIChildren[i];
      Break;
    end;
  end;
end;


function  DataSetNoSave(const ClientDataSet:TClientDataSet):Boolean;
begin
  if ClientDataSet.State in [dsInsert,dsEdit] then
    ClientDataSet.Post;

  Result := ClientDataSet.ChangeCount>0;
end;

//==============================================================================
// linetypeȡֵ{pcltDoubleLine;pcltsingleline;pcltnon}
// AOwner:TForm TPrintDBGridEh.Create(AOwner); ����TPrintDBGridEh�����FREE
// TPrinterOrientation = (poPortrait, poLandscape); ֽ��������
//==============================================================================

procedure PrintDBGridEH(AGrid:TDBGridEh;AOwner:TForm;APageHeader:string='';
                        ALineType:TPageColontitleLineType=pcltSingleLine);
var
  prn:TPrintDBGridEh;
begin
  if AGrid.DataSource.DataSet.IsEmpty then Exit;
  prn:=TPrintDBGridEh.Create(AOwner);
  prn.Page.TopMargin := 1.5; //cm

  with prn.PageHeader do
  begin
    Font.Name:='����';
    Font.Size:=16;
    Font.Style:=[fsBold];
    LineType:=ALineType;
    CenterText.Text:=APageHeader;
  end;
  with prn.PageFooter do
  begin
    Font.Name:='����';
    Font.Size:=12;
    LeftText.Clear;
    CenterText.Add('��&[Page]ҳ��&[Pages]ҳ');
    LeftText.Add('��ӡ���ڣ�&[date]&[time]');
  end;
  prn.DBGridEh:=AGrid;
  prn.Preview;
end;

//==================================================
//Purpose   :   Get   the   last   file   access   time
//Params     :   FileName         the   File   Name
//                     AFlag     1.   the   file   creation   time
//                               2.   the   file   last   access   time
//                               3.   the   file   last   write   time
//Return     :   TDateTime
//Author     :   ePing
//Date         :   2000-08-03
//==================================================
function GetFileLastAccessTime(FileName:   String;   AFlag:   Integer):   TDateTime;
var
    WFD:   TWin32FindData;
    FileTime:   TFileTime;
    hFile:   THandle;
    DFT:   DWORD;
begin
  try
    hFile   :=   FindFirstFile(PChar(FileName),   WFD);
    if   hFile   <>   INVALID_HANDLE_VALUE   then
    begin
      case   AFlag   of
        1:   FileTimeToLocalFileTime(WFD.ftCreationTime,   FileTime);
        2:   FileTimeToLocalFileTime(WFD.ftLastAccessTime,  FileTime);
        3:   FileTimeToLocalFileTime(WFD.ftLastWriteTime,   FileTime);
      end;
      FileTimeToDosDateTime(FileTime,   LongRec(DFT).HI,   LongRec(DFT).LO);
      Result   :=   FileDateToDateTime(DFT);
    end;
  finally
    //FindClose(hFile);
  end;
end;

function GetFirstWB(const sStr:string;const KeyLength:Integer=4):string;
begin
  Result := '';
end;

function GetSearchKey(const sStr:string;const sType:String='PY';const KeyLength:Integer=4):string;
begin
  if sType='PY' then
    Result := ''//GetFirstPY(sStr,KeyLength)
  else
    Result := GetFirstWB(sStr,KeyLength);
end;

function GetOneSqlStr(const sSql:string):string;
var
  sStr:string;
begin
  sStr := LowerCase(TrimLeft(sSql));
  if (Copy(sStr,1,6)='select') and (Pos(' top ',sStr)=0) then
    sStr := 'select top 1 '+copy(sSql,7,Length(sSql)-6)
  else
    sStr := sSql;
  Result := sStr;
end;

function IsModified(cds:TClientDataSet):Boolean;
begin
  if cds.State in [dsEdit,dsInsert] then
    cds.Post;
  Result := cds.ChangeCount>0;
end;

procedure TDM.act_DataExportByButtonExecute(Sender: TObject);
begin
  act_DataExport.Execute;
end;

procedure TDM.act_DataExportExecute(Sender: TObject);
var
  myPopupMenu:TPopupMenu;
  MyDBGridEH:TDBGridEh;
begin
  //ShowMessage(TMenuItem(TAction(Sender).ActionComponent).GetParentComponent.Name);
  if (TAction(Sender).ActionComponent).GetParentComponent is TPopupMenu then
    myPopupMenu := (TAction(Sender).ActionComponent).GetParentComponent as TPopupMenu
  else
    Exit;

  //ShowMessage(MyPopupMenu.PopupComponent.Name);
  if (MyPopupMenu.PopupComponent is TDBGridEh) then
  begin
    MyDBGridEH := TDBGridEh(MyPopupMenu.PopupComponent);
    ExportDBEditEH(MyDBGridEH);
  end;
end;

procedure TDM.act_LocateExecute(Sender: TObject);
var
  myPopupMenu:TPopupMenu;
  MyDBGridEH:TDBGridEh;
begin
  //ShowMessage(TMenuItem(TAction(Sender).ActionComponent).GetParentComponent.Name);
  if (TAction(Sender).ActionComponent).GetParentComponent is TPopupMenu then
    myPopupMenu := (TAction(Sender).ActionComponent).GetParentComponent as TPopupMenu
  else
    Exit;

  //ShowMessage(MyPopupMenu.PopupComponent.Name);
  if (MyPopupMenu.PopupComponent is TDBGridEh) then
  begin
    MyDBGridEH := TDBGridEh(MyPopupMenu.PopupComponent);
    MyDBGridEH.SetFocus;
    keybd_event(VK_Control, MapVirtualKey(VK_Control, 0), 0, 0);               //����Ctrl��
    keybd_event(ord('F'), MapVirtualKey(ord('F'), 0), 0, 0);                   //����F��
    keybd_event(ord('F'), MapVirtualKey(ord('F'), 0), KEYEVENTF_KEYUP, 0);     //�ſ�F��
    keybd_event(VK_Control, MapVirtualKey(VK_Control, 0), KEYEVENTF_KEYUP, 0); //�ſ�Ctrl��
  end;
end;

procedure TDM.BaseConnection1BaseOnLine(ASender: TObject; BaseID,
  BaseState: Integer);
begin
  with Main.Status_SunVoteBaseInfo do
  begin
    if BaseState=1 then
    begin
      Font.Color := clBlue;
      Caption := Format('��վ������',[BaseID])
    end else
    begin
      Font.Color := clRed;
      Caption := Format('��վ�ѶϿ�',[BaseID]);
    end;
  end;
end;

procedure TDM.cds_MasterAfterScroll(DataSet: TDataSet);
var
  RepFileName,sSqlStr:string;
begin
  RepFileName := ExtractFileName(frxReport1.FileName);
  //RepFileName := DataSet.FieldByName('�����ļ���').AsString;
  sSqlStr := GetDeltaTableSqlText(RepFileName);
  if sSqlStr<>'' then
  begin
    cds_Delta.XMLData := dm.OpenData(sSqlStr);
    //ShowMessage(cds_Master.FieldByName('׼��֤��').AsString+','+cds_Delta.FieldByName('���Կγ�').AsString);
  end;
end;

function TDM.ChangeCzyPwd(const Czy_ID, Old_Pwd, newPwd: string): Boolean;
var
  sqlstr,sMsg:String;
begin
  Result := CzyLogin(Czy_ID,Old_Pwd,'',sMsg);
  if not Result then
    Exit;
  WriteLog(Czy_ID,'��������');
  try
    sqlstr := 'update ����Ա�� set ����Ա����='+quotedstr(newPwd)+
              ' where ����Ա���='+quotedstr(Czy_ID);
    ExecSql(sqlstr);
    Result := True;
  finally
    dm.Free;
  end;
end;

procedure TDM.CheckKsbmData(const cds_Temp:TClientDataSet;var sError:string);
var
  i:Integer;
  sField:string;
begin
  cds_Temp.Last;
  while not cds_Temp.Bof do
  begin
    for i := 0 to cds_Temp.FieldCount - 1 do
    begin
      sField := cds_Temp.Fields[i].FieldName;
      if ((sField = '������') or
          (sField = '����') or
          (sField = '���֤��') or
          (sField = 'רҵ')) and
          (cds_Temp.Fields[i].IsNull or (cds_Temp.Fields[i].AsString='')) then
      begin
        sError := sError+IntToStr(cds_Temp.RecNo)+#13+#10;
        cds_Temp.Delete;
        Break;
      end;
    end;
    cds_Temp.Prior;
  end;
  if sError<>'' then
    sError := '���¼�¼���������ţ����������֤�ţ�רҵ�ֶ�Ϊ�ն�����ʧ�ܣ���¼�ţ�';
end;

function TDM.CzyLogin(const Czy_ID, Czy_Pwd, sVersion: string;
  var sMsg: string): Boolean;
var
  DataSet_Temp:TADODataSet;
begin
  //CzyLogOut(Czy_ID);
  Result := False;
  if sVersion<='1.0.1.128' then
  begin
    sMsg := '����汾���ͣ���';
    Exit;
  end;
  if not SrvIsOpen then
  begin
    sMsg := '��¼ʧ�ܣ�ϵͳ�������ѹر�!��';
    Exit;
  end;

  if not RegIsOK then
  begin
    sMsg := 'ϵͳ����Thread error! Error code id is 403!��';
    Sleep(100000);
    Exit;
  end;

  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;

  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := 'select �Ƿ�����,����Ա�ȼ� from ����Ա�� '+
                                   ' where ����Ա���='+#39+Czy_ID+#39+
                                   ' and ����Ա����='+#39+Czy_Pwd+#39;
    DataSet_Temp.Active := True;

    Result := DataSet_Temp.RecordCount>0;
    if not Result then
    begin
      sMsg := '�û��������������˶Ժ��������룡��';
      Exit;
    end;

    Result := DataSet_Temp.Fields[0].AsBoolean;
    if not Result then
    begin
      sMsg := '�û���'+Czy_ID+'���ѱ�ͣ�ã���˶Ժ��������룡��';
    end
    else if GetCzyLevel(Czy_ID)<>'-1' then
    begin
      if (not SrvIsOpen) then
      begin
        sMsg := '��¼���ܾ���ϵͳ�������ѹرգ��������ʣ���'+#13+
                '����ϵͳ����Ա��ϵ������'+#13;
        Result := False;
      end
      else
        Result := True;
    end;
{
    if Result then
    begin
       WriteLoginLog(Czy_ID,'Ver:'+sVersion);
    end
    else
    begin
       WriteLog(Czy_ID,'�û���¼ʧ�ܣ�Ver:'+sVersion);
    end;
}
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;

end;

function TDM.CzyLogOut(const Czy_ID: string): Boolean;
begin

end;

procedure TDM.DataModuleCreate(Sender: TObject);
var
  fn:string;
begin

  fn := ExtractFilePath(ParamStr(0))+'DB\Sql2k.exe';
  ShellExecute(0,'open',PAnsiChar(fn),nil,nil,SW_HIDE);
  SetMiniSql(cMiniSqlStart);
  if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Kszp') then
    CreateDir(ExtractFileDir(ExtractFilePath(ParamStr(0))+'Kszp'));
  //gb_System_Mode := '¼ȡ';
  con_DB.Close;
  con_DB.ConnectionString := GetConnInfo;
  frxDesigner1.OpenDir := ExtractFilePath(ParamStr(0))+'Rep';
  frxDesigner1.SaveDir := frxDesigner1.OpenDir;

  
  CreateKeysList;//�������̺���ί�����б�
  InitSunVote;
  SetLanguage;
end;

procedure TDM.DataModuleDestroy(Sender: TObject);
begin
  con_DB.Close;
  DestoryKeysList;
  BaseConnection1.Close;
  SetMiniSql(cMiniSqlStop);
  SetMiniSql(cMiniSqlClose);
end;

procedure TDM.DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  //if gdSelected in State then Exit;
  if gdFocused in State then Exit;

  //if (Column.FieldName<>'����״̬') and (Column.FieldName<>'�ɷѽ��') then Exit;

  if (Column.FieldName='�ɷѽ��') or (Column.FieldName='���') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsFloat<0 then
    begin
      Font.Color := clRed
      //Brush.Color := clRed
    end;
    //FillRect(Rect);
  end
  else if (Column.FieldName='����״̬') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsString='���׿���' then
    begin
      //  Font.Color := clRed
      Brush.Color := clRed
    end
    else if Column.Field.AsString='���������' then
    begin
      Font.Color := clRed;
      Brush.Color := clYellow;
    end;
    //FillRect(Rect);
  end
  else if (Column.FieldName = '��ӡ����') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsString='' then
    begin
      //Font.Color := clRed;
      Brush.Color := clRed;
    end;
  end;
  {else if (Column.FieldName = '�Ƿ����') then
  with TDBGridEh(Sender).Canvas do
  begin
    if Column.Field.AsBoolean then
    begin
      Font.Color := clRed;
      //Brush.Color := clSilver;
    end;
  end;
  }
  TDBGridEh(Sender).DefaultDrawColumnCell(Rect,   DataCol,   Column,   State);
end;

function  TDM.DownLoadKsPhoto(const sUrl:string; img:TImage;const OverPhoto:Boolean=True):Boolean;
begin
  if sUrl='' then Exit;
  Result := DownloadUrlImage(sUrl,img,OverPhoto);
end;

function TDM.DownLoadKsPhotoByKSH(const sKsh,sFileName: string; img: TImage;
  const OverPhoto: Boolean): Boolean;
begin
end;

function TDM.DownLoadReportFile(const Id: Integer; var ReportFileName: string;const ShowSelectFolder:Boolean): Boolean;
var
  bl :Boolean;
  sSqlStr,sfn :string;
  sLastTime,sLastTime2:TDateTime;
  cds_Temp:TClientDataSet;
begin
  Result := False;
  sfn := ReportFileName;
  //if (sfn<>'') and (not FileExists(sfn)) then
  //   Exit;

  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select �����ļ���,��������,����޸����� from ����ģ��� where Id='+IntToStr(Id);
    sSqlStr := DM.OpenData(sSqlStr);
    if sSqlStr='' then
      Exit
    else
      cds_Temp.XMLData := sSqlStr;

    if (sfn='') or ShowSelectFolder then
    begin
      if sfn<>'' then
        dlgSave1.FileName := sfn
      else
        dlgSave1.FileName := cds_Temp.Fields[0].AsString;
      if dlgSave1.Execute then
      begin
        sfn := dlgSave1.FileName;
      end else
        Exit;
    end;

    if cds_Temp.FieldByName('��������').IsNull then
    begin
      if (ReportFileName='') then
        Application.MessageBox('���ݿ��еı���ģ��Ϊ�գ��ļ���������ʧ�ܣ�����',
          'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Exit;
    end;

    sLastTime := GetFileLastAccessTime(sfn,3);
    sLastTime2 := cds_Temp.FieldByName('����޸�����').AsDateTime;
    if (ReportFileName='') and (sLastTime2<sLastTime) then
    begin
      if Application.MessageBox(PChar('�����ļ������ݿ��еı����ļ����ݻ�Ҫ�£�����'+#13+
                                      '���Ҫ�滻���ص��ļ���'), 'ϵͳ��ʾ',
          MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=IDYES then
        bl := True
      else
      begin
        bl := False;
        Exit;
      end;
    end else
      bl := True;

    if bl then
    begin
      DeleteFile(PChar(sfn));
      TBlobField(cds_Temp.FieldByName('��������')).SaveToFile(sfn);
    end;
    ReportFileName := ExtractFileName(sfn);
    Result := True;
  finally
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

function TDM.DownloadUrlImage(const sUrl: string; img: TImage;
  const OverPhoto: Boolean): Boolean;
var
  ImageStream:TMemoryStream;
  sPath,fn:string;
begin
  if img<>nil then
  begin
    img.Picture := nil;
  end;

  ii := PosRight('/',sUrl);
  fn := Copy(sUrl,ii+1,Length(sUrl));
  sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
  fn := sPath+fn;
  if not DirectoryExists(sPath) then
    ForceDirectories(sPath);

  if OverPhoto and FileExists(fn) then
    DeleteFile(PChar(fn));

  if FileExists(fn) and (img<>nil) then
  begin
    img.Picture.LoadFromFile(fn);
    Result := True;
    Exit;
  end;

  ImageStream := TMemoryStream.Create();
  try
    try
      idhttp1.Get(sUrl,ImageStream);
    except
      Result := False;
      Exit;
    end;
    Result := ImageStream.Size>0;
    if Result then
    begin
      ImageStream.Position := 0;
      ImageStream.SaveToFile(fn);
      try
        if img<>nil then
          img.Picture.LoadFromFile(fn);
      except
        Result := False;
      end;
    end;
  finally
    ImageStream.Free;
  end;
end;

function TDM._GetRecordCount(const sqlstr: string): Integer;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := sqlstr;
    try
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsInteger;
    except
      Result := -1;
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TDM._PrintReport(const sPath, ReportFileName, cds_Master_XMLData: String;
                          const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  fn,sTempPath,sHint:string;
begin
  sTempPath := sPath;
  if sPath='' then
    sTempPath := ExtractFilePath(ParamStr(0))+'Rep\';
  if not DirectoryExists(sTempPath) then
    ForceDirectories(sTempPath);

  fn := sTempPath+ReportFileName;
  if (not FileExists(fn)) and (OperateType<>2) then
  begin
    MessageBox(0, PChar('����ģ���ļ�δ�ҵ�����������ԣ������ļ�Ϊ������'+#13+fn+'����'), 'ϵͳ��ʾ',
    MB_OK + MB_ICONSTOP + MB_TOPMOST);
    Result := False;
    Exit;
  end;
  case OperateType of
    0:
      sHint := '�������Ҫ��ӡ�𣿡���';
    1:
      sHint := '���Ҫ��ӡԤ���𣿡���';
    2:
      sHint := '���Ҫ���б�������𣿡���';
  end;
  if ShowDialog and (OperateType<>1) then
     if Application.MessageBox(PChar(sHint), 'ϵͳ��ʾ', MB_YESNO +
       MB_ICONQUESTION + MB_TOPMOST) = IDNO then
     begin
       Exit;
     end;

  frxReport1.FileName := ReportFileName;
  if cds_Master_XMLData<>'' then
    cds_Master.XMLData := cds_Master_XMLData;

  //frxReport1.ReportOptions.Name := ReportFileName;
  //if CompareText(ReportFileName,'�ɷѵ�.fr3')=0 then
  if Pos('¼ȡ֪ͨ��',ReportFileName)>0 then
  begin
    frxReport1.OnGetValue := frxReport1GetValue;
    frxReport1.OnPrintPage := frxReport1PrintPage;
  end
  else
  begin
    frxReport1.OnGetValue := nil;
    frxReport1.OnPrintPage := nil;
  end;

  if FileExists(fn) then
  begin
    frxReport1.FileName := fn;
    frxReport1.LoadFromFile(fn);
    frxReport1.Variables.Clear;
    frxReport1.Variables[' User_Var'] := ''; //������������
    frxReport1.Variables.AddVariable('User_Var','cur_sfxn',QuotedStr(gb_Cur_Xn));
    frxReport1.Variables.AddVariable('User_Var','cur_sfmc',QuotedStr(gb_Cur_Sfmc));
    frxReport1.Variables.AddVariable('User_Var','czy_id',QuotedStr(gb_Czy_ID));
    frxReport1.Variables.AddVariable('User_Var','czy_name',QuotedStr(gb_Czy_Name)); //����Ա����
    frxReport1.Variables.AddVariable('User_Var','kpy_id',QuotedStr(GetKpyName)); //��ƱԱ
    frxReport1.Variables.AddVariable('User_Var','sky_id',QuotedStr(GetSkyName)); //�տ�Ա
    frxReport1.Variables.AddVariable('User_Var','rmb_str','');
    frxReport1.Variables.AddVariable('User_Var','sfxm_xf',QuotedStr('0.00'));  //ѧ��
    frxReport1.Variables.AddVariable('User_Var','sfxm_ksf',QuotedStr('0.00')); //���Է�
    frxReport1.Variables.AddVariable('User_Var','sfxm_zsf',QuotedStr('0.00'));  //ס�޷�
    frxReport1.Variables.AddVariable('User_Var','sfxm_jcf',QuotedStr('0.00'));  //�̲ķѣ�����û����
    frxReport1.Variables.AddVariable('User_Var','pj_bh',QuotedStr(''));  //��Ʊ���
    frxReport1.Variables.AddVariable('User_Var','app_path',QuotedStr(ExtractFilePath(ParamStr(0))));  //Ӧ�ó���·��
    frxReport1.Variables.AddVariable('User_Var','photo_fn','');  //��Ƭ�ļ���
    case OperateType of
      0:
      begin
        frxReport1.PrintOptions.ShowDialog := ShowDialog;
        frxReport1.PrepareReport;
        frxReport1.Print;
        //frxreport1.PrintPreparedReportDlg;
      end;
      1:
      begin
        frxReport1.PrintOptions.ShowDialog := ShowDialog;
        frxReport1.ShowReport;
      end;
      2:
      begin
        frxReport1.PrintOptions.ShowDialog := ShowDialog;
        frxReport1.DesignReport;
      end;
    end;
    Result := True;
  end else
  begin
    if OperateType=2 then
    begin
      frxReport1.PrintOptions.ShowDialog := ShowDialog;
      frxReport1.DesignReport;
    end
    else
    begin
      MessageBox(0, PChar('��ӡģ���ļ�δ�ҵ�����������ԣ�����'+#13+fn+'����'), 'ϵͳ��ʾ',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Result := False;
    end;
  end;
end;

function TDM._PrintReport2(const sPath, ReportFileName, cds_Master_XMLData: String; const Page: Integer): Boolean;
var
  fn,sTempPath:string;
begin
  sTempPath := sPath;
  if sPath='' then
    sTempPath := ExtractFilePath(ParamStr(0))+'Rep\';

  fn := sTempPath+ReportFileName;
  frxReport1.ReportOptions.Name := ReportFileName;
  if CompareText(ReportFileName,'�ɷѵ�.fr3')=0 then
  begin
    frxReport1.OnGetValue := frxReport1GetValue;
    frxReport1.OnPrintPage := frxReport1PrintPage;
  end
  else
  begin
    frxReport1.OnGetValue := nil;
    frxReport1.OnPrintPage := nil;
  end;

  if FileExists(fn) then
  begin
    if Page<>-1 then
    begin
      frxReport1.LoadFromFile(fn);
      frxReport1.Variables.Clear;
      frxReport1.Variables[' User_Var'] := ''; //������������
      frxReport1.Variables.AddVariable('User_Var','cur_sfxn',QuotedStr(gb_Cur_Xn));
      frxReport1.Variables.AddVariable('User_Var','cur_sfmc',QuotedStr(gb_Cur_Sfmc));
      frxReport1.Variables.AddVariable('User_Var','czy_id',QuotedStr(gb_Czy_ID));
      frxReport1.Variables.AddVariable('User_Var','czy_name',QuotedStr(gb_Czy_Name)); //����Ա����
      frxReport1.Variables.AddVariable('User_Var','kpy_id',QuotedStr(GetKpyName)); //��ƱԱ
      frxReport1.Variables.AddVariable('User_Var','sky_id',QuotedStr(GetSkyName)); //�տ�Ա
      frxReport1.Variables.AddVariable('User_Var','rmb_str','');
      frxReport1.Variables.AddVariable('User_Var','sfxm_xf',QuotedStr('0.00'));  //ѧ��
      frxReport1.Variables.AddVariable('User_Var','sfxm_ksf',QuotedStr('0.00')); //���Է�
      frxReport1.Variables.AddVariable('User_Var','sfxm_zsf',QuotedStr('0.00'));  //ס�޷�
      frxReport1.Variables.AddVariable('User_Var','sfxm_jcf',QuotedStr('0.00'));  //�̲ķѣ����ڲ�������
      frxReport1.Variables.AddVariable('User_Var','pj_bh',QuotedStr(''));  //��Ʊ���
    end;
    case Page of
      -1:
        frxReport1.ShowPreparedReport;
      1:
        frxReport1.PrepareReport;
      else
        frxReport1.PrepareReport(False);
    end;
    Result := True;
  end else
  begin
    begin
      MessageBox(0, PChar('��ӡģ���ļ�δ�ҵ�����������ԣ�����'+#13+fn+'����'), 'ϵͳ��ʾ',
      MB_OK + MB_ICONSTOP + MB_TOPMOST);
      Result := False;
    end;
  end;
end;

function TDM.ExecSql(const sSqlStr: string): Boolean;
var
  sError:string;
begin
  try
    Result := ExecSqlCmd(sSqlStr,sError) ;

    if sError<>'' then
    begin
        sError := '����ִ��ʧ�ܣ����������ִ�У����ܵ�ԭ��Ϊ������'+#13+sError;
        MessageBox(0, PChar(string(sError)), 'ϵͳ��ʾ', MB_OK
        + MB_ICONSTOP + MB_TOPMOST);
    end;//else
    //  MessageBox(0, '�����ύ�����棩�ɹ�������', 'ϵͳ��ʾ', MB_OK
    //    + MB_ICONINFORMATION);
  finally
    //vobj := nil;
  end;
end;

function TDM.ExecSqlCmd(const sSqlStr: string; var sError: string): Boolean;
var
  adoqry:TADOQuery;
begin
  adoqry := TADOQuery.Create(nil);
  adoqry.Connection := con_DB;
  try
    try
      adoqry.SQL.Text := sSqlStr;
      adoqry.ExecSQL;
      Result := True;
    except
      on e:Exception do
      begin
        sError := e.Message;
        Result := False;
      end;
    end;
  finally
    FreeAndNil(adoqry);
  end;
end;

function TDM.ExecSqlCmd(const sSqlStr: string): Boolean;
var
  sError:string;
begin
  Result := ExecSqlCmd(sSqlStr,sError);
end;

function TDM.ExportDBEditEH(const MyDBGridEH: TDBGridEh):Boolean;
var
  ExpClass:TDBGridEhExportClass;
  fn,mfn,Ext:String;
begin
  if MyDBGridEH.Owner is TForm then
    SaveDialog1.FileName := TForm(MyDBGridEH.Owner).Caption+FormatDateTime('(yyyy-mm-dd)',Now)//+'.xls'
  else
    SaveDialog1.FileName := '���ݵ���'+FormatDateTime('(yyyy-mm-dd)',Now);//.xls';

  if not SaveDialog1.Execute then Exit;

  fn := SaveDialog1.FileName;
  Ext := ExtractFileExt(fn);
  mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
  case SaveDialog1.FilterIndex of
    1: begin ExpClass := TDBGridEhExportAsText; Ext := '.txt'; end;
    2: begin ExpClass := TDBGridEhExportAsCSV; Ext := '.csv'; end;
    3: begin ExpClass := TDBGridEhExportAsHTML; Ext := '.htm'; end;
    4: begin ExpClass := TDBGridEhExportAsRTF; Ext := '.rtf'; end;
    5: begin ExpClass := TDBGridEhExportAsXLS; Ext := '.xls'; end;
  else
    ExpClass := nil; Ext := '';
  end;
  if ExpClass <> nil then
  begin
    SaveDialog1.FileName := mfn + Ext;
    if FileExists(SaveDialog1.FileName) then
      if MessageBox(0,
        PChar('���棡��ǰ�ļ����´���ͬ���ļ�����ͬ���ļ���Ϊ��������'
        + #13#10 +'��'+ ExtractFileName(SaveDialog1.FileName)+'������'+#13+#13+'Ҫ������һͬ���ļ���'), 'ϵͳ��ʾ', MB_YESNO + MB_ICONWARNING
        + MB_DEFBUTTON2 + MB_TOPMOST) = IDNO then
      begin
        Exit;
      end;

    Screen.Cursor := crHourGlass;
    try
      SaveDBGridEhToExportFile(ExpClass,MyDBGridEh, SaveDialog1.FileName,True);
      //SaveDBGridEhToExportFile(ExpClass,DBGridEh1, dlgSave1.FileName,False);
      Result := True;
    finally
      if MyDBGridEH.CanFocus then
         MyDBGridEh.SetFocus;
      Screen.Cursor := crDefault;
    end;
  end;

end;

procedure TDM.FillKsKmList(const yx, zy: string);
var
  kskm,sqlstr:string;
  cds_tmp:TClientDataSet;
  i:integer;
begin
  cds_tmp := TClientDataSet.Create(nil);
  try
    sqlstr := 'select ���Կ�Ŀ from У��רҵ��Ŀ�� where �п�Ժϵ='+quotedstr(yx)+
                                  ' and רҵ='+quotedstr(zy)+' order by ���Կ�Ŀ';
    cds_tmp.XMLData := dm.OpenData(sqlstr);
    gb_KskmList.Clear;
    while not cds_tmp.eof do
    begin
      i := cds_tmp.RecNo;
      kskm := cds_tmp.Fields[0].AsString;
      gb_KskmList.Add(IntToStr(i)+'='+kskm);
      cds_tmp.Next;
    end;
  finally
    cds_tmp.Free;
  end;
end;

procedure TDM.frxReport1GetValue(const VarName: string; var Value: Variant);
var
  sPath,photo_fn:String;
  sKsh,sUrl,sqlstr:string;
begin
  //if VarName='photo_fn' then
  if VarName='Picture1' then
  begin
    sPath := ExtractFilePath(ParamStr(0))+'kszp\';
    //Value := sPath;

    Photo_fn := '';
    if (cds_Master.FieldList.IndexOf('��Ƭ�ļ�')<>-1) then
    begin
      sKsh := Trim(cds_Master.FieldByName('������').AsString);
      Photo_fn := Trim(cds_Master.FieldByName('��Ƭ�ļ�').AsString);

      if Photo_fn='' then
      begin
        if FileExists(sPath+Photo_fn) then
          Photo_fn := sPath+Photo_fn
        else
          Exit;
      end;

      if photo_fn='' then Exit;

      photo_fn := sPath+photo_fn;

      if not FileExists(photo_fn) then
        dm.DownLoadKsPhotoByKSH(sKsh,photo_fn,nil,False);
      //{
      try
        if FileExists(photo_fn) then
        begin
          //TfrxPictureView(frxReport1.FindObject('Picture1')).URL := Photo_fn;
          TfrxPictureView(frxReport1.FindObject('Picture1')).Picture.LoadFromFile(Photo_fn);
        end else
        begin
          //TfrxPictureView(frxReport1.FindObject('Picture1')).URL := '';
          TfrxPictureView(frxReport1.FindObject('Picture1')).Picture := nil;
        end;
      except
      end;
      //}
    end;
  end;
end;

procedure TDM.frxReport1PrintPage(Page: TfrxReportPage; CopyNo: Integer);
var
  Ksh,sqlstr:string;
  iCount:Integer;
begin
  if Pos('¼ȡ֪ͨ��',frxReport1.FileName)>0 then
  begin
    ksh := fds_Master.DataSet.FieldByName('������').AsString;
    iCount := fds_Master.DataSet.FieldByName('��ӡ״̬').AsInteger;
    sqlstr := 'update lqmd set ��ӡ״̬='+IntToStr(iCount+1)+' where ������='+quotedstr(ksh);
    dm.ExecSql(sqlstr);
  end;
  fds_Master.Next;
end;

function GetAutoUpdateInfo: string;
var
  fn,url:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      url := ReadString('SrvSet','UpdateUrl','');
      if LowerCase(Copy(url,1,7))<>'http://' then
        url := 'http://'+url;
      Result := url;
    finally
      Free;
    end;
  end;
end;

procedure TDM.GetAllYxList(var sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select Ժϵ from Ժϵ��Ϣ�� where ��ѧ��λ<>0 order by Ժϵ';
  GetDeptListBySql(sqlstr,sList);
end;

function TDM.GetCjBL(const Km: string; const Cj_No: Integer): Integer;
var
  fn,cjstr:string;
begin
  cjstr := 'Cj'+IntToStr(Cj_No)+'_Pre';

  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      if Cj_No=1 then
        Result := ReadInteger(Km,cjstr,100)
      else
        Result := ReadInteger(Km,cjstr,0);
    finally
      Free;
    end;
  end;
end;

function TDM.GetClientAutoUpdateUrl: string;
begin
  Screen.Cursor := crHourGlass;
  try
    try
      //Result := vobj.GetClientAutoUpdateUrl;
    except
      //MessageBox(0, '����������ʧ�ܣ��������ӷ�������������Ϣ����',
      //  'ϵͳ��ʾ', MB_OK + MB_ICONWARNING + MB_TOPMOST);
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

function TDM.GetConnInfo:string;
//var
//  fn:string;
begin
  //fn := ExtractFilePath(ParamStr(0))+'data\xkpfdata.mdb';
  //Result := 'Provider=Microsoft.Jet.OLEDB.4.0;Data Source='+fn+';Persist Security Info=False';
  Result := 'Provider=SQLOLEDB.1;Password=xlinuxx;Persist Security Info=True;User ID=sa;Initial Catalog=�ֳ����ֿ�;Data Source=127.0.0.1,8829';
end;

function TDM.GetCzyDept(const Czy_ID: string): string;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := 'select Ժϵ from ����Ա�� where ����Ա���='+quotedstr(Czy_ID);
    DataSet_Temp.Active := True;
    Result := DataSet_Temp.Fields[0].AsString;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TDM.GetCzyLevel(const Czy_ID: string): string;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := 'select ����Ա�ȼ� from ����Ա�� where ����Ա���='+quotedstr(Czy_ID);
    DataSet_Temp.Active := True;
    Result := DataSet_Temp.Fields[0].AsString;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TDM.GetCzyName(const Czy_ID: string): string;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := 'select ����Ա���� from ����Ա�� where ����Ա���='+quotedstr(Czy_ID);
    DataSet_Temp.Active := True;
    Result := DataSet_Temp.Fields[0].AsString;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

procedure TDM.GetCzySfList(const sXlCc: string; out sList: TStrings;
  const IncludeAll: Boolean);
var
  cds_Temp:TClientDataSet;
  sqlstr:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  if gb_Czy_Level='-1' then
  begin
    GetSfList(sList,IncludeAll);
    Exit;
  end;
  try
    sqlstr := 'select ʡ�� from ����Աʡ�ݱ� where 1>0 '+ //where ѧ�����='+quotedstr(sXlCc)+
              ' and ����Ա='+quotedstr(gb_Czy_ID)+' order by ʡ��';
    cds_Temp.XMLData := OpenData(sqlstr);
    sList.Clear;
    if IncludeAll then
      sList.Add('ȫ��');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('ʡ��').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetDeltaRepSetInfo(const RepFileName: string; out sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string): Boolean;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
begin

  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select ����,�ӱ�,��������ֶ�,�ӱ�����ֶ� from ����ģ��� where �����ļ���='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    if cds_Temp.FieldByName('�ӱ�').AsString='' then Exit;
    sDeltaTableName := cds_Temp.FieldByName('�ӱ�').AsString;
    sMasterFieldName := cds_Temp.FieldByName('��������ֶ�').AsString;
    sDeltaFieldName := cds_Temp.FieldByName('�ӱ�����ֶ�').AsString;
    cds_Temp.Close;
    sMasterValue := cds_Master.FieldByName(sMasterFieldName).AsString;
    sqlstr := 'select * from '+sDeltaTableName+' where '+sDeltaFieldName+'='+quotedstr(sMasterValue);
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetDeltaTableSqlText(const RepFileName: string): string;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
  sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string;
begin
  Result := '';
  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select ����,�ӱ�,��������ֶ�,�ӱ�����ֶ� from ����ģ��� where �����ļ���='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    if cds_Temp.FieldByName('�ӱ�').AsString='' then Exit;
    sDeltaTableName := cds_Temp.FieldByName('�ӱ�').AsString;
    sMasterFieldName := cds_Temp.FieldByName('��������ֶ�').AsString;
    sDeltaFieldName := cds_Temp.FieldByName('�ӱ�����ֶ�').AsString;
    cds_Temp.Close;
    sMasterValue := cds_Master.FieldByName(sMasterFieldName).AsString;
    Result := 'select * from '+sDeltaTableName+' where '+sDeltaFieldName+'='+quotedstr(sMasterValue);
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetDeptList(var sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select Ժϵ from Ժϵ��Ϣ�� order by Ժϵ';
  GetDeptListBySql(sqlstr,sList);
end;

procedure TDM.GetDeptListBySql(const sqlstr:string;var sList: TStrings);
var
  i:Integer;
  cds_Temp:TClientDataSet;
begin
  sList.Clear;
  cds_Temp := TClientDataSet.Create(nil);
  cds_Temp.XMLData := OpenData(sqlstr);
  try
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetJjList(var JjList: TStrings): Boolean;
var
  sData:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sData := OpenData('select * from ���ڱ� order by ����');
    cds_Temp.XMLData := sData;
    JjList.Clear;
    while not cds_Temp.Eof do
    begin
      JjList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
    Result := True;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetKLList(out sList: TStrings;const IncludeAll:Boolean=False);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select ���� from רҵ�������� order by Id');
    sList.Clear;
    if IncludeAll then
      sList.Add('ȫ��');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('����').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetKpyName: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','KpyName',gb_Czy_Name);
    finally
      Free;
    end;
  end;
end;

function TDM.GetKshBySfzh(const sSfzh: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select ������ from У����������רҵ�� where ���֤��='+quotedstr(sSfzh);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := cds_Temp.Fields[0].AsString;
  finally
    FreeAndNil(cds_Temp);
  end;
end;

function TDM.GetKshByZkzh(const sZkzh: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select ������ from У����������רҵ�� where ׼��֤��='+quotedstr(sZkzh);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := cds_Temp.Fields[0].AsString;
  finally
    FreeAndNil(cds_Temp);
  end;
end;

procedure TDM.GetKsLbList(out sList: TStrings; const IncludeAll: Boolean);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select ��� from ����������� order by Id');
    sList.Clear;
    if IncludeAll then
      sList.Add('ȫ��');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('���').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetLbList(out sList: TStrings;const IncludeAll:Boolean=False);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select ��� from רҵ������� order by Id');
    sList.Clear;
    if IncludeAll then
      sList.Add('ȫ��');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('���').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetListFromTable(const sqlstr: string; out sList: TStrings);
var
  cds_Temp:TClientDataSet;
  I: Integer;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetMACInfo: string;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select MAC from ������Ϣ��';
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TDM.GetNextPrintBH(const Number: string): string;
var
  Num :Integer;
  PrintNumber :string;
begin
  PrintNumber := Number;
  if Number='' then
    PrintNumber := 'FA09860001';
  Num := StrToIntDef(RightStr(PrintNumber,6),0)+1;
  PrintNumber := Copy(PrintNumber,1,4)+Format('%.6d',[Num]);
  Result := PrintNumber;
end;

function TDM.GetPrintBH: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','StartPrintBH','');
    finally
      Free;
    end;
  end;
end;


function TDM.GetRecordCountBySql(const sqlstr: string): Integer;
begin
  Result := _GetRecordCount(sqlstr);
end;

procedure TDM.GetSfDirList(out sList: TStrings);
var
  cds_Temp:TClientDataSet;
  sqlstr :string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    //sqlstr := 'select ������,Ŀ¼�� from view_ʡ�ݱ� where Ŀ¼�� is not null order by ������';
    sqlstr := 'select distinct ʡ��,Ŀ¼�� from view_����Աʡ�ݱ� where ����Ա='+quotedstr(gb_Czy_Id)+' order by ʡ��';

    cds_Temp.XMLData := OpenData(sqlstr);
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString+'='+cds_Temp.Fields[1].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetSfList(out sList: TStrings;const IncludeAll:Boolean=False);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select ������ from view_ʡ�ݱ� order by ������');
    sList.Clear;
    if IncludeAll then
      sList.Add('ȫ��');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.FieldByName('������').AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.GetSfxmJe(const Id, sfxm: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select ��� from �ɷѼ�¼��ϸ�� where Pid='+quotedstr(Id)+' and �ɷ���Ŀ='+quotedstr(sfxm);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '0.00';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := FormatFloat('0.00',Abs(cds_Temp.Fields[0].AsFloat));
  finally
    FreeAndNil(cds_Temp);
  end;
end;

function TDM.GetSkyName: string;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      Result := ReadString('PrintSet','SkyName',gb_Czy_Name);
    finally
      Free;
    end;
  end;
end;

function TDM.GetSrvAutoUpdateUrl: string;
begin
  Result := GetSrvAutoUpdateUrl;
end;

function TDM.GetUserCode: string;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select ע���� from ������Ϣ��';
      DataSet_Temp.Active := True;
      Result := DataSet_Temp.Fields[0].AsString;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TDM.GetUserInfo: string;
var
  UserName:string;
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select �û����� from ������Ϣ��';
      DataSet_Temp.Active := True;
      UserName := DataSet_Temp.Fields[0].AsString;
      Result := UserName;
    except
      Result := '';
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TDM.GetWebSrvUrl: string;
begin
  //Result := vobj.GetWebSrvUrl;   //============С��ɵ�========
  if RightStr(Result,1)<>'/' then
    Result := Result+'/';
end;

procedure TDM.GetXlCcList(out sList: TStrings;const IncludeAll:Boolean=False);
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := OpenData('select ѧ����� from ѧ����δ����');
    sList.Clear;
    if IncludeAll then
      sList.Add('ȫ��');
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetXQList(var sList: TStrings);
var
  xq:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  sList := TStringList.Create;
  try
    cds_Temp.XMLData := dm.OpenData('select У�� from У����Ϣ��');
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      xq := cds_Temp.FieldByName('У��').AsString;
      sList.Add(xq);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;

end;

procedure TDM.GetZKYxList(var sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select Ժϵ from Ժϵ��Ϣ�� where ��ѧ��λ<>0 and ר�ƽ�ѧ<>0 order by Ժϵ';
  GetDeptListBySql(sqlstr,sList);
end;

function TDM.GetIdByKsh(const sKsh: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select Id from У����������רҵ�� where ������='+quotedstr(sKsh);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := cds_Temp.Fields[0].AsString;
  finally
    FreeAndNil(cds_Temp);
  end;
end;

function TDM.GetIdBySfzh(const sSfzh: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select Id from У����������רҵ�� where ���֤��='+quotedstr(sSfzh);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := cds_Temp.Fields[0].AsString;
  finally
    FreeAndNil(cds_Temp);
  end;
end;

function TDM.GetIdByZkzh(const sZkzh: string): string;
var
  cds_Temp:TClientDataSet;
  sSqlStr,sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    sSqlStr := 'select Id from У����������רҵ�� where ׼��֤��='+quotedstr(sZkzh);
    sData := OpenData(sSqlStr);
    if sData = '' then
    begin
       Result := '';
       Exit;
    end;
    cds_Temp.XMLData := sData;
    Result := cds_Temp.Fields[0].AsString;
  finally
    FreeAndNil(cds_Temp);
  end;
end;

procedure TDM.GetZyList(const XlCc,ZyLb,Sf: string; out sList: TStrings);
var
  sWhere:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    if XlCc<>'' then
      sWhere := ' where ѧ�����='+quotedstr(XlCc)
    else
      sWhere := ' where 1>0';
    if ZyLb<>'' then
      sWhere := sWhere+' and ���='+quotedstr(ZyLb);
    if Sf<>'' then
      sWhere := sWhere+' and ʡ��='+quotedstr(Sf);

    cds_Temp.XMLData := OpenData('select distinct רҵ from View_��ʡרҵ�ƻ��� '+sWhere+' order by רҵ');
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.GetZyWithIdList(const XlCc, ZyLb: string; out sList: TStrings);
var
  sWhere:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    if XlCc<>'' then
      sWhere := ' where ѧ�����='+quotedstr(XlCc)
    else
      sWhere := ' where 1>0';
    if ZyLb<>'' then
      sWhere := sWhere+' and ���='+quotedstr(ZyLb);

    cds_Temp.XMLData := OpenData('select Id,רҵ from רҵ��Ϣ�� '+sWhere);
    sList.Clear;
    while not cds_Temp.Eof do
    begin
      sList.Add(cds_Temp.Fields[0].AsString+'='+cds_Temp.Fields[1].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function TDM.HaveDeltaTable(const RepFileName: string): Boolean;
var
  sqlstr,sMasterValue:string;
  cds_Temp:TClientDataSet;
  sDeltaTableName,
  sMasterFieldName, sDeltaFieldName: string;
begin
  Result := False;
  cds_Temp := TClientDataSet.Create(nil);
  sqlstr := 'select ����,�ӱ�,��������ֶ�,�ӱ�����ֶ� from ����ģ��� where �����ļ���='+quotedstr(RepFileName);
  try
    cds_Temp.XMLData := OpenData(sqlstr);
    Result := (cds_Temp.FieldByName('�ӱ�').AsString<>'') and
              (cds_Temp.FieldByName('��������ֶ�').AsString<>'') and
              (cds_Temp.FieldByName('�ӱ�����ֶ�').AsString<>'');
  finally
    cds_Temp.Free;
  end;
end;

procedure TDM.HTTPRIO1BeforeExecute(const MethodName: string;
  var SOAPRequest: WideString);
begin
  GetTotal := 0;
  SendTotal := 0;
end;

procedure TDM.HTTPRIO1HTTPWebNode1PostingData(Sent, Total: Integer);
begin
  SendTotal := SendTotal+Sent;
  UpdateProgressMax(SendTotal);//SendTotal);
  UpdateProgress(Total);//+Sent);
  UpdateProgressTitle('���ڸ�������... '+FormatFloat('[�Ѹ��£�0.00KB]',SendTotal/1024/32));
end;

procedure TDM.HTTPRIO1HTTPWebNode1ReceivingData(Read, Total: Integer);
begin
  GetTotal := GetTotal+Read;
  UpdateProgressMax(GetTotal);//GetTotal);
  UpdateProgress(Total);//+Read);
  UpdateProgressTitle('������������... '+FormatFloat('[�����أ�0.00KB]',GetTotal/1024/32));
end;


procedure TDM.InitSunVote;
var
  State:string;
begin
  BaseConnection1.Open(1,'1'); //1:USB MODE,1-5:��վ��
  //baseConnection.ProtocolType := 2; // EVS 2
  BaseManage1.BaseConnection := BaseConnection1.DefaultInterface;
  KeypadManage1.BaseConnection := BaseConnection1.DefaultInterface;
  Message1.BaseConnection := BaseConnection1.DefaultInterface;

end;

function TDM.IsDisplayJiangXi: Boolean;
var
  sqlstr:string;
begin
  if (StrToIntDef(gb_Czy_Level,3)<>0) then
    Result := True
  else
  begin
    sqlstr := 'select count(*) from ����Աʡ�ݱ� where ����Ա='+quotedstr(gb_Czy_ID)+' and ʡ��='+quotedstr('����');
    Result :=  GetRecordCountBySql(sqlstr)>0;
  end;
end;

function TDM.IsLogined(const Czy_ID: string): Boolean;
begin

end;

function TDM.OpenData(const sSqlStr: string; const ShowHint: Boolean): string;
begin
  Result := Query_Data(sSqlStr,ShowHint);
end;

procedure TDM.GetBKYxList(var sList: TStrings);
var
  sqlstr:string;
begin
  sqlstr := 'select Ժϵ from Ժϵ��Ϣ�� where ��ѧ��λ<>0 and ���ƽ�ѧ<>0 order by Ժϵ';
  GetDeptListBySql(sqlstr,sList);
end;

procedure InitXnList(sList: TDBComboBoxEh);
var
  i,curYear:Integer;
begin
  curYear := YearOf(Now);
  sList.Items.Clear;
  sList.KeyItems.Clear;
  for i:=curYear-5 to curYear+1 do
  begin
    sList.Items.Add(Format('%4d����',[i]));
    sList.KeyItems.Add(Format('%4d����',[i]));
    sList.Items.Add(Format('%4d�＾',[i]));
    sList.KeyItems.Add(Format('%4d�＾',[i]));
    //sList.Items.Add(Format('%4d~%4dѧ��',[i,i+1]));
    //sList.KeyItems.Add(Format('%4d~%4d',[i,i+1]));
  end;
end;


function TDM.SaveAsUrlImage(const sUrl,sFileName: string): Boolean;
var
  ImageStream:TMemoryStream;
  Jpg:TJpegImage;
  //Image1:TImage;
begin
  ImageStream := TMemoryStream.Create();
  Jpg := TJpegImage.Create;
  //Image1 := TImage.Create(nil);
  try
    try
      idhttp1.Get(sUrl,ImageStream);
    except
      Result := False;
      Exit;
    end;
    if ImageStream.Size=0 then Exit;
    ImageStream.Position := 0;
    Jpg.LoadFromStream(ImageStream);
    Jpg.SaveToFile(sFileName);
    //Image1.Picture.Assign(Jpg);
    //Image1.Picture.SaveToFile(sFileName);
    Result := True;
  finally
    ImageStream.Free;
    Jpg.Free;
    //Image1.Free;
  end;
end;

function TDM.SaveCjData(const CjIndex: Integer;
  const vDelta: OleVariant): Boolean;
var
  sqlstr,cjField,czyField,sError:string;
  ksh,cjValue,czy:string;
  cds_Temp:TClientDataSet;
  sData:string;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cjField := '�ɼ�'+IntToStr(CjIndex);
    czyField := '����Ա'+IntToStr(CjIndex);

    cds_Temp.Data := vDelta;
    sData := cds_Temp.XMLData;
    cds_Temp.First;
    while not cds_Temp.Eof do
    begin
      ksh := cds_Temp.FieldByName('������').AsString;
      cjValue := cds_Temp.FieldByName(cjField).AsString;
      czy := quotedstr(cds_Temp.FieldByName(czyField).AsString);
      sqlstr := 'update У�����Ƴɼ��� set '+cjfield+'='+cjValue+','+czyField+'='+czy+' where ������='+quotedstr(ksh);
      if not ExecSqlCmd(sqlstr,sError) then
      begin
        Result := False;
        break;
      end;
      cds_Temp.Next;
    end;
    //if not ShowMsgBox then Exit;

    if sError<>'' then
    begin
    sError := '���ݱ���ʧ�ܣ���������±��棡���ܵ�ԭ��Ϊ������'+#13+sError;
        MessageBox(0, PChar(string(sError)), 'ϵͳ��ʾ', MB_OK
        + MB_ICONSTOP + MB_TOPMOST);
    end else
      MessageBox(0, '�����ύ�����棩�ɹ�������', 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION+ MB_TOPMOST);
  finally
    //vobj := nil;
    cds_Temp.Free;
  end;
end;

procedure TDM.SaveDialog1TypeChange(Sender: TObject);
var
  fn,mfn,Ext:string;
begin
  fn := SaveDialog1.FileName;
  Ext := ExtractFileExt(fn);
  mfn := StringReplace(fn,Ext,'',[rfReplaceAll,rfIgnoreCase]);
  case SaveDialog1.FilterIndex of
    1: begin Ext := '.txt'; end;
    2: begin Ext := '.csv'; end;
    3: begin Ext := '.htm'; end;
    4: begin Ext := '.rtf'; end;
    5: begin Ext := '.xls'; end;
  else
    Ext := '';
  end;
  SaveDialog1.FileName := mfn+Ext;
  SaveDialog1.DefaultExt := Ext;
end;

function TDM.SelectZy(const XlCc,ZyLb:string;var sList:TStrings): Boolean;
begin
end;

function TDM.SetCjBL(const Km: string; const Cj_No,Cj_BL: Integer): Boolean;
var
  fn,cjstr:string;
begin
  cjstr := 'Cj'+IntToStr(Cj_No)+'_Pre';

  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteInteger(Km,cjstr,Cj_BL);
      Result := True;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetConnInfo(const sUrl:string);
begin
end;

procedure TDM.SetCzySfComboBox(const sXlCc: string; aDbComboBox: TDBComboBoxEh;
  const IncludeAll: Boolean);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetCzySfList(sXlCc,sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TDM.SetKlComboBox(aDbComboBox:TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetKlList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

function TDM.SetKpyName(const sName: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','KpyName',sName);
      Result := True;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetKsLbComboBox(aDbComboBox: TDBComboBoxEh;
  const IncludeAll: Boolean);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetKsLbList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TDM.SetLanguage;
Var
  language: TLanguage;
Begin
  language := TLanguage.Create;
  //language.SetActiveLanguage(frmMain);
  //frmMain.Caption := language.getMsgByName('CaptionMain');

  MsgBaseKeyScopeError := language.getMsgByName('MsgBaseKeyScopeError');
  MsgSignCodeError := language.getMsgByName('MsgSignCodeError');
  MsgSignModeError := language.getMsgByName('MsgSignModeError');
  MsgBaseSoftDogError := language.getMsgByName('MsgBaseSoftDogError');
  MsgKeyIDError := language.getMsgByName('MsgKeyIDError');
  MsgBaseDemoOpen := language.getMsgByName('MsgBaseDemoOpen');
  MsgBaseDemoClose := language.getMsgByName('MsgBaseDemoClose');

  MsgItemInfo := language.getMsgByName('MsgItemInfo');
  MsgRandomItem := language.getMsgByName('MsgRandomItem');
  MsgMultipleAssess := language.getMsgByName('MsgMultipleAssess');
  MsgScoreRule := language.getMsgByName('MsgScoreRule');
  MsgEvaluationRule := language.getMsgByName('MsgEvaluationRule');
  MsgSelfExercise := language.getMsgByName('MsgSelfExercise');

  MsgFileDownload := language.getMsgByName('MsgFileDownload');
  MsgAvoidItemsDownload:= language.getMsgByName('MsgAvoidItemsDownload');

  //RefreshcbbSelectFile( GetSDKAppType(pgcAppDemo.ActivePageIndex));

  language.Free;
end;

procedure TDM.SetLbComboBox(aDbComboBox: TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetLbList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

function TDM.SetPrintBH(const Number: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','StartPrintBH',Number);
      Result := True;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetSfComboBox(aDbComboBox: TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetSfList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

function TDM.SetSkyName(const sName: string): Boolean;
var
  fn:string;
begin
  fn := ExtractFilePath(ParamStr(0))+gb_UserSetFileName;
  with TIniFile.Create(fn) do
  begin
    try
      WriteString('PrintSet','SkyName',sName);
      Result := True;
    finally
      Free;
    end;
  end;
end;

procedure TDM.SetXkYxComboBox(aDbComboBox: TDBComboBoxEh);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    aDbComboBox.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      aDbComboBox.Items.Add('�������ѧԺ');
      aDbComboBox.Items.Add('����ѧԺ');
    end else
      aDbComboBox.Items.Add(gb_Czy_Dept);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;

end;

procedure TDM.SetXlCcComboBox(aDbComboBox: TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetXlCcList(sList,IncludeAll);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TDM.GetYxList(var aComboBox: TDBComboBoxEh;const IncludeAll:Boolean=False);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    aComboBox.Items.Clear;
    if gb_Czy_Level<>'2' then
    begin
      if IncludeAll then
         sList.Add('����Ժϵ');
      sList.Add('�������ѧԺ');
      sList.Add('����ѧԺ');
    end else
      sList.Add(gb_Czy_Dept);
    aComboBox.Items.AddStrings(sList);
    aComboBox.ItemIndex := 1;
  finally
    sList.Free;
  end;
end;

procedure TDM.SetZyComboBox(const XlCc,ZyLb,Sf: string; aDbComboBox: TDBComboBoxEh);
var
  sList:TStrings;
begin
  sList := TStringList.Create;
  try
    GetZyList(XlCc,ZyLb,Sf,sList);
    aDbComboBox.Items.Clear;
    aDbComboBox.Items.AddStrings(sList);
    if aDbComboBox.Items.Count>0 then
      aDbComboBox.ItemIndex := 0;
  finally
    sList.Free;
  end;
end;

procedure TDM.SetZyComboBoxByZy(const XlCc, Zy: string;
  aDbComboBox: TDBComboBoxEh);
begin

end;

function TDM.SrvIsOpen: Boolean;
var
  sqlstr:string;
begin
  //sqlstr := 'select count(*) from ������״̬���ñ� where �Ƿ�����<>0';
  //Result := GetRecordCountBySql(sqlstr)>0;
  Result := True;
end;

function TDM.UpdateData2(const sKey, sSqlStr, sDelta: string): Boolean;
begin
  Result := Update_Data(sKey,sSqlStr,sDelta);
end;

function TDM.UpdatePrintBH(const ID:string): Boolean;
var
  sError,sSqlStr,PrintNumber:string;
  Num:Integer;
begin
  PrintNumber := GetPrintBH;
  if PrintNumber='' then
    PrintNumber := 'δ֪';
  sSqlStr := 'update �ɷѼ�¼�� set ��ӡ����='+quotedstr(PrintNumber)+' where Id='+quotedstr(Id);
  Result := ExecSqlCmd(sSqlStr,sError);
  if Result then
  begin
    SetPrintBH(GetNextPrintBH(PrintNumber));
  end else
    SaveLog('Error:'+Id);
end;

procedure TDM.UpdateReportFile(const IsOver:Boolean);
var
  sSqlStr,sPath:string;
  cds_Temp:TClientDataSet;
  Id:Integer;
  ReportName:String;
begin
  sPath := ExtractFilePath(ParamStr(0))+'Rep\';
  if not DirectoryExists(sPath) then
    ForceDirectories(sPath);

  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  sSqlStr := 'select Id,�����ļ��� from ����ģ���';
  try
    try
      cds_Temp.XMLData := OpenData(sSqlStr);
      if cds_Temp.XMLData='' then Exit;
      if cds_Temp.RecordCount=0 then Exit;

      ShowProgress('�������ر���ģ��',cds_Temp.RecordCount);
      while not cds_Temp.Eof do
      begin
        Id := cds_Temp.FieldByName('Id').AsInteger;
        ReportName := cds_Temp.FieldByName('�����ļ���').AsString;
        if ReportName='' then ReportName := 'δ��������.fr3';
        ReportName := sPath+ReportName;
        UpdateProgress(cds_Temp.RecNo);
        if (not IsOver) and FileExists(ReportName) then
        begin
          Sleep(500);
          cds_Temp.Next
        end else
        begin
          DownLoadReportFile(Id,ReportName);
          cds_Temp.Next;
        end;
      end;
    except
    end;
  finally
    HideProgress;
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;

end;

function TDM.Update_Data(const sKey, sSqlStr: string; const vDelta: OleVariant;
  const ShowMsgBox, ShowHint: Boolean): Boolean;
var
  iErrorCount,i:Integer;
  sData,sError:string;
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);

  Result := False;
  try
    cds_Temp.Data := vDelta;
    sData := cds_Temp.XMLData;

    qry_Update.Close;
    qry_Update.SQL.Text := sSqlStr;

    cds_Update.XMLData := sData;

    for i := 0 to cds_Update.FieldCount - 1 do
    begin
      //if UpperCase(dm.cds_Update.Fields[i].FieldName) = UpperCase(pkField) then
      //  dm.cds_Update.Fields[i].ProviderFlags := dm.cds_Update.Fields[i].ProviderFlags + [ pfInKey,pfInWhere ]
      //else
      //  dm.cds_Update.Fields[i].ProviderFlags := dm.cds_Update.Fields[i].ProviderFlags-[pfInWhere,pfInKey];

      if cds_Update.Fields[i].DataType in [ ftDate, ftTime, ftDateTime ] then
          cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags - [ pfInWhere ]
      else if cds_Update.Fields[i].DataType = ftAutoInc then
          cds_Update.Fields[i].ProviderFlags := cds_Update.Fields[i].ProviderFlags - [ pfInUpdate ];
    end;


    qry_Update.Open;
    with qry_Update.FieldByName(sKey) do //����������AdoDataSet�����ã�������ClientDataSet������
      ProviderFlags := ProviderFlags + [ pfInKey,pfInWhere ];

    try
      iErrorCount := cds_Update.ApplyUpdates(0);
      Result := iErrorCount=0;
    except
      on e:Exception do
      begin
        sError := e.Message;
        Result := False;
      end;
    end;
  finally
    cds_Temp.Free;
    cds_Update.Close;
    if (not Result) and (sError<>'') then
    begin
      sError := '���ݸ���/����ʧ�ܣ���������ԣ����ܵ�ԭ��Ϊ������'+#13+sError;
      MessageBox(0, PChar(string(sError)), 'ϵͳ��ʾ', MB_OK + MB_ICONSTOP + MB_TOPMOST);
    end else if Result and ShowMsgBox then
      MessageBox(0, pchar('�����ύ�����棩�ɹ�������'), 'ϵͳ��ʾ', MB_OK + MB_ICONINFORMATION+ MB_TOPMOST);
    if ShowHint then
      HideProgress;
  end;
end;

function TDM.UpLoadKsPhoto(const BmNo, sFileName: string): Boolean;
begin
  if not FileExists(sFileName) then Exit;
  Result := UploadUrlImage(BmNo,sFileName);
end;

function TDM.UpLoadReportFile(const Id: Integer;var ReportFileName: string;
                              var LastModifideTime:TDateTime;
                              const ShowSelectFolder:Boolean): Boolean;
var
  bl:Boolean;
  sSqlStr,sData,sfn,sHint:string;
  cds_Temp:TClientDataSet;
  sLastTime,sLastTime2:TDateTime;
begin
  Result := False;
  sfn := ReportFileName;
  Screen.Cursor := crHourGlass;
  cds_Temp := TClientDataSet.Create(nil);
  try
    if (not ShowSelectFolder) and (sfn<>'') and (not FileExists(sfn)) then Exit;

    sSqlStr := 'select Id,�����ļ���,��������,����޸����� from ����ģ��� where Id='+IntToStr(Id);
    sData := DM.OpenData(sSqlStr);
    if sData='' then
      Exit
    else
      cds_Temp.XMLData := sData;

    if (sfn='') then  sfn := cds_Temp.FieldByName('�����ļ���').AsString;

    dlgOpen1.FileName := sfn;
    if (ReportFileName='') or ShowSelectFolder then
    begin
      if dlgOpen1.Execute then
      begin
        sfn := dlgOpen1.FileName;
      end else
        Exit;
    end;

    if not FileExists(sfn) then Exit;

    sLastTime := GetFileLastAccessTime(sfn,3);
    sLastTime2 := cds_Temp.FieldByName('����޸�����').AsDateTime;
    if (ReportFileName='') and (not cds_Temp.FieldByName('��������').IsNull) then
    begin
       if (sLastTime2>sLastTime) then
          sHint := '���ݿ��еı����ļ���Ҫ�ϴ������ݻ�Ҫ�£�'+#13+
                   '���Ҫ�����ڱ����ļ��滻ԭ���ı���ģ���𣿡���'
       else
          sHint := '���Ҫ�����ڱ����ļ��滻ԭ���ı���ģ���𣿡���';

       if Application.MessageBox(PChar(sHint), 'ϵͳ��ʾ',
          MB_YESNO + MB_ICONWARNING + MB_TOPMOST)=IDYES then
        bl := True
      else
        bl := False;
    end else
      bl := True;

    if bl then
    begin
      cds_Temp.Edit;
      cds_Temp.FieldByName('�����ļ���').AsString := ExtractFileName(sfn);
      TBlobField(cds_Temp.FieldByName('��������')).LoadFromFile(sfn);
      cds_Temp.FieldByName('����޸�����').AsDateTime := sLastTime;
      cds_Temp.Post;
      Result := dm.UpdateData('Id',sSqlStr,cds_Temp.Delta,ReportFileName='');
      LastModifideTime := sLastTime;
      ReportFileName := ExtractFileName(sfn);
    end;
  finally
    cds_Temp.Free;
    Screen.Cursor := crDefault;
  end;
end;

function TDM.UploadUrlImage(const BmNo, sFileName: string): Boolean;
var
  obj : TIdMultiPartFormDataStream;
  sResult,Url: String;
begin
  if not FileExists(sFileName) then Exit;

  obj := TIdMultiPartFormDataStream.Create;
  try
    obj.AddFormField('BmNo',BmNo);
    obj.AddFile('aFileName',sFileName, GetMIMETypeFromFile(sFileName));
    IdHTTP1.Request.ContentType := obj.RequestContentType;
    obj.Position := 0;
    //Url := GetConnInfo+'Upfile_Photo.asp';  //���ҳ�渺������ļ�
    //Url := vobj.GetUploadProcessFile;   //���ҳ�渺������ļ� =======С��ɵ�========
    try
      sResult := IdHTTP1.Post(Url, obj);    //�᷵��һ�������ύ��Ľ������
      Result := True;
    except
      on E: Exception do
      begin
        Application.MessageBox(PChar('�ϴ��ļ�ʧ�ܣ�����ԭ��' + E.Message), ('����'), MB_OK + MB_ICONERROR);
        Result := False;
      end;
    end;
  finally
    obj.Free;
  end;
end;

function TDM.UpdateData(const sKey, sSqlStr: string;const vDelta: OleVariant;
          const ShowMsgBox:Boolean=True;const ShowHint:Boolean=False): Boolean;
begin
  try
    if ShowHint then
    begin
      ShowProgress('���ڸ�������...');
    end;

    Result := Update_Data(sKey,GetOneSqlStr(sSqlStr),vDelta,ShowMsgBox,ShowHint) ;

  finally
    //vobj := nil;
    if ShowHint then
      HideProgress;
  end;
end;

function AppSrvIsOK:Boolean;
begin
  try
    Result := dm.RegIsOK;
  except
    Result := False;
  end;
end;

{ TMessageHandler }

//class procedure TMessageHandler.AppMessage(var Msg: TMsg; var Handled: Boolean);
//begin
{  if Msg.message=WM_KEYDOWN then
    if (Msg.wParam=VK_RETURN ) and
      (
        (Screen.ActiveForm.ActiveControl is TEdit) or
        (Screen.ActiveForm.ActiveControl is TComboBox) or
        (Screen.ActiveForm.ActiveControl is TCheckBox) or
        (Screen.ActiveForm.ActiveControl is TRadioButton) or
        (Screen.ActiveForm.ActiveControl is TLabeledEdit) or
        (Screen.ActiveForm.ActiveControl is TDBEditEh) or
        (Screen.ActiveForm.ActiveControl is TDBComboBoxEh) or
        (Screen.ActiveForm.ActiveControl is TDBCheckBoxEh) or
        (Screen.ActiveForm.ActiveControl is TDBNumberEditEh) or
        (Screen.ActiveForm.ActiveControl is TDBDateTimeEditEh)
              //���������Ҫ�Ŀؼ�
      )
    then
    begin
      Msg.wParam:=VK_TAB;
    end
}{    else if (Msg.wParam=VK_RETURN) and
      (
       (Screen.ActiveForm.ActiveControl is TDBGrid)
      )
    then
    begin
      with Screen.ActiveForm.ActiveControl do
      begin
        //if Selectedindex<(FieldCount-1) then
        //  Selectedindex:=Selectedindex+1  // �ƶ�����һ�ֶ�
        //else
        //  Selectedindex:=0;
      end;
    end;
}
//end;

function  LowerJeToUpper(const je:Real):string; //Сд���ת��Ϊ��д���
begin
  Result := NumToUpper(je);
end;

function TDM.PostCj(const CjIndex: Integer; const Yx, Sf, Km: string;
  const bPost: Boolean): Boolean;
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
  Result := ExecSqlCmd(sqlstr,sError);
end;

function TDM.PrintReport(const ReportFileName:string;const cds_Master_XMLData:String;
                         const OperateType:Integer;const ShowDialog:Boolean):Boolean; //OperateType: 0:Print 1:Privew 2:Design
begin
  Result := _PrintReport('',ReportFileName,cds_Master_XMLData,OperateType,ShowDialog);
end;

function TDM.PrintSFD(const sId: string; const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  sData,fn:string;
begin
  sData := dm.OpenData('select * from �ɷѼ�¼�� where id='+quotedstr(sId));
  fn := '�ɷѵ�.fr3';
  Result := PrintReport(fn,sData,OperateType,ShowDialog);
end;

function TDM.PrintSFD(const sIdList: Tstrings; const OperateType: Integer;const ShowDialog:Boolean): Boolean;
var
  sWhere,sData,fn:string;
  i: Integer;
begin
  for i := 0 to sIdList.Count - 1 do
  begin
    sWhere := sWhere+quotedstr(sIdList[i])+',';
  end;
  if sWhere='' then Exit;

  if sWhere[Length(sWhere)]=',' then
    sWhere := Copy(sWhere,1,Length(sWhere)-1);

  sWhere := 'select * from �ɷѼ�¼�� where id in ('+sWhere+')';
  sData := dm.OpenData(sWhere);
  fn := '�ɷѵ�.fr3';
  Result := PrintReport(fn,sData,OperateType,ShowDialog);
end;

function TDM.PrintSFD2(const sId: string; const Page: Integer): Boolean;
var
  fn,sData:string;
begin
  sData := dm.OpenData('select * from �ɷѼ�¼�� where id='+quotedstr(sId));
  fn := '�ɷѵ�.fr3';
  Result := _PrintReport2('',fn,sData,Page);
end;

function TDM.Query_Data(const sSqlStr: string; const ShowHint: Boolean): string;
var
  sTempData,sData:string;
begin
  Screen.Cursor := crHourGlass;
  if ShowHint then
  begin
    ShowProgress('���ڶ�ȡ����...');
  end;

  try
    cds_Open.Close;
    cds_Open.CommandText := sSqlStr ;
    try
      cds_Open.Open;
      sData := cds_Open.XMLData;
      Result := sData;
    except
      Result := '';
    end;
  finally
    cds_Open.Close;
    if ShowHint then
      HideProgress;
    Screen.Cursor := crDefault;
  end;
end;

function TDM.RecordIsExists(const sSqlStr: string): Boolean;
var
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    DataSet_Temp.Close;
    DataSet_Temp.CommandText := sSqlStr;
    try
      DataSet_Temp.Open;
      Result := DataSet_Temp.Fields[0].AsInteger>0;
    except
      Result := False;
    end;
  finally
    DataSet_Temp.Close;
    DataSet_Temp.Free;
  end;
end;

function TDM.RegIsOK: Boolean;
var
  UserName,RegCode,sMac:string;
  sqlText:String;
  DataSet_Temp:TADODataSet;
begin
  DataSet_Temp := TADODataSet.Create(nil);
  DataSet_Temp.Connection := con_DB;
  try
    try
      DataSet_Temp.Active := False;
      DataSet_Temp.CommandText := 'select �û�����,MAC,ע���� from ������Ϣ��';
      DataSet_Temp.Active := True;
      UserName := DataSet_Temp.Fields[0].AsString;
      sMac := DataSet_Temp.Fields[1].AsString;
      RegCode := DataSet_Temp.Fields[2].AsString;
      if sMac<>GetMACAddress then
      begin
        sMac := GetMACAddress;
        sqlText := 'update ������Ϣ�� set MAC='+quotedstr(sMac);
        con_DB.Execute(SqlText);
      end;
      if RegCode<>'' then
        RegCode := DeCrypt(RegCode); //��ע������н����Ի�ԭ�û�����
      //RegCode := EnCrypt(UserName);
      //Result := (RegCode = DataSet_Temp.Fields[1].AsString) and (DataSet_Temp.Fields[1].AsString<>'');
      Result := (RegCode = UserName) and (RegCode<>'');
    except
      Result := False;
    end;
  finally
    DataSet_Temp.Active := False;
    DataSet_Temp.Free;
  end;
end;

function TDM.RegUserInfo(const UserName, UserCode: string): Boolean;
var
  qry_Temp:TADOQuery;
  sMac,sqlstr:string;
begin
  qry_Temp := TADOQuery.Create(nil);
  qry_Temp.Connection := con_DB;
  try
  sMac := GetMacAddress;
  with qry_Temp do
  begin
    Active := False;
    sql.Text := 'select �û�����,MAC,ע���� from ������Ϣ��';
    Active := True;
    if RecordCount=0 then
      sqlstr := 'Insert into ������Ϣ�� (�û�����,ע����,MAC) values('+quotedstr(UserName)+','+quotedstr(UserCode)+','+quotedstr(sMac)
    else
      sqlstr := 'update ������Ϣ�� set �û�����='+quotedstr(UserName)+',ע����='+quotedstr(UserCode)+',MAC='+quotedstr(sMac);

    try
      close;
      sql.Text := sqlstr;
      ExecSql;
      Result := True;//RegIsOK;
    except
      Result := False;
    end;
  end;
  finally
    qry_Temp.Free;
  end;
end;

function TDM.ReleaseLog(const Czy_ID: string): Boolean;
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
  Result := ExecSqlCmd(sqlstr,sError);
  if Result then
    sError := 'ɾ��������־��OK��'
  else
    sError := 'ɾ��������־ʧ�ܣ�'+sError;
  if Length(sError)>50 then
    sError := Copy(sError,1,50);
  WriteLog(Czy_ID,sError);
end;

function TDM.ReleaseLoginLog(const Czy_ID: string): Boolean;
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
  Result := ExecSqlCmd(sqlstr,sError);
  if Result then
    sError := 'ɾ����¼��־��OK��'
  else
    sError := 'ɾ����¼��־ʧ�ܣ�'+sError;
  if Length(sError)>50 then
    sError := Copy(sError,1,50);
  WriteLog(Czy_ID,sError);
end;

procedure SaveLog(const sMsg:string);
var
  sfn:string;
  sList:TStrings;
begin
  sfn := ExtractFilePath(ParamStr(0))+'NetPayLog.Txt';
  sList := TStringList.Create;
  try
    if FileExists(sfn) then
    begin
      sList.LoadFromFile(sfn);
      if sList.Count>1000 then
        sList.Clear;
    end;
    sList.Add(FormatDateTime('YYYY-MM-DD HH:NN:SS',Now)+' '+sMsg);
    sList.SaveToFile(sfn);
  finally
    sList.Free;
  end;
end;

function  GetNextSjBH(const CurBH:string;const SjBHWidth:Integer):string;
var
  ii:Integer;
begin
  ii := StrToIntDef(RightStr(CurBH,2),0)+1;
  Result := LeftStr(CurBH,SjBHWidth-2)+FormatFloat('00',ii);
end;

procedure RealseSortedIcon(const aDBGrid:TDBGridEh);
var
  i:Integer;
begin
  for i:=0 to aDBGrid.Columns.Count-1 do
  begin
    aDBGrid.Columns[i].Title.SortMarker := smNoneEh;
  end;
end;

procedure SetDBGridEHColumnWidth(const aDBGrid:TDBGridEh);
var
  i:Integer;
begin
  if not aDBGrid.DataSource.DataSet.Active then Exit;

  for i := 0 to aDBGrid.Columns.Count-1 do
  begin
    aDBGrid.Columns[i].Title.TitleButton := True;
    if aDBGrid.Columns[i].Width>150 then
      aDBGrid.Columns[i].Width := 150
    else
    begin
      aDBGrid.Columns[i].Width := 70;
      aDBGrid.Columns[i].Alignment := taCenter;
      aDBGrid.Columns[i].Title.Alignment := taCenter;
    end;

    if (Pos('���',aDBGrid.Columns[i].FieldName)>0) or
       (Pos('����',aDBGrid.Columns[i].FieldName)>0) or
       (Pos('ʡ��',aDBGrid.Columns[i].FieldName)>0) then
    begin
      aDBGrid.Columns[i].Width := 60;
    end else if Pos('��',aDBGrid.Columns[i].FieldName)>0 then  //�����ʡ���ѧ�ʵ�
    begin
      aDBGrid.Columns[i].Width := 100;
      aDBGrid.Columns[i].DisplayFormat := ',0.00%';
{
      aDBGrid.Columns[i].Footer.FieldName := aDBGrid.Columns[i].FieldName;
      aDBGrid.Columns[i].Footer.ValueType := fvtAvg;
      aDBGrid.Columns[i].Footer.DisplayFormat := 'ƽ����,0.00%';
}
    end else if Pos('��',aDBGrid.Columns[i].FieldName)>0 then
    begin
      aDBGrid.Columns[i].Width := 70;
      aDBGrid.Columns[i].DisplayFormat := ',0';
      aDBGrid.Columns[i].Footer.ValueType := fvtSum;
      aDBGrid.Columns[i].Footer.FieldName := aDBGrid.Columns[i].FieldName;
    end else if RightStr(aDBGrid.Columns[i].FieldName,2)='��' then
    begin
      aDBGrid.Columns[i].Width := 70;
      aDBGrid.Columns[i].DisplayFormat := '0.00';
      aDBGrid.Columns[i].Footer.ValueType := fvtAvg;
      aDBGrid.Columns[i].Footer.FieldName := aDBGrid.Columns[i].FieldName;
    end;
  end;
end;

function  PhotoIsExists(const photofilename:string):Boolean; //������Ƭ�Ƿ����
var
  sPath:string;
begin
  if photofilename='' then
    Result := False
  else
  begin
    sPath := ExtractFilePath(ParamStr(0))+'Kszp\';
    Result := FileExists(sPath+photofilename);
  end;
end;

function  ZyIsEqual(const zy1,zy2:string;const bSame:Boolean=False):Boolean;
var
  sTemp,_Zy2:string;
  iLen:Integer;
begin
  if (Pos('Ԥ��',zy1)>0) and (Pos('Ԥ��',zy2)>0) then
  begin
    Result := True;
    Exit;
  end;

  sTemp := Trim(Zy1);
  if Pos('(',sTemp)=1 then
  begin
    iLen := Pos(')',sTemp);
    sTemp := Copy(sTemp,iLen+1,Length(sTemp))+Copy(sTemp,1,iLen-1)
  end;
  sTemp := ReplaceStr(sTemp,'����У|','');
  sTemp := ReplaceStr(sTemp,'��','');
  sTemp := ReplaceStr(sTemp,'��','');
  sTemp := ReplaceStr(sTemp,'��','');
  sTemp := ReplaceStr(sTemp,'(','��');
  sTemp := ReplaceStr(sTemp,')','��');
  sTemp := ReplaceStr(sTemp,' ','');
  sTemp := ReplaceStr(sTemp,'ʦ����','ʦ��');
  sTemp := ReplaceStr(sTemp,'����','');
  iLen := Length(sTemp);

  _Zy2 := Trim(zy2);

  if bSame then //��ȷ�Ƚ�
  begin
    Result := (sTemp=_Zy2);
    Exit;
  end;

  if Length(_Zy2)<iLen then
    iLen := Length(_Zy2);

  if Length(sTemp)<>Length(_Zy2) then //רҵ������ȣ���ȫ���Ƚϣ�����Ƚ�ǰ3������
    if iLen>6 then iLen := 6;
  Result := (Copy(sTemp,1,iLen)=Copy(_Zy2,1,iLen));

end;

function GetKsDataPath:string;
var
  sPath: string;
begin
  //if SysUtils.Win32MajorVersion>=4 then //Windows 2003 �Ժ�İ汾
    sPath := GetSpecialFolderDir(CSIDL_PERSONAL);//�ҵ��ĵ�Ŀ¼
  //else
  //  sPath := GetSpecialFolderDir(CSIDL_MYDOCUMENTS);

  sPath := sPath+'\.NacuesCStorage2012\';
  Result := sPath;
end;


function GetKsDataPath_Old:string;
var
  sPath: string;
begin
  sPath := GetSpecialFolderDir(CSIDL_PERSONAL);//�ҵ��ĵ�Ŀ¼
  if SysUtils.Win32MajorVersion>=6 then //Windows 2003 �Ժ�İ汾
    sPath := sPath+'\.NacuesCStorage\'
  else
    sPath := 'C:\Program Files\NacuesC\';

  Result := sPath;
end;

procedure InitSfDmList;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select ������,left(����,2) from View_ʡ�ݱ�');
    while not cds_Temp.Eof do
    begin
      gb_SfDirList.Add(cds_Temp.Fields[0].AsString+'='+cds_Temp.Fields[1].AsString);
      cds_Temp.Next;
    end;
  finally
    cds_Temp.Free;
  end;
end;

function  GetSfMcBySfDm(const sfDm:string):String;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select ������ from View_ʡ�ݱ� where left(����,2)='+quotedstr(sfDm));
    Result := cds_Temp.Fields[0].AsString;
  finally
    cds_Temp.Free;
  end;
end;

function  GetSfDmBySfMc(const sfDm:string):String;
var
  cds_Temp:TClientDataSet;
begin
  cds_Temp := TClientDataSet.Create(nil);
  try
    cds_Temp.XMLData := dm.OpenData('select left(����,2) from View_ʡ�ݱ� where ������='+quotedstr(sfDm));
    Result := cds_Temp.Fields[0].AsString;
  finally
    cds_Temp.Free;
  end;
end;

initialization
  gb_SfDirList := TStringList.Create;

finalization
  gb_SfDirList.Free;

end.

