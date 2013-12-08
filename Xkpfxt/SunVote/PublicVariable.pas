unit PublicVariable;

interface
uses
  forms,SysUtils,uLogFile;

type
// 应用类型
  TSDKAppType = (satNull, // 空
    satSign, // 签到
    satPressSign, // 按键签到(CRS)
    satLoginSign, // 注册签到
    satNumber, // 数值
    satChoices, // 单选、多选
    satSequence, // 排序
    satBusinessResearch, // 调研
    satMate, // 配对
    satHardwareTest, // 模拟模式
    satRushAnswer, // 选举
    satGrade, // 等级
    satMessage, // 短信
    satTrueFalse, // TrueFalse
    satVote, // 表决
    satHomework, // 作业
    satCloze, // 填空
    satScore, // 简单评分
    satSelfExercise, // 自我练习
    satExamination, // 测验
    satWordStock, // 字库
    satEvaluationRuleExplain, // 评议规则说明
    satScoreRuleExplain, // 评分规则说明
    satBatchEvaluation, // 批次评议
    satBatchScore, // 批次评分
    satBatchVote, // 批次表决
    satElection, // 选举
    satEvaluation, // 评议
    satMultipleAssess, // 综合测评
    satHardwareMonitor, // 硬件监控
    satRequest, // 键盘请求
    satFileDownload, //文件下载
    satAvoidItemsDownload, //回避表下载
    satDeskBrand //桌牌灯控
    );

  TFilePath = Record //文件路径
    System: String;
  End;

  Procedure InitDebugLog(); // 初始化调试日志
  Procedure WriteDebugLog(ATitle, AText:string);overload; // 写调试日志

var
  gExePAth: String; //执行文件所在目录
  gFilePath: TFilePath; //文件路径
  gDebugLogFile: TLogFile;
  gIsWriteDebugLog:Boolean;
implementation

Procedure InitDebugLog(); // 初始化调试日志
begin
  if not gIsWriteDebugLog then
    Exit;

  gDebugLogFile.Free;
  // SunVoteSDK\20100223.log
  gDebugLogFile := TLogFile.Create('RecordData\' +
                 FormatDateTime('YYYY-MM-DD hh.nn.ss.zzz',Now) + '.log');
  if not gDebugLogFile.FileExist then // 外部判断，初始信息可能不同
    WriteDebugLog('Create', '');
end;

Procedure WriteDebugLog(ATitle, AText: string); // 写调试日志
begin
  if not gIsWriteDebugLog then
    Exit;

  if gDebugLogFile = nil then
    InitDebugLog;

  gDebugLogFile.WriteErrLog(ATitle, AText, True); // 添加到未行，加快速度
end;

Initialization
  gExePath := ExtractFilePath(application.ExeName);
  gFilePath.System := gExePath + 'System.ini';


end.
