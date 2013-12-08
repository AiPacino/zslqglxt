unit PublicVariable;

interface
uses
  forms,SysUtils,uLogFile;

type
// Ӧ������
  TSDKAppType = (satNull, // ��
    satSign, // ǩ��
    satPressSign, // ����ǩ��(CRS)
    satLoginSign, // ע��ǩ��
    satNumber, // ��ֵ
    satChoices, // ��ѡ����ѡ
    satSequence, // ����
    satBusinessResearch, // ����
    satMate, // ���
    satHardwareTest, // ģ��ģʽ
    satRushAnswer, // ѡ��
    satGrade, // �ȼ�
    satMessage, // ����
    satTrueFalse, // TrueFalse
    satVote, // ���
    satHomework, // ��ҵ
    satCloze, // ���
    satScore, // ������
    satSelfExercise, // ������ϰ
    satExamination, // ����
    satWordStock, // �ֿ�
    satEvaluationRuleExplain, // �������˵��
    satScoreRuleExplain, // ���ֹ���˵��
    satBatchEvaluation, // ��������
    satBatchScore, // ��������
    satBatchVote, // ���α��
    satElection, // ѡ��
    satEvaluation, // ����
    satMultipleAssess, // �ۺϲ���
    satHardwareMonitor, // Ӳ�����
    satRequest, // ��������
    satFileDownload, //�ļ�����
    satAvoidItemsDownload, //�رܱ�����
    satDeskBrand //���Ƶƿ�
    );

  TFilePath = Record //�ļ�·��
    System: String;
  End;

  Procedure InitDebugLog(); // ��ʼ��������־
  Procedure WriteDebugLog(ATitle, AText:string);overload; // д������־

var
  gExePAth: String; //ִ���ļ�����Ŀ¼
  gFilePath: TFilePath; //�ļ�·��
  gDebugLogFile: TLogFile;
  gIsWriteDebugLog:Boolean;
implementation

Procedure InitDebugLog(); // ��ʼ��������־
begin
  if not gIsWriteDebugLog then
    Exit;

  gDebugLogFile.Free;
  // SunVoteSDK\20100223.log
  gDebugLogFile := TLogFile.Create('RecordData\' +
                 FormatDateTime('YYYY-MM-DD hh.nn.ss.zzz',Now) + '.log');
  if not gDebugLogFile.FileExist then // �ⲿ�жϣ���ʼ��Ϣ���ܲ�ͬ
    WriteDebugLog('Create', '');
end;

Procedure WriteDebugLog(ATitle, AText: string); // д������־
begin
  if not gIsWriteDebugLog then
    Exit;

  if gDebugLogFile = nil then
    InitDebugLog;

  gDebugLogFile.WriteErrLog(ATitle, AText, True); // ��ӵ�δ�У��ӿ��ٶ�
end;

Initialization
  gExePath := ExtractFilePath(application.ExeName);
  gFilePath.System := gExePath + 'System.ini';


end.
