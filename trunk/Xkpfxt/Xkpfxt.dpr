program Xkpfxt;

uses
  Forms,
  uMain in 'uMain.pas' {Main},
  Net in '..\public\Net.pas',
  uDM in 'uDM.pas' {DM: TDataModule},
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uABOUT in 'uABOUT.pas' {AboutBox},
  uCzyEdit in 'uCzyEdit.pas' {CzyEdit},
  uChangeCzyPwd in 'uChangeCzyPwd.pas' {ChangeCzyPwd},
  uCountSqlSet in 'uCountSqlSet.pas' {CountSqlSet},
  uSysLog in 'uSysLog.pas' {SysLog},
  uUserLoginLog in 'uUserLoginLog.pas' {UserLoginLog},
  uCzyRightSet in 'uCzyRightSet.pas' {CzyRightSet},
  uCzyRightGroupSet in 'uCzyRightGroupSet.pas' {CzyRightGroupSet},
  uLockScreen in 'uLockScreen.pas' {LockScreen},
  uOnlineUpdateSet in 'uOnlineUpdateSet.pas' {OnlineUpdateSet},
  uXkZySet in 'uXkZySet.pas' {XkZySet},
  uXkKmSet in 'uXkKmSet.pas' {XkKmSet},
  uXkZyKmSet in 'uXkZyKmSet.pas' {XkZyKmSet},
  uXkKdSet in 'uXkKdSet.pas' {XkKdSet},
  uXkKdBrowse in 'uXkKdBrowse.pas' {XkKdBrowse},
  uXkKdTimeSet in 'uXkKdTimeSet.pas' {XkKdTimeSet},
  uXkKdSetConfirm in 'uXkKdSetConfirm.pas' {XkKdSetConfirm},
  uXkInfoImport in 'uXkInfoImport.pas' {XkInfoImport},
  uXkDataImport in 'uXkDataImport.pas' {XkDataImport},
  uXkDataInit in 'uXkDataInit.pas' {XkDataInit},
  uXkKdEdit in 'uXkKdEdit.pas' {XkKdEdit},
  uXkInfoBrowse in 'uXkInfoBrowse.pas' {XkInfoBrowse},
  uXkInfoInput in 'uXkInfoInput.pas' {XkInfoInput},
  uXkInfoCount in 'uXkInfoCount.pas' {XkInfoCount},
  CnLoadingFrm in '..\public\CnLoadingFrm.pas' {LoadingForm},
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  uXkKmPwRsSet in 'uXkKmPwRsSet.pas' {XkKmPwRsSet},
  uLogin in 'uLogin.pas' {Login},
  uIniFile in 'uIniFile.pas',
  uXkInfoEdit in 'uXkInfoEdit.pas' {XkInfoEdit},
  uSysRegister in 'uSysRegister.pas' {SysRegister},
  uXkpf in 'uXkpf.pas' {Xkpf},
  uPwqd in 'uPwqd.pas' {Pwqd},
  uXkPwSet in 'uXkPwSet.pas' {XkPwSet},
  uXkPwWorkSet in 'uXkPwWorkSet.pas' {XkPwWorkSet},
  uSelectZyKmPw in 'uSelectZyKmPw.pas' {SelectZyKmPw},
  uSelectYxKdZy in 'uSelectYxKdZy.pas' {SelectYxKdZy},
  uSunVote in 'uSunVote.pas' {Form2};

//,
  //uPhotoExport in 'uPhotoExport.pas' {PhotoExport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '校考现场评分系统';
  dm := TDM.Create(Application);
  gb_System_Mode := '校考';
  gbIsOK := False;
  Login := TLogin.Create(Application);
  Login.ShowModal;
  if gbIsOK then
    Application.CreateForm(TMain, Main);
  Application.Run;
end.
