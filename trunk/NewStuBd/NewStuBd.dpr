program NewStuBd;

uses
  Forms,
  uMain in 'uMain.pas' {Main},
  uNewStuList in 'uNewStuList.pas' {NewStuList},
  Net in '..\public\Net.pas',
  uChangeZy in 'uChangeZy.pas' {ChangeZy},
  uChgZyHistory in 'uChgZyHistory.pas' {ChgZyHistory},
  uLogin in 'uLogin.pas' {Login},
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  uNewStuLqBdIntf in '..\Srv\uNewStuLqBdIntf.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uConnSet in 'uConnSet.pas' {ConnSet},
  uNoBaoDaoBz in 'uNoBaoDaoBz.pas' {NoBaoDaoBz},
  uABOUT in '..\public\uABOUT.pas' {AboutBox},
  uCzyEdit in 'uCzyEdit.pas' {CzyEdit},
  uChangeCzyPwd in 'uChangeCzyPwd.pas' {ChangeCzyPwd},
  uCountBdl in 'uCountBdl.pas' {CountBdl},
  uZySet in 'uZySet.pas' {ZySet},
  uCountSqlSet in 'uCountSqlSet.pas' {CountSqlSet},
  uSysLog in 'uSysLog.pas' {SysLog},
  uUserLoginLog in 'uUserLoginLog.pas' {UserLoginLog},
  uStuInfo in 'uStuInfo.pas' {StuInfo},
  uBaoDaoTimeSet in 'uBaoDaoTimeSet.pas' {BaoDaoTimeSet},
  uJlxmSet in 'uJlxmSet.pas' {JlxmSet},
  uIpSet in 'uIpSet.pas' {IpSet},
  uSrvStateSet in 'uSrvStateSet.pas' {SrvStateSet},
  uCzyRightSet in 'uCzyRightSet.pas' {CzyRightSet},
  uCzyRightGroupSet in 'uCzyRightGroupSet.pas' {CzyRightGroupSet},
  uLockScreen in 'uLockScreen.pas' {LockScreen},
  uOnlineUpdateSet in 'uOnlineUpdateSet.pas' {OnlineUpdateSet},
  uNewStuBdHistory in 'uNewStuBdHistory.pas' {NewStuBdHistory},
  uYxSet in 'uYxSet.pas' {YxSet},
  uYxZyList in 'uYxZyList.pas' {YxZyList},
  uYxZySet in 'uYxZySet.pas' {YxZySet},
  uZySelect in 'uZySelect.pas' {ZySelect},
  uKsList in 'uKsList.pas' {KsList},
  uIniFile in 'uIniFile.pas',
  uPhotoExport in 'uPhotoExport.pas' {PhotoExport},
  uSelectCjInputIndex in 'uSelectCjInputIndex.pas' {SelectCjInputIndex},
  uDataImport in 'uDataImport.pas' {DataImport},
  uDataInit in 'uDataInit.pas' {DataInit},
  uZsjhSet in 'uZsjhSet.pas' {ZsjhSet},
  uCountXkInfo in 'uCountXkInfo.pas' {CountXkInfo},
  CnLoadingFrm in '..\public\CnLoadingFrm.pas' {LoadingForm},
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  uCountXkCjInfo in 'uCountXkCjInfo.pas' {CountXkCjInfo},
  uWorkBrowse in 'uWorkBrowse.pas' {WorkBrowse},
  uWorkSet in 'uWorkSet.pas' {WorkSet},
  uWorkHint in 'uWorkHint.pas' {WorkHint},
  uWorkInput in 'uWorkInput.pas' {WorkInput},
  uZsjhBrowse in 'uZsjhBrowse.pas' {ZsjhBrowse},
  uSqlCmdSet in 'uSqlCmdSet.pas' {SqlCmdSet},
  uZsjhAdjustEdit in 'uZsjhAdjustEdit.pas' {ZsjhAdjustEdit},
  uZsjhAdjustBrowse in 'uZsjhAdjustBrowse.pas' {ZsjhAdjustBrowse},
  uZsjhAdjustConfirm in 'uZsjhAdjustConfirm.pas' {ZsjhAdjustConfirm},
  uAdjustJhInput in 'uAdjustJhInput.pas' {AdjustJhInput},
  uReportDesign in 'uReportDesign.pas' {ReportDesign},
  uFormatZymc in 'uFormatZymc.pas' {FormatZymc},
  uFormatKL in 'uFormatKL.pas' {FormatKL},
  uFormatZySqlSet in 'uFormatZySqlSet.pas' {FormatZySqlSet},
  uFormatZy in 'uFormatZy.pas' {FormatZy},
  uLqqkCount in 'uLqqkCount.pas' {LqqkCount},
  uLqqkBrowse in 'uLqqkBrowse.pas' {LqqkBrowse},
  uKsInfoBrowse_All in 'uKsInfoBrowse_All.pas' {KsInfoBrowse_All},
  uMareData_BDE in 'uMareData_BDE.pas' {MareData_BDE},
  uMareData_BDE_Photo in 'uMareData_BDE_Photo.pas' {MareData_BDE_Photo},
  uSQLWhere in 'uSQLWhere.pas' {SQLWhere},
  uExportToAccess in 'uExportToAccess.pas' {ExportToAccess},
  uTdKsInfoBrowse in 'uTdKsInfoBrowse.pas' {TdKsInfoBrowse},
  uKsInfoBrowse in 'uKsInfoBrowse.pas' {KsInfoBrowse},
  uSetNumber in 'uSetNumber.pas' {SetNumber},
  uEMSNumberImport in 'uEMSNumberImport.pas' {EMSNumberImport},
  uDbTools in 'uDbTools.pas' {DbTools},
  uFileEdit in 'uFileEdit.pas' {FileEdit},
  uFileBrowse in 'uFileBrowse.pas' {FileBrowse},
  uCzySfSet in 'uCzySfSet.pas' {CzySfSet},
  uJwInfoImport in 'uJwInfoImport.pas' {JwInfoImport};

//,
  //uPhotoExport in 'uPhotoExport.pas' {PhotoExport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '高招录取管理系统';
  dm := TDM.Create(Application);
  gb_System_Mode := '录取';
  gbIsOK := False;
  Login := TLogin.Create(Application);
  Login.ShowModal;
  if gbIsOK then
    Application.CreateForm(TMain, Main);
  Application.Run;
end.
