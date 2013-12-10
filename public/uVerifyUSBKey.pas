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
  keyName:array [0..16] of Char;//����������
  pwd1,pwd2,pwd3,pwd4:Integer;//4���û�����
  request:Integer;//������ԿA
  response:Integer;//��ԿB
  pageData:array [0..256] of Char; //��ҳ�洢������
  Rtn,i:Integer;
  url,sLastDate:string;
begin
  Result := False;
  //���Ҽ�����
  //APPID:=$00ABCDEF;    //Ӧ�ó����ʶ,���뷶Χ0x0--0xFFFFFFFF����Ź���������ֵΪ16���ƣ�$����16����
  Rtn:=Smart1000AppApis.Smart1000Find(APPID,@keyHandle,@keyNumber); //������ȷ�ĳ����ʶ
  if Rtn<>0 then Exit;

  try
    //��ȡӲ�����к�(32λ�̶�����)
    //Rtn:=Smart1000AppApis.Smart1000GetUID(keyHandle[0],@GUID);
    //if Rtn<>0 then Exit;

    //��ȡ����������(��󳤶�16λ)
    keyName:='';
    Rtn:=Smart1000AppApis.Smart1000GetKeyName(keyHandle[0],keyName);
    if Rtn<>0 then Exit;
    if keyName<>AppName then Exit;


    //�򿪼�����
    //�û����룬ͨ����Ź�������,���������ǳ���Ĭ������ �� �������루admin�� + �����루FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF�����ɵ�ʮ��������;
    pwd1:=$87DA211;//$1ADC0193;
    pwd2:=$3EBCB2F7;//$854110F2;
    pwd3:=$CE3BDBAD;//$5DAE0EBC;
    pwd4:=$6B6D224F;//$A89011EE;
    Rtn:=Smart1000AppApis.Smart1000Open(keyHandle[0],pwd1,pwd2,pwd3,pwd4,@request); //������ȷ���û�������д�,��������ԿA
    //RtnMSG('Smart1000 Open Successful��','Smart1000 Open fail��' );

    //������֤���ɹ�����ܽ��ж�д����
    //���γ����֤  response����Ź������ã�open�󷵻ص�requestFromKey ��Ӧ���response��
    //request(A) �� response(B) ���û�ͨ����Ź������� Ĭ������Ϊrequest = 1 2 ���� 64 ��  response = 1 2 ���� 64 ��Ӧ����request  = response ��
    //ʾ����ʹ�õ���Ĭ�ϳ�������.
    response:=request;//����Ĭ����ԿA����ԿB��ͬ���ֱ�Ϊ1��2��3...64
    Rtn:=Smart1000AppApis.Smart1000Verify(keyHandle[0],response);
    if Rtn<>0 then Exit;

    //����ҳ�洢��
    //0,1,2,3��4����ҳ�洢����0: http://ip:80/kjcx/srv/   1: 2013-12-24 �������
    Rtn:=Smart1000AppApis.Smart1000ReadPage(keyHandle[0],0,pageData);  // ��ȡ���ݣ���ȡ�����ݷ���pageData��
    if Rtn<>0 then Exit;
    //--------------------------------------------//
    url := pageData;
    if LowerCase(Copy(url,1,7))<>'http://' then
      url := 'http://'+url;
    if Copy(url,Length(url),1)<>'/' then
      url := url+'/';
    gb_SrvIP := url;
    //-------------------------------------------//
    Rtn:=Smart1000AppApis.Smart1000ReadPage(keyHandle[0],1,pageData);  // ��ȡ���ݣ���ȡ�����ݷ���pageData��

    //if (pageData < '2014-03-10') then
    //  Rtn:=Smart1000AppApis.Smart1000WritePage(keyHandle[0],1,pageData);
    sLastDate := pageData;
    if (Rtn<>0) or (FormatDateTime('yyyy-mm-dd',Now)>sLastDate) then Exit;

    Result := True;
  finally
    //�رռ�����
    Smart1000AppApis.Smart1000Close(keyHandle[0]);    //�رռ��������ͷ�Ȩ��
    //����ͨ��keyHandle�е�ֵȥ����ÿһֻ����
  end;
end;

function GetSrvIp:string;
begin

end;

end.
