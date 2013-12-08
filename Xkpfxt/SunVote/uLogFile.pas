{*********************************************************************
  ��������  2010-1-18
  ������    xx
  ��������
      ��־�ļ�����
  �޸���Ϣ���޸��ˡ��޸�ԭ���޸����ڣ�
     ��ʼ�����ļ�ʱ�����ɶ༶Ŀ¼ (xx������ʱ�ɴ��ļ��С�2010-2-24)
     �����ж���־�ļ����� (xx��������Ҫ��ʼ������Ϣ��2010-2-24)
*********************************************************************}

unit uLogFile;

interface
uses
  SysUtils,Forms,Classes;

Type
   TLogFile = Class

  Private
    FFileName:string;

  Public
    Constructor Create(FileName:string);
    Destructor Destroy; Override;

    Procedure WriteErrLog(Description,ClassFunctionName:string;AddLast:Boolean=False); //д������־
    Function FileExist: Boolean; //��־�ļ�����
  End;
implementation

Constructor TLogFile.Create(FileName:string);
var
  lDir:string;
Begin
  Inherited Create; // �������һ��,������� Create ����ʡ��

  lDir:=ExtractFileDir(FileName);

  if lDir='' then //ֻ���ļ���(123.txt)
    begin
      lDir:=ExtractFilePath(Application.ExeName);
      FFileName:=lDir+FileName; //��ǰexe����Ŀ¼
    end
  else   //��·��
    begin
      if pos(':',lDir)>0 then //����·��(D:\1\2\3.log)
        FFileName:=FileName
      else //������·��(1\2\3.log)
        begin
          lDir:=ExtractFilePath(Application.ExeName)+lDir;  //��ǰexe����Ŀ¼
          FFileName:=lDir+'\'+ExtractFileName(FileName);
        end;

      if not DirectoryExists(lDir) then
        begin
          ForceDirectories(lDir);//�༶�ļ��� CreateDir(lDir);һ��
        end;
    end;

End;

Destructor TLogFile.Destroy;
Begin
  //inherited Destroy;
  Inherited; //ʡ�Ծ��Ǽ̳�ͬ������
end;

//*********************************************************************������������������������������������������������������
//  ����˵������־�ļ�����
//  ����˵����
//  ��������ֵ˵����True ���ڣ�False������
//**********************************************************************
function TLogFile.FileExist: Boolean;
begin
  if FileExists(FFileName) then
    Result:=True
  else
    Result:=False
end;

//ϵͳ���в�����־��¼����������ϵͳ������ϵͳ������Ϣ�ȵȡ���־��Ϣ�����ڰ�װ�����log�ļ��£�������־��Ϣ��ʽ��.log�ļ���β������Ϊ��
//�������ڣ����ڸ�ʽ��yyyy-mm-dd hh:mm:ss:sss��
//����ģ�飺�磺�û�ģ�飻
//�����������磺��ӣ��޸��û���
//�������������������д��ݵĲ���ֵ��
//��ע��������ע��Ϣ��

//*********************************************************************������������������������������������������������������
//  ����˵����д������־
//  ����˵����Description:����
//            ClassFunctionName:����������
//            AddLast:True ��ӵ�δ�С�False=��ӵ�����
//              10000�к���ӵ����ٶȶ���0-0.016s������д�����ٶ����ܴ�(δ���ٶȿ�)
//  ��������ֵ˵����
//**********************************************************************
procedure TLogFile.WriteErrLog(Description,ClassFunctionName:string;AddLast:Boolean=False);
var
  lTime:string;
  lLog:string;
  lSpace:string;
  lTextFile: TextFile;
  lStrLit:TStringList;
  lOpenFile,lAppend:Boolean;

begin
  try
    lTime:=FormatDateTime('yyyy-mm-dd hh:nn:ss:zzz',now);
    lSpace:='  ';
    lLog:=lTime + lSpace + Description + lSpace +ClassFunctionName;

    lOpenFile:=False;
    if FileExists(FFileName) then
      lAppend:=True
    else
      begin
        AssignFile(lTextFile,FFileName);
        Rewrite(lTextFile);         //�ļ��������򴴽�
        lAppend:=False;
        lOpenFile:=True;
      end;

    if AddLast then
      begin
        if lAppend then
          begin
            AssignFile(lTextFile,FFileName);
            Append(lTextFile);
          end;

        WriteLn(lTextFile,lLog);  //���ַ�ʽ1000�� =0.7�� ���������ļ���СӰ��
        CloseFile(lTextFile);
      end
    else
      begin
        if lOpenFile then
          CloseFile(lTextFile);

        //��ʱ�����ַ�ʽ1000�� =1.6��
        //����6000��ʱ�����ַ�ʽ1000�� =8.4��
        lStrLit:=TStringList.Create; //����6000��ʱ�����ַ�ʽ1000�� =14�� ���ļ���СӰ���
        lStrLit.loadfromfile(FFileName);
        lStrLit.insert(0,lLog);
        lStrLit.savetofile(FFileName);
        lStrLit.Free;
      end;
  except on E: Exception do
    RaiseLastOSError;
  end;


end;

end.
