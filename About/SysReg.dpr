program SysReg;

uses
  Forms,
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  uSysRegister in '..\public\uSysRegister.pas' {SysRegister},
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  uNewStuLqBdIntf in '..\Srv\uNewStuLqBdIntf.pas',
  uZySelect in '..\NewStuBd\uZySelect.pas' {ZySelect},
  Net in '..\public\Net.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  dm := TDM.Create(Application);
  Application.CreateForm(TSysRegister, SysRegister);
  Application.Run;
end.
