program Xkglxt;

uses
  Forms,
  uMain in 'uMain.pas' {Main},
  Net in '..\public\Net.pas',
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  uNewStuLqBdIntf in '..\Srv\uNewStuLqBdIntf.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uConnSet in '..\NewStuBd\uConnSet.pas' {ConnSet},
  uABOUT in '..\public\uABOUT.pas' {AboutBox},
  uCzyEdit in '..\NewStuBd\uCzyEdit.pas' {CzyEdit},
  uChangeCzyPwd in '..\NewStuBd\uChangeCzyPwd.pas' {ChangeCzyPwd},
  uCountSqlSet in '..\NewStuBd\uCountSqlSet.pas' {CountSqlSet},
  uSysLog in '..\NewStuBd\uSysLog.pas' {SysLog},
  uUserLoginLog in '..\NewStuBd\uUserLoginLog.pas' {UserLoginLog},
  uIpSet in '..\NewStuBd\uIpSet.pas' {IpSet},
  uSrvStateSet in '..\NewStuBd\uSrvStateSet.pas' {SrvStateSet},
  uCzyRightSet in '..\NewStuBd\uCzyRightSet.pas' {CzyRightSet},
  uCzyRightGroupSet in '..\NewStuBd\uCzyRightGroupSet.pas' {CzyRightGroupSet},
  uLockScreen in '..\NewStuBd\uLockScreen.pas' {LockScreen},
  uOnlineUpdateSet in '..\NewStuBd\uOnlineUpdateSet.pas' {OnlineUpdateSet},
  uXkZySet in 'uXkZySet.pas' {XkZySet},
  uXkKmSet in 'uXkKmSet.pas' {XkKmSet},
  uXkZyKmSet in 'uXkZyKmSet.pas' {XkZyKmSet},
  uXkKdSet in 'uXkKdSet.pas' {XkKdSet},
  uXkKdBrowse in 'uXkKdBrowse.pas' {XkKdBrowse},
  uXkKdTimeSet in 'uXkKdTimeSet.pas' {XkKdTimeSet},
  uXkKdSetConfirm in 'uXkKdSetConfirm.pas' {XkKdSetConfirm},
  uXkZyCjBrowse in 'uXkZyCjBrowse.pas' {XkZyCjBrowse},
  uXkSelectCjInputSf in 'uXkSelectCjInputSf.pas' {XkSelectCjInputSf},
  uXkInfoImport in 'uXkInfoImport.pas' {XkInfoImport},
  uXkDataImport in 'uXkDataImport.pas' {XkDataImport},
  uXkDataInit in 'uXkDataInit.pas' {XkDataInit},
  uXkKmCjCheck in 'uXkKmCjCheck.pas' {XkKmCjCheck},
  uXkKdEdit in 'uXkKdEdit.pas' {XkKdEdit},
  uXkInfoBrowse in 'uXkInfoBrowse.pas' {XkInfoBrowse},
  uXkKsKmCjBrowse in 'uXkKsKmCjBrowse.pas' {XkKsKmcjBrowse},
  uXkKmCjEdit in 'uXkKmCjEdit.pas' {XkKmCjEdit},
  uXkCjInputSet in 'uXkCjInputSet.pas' {XkCjInputSet},
  uXkZsjhSet in 'uXkZsjhSet.pas' {XkZsjhSet},
  uXkInfoInput in 'uXkInfoInput.pas' {XkInfoInput},
  uXkInfoCount in 'uXkInfoCount.pas' {XkInfoCount},
  uXkKmCjBrowse in 'uXkKmCjBrowse.pas' {XkKmCjBrowse},
  uXkKmErrorCjInput in 'uXkKmErrorCjInput.pas' {XkKmErrorCjInput},
  uXkKmCjInput in 'uXkKmCjInput.pas' {XkKmCjInput},
  uXkKmCjInputResultBrowse in 'uXkKmCjInputResultBrowse.pas' {XkKmCjInputResultBrowse},
  uXkKmCjUpload in 'uXkKmCjUpload.pas' {XkKmCjUpload},
  CnLoadingFrm in '..\public\CnLoadingFrm.pas' {LoadingForm},
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  uXkCjInfoCount in 'uXkCjInfoCount.pas' {XkCjInfoCount},
  uXkKmSjCjMerge in 'uXkKmSjCjMerge.pas' {XkKmSjCjMerge},
  uXkKmPwRsSet in 'uXkKmPwRsSet.pas' {XkKmPwRsSet},
  uXkZyCjMerge in 'uXkZyCjMerge.pas' {XkZyCjMerge},
  uZySelect in '..\NewStuBd\uZySelect.pas' {ZySelect},
  uLogin in '..\NewStuBd\uLogin.pas' {Login},
  uIniFile in '..\NewStuBd\uIniFile.pas',
  uXkInfoEdit in 'uXkInfoEdit.pas' {XkInfoEdit},
  uXkBmEdit in 'uXkBmEdit.pas' {XkBmEdit},
  uSysRegister in '..\public\uSysRegister.pas' {SysRegister},
  uFormatBkZy in 'uFormatBkZy.pas' {FormatBkZy};

//,
  //uPhotoExport in 'uPhotoExport.pas' {PhotoExport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '艺术类考试管理系统';
  dm := TDM.Create(Application);
  gb_System_Mode := '校考';
  gbIsOK := False;
  Login := TLogin.Create(Application);
  Login.ShowModal;
  if gbIsOK then
    Application.CreateForm(TMain, Main);
  Application.Run;
end.
