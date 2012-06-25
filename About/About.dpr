program About;

uses
  Forms,
  uABOUT in '..\public\uABOUT.pas' {AboutBox},
  Net in '..\public\Net.pas',
  uDM in '..\public\uDM.pas' {DM: TDataModule},
  PwdFunUnit in '..\public\PwdFunUnit.pas',
  EncdDecdEx in '..\public\EncdDecdEx.pas',
  uNewStuLqBdIntf in '..\Srv\uNewStuLqBdIntf.pas',
  uZySelect in '..\NewStuBd\uZySelect.pas' {ZySelect};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  dm := Tdm.Create(Application);
  Application.CreateForm(TAboutBox, AboutBox);
  Application.Run;
end.
