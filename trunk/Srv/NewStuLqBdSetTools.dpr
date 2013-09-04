program NewStuLqBdSetTools;

uses
  Forms,
  uDbInfoSet in 'uDbInfoSet.pas' {DbInfoSet},
  uToolsMain in 'uToolsMain.pas' {ToolsMain},
  Net in '..\public\Net.pas',
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  uIIS in '..\public\uIIS.pas',
  uServiceSet in 'uServiceSet.pas' {ServiceSet},
  uDbConnect in 'uDbConnect.pas',
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  uSQLBackupRestore in '..\public\uSQLBackupRestore.pas',
  uDbBackupRestore in 'uDbBackupRestore.pas' {DbBackupRestore},
  uInputSaPwd in 'uInputSaPwd.pas' {InputSaPwd},
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  uNewStuLqBdIntf in 'uNewStuLqBdIntf.pas',
  uZySelect in '..\NewStuBd\uZySelect.pas' {ZySelect},
  uPhotoSavePathSet in 'uPhotoSavePathSet.pas' {PhotoSavePathSet},
  uSrvStateSet in 'uSrvStateSet.pas' {SrvStateSet};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := False;
  dm := TDM.Create(Application);
  Application.CreateForm(TToolsMain, ToolsMain);
  Application.Run;
end.
